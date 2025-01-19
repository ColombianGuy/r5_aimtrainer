               
global function PathTT_Init
global function PathTT_OnNetworkRegistration
global function IsPathTTEnabled

#if SERVER
global function DEV_SimulateThermiteTrace
global function DEV_TestRapidRingEntryAndDeath
global function PathTT_PlayAnnouncerLineForPlayersInRing
global function PathTT_AddCallbackOnHologramChanged
global function GetPathfinderTTAssetsToPrecache
#endif
#if CLIENT
global function ClInitPathTTRingTVEntities
global function SCB_PathTT_SetMessageIdxToCustomSpeakerIdx
global function SCB_PathTT_PlayRingAnnouncerDialogue
global function DEV_CheckIsPlayerInRing
#endif

////////////////////////////////////
// TV SCREENS
////////////////////////////////////
enum ePathTTRingTVStates
{
	NO_PLAYERS = 0,
	ONE_SQUAD,
	MULTIPLE_SQUADS,
	RUN_AWAY,
	KNOCKOUT
}

const string FLAG_UPDATE_RING_TVS = "RingTVUpdate"
const float RING_TV_TEMP_MESSAGE_DISPLAY_TIME = 5.0
const float RING_TV_KNOCKOUT_TIME_ELAPSED_CAN_OVERRIDE = 4.0

const asset RING_CSV_DIALOGUE = $"datatable/dialogue/oly_path_tt_ring_announcer_dialogue.rpak"
const string BOXING_RING_MODEL = "mdl/test/davis_test/pathfinder_tt_ring_shield.rmdl"
const string BOXING_RING_FX = "mdl/fx/pathfinder_tt_fill_fx.rmdl"
global const string BOXING_RING_SCRIPTNAME = "pathfinder_tt_ring_shield"

const string FLAG_ARENA_LIGHTS_01 = "arena_lights_01"
const string FLAG_ARENA_LIGHTS_02 = "arena_lights_02"
const string FLAG_ARENA_LIGHTS_03 = "arena_lights_03"
const string FLAG_ARENA_LIGHTS_04 = "arena_lights_04"

const string FLAG_ARENA_TOP_GLOVES = "arena_top_gloves"
const string FLAG_ARENA_TOP_TEXT = "arena_top_text"

const string FLAG_ARENA_ROPES = "arena_ropes"

const string PLAYER_PASS_THROUGH_RING_SHIELD_SOUND = "Player_Enter_Ring_v1"
const string PLAYER_ENTER_RING_BELL = "Player_Enter_Ring_v2"

#if SERVER
const float PATH_TT_BELL_DING_DEBOUNCE = 1.0
//const int PATH_TT_DISABLED_WEAPON_TYPES = WPT_ALL_EXCEPT_VIEWHANDS_OR_INCAP & ~WPT_CONSUMABLE & ~WPT_MELEE
#endif

#if SERVER
struct BoxingRingPlayerData
{
	bool hasTakenDamage
	int knockedPlayers
	table< entity, float > damageDealtToPlayersInRing
	entity player
	array<string> meleeWeapons
	bool haveWeaponsBeenReturned
	int immunityStatusEffectHandle
	int boxingStatusEffectHandle
	//int	hitCombo
}
#endif

struct
{
#if SERVER
	int numPlayersInRing
	int numTeamsInRing

	array<BoxingRingPlayerData> allRingPlayerData

	array<entity> boxingRingJumboScreens
	float timeToRevertJumboTronKOScreen
	bool isKOScreenActive

	array<entity> 	boxingRingCrowdAmbients_active
	array<entity> 	boxingRingCrowd_cheerTargets
	float            lastCrowdStingerTime

	int				customQueueIdx
	vector			centerRingSoundOrigin

	bool DEV_devRingShieldDisabled

	int prevRingTVState
	int ringTVState

	float lastBellDingTime

	array< void functionref( int ) > OnHologramChangedCallbacks
#endif

#if CLIENT
	int   customQueueIdx
	int   currentlyPlayingLinePriority
	float announcerLineFinishedPlayingTime
	bool  isInStadium
	array<entity>	boxingRingCrowdAmbients_AudioPlaced
	//int hitCombo_client
#endif

} file

void function PathTT_OnNetworkRegistration()
{
	Remote_RegisterClientFunction( "SCB_PathTT_SetMessageIdxToCustomSpeakerIdx", "int", 0, NUM_TOTAL_DIALOGUE_QUEUES )
	Remote_RegisterClientFunction( "SCB_PathTT_PlayRingAnnouncerDialogue", "int", 0, eRingAnnouncerLines._count )
	RegisterNetworkedVariable( "PathTT_IsCrowdActive", SNDC_GLOBAL, SNVT_BOOL, false )

	#if CLIENT
		//RegisterNetVarBoolChangeCallback( "PathTT_IsCrowdActive", OnIsCrowdActiveChanged )
	#endif
}

void function PathTT_Init()
{
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )

	#if SERVER
	InitPathTTRingTVSystem()
	#endif

	#if CLIENT
	ClInitPathTTRingTVEntities()
	#endif
}

void function EntitiesDidLoad()
{
	if ( !IsPathTTEnabled() )
		return

	RegisterCSVDialogue( RING_CSV_DIALOGUE )
	RegisterSignal( "OnStartTouch" )
	RegisterSignal( "OnEndTouch" )
	PrecacheWeapon( $"mp_weapon_melee_boxing_ring" )
	PrecacheWeapon( $"melee_boxing_ring" )

	InitPathTTBoxingRing()

	#if SERVER
		InitPathTTRingTVSystemEntities()
	#endif

	InitPathTTBoxingRingEntities()
}

void function InitPathTTBoxingRing()
{
#if SERVER
	AddCallback_GameStateEnter( eGameState.Playing, PathTT_SpawnLootRollers )
	AddCallback_OnPlayerKilled( PathTT_OnPlayerKilled )
	BleedoutState_AddCallback_OnPlayerBleedoutStateChanged( PathTT_PlayerBleedoutStateChanged )
	Bleedout_AddCallback_OnPlayerStartBleedout( PathTT_OnPlayerBleedoutStarted )
	AddDamageFinalCallback( "player", PathTT_OnPlayerDamaged )
	AddCallback_OnClientConnected( OnPlayerConnectedOrReconnected )
	//AddCallback_OnClientConnectionRestored(OnPlayerConnectedOrReconnected)
	file.customQueueIdx = RequestCustomDialogueQueueIndex()

	RegisterSignal( "GivePathTTMeleeWeaponsToPlayer" )
	RegisterSignal( "ReturnOriginalMeleeWeaponsToPlayer" )
#endif

#if CLIENT
	AddCallback_OnWeaponStatusUpdate( Boxing_WeaponStatusCheck )
#endif

	//PrecacheScriptString( BOXING_RING_SCRIPTNAME )

	FlagInit( FLAG_ARENA_LIGHTS_01 )
	FlagInit( FLAG_ARENA_LIGHTS_02 )
	FlagInit( FLAG_ARENA_LIGHTS_03 )
	FlagInit( FLAG_ARENA_LIGHTS_04 )
	FlagInit( FLAG_ARENA_TOP_GLOVES )
	FlagInit( FLAG_ARENA_TOP_TEXT )
	FlagInit( FLAG_ARENA_ROPES )
}

