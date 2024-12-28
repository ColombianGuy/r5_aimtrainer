untyped

global function Score_Init

global function AddPlayerScore
global function AddCallback_OnPlayerScored
global function AddCallback_Score_OnPlayerKilled

global function ScoreEvent_PlayerKilled
global function ScoreEvent_TitanDoomed
global function ScoreEvent_TitanKilled
global function ScoreEvent_NPCKilled

global function ScoreEvent_SetEarnMeterValues
global function ScoreEvent_SetupEarnMeterValuesForMixedModes
global function IsPlaylistAllowedForDefaultKillNotifications

global function PreScoreEventUpdateStats
global function PostScoreEventUpdateStats

//=========================================================
//	_score.nut
//  Handles scoring for MP.
//
//	Interface:
//		- ScoreEvent_*(); called from various places in different scripts to award score to players
//=========================================================


struct {
	bool firstStrikeDone = false

	bool victoryKillEnabled = false
	bool firstStrikeGiven = false
	array<void functionref( entity, ScoreEvent )> onPlayerScoredCallbacks
	table< string, void functionref( entity, entity, var ) > onPlayerKilledCallbacks
} file

void function Score_Init()
{

}

void function AddCallback_OnPlayerScored( void functionref( entity, ScoreEvent ) callbackFunc )
{
	file.onPlayerScoredCallbacks.append( callbackFunc )
}


void function AddPlayerScore( entity targetPlayer, string scoreEventName, entity associatedEnt = null, string noideawhatthisis = "", int ownValueOverride = -1 )
{
	if ( !IsValid_ThisFrame( targetPlayer ) || !targetPlayer.IsPlayer() )
		return

	if ( !targetPlayer.hasConnected || targetPlayer.GetTeam() == TEAM_SPECTATOR )
		return
	
	ScoreEvent event = GetScoreEvent( scoreEventName )
	
	if ( !event.enabled )
		return

	var associatedHandle = 0
	if ( associatedEnt != null )
		associatedHandle = associatedEnt.GetEncodedEHandle()

	float scale = targetPlayer.IsTitan() ? event.coreMeterScalar : 1.0	
	float earnValue = event.earnMeterEarnValue * scale
	float ownValue = event.earnMeterOwnValue * scale

	if( scoreEventName == "Sur_DownedPilot" )
		ownValue = GetTotalDamageTakenByPlayer( associatedEnt, targetPlayer )

	if ( Playlist() == ePlaylists.fs_scenarios && ownValueOverride != -1 || Playlist() == ePlaylists.fs_scenarios && ownValueOverride == -1 && scoreEventName == "FS_Scenarios_PenaltyRing" || Gamemode() == eGamemodes.fs_snd && ownValueOverride != -1 ) //point value is unused in r5, gonna use own value for scenarios. Cafe
		ownValue = float( ownValueOverride )

	//PlayerEarnMeter_AddEarnedAndOwned( targetPlayer, earnValue * scale, ownValue * scale )
	
	Remote_CallFunction_NonReplay( targetPlayer, "ServerCallback_ScoreEvent", event.eventId, event.pointValue, event.displayType, associatedHandle, ownValue, earnValue )
	
	if ( event.displayType & eEventDisplayType.CALLINGCARD ) // callingcardevents are shown to all players
	{
		foreach ( entity player in GetPlayerArray() )
		{
			if ( player == targetPlayer ) // targetplayer already gets this in the scorevent callback
				continue
				
			//Remote_CallFunction_NonReplay( player, "ServerCallback_CallingCardEvent", event.eventId, associatedHandle )
		}
	}
	
	if ( ScoreEvent_HasConversation( event ) )
	{
		printt( FUNC_NAME(), "conversation:", event.conversation, "player:", targetPlayer.GetPlayerName(), "delay:", event.conversationDelay )
		// todo: reimplement conversations
		//thread Delayed_PlayConversationToPlayer( event.conversation, targetPlayer, event.conversationDelay )

	}
}