#if SERVER
void function OnPlayerConnectedOrReconnected( entity player )
{
	Remote_CallFunction_NonReplay( player, "SCB_PathTT_SetMessageIdxToCustomSpeakerIdx", file.customQueueIdx )
}
#endif

void function InitPathTTBoxingRingEntities()
{
	array<entity> enterTrigArr = GetEntArrayByScriptName( "path_tt_ring_trig" )
	if ( enterTrigArr.len() == 1 )
	{
		// There's a trigger_multiple_clientside with the same name
		#if SERVER
			if ( IsValid( enterTrigArr[ 0 ] ) )
			{
				enterTrigArr[ 0 ].SetEnterCallback( PathTT_OnEnterPathTTRingTrigger )
				enterTrigArr[ 0 ].SetLeaveCallback( PathTT_OnExitPathTTRingTrigger )
			}
		#endif
		#if CLIENT
			thread Cl_PathTT_MonitorIsPlayerInBoxingRing( enterTrigArr[ 0 ] )
		#endif
	}
	else
	{
		Warning( "Warning! Couldn't find path TT enter trigger!" )
		return
	}

	#if CLIENT
		array<entity> stadiumTrigArr = GetEntArrayByScriptName( "path_tt_stadium_trig" )
		if ( stadiumTrigArr.len() == 1 )
		{
			thread Cl_PathTT_MonitorIsPlayerInStadium( stadiumTrigArr[ 0 ] )
		}
		else
		{
			Warning( "Warning! Couldn't find client stadium trigger!" )
			return
		}

		array<entity> boxingRingAmbients_AudioPlaced = GetEntArrayByScriptName( "PathTT_Active_Crowd" )
		if ( boxingRingAmbients_AudioPlaced.len() == 0 )
		{
			Warning( "%s Warning! No audio-placed crowd ambients could be found for Path TT! Num found: %i", FUNC_NAME(), boxingRingAmbients_AudioPlaced.len() )
			return
		}
		foreach( entity ambient in boxingRingAmbients_AudioPlaced )
		{
			ambient.SetEnabled( false )
			file.boxingRingCrowdAmbients_AudioPlaced.append( ambient )
		}

	#endif

	#if SERVER

		array<entity> ringShieldTargets = GetEntArrayByScriptName( "pathtt_ring_shield_target" )
		if ( ringShieldTargets.len() != 1 )
		{
			Warning( "%s Warning! Incorrect number of ring shield targets found! %i", FUNC_NAME(), ringShieldTargets.len() )
			return
		}

		entity ringShieldTarget = ringShieldTargets[ 0 ] //TODO: Used FX model instead actually FX until we figure out how to port efct assets, remove this model after fixing particles -LorryLeKral
		entity ringShield = CreatePropScript( GetAssetFromString( BOXING_RING_MODEL ), ringShieldTarget.GetOrigin(), ringShieldTarget.GetAngles(), SOLID_VPHYSICS, 1 )
		entity ringFx = CreatePropScript( GetAssetFromString( BOXING_RING_FX ), ringShieldTarget.GetOrigin(), ringShieldTarget.GetAngles(), 0, 50000 )
		ringFx.kv.rendercolor = "104 198 223 255"
		ringFx.kv.solid = 0
		ringShield.kv.CollisionGroup = TRACE_COLLISION_GROUP_BLOCK_WEAPONS
		ringShield.kv.contents = int( ringShield.kv.contents ) | CONTENTS_NOGRAPPLE | CONTENTS_BLOCKLOS
		ringShield.kv.renderamt = 10
		ringShield.kv.collide_human = 0
		ringShield.SetScriptName( BOXING_RING_SCRIPTNAME )
	//	DispatchSpawn( ringShield )
		ringShield.Hide()
		ringShield.kv.contents = int( ringShield.kv.contents ) | CONTENTS_NOGRAPPLE | CONTENTS_BLOCKLOS

		array<entity> boxingRingAmbientTargets = GetEntArrayByScriptName( "path_tt_ring_crowd_ambience" )
		if ( boxingRingAmbientTargets.len() == 0 )
		{
			Warning( "%s Warning! No crowd emitter ambient_generics found for Path TT! Num found: %i", FUNC_NAME(), boxingRingAmbientTargets.len() )
			return
		}
		foreach( entity target in boxingRingAmbientTargets )
		{
			bool isCenterTarget = target.HasKey( "isCenterRingEmitTarget" ) && ( target.GetValueForKey( "isCenterRingEmitTarget" ) == "1" )

			// Passives - these are always on
			if ( isCenterTarget )
			{
				file.centerRingSoundOrigin = target.GetOrigin()
				entity ambGenericPassive = PathTT_CreateAmbientGeneric( target.GetOrigin(), "survival_crowd_active_atmo_lp_01", true )
			}
			// Active - only on when someone's in the ring
			else
			{
				array<entity> ambGenericActives = [ PathTT_CreateAmbientGeneric( target.GetOrigin(), "survival_crowd_active_atmo_lp_02", false ),
													PathTT_CreateAmbientGeneric( target.GetOrigin(), "survival_crowd_active_atmo_lp_03", false ),
													PathTT_CreateAmbientGeneric( target.GetOrigin(), "survival_crowd_active_atmo_lp_04", false )]

				file.boxingRingCrowdAmbients_active.extend( ambGenericActives )
			}

			// Emitters for crowd cheers
			file.boxingRingCrowd_cheerTargets.append( target )
		}

		array<entity> boxingRingScreens = GetEntArrayByScriptName( "path_tt_jumbo_screen_ad" )
		boxingRingScreens.extend( GetEntArrayByScriptName( "path_tt_jumbo_screen_ko" ) )
		if ( boxingRingScreens.len() != 2 )
		{
			Warning( "%s Warning! Incorrect number of Path TT screens found! %i", FUNC_NAME(), boxingRingScreens.len() )
			return
		}
		else
		{
			file.boxingRingJumboScreens = boxingRingScreens
			PathTT_SetJumboTronScreenToAd()
		}

		PathTT_UpdateRingCrowdAudio()

		thread PathTT_AlternateHolograms()
	#endif
}

#if SERVER
entity function PathTT_CreateAmbientGeneric( vector origin, string alias, bool active )
{
	entity ambGeneric = CreateEntity( "ambient_generic" )
	ambGeneric.SetOrigin( origin )
	ambGeneric.SetSoundName( alias )
	ambGeneric.SetEnabled( active )
	DispatchSpawn( ambGeneric )
	return ambGeneric
}
#endif

#if SERVER
void function PathTT_AddCallbackOnHologramChanged( void functionref( int index ) callbackFunc )
{
	Assert( !file.OnHologramChangedCallbacks.contains( callbackFunc ), "Already registered this callback" )
	file.OnHologramChangedCallbacks.append( callbackFunc )
}
#endif

#if SERVER
bool function GetPathfinderTTAssetsToPrecache( array< string > models, array< string > particles )
{
	if ( IsPathTTEnabled() == false )
		return false

	models.append( BOXING_RING_MODEL )

	return true
}
#endif

#if SERVER
void function PathTT_AlternateHolograms()
{
	array<string> flagsToSet = [ FLAG_ARENA_TOP_GLOVES, FLAG_ARENA_TOP_TEXT ]
	int curIdx = 0
	while ( true )
	{
		foreach( callFunc in file.OnHologramChangedCallbacks )
			callFunc( curIdx )

		FlagSet( flagsToSet[ curIdx ] )
		FlagClear( flagsToSet[ 1 - curIdx ] )
		wait 5.0

		curIdx = 1 - curIdx
	}
}
#endif

#if SERVER
void function PathTT_PlayAnnouncerLineForPlayersInRing( int lineId )
{
	array<entity> players = GetPlayerArray_AliveConnected()
	foreach( entity player in players )
	{
   		Remote_CallFunction_NonReplay(player, "SCB_PathTT_PlayRingAnnouncerDialogue", lineId )
	}
}
#endif

const array<string> RING_ANNOUNCER_LINES = [
	"bc_OlyPathTTRing_recalibrate",
	"bc_OlyPathTTRing_run_away",
	"bc_OlyPathTTRing_enter_empty_ring",
	"bc_OlyPathTTRing_challenger",
	"bc_OlyPathTTRing_killed",
	"bc_OlyPathTTRing_downed",
	"bc_OlyPathTTRing_flawless_win",
	"bc_OlyPathTTRing_chain_kill"
]
                              
const array<string> RING_ANNOUNCER_LINES_REVENANT = [
	"bc_OlyRevTTRing_recalibrate"
	"SR_OlyRevTTRing_runsAway"
	"SR_OlyRevTTRing_entersRing"
	"SR_OlyRevTTRing_challengeAccepted"
	"SR_OlyRevTTRing_killed"
	"SR_OlyRevTTRing_downed"
	"SR_OlyRevTTRing_winNoDmg"
	"SR_OlyRevTTRing_chainKill"

]
const array<string> RING_ANNOUNCER_LINES_REVENANT_EXT = [
	"bc_OlyRevTTRing_recalibrate_ext"
	"SR_OlyRevTTRing_runsAway_ext"
	"SR_OlyRevTTRing_entersRing_ext"
	"SR_OlyRevTTRing_challengeAccepted_ext"
	"SR_OlyRevTTRing_killed_ext"
	"SR_OlyRevTTRing_downed_ext"
	"SR_OlyRevTTRing_winNoDmg_ext"
	"SR_OlyRevTTRing_chainKill_ext"


]
      

const array<string> RING_ANNOUNCER_LINES_EXT  = [
	"bc_OlyPathTTRing_recalibrate_ext",
	"bc_OlyPathTTRing_run_away_ext",
	"bc_OlyPathTTRing_enter_empty_ring_ext",
	"bc_OlyPathTTRing_challenger_ext",
	"bc_OlyPathTTRing_killed_ext",
	"bc_OlyPathTTRing_downed_ext",
	"bc_OlyPathTTRing_flawless_win_ext",
	"bc_OlyPathTTRing_chain_kill_ext"
]




// NOTE!!
// Order must match RING_ANNOUNCER_LINES
// Order also defines priority. Higher ## = higher pri
enum eRingAnnouncerLines
{
	recalibrating,
	run_away,
	enter_empty_ring,
	challenger,
	killed,
	downed,
	flawless_win,
	chain_kill,

	_count
}
#if CLIENT

void function SCB_PathTT_SetMessageIdxToCustomSpeakerIdx( int customQueueIdx )
{
	file.customQueueIdx = customQueueIdx
	RegisterCustomDialogueQueueSpeakerEntities( customQueueIdx, GetEntArrayByScriptName( "path_tt_announcer_speaker" ) )
}

const float ANNOUNCER_DEBOUNCE_TIME = 5.0
void function SCB_PathTT_PlayRingAnnouncerDialogue( int lineId )
{
	if ( Time() < file.announcerLineFinishedPlayingTime && ( file.currentlyPlayingLinePriority >= lineId ) )
	{
		return
	}

	string lineToPlay = file.isInStadium? RING_ANNOUNCER_LINES[ lineId ] : RING_ANNOUNCER_LINES_EXT[ lineId ]
		//if ( IsNightMap() && UseNightRingAnnouncer() )
		//	lineToPlay = file.isInStadium? RING_ANNOUNCER_LINES_REVENANT[ lineId ] : RING_ANNOUNCER_LINES_REVENANT_EXT[ lineId ]
	float duration = GetSoundDuration( GetAnyDialogueAliasFromName( lineToPlay ) )
	file.announcerLineFinishedPlayingTime = Time() + duration + ANNOUNCER_DEBOUNCE_TIME
	file.currentlyPlayingLinePriority = lineId

	int dialogueFlags = eDialogueFlags.USE_CUSTOM_QUEUE | eDialogueFlags.USE_CUSTOM_SPEAKERS | eDialogueFlags.BLOCK_LOWER_PRIORITY_QUEUE_ITEMS
	SCB_PlayDialogueOnCustomSpeakers( GetAnyAliasIdForName( lineToPlay ), dialogueFlags, file.customQueueIdx )
}
#endif


#if CLIENT
void function ClInitPathTTRingTVEntities()
{
	ScreenOverrideInfo pathTTOverrideInfo
	pathTTOverrideInfo.scriptNameRequired = "path_tt_tv"
	pathTTOverrideInfo.skipStandardVars = true
	pathTTOverrideInfo.ruiAsset = $"ui/apex_screen_ptt.rpak"
	pathTTOverrideInfo.vars.float3s[ "customLogoSize" ] <- < 10, 10, 0 >
	pathTTOverrideInfo.bindEventIntA = true
	ClApexScreens_AddScreenOverride( pathTTOverrideInfo )
}
#endif