bool function IsPlaylistAllowedForDefaultKillNotifications()
{
	switch( Playlist() )
	{
		case ePlaylists.fs_scenarios:
		return false
		
	}

	switch( Gamemode() )
	{
		case eGamemodes.fs_snd:
		return false
	}

	return true
}

void function AddCallback_Score_OnPlayerKilled( string gamemode, void functionref( entity, entity, var ) callbackFunc )
{
	file.onPlayerKilledCallbacks[gamemode] <- callbackFunc
}

void function PreScoreEventUpdateStats( entity attacker, entity victim ) //This is run before the friendly fire team check in PlayerOrNPCKilled
{
	if ( !GamePlayingOrSuddenDeath() )
		return

	entity killer = attacker

	if ( Bleedout_IsBleedingOut( victim ) )
	{
		killer = Bleedout_GetBleedoutAttacker( victim )
		if ( !IsValid( killer ) || !killer.IsPlayer() )
			killer = attacker
	}

	if ( victim.IsPlayer() )
	{
		victim.p.numberOfDeaths++
		victim.p.numberOfDeathsSinceLastKill++

		victim.p.playerOrTitanKillsSinceLastDeath = 0

		victim.p.lastKiller = killer
		victim.p.seekingRevenge = true

		if ( killer.IsPlayer() )
		{
			if ( !( victim in killer.p.playerKillStreaks ) )
				killer.p.playerKillStreaks[ victim ] <- 0
			killer.p.playerKillStreaks[ victim ]++

			for ( int i = killer.p.recentPlayerKilledTimes.len() - 1; i >= 0; i-- )
			{
				if ( killer.p.recentPlayerKilledTimes[ i ] < ( Time() - CASCADINGKILL_REQUIREMENT_TIME ) )
					killer.p.recentPlayerKilledTimes.remove( i )
			}
			killer.p.recentPlayerKilledTimes.append( Time() )
		}
	}

	if ( killer.IsPlayer() )
	{
		killer.p.numberOfDeathsSinceLastKill = 0

		if ( IsAlive( killer ) )
		{
			if ( ShouldIncrementPlayerOrTitanKillsSinceLastDeath( killer, victim ) )
			{
				if ( victim.IsPlayer() && victim.IsTitan() )
					killer.p.playerOrTitanKillsSinceLastDeath+= 2 //Count as 2 kills for kill spree when klling a player titan
				else
					killer.p.playerOrTitanKillsSinceLastDeath++
			}
		}

		for ( int i = killer.p.recentAllKilledTimes.len() - 1; i >= 0; i-- )
		{
			if ( killer.p.recentAllKilledTimes[ i ] < Time() - CASCADINGKILL_REQUIREMENT_TIME )
				killer.p.recentAllKilledTimes.remove( i )
		}
		killer.p.recentAllKilledTimes.append( Time() )
	}
}

bool function ShouldIncrementPlayerOrTitanKillsSinceLastDeath( entity attackerPlayer, entity victim )
{
	if ( victim.IsPlayer() )
		return true

	if ( victim.IsTitan() && victim.GetTeam() != attackerPlayer.GetTeam() ) //NPC titans count for kill spree. The team check is necessary since ejecting from your own undamaged Titan will make it count as you killing the Titan!
		return true

	return false
}

void function PostScoreEventUpdateStats( entity attacker, entity victim ) //This is run before the friendly fire team check in PlayerOrNPCKilled
{
	if ( !GamePlayingOrSuddenDeath() )
		return

	if ( victim.IsPlayer() )
	{
		if ( attacker in victim.p.playerKillStreaks )
			delete victim.p.playerKillStreaks[ attacker ]
	}

	if ( attacker.IsPlayer() )
	{
		if ( victim.IsPlayer() ) //Updating attacker killed times for CASCADINGKILL_REQUIREMENT_TIME checks to be valid.
		{
			for ( int i = 0; i < attacker.p.recentPlayerKilledTimes.len(); i++ )
			{
				attacker.p.recentPlayerKilledTimes[ i ] = Time()
			}
		}

		attacker.p.seekingRevenge = false
	}
}