#if SERVER
void function InitPathTTRingTVSystem()
{
	FlagInit( FLAG_UPDATE_RING_TVS )
}

void function InitPathTTRingTVSystemEntities()
{
	thread PathTT_RingTVThink()
}

void function PathTT_RingTVThink()
{
	if ( !GetCurrentPlaylistVarBool( "enable_apex_screens", true ) )
		return

	float stateEnterTime = Time()
	float lockStateEndTime = 0.0
	while ( true )
	{
		WaitFrame()
		FlagWait( FLAG_UPDATE_RING_TVS )

		if ( Time() < lockStateEndTime )
		{
			continue
		}

		bool stateChanged = file.ringTVState != file.prevRingTVState

		switch( file.ringTVState )
		{
			case ePathTTRingTVStates.NO_PLAYERS:
				SvApexScreens_SetEventIntA( ePathTTRingTVStates.NO_PLAYERS )
				FlagClear( FLAG_UPDATE_RING_TVS )
				break

			case ePathTTRingTVStates.ONE_SQUAD:
				SvApexScreens_SetEventIntA( ePathTTRingTVStates.ONE_SQUAD )
				FlagClear( FLAG_UPDATE_RING_TVS )
				break

			case ePathTTRingTVStates.MULTIPLE_SQUADS:
				SvApexScreens_SetEventIntA( ePathTTRingTVStates.MULTIPLE_SQUADS )
				FlagClear( FLAG_UPDATE_RING_TVS )
				break

			case ePathTTRingTVStates.RUN_AWAY:

				if ( stateChanged)
				{
					stateEnterTime = Time()
					SvApexScreens_SetEventIntA( ePathTTRingTVStates.RUN_AWAY )
				}

				if ( Time() - stateEnterTime > RING_TV_TEMP_MESSAGE_DISPLAY_TIME )
					PathTT_SetRingTVState( PathTT_GetRingTVStateFromPlayersInRing() )
				break

			case ePathTTRingTVStates.KNOCKOUT:

				if ( stateChanged )
				{
					stateEnterTime = Time()
					SvApexScreens_SetEventIntA( ePathTTRingTVStates.KNOCKOUT )
					lockStateEndTime = Time() + RING_TV_KNOCKOUT_TIME_ELAPSED_CAN_OVERRIDE
				}

				if ( Time() - stateEnterTime > RING_TV_TEMP_MESSAGE_DISPLAY_TIME )
				{
					PathTT_SetRingTVState( PathTT_GetRingTVStateFromPlayersInRing() )
				}
				break

			default:
				Assert( false, "Error! Path TT ring TVs in invalid state! " + file.ringTVState )
		}

		file.prevRingTVState = file.ringTVState
	}
}

int function PathTT_GetRingTVStateFromPlayersInRing()
{
	if ( file.numTeamsInRing < 1 )
		return ePathTTRingTVStates.NO_PLAYERS
	else if ( file.numTeamsInRing < 2 )
		return ePathTTRingTVStates.ONE_SQUAD
	else
		return ePathTTRingTVStates.MULTIPLE_SQUADS

	unreachable
}

void function PathTT_RevertToPreviousState()
{
	file.ringTVState = file.prevRingTVState
}

void function PathTT_SetRingTVState( int newState )
{
	if ( newState == file.ringTVState )
		return

	file.prevRingTVState = file.ringTVState
	file.ringTVState = newState
	FlagSet( FLAG_UPDATE_RING_TVS )
}
#endif // SERVER

#if SERVER
void function PathTT_SpawnLootRollers()
{
	if ( !GetCurrentPlaylistVarBool( "path_tt_loot_rollers_enabled", true ) )
		return

	array<entity> lootRollerSpawns = GetEntArrayByScriptName( "path_tt_loot_roller_spawn" )
	foreach( entity spawn in lootRollerSpawns )
	{
		//LootRollers_CreatePathTTLootRoller( spawn.GetOrigin(), spawn.GetAngles() )
	}
}
#endif

#if SERVER
void function PathTT_OnEnterPathTTRingTrigger( entity trigger, entity ent )
{
	if ( !IsValid( ent ) || !IsAlive( ent ) || !ent.IsPlayer() )
	{
		return
	}

	// Getting revived gets registered as a leave callback.
	if ( Bleedout_IsPlayerGettingFirstAid( ent ) || Bleedout_IsPlayerSelfReviving( ent ) )
	{
		return
	}

	BoxingRingPlayerData newPlayerData
	newPlayerData.player = ent
	//newPlayerData.immunityStatusEffectHandle = StatusEffect_AddEndless( ent, eStatusEffect.immune_to_abilities, 1.0 )
	//newPlayerData.boxingStatusEffectHandle = StatusEffect_AddEndless( ent, eStatusEffect.is_boxing, 1.0 )

	//Signal( ent, "DeathTotem_ForceEnd" )
	Signal( ent, "EndStim" )
	Signal( ent, "PhaseTunnel_EndPlacement" )
	Signal( ent, "HuntMode_ForceAbilityStop" )
	//Signal( ent, "DeployableBreachChargePlacement_End" )
	ChargeTactical_ForceEnd( ent )

	GivePathTTMeleeWeaponsToPlayer( newPlayerData )
	//ent.DisableWeaponTypes( PATH_TT_DISABLED_WEAPON_TYPES )
	// Allow switching between weapon tabs in hud while main weapons are disabled
	//ent.Weapon_SetAllowHudSelectionWhileWeaponsDisabled( true )

	file.numPlayersInRing++
	if ( file.numPlayersInRing >= 1 )
	{

		if ( file.numPlayersInRing == 1 )
		{
			FlagSet( FLAG_ARENA_LIGHTS_01 )
			FlagSet( FLAG_ARENA_LIGHTS_02 )
			FlagSet( FLAG_ARENA_LIGHTS_03 )
			FlagSet( FLAG_ARENA_LIGHTS_04 )
			FlagSet( FLAG_ARENA_ROPES )
		}
	}

	PathTT_UpdateRingCrowdAudio()

	if ( Time() - file.lastBellDingTime > PATH_TT_BELL_DING_DEBOUNCE )
	{
		EmitSoundAtPosition( TEAM_UNASSIGNED, file.centerRingSoundOrigin, PLAYER_ENTER_RING_BELL, trigger )
		file.lastBellDingTime = Time()
	}

	// Determine whether the entering player is on a team that *isn't* in the ring.
	// Heads up: This is done BEFORE the player data is added. PathTT_GetNumTeamsInBoxingRing will NOT count the new entering player.
	array<int> teamsInRing = PathTT_GetNumTeamsInBoxingRing()
	int newPlayerTeam      = ent.GetTeam()
	int prevNumTeamsInRing = teamsInRing.len()
	int numTeamsInRing     = prevNumTeamsInRing
	if ( !teamsInRing.contains( newPlayerTeam ) )
	{
		numTeamsInRing++
	}
	file.numTeamsInRing = numTeamsInRing

	if ( prevNumTeamsInRing < 1 )
	{
		PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.enter_empty_ring )
	}
	else if ( prevNumTeamsInRing == 1 && numTeamsInRing > 1 )
	{
		PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.challenger )
	}

	file.allRingPlayerData.append( newPlayerData )

	PathTT_SetRingTVState( PathTT_GetRingTVStateFromPlayersInRing() )
	// TODO: Handle self-res
	PathTT_PlayerPassThroughRingShieldCeremony( ent )
}

const int NUM_BOTS_TO_TEST = 30//55
const float TEST_DURATION_RAPID_RING_ENTRY = 30
void function DEV_TestRapidRingEntryAndDeath()
{
	#if DEV
	ServerCommand( "kick_all_bots" )
	int startNumPlayers = GetPlayerArray().len()
	int numBots = NUM_BOTS_TO_TEST - startNumPlayers

	if ( numBots <= 0 )
	{
		Warning( "Warning! DEV_TestRapidRingEntry can't spawn bots! Too many players!" )
		return
	}

	ServerCommand( "bots " + NUM_BOTS_TO_TEST )

	wait 5

	const float MARK_FOR_DEATH_INTERVAL = 2.0
	const float SWAP_IN_OUT_INTERVAL = 0.2

	float lastMarkedForDeathTime = Time()
	float lastSwapInOutTime = Time()
	array<entity> devTestBots = GetPlayerArray().slice( startNumPlayers )
	array<entity> botsInRing
	array<entity> botsOutOfRing = clone devTestBots
	const vector ORG_INSIDE_RING  = < -16856, 21392, -6464 >
	const vector ORG_OUTSIDE_RING = <-14072, 26456, -6888>
	int numBotsRemaining = devTestBots.len()

	int numInitSwappedBots = 0
	while( numInitSwappedBots <  NUM_BOTS_TO_TEST / 2 )
	{
		devTestBots[ numInitSwappedBots].SetOrigin( GetRandomPointInCircle( ORG_INSIDE_RING, 512.0 ) )
		numInitSwappedBots++
	}

	// Swap bots in and out, kill bots
	while( numBotsRemaining > 0 )
	{
		float elapsedMFDTime = Time() - lastMarkedForDeathTime
		float elapsedSwapTime = Time() - lastSwapInOutTime
		int numBotsInRing = botsInRing.len()

		if ( elapsedSwapTime > SWAP_IN_OUT_INTERVAL )
		{
			// Don't move a bot out if there's just one left
			if ( numBotsRemaining > 1 && numBotsInRing > 0 )
			{
				entity outBot = botsInRing.getrandom()
				outBot.SetOrigin( GetRandomPointInCircle( ORG_OUTSIDE_RING, 512.0 ) + < 0, 0, 512.0 > )
				botsInRing.fastremovebyvalue( outBot )
				botsOutOfRing.append( outBot )
			}

			if ( botsOutOfRing.len() > 0 )
			{
				entity inBot = botsOutOfRing.getrandom()
				inBot.SetOrigin( GetRandomPointInCircle( ORG_INSIDE_RING, 512.0 ) )
				botsInRing.append( inBot )
				botsOutOfRing.fastremovebyvalue( inBot )
			}

			lastSwapInOutTime = Time()
		}

		if ( elapsedMFDTime > MARK_FOR_DEATH_INTERVAL && botsInRing.len() > 0 )
		{
			entity markedBot = botsInRing.pop()
			devTestBots.fastremovebyvalue( markedBot )
			markedBot.TakeDamage( 150, null, null, [] )
			thread DEV_FinishOffBotToKill( markedBot )

			lastMarkedForDeathTime = Time()
		}

		numBotsRemaining = devTestBots.len()
		WaitFrame()
	}
	#endif
}

void function DEV_FinishOffBotToKill( entity botToKill )
{
	#if DEV
	wait 3
	botToKill.TakeDamage( 150, null, null, [] )
	#endif
}
#endif

#if CLIENT
// TODO: HANDLE RESPAWNING
// Plays the exit trigger sound at the correct time. Sounds really off if it just comes from the server
void function Cl_PathTT_MonitorIsPlayerInBoxingRing( entity trigger )
{
	entity player = GetLocalViewPlayer()
	if ( !IsValid( player ) )
		return

	EndSignal( player, "OnDestroy" )

	while ( true )
	{
		WaitSignal( trigger, "OnStartTouch", "OnEndTouch" )

		if ( IsAlive( player ) )
			PathTT_PlayerPassThroughRingShieldCeremony( player )
	}

}

void function Cl_PathTT_MonitorIsPlayerInStadium( entity trigger )
{
	entity player = GetLocalViewPlayer()
	if ( !IsValid( player ) )
		return

	EndSignal( player, "OnDestroy" )

	while ( true )
	{
		table signal = WaitSignal( trigger, "OnStartTouch", "OnEndTouch" )
		if ( signal.signal == "OnStartTouch" )
			file.isInStadium = true
		else
			file.isInStadium = false
	}
}

bool function DEV_CheckIsPlayerInRing()
{
	return file.isInStadium
}
#endif