void function ScoreEvent_PlayerKilled( entity victim, entity attacker, var damageInfo, bool downed = false)
{
	if( is1v1EnabledAndAllowed() )
	{
		int sourceId = DamageInfo_GetDamageSourceIdentifier( damageInfo )
		
		if ( sourceId == eDamageSourceId.damagedef_suicide )
			return
	}
	
	if( isScenariosMode() || Gamemode() == eGamemodes.fs_snd )
		return

	if ( downed && GetGameState() >= eGameState.Playing)
		AddPlayerScore( attacker, "Sur_DownedPilot", victim )
	else if( !downed && GetGameState() >= eGameState.Playing )
		AddPlayerScore( attacker, "EliminatePilot", victim )
	else if( !downed && GetGameState() <= eGameState.Playing )
		AddPlayerScore( attacker, "KillPilot", victim )
}

void function ScoreEvent_TitanDoomed( entity titan, entity attacker, var damageInfo )
{
	// will this handle npc titans with no owners well? i have literally no idea
	
	if ( titan.IsNPC() )
		AddPlayerScore( attacker, "DoomAutoTitan", titan )
	else
		AddPlayerScore( attacker, "DoomTitan", titan )
}

void function ScoreEvent_TitanKilled( entity victim, entity attacker, var damageInfo )
{
	// will this handle npc titans with no owners well? i have literally no idea

	if ( attacker.IsTitan() )
		AddPlayerScore( attacker, "TitanKillTitan", victim.GetTitanSoul().GetOwner() )
	else
		AddPlayerScore( attacker, "KillTitan", victim.GetTitanSoul().GetOwner() )
}

void function ScoreEvent_NPCKilled( entity victim, entity attacker, var damageInfo )
{
	#if HAS_NPC_SCORE_EVENTS
	AddPlayerScore( attacker, ScoreEventForNPCKilled( victim, damageInfo ), victim )
	#endif
}



void function ScoreEvent_SetEarnMeterValues( string eventName, float earned, float owned, float coreScale = 1.0 )
{
	ScoreEvent event = GetScoreEvent( eventName )
	event.earnMeterEarnValue = earned
	event.earnMeterOwnValue = owned
	event.coreMeterScalar = coreScale
}

void function ScoreEvent_SetupEarnMeterValuesForMixedModes() // mixed modes in this case means modes with both pilots and titans
{
	// todo needs earn/overdrive values
	// player-controlled stuff
	ScoreEvent_SetEarnMeterValues( "KillPilot", 0.0, 0.05 )
	ScoreEvent_SetEarnMeterValues( "KillTitan", 0.0, 0.15 )
	ScoreEvent_SetEarnMeterValues( "TitanKillTitan", 0.0, 0.0 ) // unsure
	ScoreEvent_SetEarnMeterValues( "PilotBatteryStolen", 0.0, 0.35 )
	
	// ai
	ScoreEvent_SetEarnMeterValues( "KillGrunt", 0.0, 0.02, 0.5 )
	ScoreEvent_SetEarnMeterValues( "KillSpectre", 0.0, 0.02, 0.5 )
	ScoreEvent_SetEarnMeterValues( "LeechSpectre", 0.0, 0.02 )
	ScoreEvent_SetEarnMeterValues( "KillStalker", 0.0, 0.02, 0.5 )
	ScoreEvent_SetEarnMeterValues( "KillSuperSpectre", 0.0, 0.1, 0.5 )
}

void function ScoreEvent_SetupEarnMeterValuesForTitanModes()
{
	// todo needs earn/overdrive values
	
}