#if SERVER
void function PathTT_OnExitPathTTRingTrigger( entity trigger, entity ent )
{
	BoxingRingPlayerData ornull playerDataOrNull = PathTT_GetBoxingRingPlayerData( ent )
	if ( playerDataOrNull == null )
	{
		return
	}

	// Getting revived gets registered as a leave callback.
	if ( Bleedout_IsPlayerGettingFirstAid( ent ) || Bleedout_IsPlayerSelfReviving( ent ) )
	{
		return
	}

	BoxingRingPlayerData playerData = expect BoxingRingPlayerData( playerDataOrNull )
	file.allRingPlayerData.fastremovebyvalue( playerData )

	int prevNumTeamsInRing = file.numTeamsInRing
	file.numTeamsInRing = PathTT_GetNumTeamsInBoxingRing().len()

	if ( IsValid( ent ) && ent.IsPlayer() )
	{
		// Even if player is dead, undo status effects, and re-enable weapon types
		StatusEffect_Stop( ent, playerData.immunityStatusEffectHandle )
		StatusEffect_Stop( ent, playerData.boxingStatusEffectHandle )
		//ent.EnableWeaponTypes( PATH_TT_DISABLED_WEAPON_TYPES )
		//ent.Weapon_SetAllowHudSelectionWhileWeaponsDisabled( false )
		if ( IsAlive( ent ) )
		{
			// Only return weapons to player if they're alive. If they're dead, the respawn sequence will handle weapons.
			thread ReturnOriginalMeleeWeaponsToPlayer( playerData )
			if ( prevNumTeamsInRing > file.numTeamsInRing && prevNumTeamsInRing > 1 )
			{
				PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.run_away )
				if ( !Bleedout_IsBleedingOut( ent ) )
				{
					PathTT_SetRingTVState( ePathTTRingTVStates.RUN_AWAY )
				}
			}
			else
				PathTT_SetRingTVState( PathTT_GetRingTVStateFromPlayersInRing() )
		}
	}

	file.numPlayersInRing--

	// Don't play if player DCs or dies inside trigger
	if ( !trigger.ContainsPoint( ent.GetOrigin() ) )
		PathTT_PlayerPassThroughRingShieldCeremony( ent )

	if ( file.numPlayersInRing <= 0 )
	{
		PathTT_UpdateRingCrowdAudio()

		FlagClear( FLAG_ARENA_LIGHTS_01 )
		FlagClear( FLAG_ARENA_LIGHTS_02 )
		FlagClear( FLAG_ARENA_LIGHTS_03 )
		FlagClear( FLAG_ARENA_LIGHTS_04 )
		FlagClear( FLAG_ARENA_ROPES )
	}
}
#endif

#if SERVER
BoxingRingPlayerData ornull function PathTT_GetBoxingRingPlayerData( entity player )
{
	PathTT_CleanUpInvalidPlayerData()
	
	foreach( BoxingRingPlayerData playerData in file.allRingPlayerData )
		if ( playerData.player == player )
			return playerData

	return null
}
#endif

#if SERVER
void function PathTT_CleanUpInvalidPlayerData()
{
	array< BoxingRingPlayerData > clonedData = clone file.allRingPlayerData

	int debugInitLen = file.allRingPlayerData.len()

	foreach( BoxingRingPlayerData playerData in clonedData )
		if ( !IsValid( playerData.player ) )
			file.allRingPlayerData.fastremovebyvalue( playerData )
}
#endif

#if SERVER
array<int> function PathTT_GetNumTeamsInBoxingRing()
{
	PathTT_CleanUpInvalidPlayerData()
	array<int> teams
	foreach( BoxingRingPlayerData playerData in file.allRingPlayerData )
	{
		// Defensive fix. This should get cleaned up next time this is called. Bug is R5DEV-207385
		if ( !IsValid( playerData.player ) )
			continue

		int playerTeam = playerData.player.GetTeam()
		if ( !teams.contains( playerTeam ) )
		{
			teams.append( playerTeam )
		}
	}

	return teams
}
#endif


void function PathTT_PlayerPassThroughRingShieldCeremony( entity player )
{
	vector org = player.GetOrigin()
	#if SERVER
		EmitSoundAtPositionExceptToPlayer( TEAM_UNASSIGNED, org, player, PLAYER_PASS_THROUGH_RING_SHIELD_SOUND )
	#endif

	#if CLIENT
		//Signal( player, "DeployableBreachChargePlacement_End" )
		EmitSoundAtPosition( TEAM_UNASSIGNED, org, PLAYER_PASS_THROUGH_RING_SHIELD_SOUND )
	#endif
}

enum ePathTTRingAudio
{
	CROWD,
	ANNOUNCER,

	_count
}

#if SERVER
void function PathTT_UpdateRingCrowdAudio()
{
	switch( file.numPlayersInRing )
	{
		case 0:
			PathTT_SetCrowdAmbienceActive( false )
			break

		default:
			PathTT_SetCrowdAmbienceActive( true )
			break
	}
}
#endif

#if SERVER
void function PathTT_SetCrowdAmbienceActive( bool active )
{
	foreach( entity ambient in file.boxingRingCrowdAmbients_active )
	{
		ambient.SetEnabled( active )
	}

	SetGlobalNetBool( "PathTT_IsCrowdActive", active )
}
#endif

#if CLIENT
void function OnIsCrowdActiveChanged( entity player, bool new )
{
	foreach( entity ambient in file.boxingRingCrowdAmbients_AudioPlaced )
	{
		ambient.SetEnabled( new )
	}
}
#endif

#if SERVER
void function PathTT_PlayRingAudio( string audioName )
{
	foreach( entity ambient in file.boxingRingCrowd_cheerTargets )
	{
		EmitSoundAtPosition( TEAM_UNASSIGNED, ambient.GetOrigin(), audioName, ambient)
	}

	file.lastCrowdStingerTime = Time()
}
#endif

#if SERVER
string function PathTT_GetCrowdCheerToPlay()
{
	array<int> teamsInRing = PathTT_GetNumTeamsInBoxingRing()

	// Short cheer if other teams are there, long cheer if that was the last one
	if ( teamsInRing.len() > 1 )
		return "survival_crowd_cheering_01"
	else
		return "survival_crowd_cheering_02"

	unreachable
}
#endif

#if SERVER
bool function PathTT_CanPlayCrowdStinger()
{
	return Time() - file.lastCrowdStingerTime > PATH_TT_CROWD_STINGER_DEBOUNCE
}
#endif

#if SERVER
void function GivePathTTMeleeWeaponsToPlayer( BoxingRingPlayerData playerData )
{
	entity player = playerData.player
	player.Signal( "GivePathTTMeleeWeaponsToPlayer" )

	// Don't take path melee gloves
	entity meleeWeapon = player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 )
	string meleeSkinName

	if ( meleeWeapon != null )
		meleeSkinName = meleeWeapon.GetWeaponClassName()

	if ( ArePathfinderGloves( meleeSkinName ) )
		return

                            
                      
            
                        
        
                                                         
       

	entity offhandWeapon = player.GetOffhandWeapon( OFFHAND_MELEE )
	string offhandWepName

	if ( offhandWeapon != null )
	{
		offhandWepName = offhandWeapon.GetWeaponClassName()
		player.TakeWeaponNow( offhandWepName )
		player.TakeOffhandWeapon(OFFHAND_MELEE)
		player.TakeNormalWeaponByIndexNow( WEAPON_INVENTORY_SLOT_PRIMARY_2 )

		if ( offhandWepName == "melee_boxing_ring" )
		{
			//offhandWepName = Survival_GetOffhandMeleeWeaponName( player )
		}
	}

	else
	{
		player.TakeOffhandWeapon(OFFHAND_MELEE)
		player.TakeNormalWeaponByIndexNow( WEAPON_INVENTORY_SLOT_PRIMARY_2 )
		
		//if ( meleeSkinName == "mp_weapon_melee_boxing_ring" )
			//meleeSkinName = Survival_GetMeleeWeaponName( player )
	}

	player.GiveWeapon( "mp_weapon_melee_boxing_ring", WEAPON_INVENTORY_SLOT_PRIMARY_2 )
	player.GiveOffhandWeapon( "melee_boxing_ring", OFFHAND_MELEE )

	// Fix for R5DEV-220501. Somehow this was working without manually setting weapon active.
	//player.SetActiveWeaponBySlot( eActiveInventorySlot.mainHand, WEAPON_INVENTORY_SLOT_PRIMARY_2 )
	// R5DEV-572581.  Putting call to make weapon active in thread.
	// This will allow time for active slot to become re-enabled if player grapples into ring.
	thread SetMeleeWeaponToActiveSlot_Thread( player )
	playerData.meleeWeapons = [ meleeSkinName, offhandWepName ]
}

void function SetMeleeWeaponToActiveSlot_Thread( entity player )
{
	player.EndSignal( "OnDeath" )
	player.EndSignal( "ReturnOriginalMeleeWeaponsToPlayer" )
	player.EndSignal( "GivePathTTMeleeWeaponsToPlayer" )

	while ( player.IsWeaponSlotDisabled( eActiveInventorySlot.mainHand ) )
	{
		WaitFrame();
	}

	player.SetActiveWeaponBySlot( eActiveInventorySlot.mainHand, WEAPON_INVENTORY_SLOT_PRIMARY_2 )
}

bool function ArePathfinderGloves( string meleeSkinName )
{
	return meleeSkinName == "mp_weapon_pathfinder_gloves_primary"
}
#endif

#if SERVER
void function ReturnOriginalMeleeWeaponsToPlayer( BoxingRingPlayerData playerData )
{
	entity player = playerData.player
	player.Signal( "ReturnOriginalMeleeWeaponsToPlayer" )

	player.EndSignal( "OnDeath" )
	player.EndSignal( "ReturnOriginalMeleeWeaponsToPlayer" )
	player.EndSignal( "GivePathTTMeleeWeaponsToPlayer" )

	if ( IsValid( player ) && player.IsPlayer() )
	{
		string meleeSkinName = player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ).GetWeaponClassName()
		if ( ArePathfinderGloves( meleeSkinName ) )
			return

		player.TakeWeaponNow( "mp_weapon_melee_boxing_ring" )
		player.TakeWeaponNow( "melee_boxing_ring" )

		while ( true )
		{
			int readyWeaponCount

			if ( player.GetOffhandWeapon( OFFHAND_MELEE ) != null && player.GetOffhandWeapon( OFFHAND_MELEE ).GetWeaponClassName() == "melee_boxing_ring" )
			{
				player.TakeWeaponNow( "melee_boxing_ring" )
			}

			if ( player.GetOffhandWeapon( OFFHAND_MELEE ) == null )
			{
				if ( IsValid ( playerData.meleeWeapons[ 1 ] ) )
				{
					player.GiveOffhandWeapon( playerData.meleeWeapons[ 1 ], OFFHAND_MELEE )
				//	MeleeWeaponCosmetics_ApplyForWeapon( player, player.GetOffhandWeapon( OFFHAND_MELEE ) )
				}
				else
					Warning( "%s Could not return Offhand weapon to player! Please bug!", FUNC_NAME() )
			}
			else if ( player.GetOffhandWeapon( OFFHAND_MELEE ).GetWeaponClassName() != "melee_boxing_ring" )
			{
				readyWeaponCount++
			}

			if ( player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ) != null && player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ).GetWeaponClassName() == "mp_weapon_melee_boxing_ring" )
			{
				player.TakeWeaponNow( "mp_weapon_melee_boxing_ring" )
			}

			if ( player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ) == null )
			{
				if ( IsValid ( playerData.meleeWeapons[ 0 ] ) )
				{
					player.GiveWeapon( playerData.meleeWeapons[ 0 ], WEAPON_INVENTORY_SLOT_PRIMARY_2 )
				//	MeleeWeaponCosmetics_ApplyForWeapon( player, player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ) )
				}
				else
					Warning( "%s Could not return Primary weapon to player! Please bug!", FUNC_NAME() )
			}
			else if ( player.GetNormalWeapon( WEAPON_INVENTORY_SLOT_PRIMARY_2 ).GetWeaponClassName() != "mp_weapon_melee_boxing_ring" )
			{
				readyWeaponCount++
			}

			if ( readyWeaponCount == 2 )
			{
				break
			}

			WaitFrame()
		}
	}
}
#endif

#if SERVER
// TODO: Playing incorrect kill line when downed
void function PathTT_OnPlayerKilled( entity victim, entity attacker, var damageInfo )
{
	// Only react + play applause if they're the last in their squad
	if ( Bleedout_AnyOtherSquadmatesAliveAndNotBleedingOut( victim ) )
		return

	BoxingRingPlayerData ornull playerDataOrNull = PathTT_GetBoxingRingPlayerData( victim )
	if ( playerDataOrNull != null )
	{
		if ( PathTT_CanPlayCrowdStinger() )
			PathTT_PlayRingAudio( PathTT_GetCrowdCheerToPlay() )

		PathTT_SetJumboTronScreenToKO()

		PathTT_SetRingTVState( ePathTTRingTVStates.KNOCKOUT )

		PathTT_Announcer_ProcessKnockedOrKilledPlayer( victim, attacker, damageInfo )

		if ( attacker != victim )
			thread PlayBoxingRingKnockdownCommentary( attacker )
	}
}
#endif

#if SERVER
const float PATH_TT_JUMBO_TRON_KO_SCREEN_TIME = 5.0
void function PathTT_SetJumboTronScreenToKO()
{
	file.timeToRevertJumboTronKOScreen = Time() + PATH_TT_JUMBO_TRON_KO_SCREEN_TIME

	file.boxingRingJumboScreens[ 1 ].Show()
	file.boxingRingJumboScreens[ 0 ].Hide()

	if ( !file.isKOScreenActive )
	{
		file.isKOScreenActive = true
		thread PathTT_WaitToSetJumboTronScreenToAd()
	}
}
#endif

#if SERVER
void function PathTT_WaitToSetJumboTronScreenToAd()
{
	while ( true )
	{
		if ( Time() < file.timeToRevertJumboTronKOScreen )
		{
			WaitFrame()
			continue
		}

		PathTT_SetJumboTronScreenToAd()
		break
	}
}
#endif

#if SERVER
void function PathTT_SetJumboTronScreenToAd()
{
	file.boxingRingJumboScreens[ 1 ].Hide()
	file.boxingRingJumboScreens[ 0 ].Show()
	file.isKOScreenActive = false
}
#endif

#if SERVER
const float PATH_TT_CROWD_STINGER_DEBOUNCE = 0.5
void function PathTT_PlayerBleedoutStateChanged( entity player, int newState )
{
	if ( newState != BS_BLEEDING_OUT )
		return

	// Handle edge case for returning weapons to players who were downed, then left ring
	BoxingRingPlayerData ornull playerDataOrNull = PathTT_GetBoxingRingPlayerData( player )
	if ( playerDataOrNull == null )
		return

	entity attacker = Bleedout_GetBleedoutAttacker( player )
	if ( IsValid( attacker ) && ( attacker != player ) )
	{
		thread PlayBoxingRingKnockdownCommentary( attacker )
	}

	// Audio / jumbo tron reacts when someone goes down in the ring
	if ( PathTT_CanPlayCrowdStinger() )
		PathTT_PlayRingAudio( PathTT_GetCrowdCheerToPlay() )

	PathTT_SetJumboTronScreenToKO()

	PathTT_SetRingTVState( ePathTTRingTVStates.KNOCKOUT )

}
#endif

#if SERVER
void function PlayBoxingRingKnockdownCommentary( entity killer )
{
	AssertIsNewThread()
	wait 1.75

	if ( !ShouldPlayBoxingRingKnockdownCommentary( killer ) )
		return

	// Cutting this line on request from writing
	//PlayBattleChatterLineToSpeakerAndTeam( killer, "bc_eventBoxingKill" )
}
#endif

#if SERVER
bool function ShouldPlayBoxingRingKnockdownCommentary( entity killer )
{
	if ( !IsValid( killer ) )
		return false

	if ( !IsAlive( killer ) )
		return false

	if ( !killer.IsPlayer() )
		return false

	return true
}
#endif //#if SERVER

#if SERVER
// Announcer callouts for killstreak or flawless kill
const float DAMAGE_DONE_FOR_FLAWLESS_KILL = 70.0
void function PathTT_OnPlayerBleedoutStarted( entity player, entity attacker, var damageInfo )
{
	PathTT_Announcer_ProcessKnockedOrKilledPlayer( player, attacker, damageInfo )
}
#endif


#if SERVER
void function PathTT_Announcer_ProcessKnockedOrKilledPlayer( entity victim, entity attacker, var damageInfo )
{
	if ( !IsBitFlagSet( DamageInfo_GetCustomDamageType( damageInfo ), DF_MELEE ) )
		return

	if ( victim == attacker )
		return

	BoxingRingPlayerData ornull attackerDataOrNull = PathTT_GetBoxingRingPlayerData( attacker )
	if ( attackerDataOrNull == null )
		return

	BoxingRingPlayerData attackerData = expect BoxingRingPlayerData( attackerDataOrNull )
	attackerData.knockedPlayers++

	bool isFlawlessKill = false

	if ( attackerData.knockedPlayers == 3 )
	{
		PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.chain_kill )
	}
	else
	{
		if ( !attackerData.hasTakenDamage )
		{
			if ( victim in attackerData.damageDealtToPlayersInRing && attackerData.damageDealtToPlayersInRing[ victim ] > DAMAGE_DONE_FOR_FLAWLESS_KILL )
			{
				PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.flawless_win )
				isFlawlessKill = true
			}
		}

		if ( !isFlawlessKill )
		{
			if ( IsAlive( victim ) )
				PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.downed )
			else
				PathTT_PlayAnnouncerLineForPlayersInRing( eRingAnnouncerLines.killed )
		}
	}
}
#endif

#if SERVER
void function PathTT_OnPlayerDamaged( entity player, var damageInfo )
{
	PrintDamageFlags( DamageInfo_GetCustomDamageType( damageInfo ) )
	if ( !IsBitFlagSet( DamageInfo_GetCustomDamageType( damageInfo ), DF_MELEE ) )
	{
		return
	}

	BoxingRingPlayerData ornull playerDataOrNull = PathTT_GetBoxingRingPlayerData( player )
	if ( playerDataOrNull != null )
	{
		BoxingRingPlayerData playerData = expect BoxingRingPlayerData( playerDataOrNull )
		playerData.hasTakenDamage = true
		//playerData.hitCombo = 0
	}

	entity attacker = DamageInfo_GetAttacker( damageInfo )
	if ( IsValid( attacker ) && attacker.IsPlayer() && IsAlive( attacker ) )
	{
		BoxingRingPlayerData ornull attackerDataOrNull = PathTT_GetBoxingRingPlayerData( attacker )
		if( attackerDataOrNull != null && !Bleedout_IsBleedingOut( player ) )
		{
			BoxingRingPlayerData attackerData = expect BoxingRingPlayerData( attackerDataOrNull )
			float damageDealt = DamageInfo_GetDamage( damageInfo )
			if ( player in attackerData.damageDealtToPlayersInRing )
			{
				attackerData.damageDealtToPlayersInRing[ player ] += damageDealt
				//attackerData.hitCombo++
			}
			else
			{
				attackerData.damageDealtToPlayersInRing[ player ] <- damageDealt
				//attackerData.hitCombo++
			}
		}
	}
}
#endif

#if SERVER
void function DEV_SimulateThermiteTrace()
{
	entity player = GetPlayerArray()[ 0 ]
	vector traceStart = player.EyePosition()
	vector traceDir = AnglesToForward( player.EyeAngles() )
	vector traceVec = ( traceDir * 4096.0 )
	vector traceEnd = traceStart + traceVec
	array<entity> ignoreArray = [ player ]
	TraceResults traceResults = TraceLine( traceStart, traceEnd, ignoreArray, TRACE_MASK_SHOT, TRACE_COLLISION_GROUP_BLOCK_WEAPONS )
	float traceFrac = traceResults.fraction
	vector hitPos = traceStart + ( traceVec * traceFrac )
	//DebugDrawSphere( hitPos, 16, COLOR_YELLOW, true, 10.0 )
	//DebugDrawLine( traceStart, traceEnd, COLOR_GREEN, true, 10.0 )
}
#endif

#if CLIENT
void function Boxing_WeaponStatusCheck( entity player, var rui, int slot )
{
	switch ( slot )
	{
		case OFFHAND_LEFT:
		case OFFHAND_INVENTORY:
			/*if ( StatusEffect_HasSeverity( player, eStatusEffect.is_boxing ) )
			{
				RuiSetBool( rui, "isBoxing", true )
			}
			else
			{
				RuiSetBool( rui, "isBoxing", false )
			}*/
			break
	}
}
#endif

//CHECK IF THE TT EXISTS IN THE MAP
bool function IsPathTTEnabled()
{
	if (MapName() == eMaps.mp_rr_olympus_tt )
	{
		return true
	}

	return false
}

                     
