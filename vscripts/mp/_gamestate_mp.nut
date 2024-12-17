// stub script

global function GameState_GetTimeLimitOverride

global function GetConnectedPlayers
global function AllTeamsConnected

global function IsRoundBasedGameOver
global function ShouldRunEvac
global function GiveTitanToPlayer
global function GetTimeLimit_ForGameMode
global function SetGameState
global function GameState_EntitiesDidLoad

global function CodeCallback_GamerulesThink
global function Flowstate_AssignUniqueCharacterForPlayer

struct {
	int gameState = -1
} file

float function GameState_GetTimeLimitOverride()
{
	return 100
}

array<entity> function GetConnectedPlayers()
{
	array<entity> players = GetPlayerArray()
	array<entity> guys
	foreach ( player in players )
	{
		if ( !player.hasConnected )
			continue

		guys.append( player )
	}

	return guys
}

bool function AllTeamsConnected()
{
	if ( IsFFAGame() )
		return true

	table<int, int> teamToPlayerCountTable

	array<entity> players = GetPlayerArray()
	foreach ( player in players )
	{
		if ( !player.hasConnected )
			continue

		int playerTeam = player.GetTeam()
		if ( playerTeam in teamToPlayerCountTable )
		{
			teamToPlayerCountTable[ playerTeam ]++
		}
		else
		{
			teamToPlayerCountTable[ playerTeam ] <- 1
			if ( teamToPlayerCountTable.len() == MAX_TEAMS )
				return true
		}
	}

	return false
}

bool function IsRoundBasedGameOver()
{
	return false
}

bool function ShouldRunEvac()
{
	return true
}

void function GiveTitanToPlayer(entity player)
{

}

float function GetTimeLimit_ForGameMode()
{
	return 100.0
}

void function SetGameState( int newState )
{
	if ( newState == GetGameState() )
		return
	
	level.nv.gameStateChangeTime = Time()
	level.nv.gameState = newState
	Signal( svGlobal.levelEnt, "GameStateChanged", { newState = newState } )
	SetServerVar( "gameState", newState )

	if( Flag( "EntitiesDidLoad" ) && Gamemode() != eGamemodes.SURVIVAL )
		SetGlobalNetInt( "gameState", newState )

	// added in AddCallback_GameStateEnter
	foreach ( callbackFunc in svGlobal.gameStateEnterCallbacks[ newState ] )
	{
		callbackFunc()
	}
	
	switch ( newState )
	{
		// case eGameState.WaitingForCustomStart:
			// break

		case eGameState.WaitingForPlayers:
			thread Sequence_WaitingForPlayers()
			break

		case eGameState.PickLoadout:
			thread Sequence_PickLoadout()
			break

		case eGameState.Prematch:
			thread Sequence_Prematch()
			break

		// case eGameState.Playing:
			// break

		// case eGameState.SuddenDeath:
			// break

		// case eGameState.WinnerDetermined:
			// break

		// case eGameState.SwitchingSides:
			// break

		// case eGameState.Epilogue:
			// break

		// case eGameState.Resolution:
			// break

		// case eGameState.Postmatch:
			// break

		default:
			Assert( false, "Unknown game state" )
	}
	
	LiveAPI_OnGameStateChanged( newState )
}

void function CodeCallback_GamerulesThink()
{
	int gameState = GetGameState()
	if ( gameState != file.gameState )
	{
		string oldPrintVal = file.gameState == -1 ? "-1" : GetEnumString( "eGameState", file.gameState )
		string newPrintVal = gameState == -1 ? "-1" : GetEnumString( "eGameState", gameState )
		printw( "GameState changed from", oldPrintVal, "to", newPrintVal )

		file.gameState = gameState
	}
}


#if SERVER
/*
	███████╗███████╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗ ██████╗███████╗███████╗
	██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔════╝██╔════╝██╔════╝
	███████╗█████╗  ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║     █████╗  ███████╗
	╚════██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ██║╚██╗██║██║     ██╔══╝  ╚════██║
	███████║███████╗╚██████╔╝╚██████╔╝███████╗██║ ╚████║╚██████╗███████╗███████║
	╚══════╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚══════╝
	
	This part describes the onboarding sequences: threaded functions which control the onboarding.
*/

void function Sequence_WaitingForPlayers()
{
	// Wait the absolute minimum delay, if required (0 by default)
	wait PreGame_GetWaitingForPlayersDelayMin()

	// Start to wait for players.
	// Countdown will be reached when the minimum amount of players join, or when the maximum delay is reached (if enabled).
	float timeSpentWaitingForPlayers = 0.0
	float maximumTimeToSpendToWaitForPlayers = PreGame_GetWaitingForPlayersDelayMax() - PreGame_GetWaitingForPlayersDelayMin()

	// bool shouldNotWaitForever = maximumTimeToSpendToWaitForPlayers > 0.0 && !PreGame_GetWaitingForPlayersWaitForeverEnabled()

	const float LOOP_INTERVAL = 0.1
	while ( !Flag( "MinPlayersReached" ) )
	{
		timeSpentWaitingForPlayers += LOOP_INTERVAL
		wait LOOP_INTERVAL

		int connectedPlayerCount = GetPlayerArray().len()

		// if ( shouldNotWaitForever 
			// && timeSpentWaitingForPlayers >= maximumTimeToSpendToWaitForPlayers
			// && connectedPlayerCount > 0
			// )
			// break
	}

	// Update to make client aware of the countdown
	UpdateSequencedTimePoints( Time() )

	bool introCountdownEnabled = CharSelect_GetIntroCountdownDuration() > 0.0
	
	if( Gamemode() != eGamemodes.SURVIVAL)
		wait PreGame_GetWaitingForPlayersCountdown() + (introCountdownEnabled ? 0.0 : CharSelect_GetIntroMusicStartTime()) - 1
	else
		wait PreGame_GetWaitingForPlayersCountdown() + (introCountdownEnabled ? 0.0 : CharSelect_GetIntroMusicStartTime())
	
	if( Gamemode() == eGamemodes.fs_aimtrainer )
		return

	if( Gamemode() != eGamemodes.SURVIVAL && Gamemode() != eGamemodes.WINTEREXPRESS )
	{
		foreach( player in GetPlayerArray() )
		{
			if( !IsValid( player ) )
				continue
			
			if( Gamemode() != eGamemodes.CUSTOM_CTF )
			{
				ScreenCoverTransition_Player(player, Time() + 2)
			} 
			else
			{
				ScreenFade( player, 0, 0, 0, 255, 1, 0, FFADE_OUT | FFADE_STAYOUT )
			}
		}
	}
	
	#if TRACKER
		if( bLog() && !Tracker_IsBatchStatsLoaded() && Flowstate_IsTrackerSupportedMode() )
			waitthread WaitSignalOrTimeout( svGlobal.levelEnt, Tracker_GetMaxWaitForBatchLoad(), "BatchFetchComplete" )
	
		WaitFrame()
	#endif

	if ( GetCurrentPlaylistVarBool( "survival_commentary_champion_enabled", true ) && GetPlayerArray().len() > 0 )
	{
		#if !TRACKER 
			entity champion = GetPlayerArray().getrandom()
			SetChampion( champion )
		#endif
	}

	if ( !introCountdownEnabled )
		PlayPickLoadoutMusic( false )
	
	SetGameState( eGameState.PickLoadout )
}

void function Sequence_PickLoadout()
{
	if ( Playlist() == ePlaylists.fs_scenarios || !Survival_CharacterSelectEnabled() || Gamemode() != eGamemodes.SURVIVAL || Playlist() == ePlaylists.fs_haloMod_survival ) 
	{
		foreach ( player in GetPlayerArray() )
		{
			ItemFlavor musicPack = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_MusicPack() )
			string skydiveMusicID = MusicPack_GetSkydiveMusic( musicPack )
			StopMusicOnPlayer( player, skydiveMusicID )
			
			if( Playlist() == ePlaylists.fs_haloMod_survival )
			{
				CharacterSelect_AssignCharacter( player, GetItemFlavorByGUID( ConvertItemFlavorGUIDStringToGUID( "SAID00898565421" ) ) )
			}
		}

		// thread Sequence_Prematch()
		SetGameState( eGameState.Prematch )
		return
	}

	// Assign character selection order to teams
	AssignLockStepOrder()

	ScreenCoverTransition_AllPlayers( Time() + CharSelect_GetIntroTransitionDuration() )
	wait CharSelect_GetIntroTransitionDuration()

	// Update future time points now that the delays should be predictable
	UpdateSequencedTimePoints( Time() )

	bool introCountdownEnabled = CharSelect_GetIntroCountdownDuration() > 0.0

	// Signalize that character selection sequence should be started clientside
	SetGlobalNetBool( "characterSelectionReady", true )

	if ( introCountdownEnabled )
	{
		wait CharSelect_GetIntroCountdownDuration() + (CharSelect_GetIntroMusicStartTime() - CharSelect_GetIntroTransitionDuration())
		PlayPickLoadoutMusic( true )
	}

	wait CharSelect_GetPickingDelayBeforeAll()

	for ( int pickIndex = 0; pickIndex < MAX_TEAM_PLAYERS; pickIndex++ )
	{
		float startTime = Time()

		float timeSpentOnSelection = Survival_GetCharacterSelectDuration( pickIndex ) + CharSelect_GetPickingDelayAfterEachLock()
		if ( pickIndex == 0 )
			timeSpentOnSelection += CharSelect_GetPickingDelayOnFirst()

		float endTime = startTime + timeSpentOnSelection

		SetGlobalNetInt( "characterSelectLockstepIndex", pickIndex )
		SetGlobalNetTime( "characterSelectLockstepStartTime", startTime )
		SetGlobalNetTime( "characterSelectLockstepEndTime", endTime )
		
		//compare player pick with GetLoadoutSlotContentsIndexInternal( playerEHI, entry ) before setting a forced pick
		// if( pickIndex == 0 ) 
		// {
			foreach ( player in GetAllPlayersOfLockstepIndex( pickIndex ) )
			{
				Flowstate_AssignUniqueCharacterForPlayer(player, false)
			}
		// }
		
		wait timeSpentOnSelection

		foreach ( player in GetAllPlayersOfLockstepIndex( pickIndex ) )
		{
			ItemFlavor selectedCharacter = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_CharacterClass() )
			CharacterSelect_AssignCharacter( player, selectedCharacter )
		}

		wait CharSelect_GetPickingDelayAfterEachLock()
	}

	// Reset selection step to lock all character selection loadout slots
	SetGlobalNetInt( "characterSelectLockstepIndex", MAX_TEAM_PLAYERS )

	foreach ( player in GetPlayerArray() )
		if ( !player.GetPlayerNetBool( "hasLockedInCharacter" ) )
			Flowstate_AssignUniqueCharacterForPlayer(player, true) // Joined too late, assign a random legend so everything runs fine

	wait CharSelect_GetPickingDelayAfterAll()

	wait CharSelect_GetOutroTransitionDuration() + CharSelect_GetOutroSceneChangeDuration() / 3.5 - CharSelect_GetPickingDelayAfterEachLock() * MAX_TEAM_PLAYERS

	if ( CharSelect_PlayerSquadIntroEnabled() ) {
		if ( CharSelect_PostSelectionMusicEnabled() )
			foreach ( player in GetPlayerArray() )
			{
				string skydiveMusicID = MusicPack_GetSkydiveMusic( LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_MusicPack() ) )
				EmitSoundOnEntityOnlyToPlayer( player, player, skydiveMusicID )
			}

		wait CharSelect_GetOutroSquadPresentDuration() - CharSelect_GetOutroSceneChangeDuration() / 3.5
	}

	SetGameState( eGameState.Prematch )
}

void function Sequence_Prematch()
{
	// Update future time points now that the delays should be predictable
	UpdateSequencedTimePoints( Time() )

	if ( CharSelect_ChampionSquadIntroEnabled() )
		wait CharSelect_GetOutroChampionPresentDuration()

	// The gamemode handles everything past this point
	SetGameState( eGameState.Playing )
}

void function Flowstate_AssignUniqueCharacterForPlayer(entity player, bool lock)
{
	// Warning( "Flowstate_AssignUniqueCharacterForPlayer" )
	// DumpStack()
	
	array< ItemFlavor > characters = clone GetAllCharacters()

	for ( int i = characters.len() - 1; i >= 0; i-- )
	{
		int playlistOpinion = GetItemFlavorPlaylistOpinion( ItemFlavor_GetHumanReadableRef( characters[ i ] ) )

		if( playlistOpinion == eItemFlavorPlaylistOpinion.LOCKED )
			characters.remove( i )
	}
	
	bool quit
	for ( int i = characters.len() - 1; i >= 0; i-- )
	{
		quit = false
		foreach ( squadMate in GetPlayerArrayOfTeam( player.GetTeam() ) )
		{
			if( quit )
				continue

			if( squadMate == player )
				continue
			
			ItemFlavor mateCharacter = LoadoutSlot_GetItemFlavor( ToEHI( squadMate ), Loadout_CharacterClass() )
			if( mateCharacter == characters[ i ] )
			{
				characters.remove( i )
				quit = true
			}
		}
	}

	ItemFlavor initialCharacter
	
	if( characters.len() == 0) //Shouldn't happen, but just in case. (Teams of more than 10 players probably)
		initialCharacter = GetAllCharacters().getrandom()
	else
		initialCharacter = characters.getrandom()
	
	player.SetPlayerNetInt( "characterSelectFocusIndex", ConvertItemFlavorToLoadoutSlotContentsIndex( Loadout_CharacterClass(), initialCharacter ) )
	
	CharacterSelect_AssignCharacter( player, initialCharacter )
	
	if( !lock || IsDevGamemode() || Gamemode() == eGamemodes.WINTEREXPRESS )
		player.SetPlayerNetBool( "hasLockedInCharacter", false )
}

// Custom logic for sequence orchestration
void function UpdateSequencedTimePoints( float referenceTime, int gameStateOverride = -1 )
{
	SetGlobalNetInt( "gameState", GetGameState() )

	if( Playlist() == ePlaylists.fs_scenarios )
		return

	switch ( gameStateOverride != -1 ? gameStateOverride : GetGameState() )
	{
		case eGameState.WaitingForPlayers:
			SetGlobalNetTime( "PreGameStartTime", referenceTime + PreGame_GetWaitingForPlayersCountdown() )
			SetGlobalNetTime( "pickLoadoutGamestateStartTime", referenceTime + PreGame_GetWaitingForPlayersCountdown() + CharSelect_GetIntroTransitionDuration() + CharSelect_GetIntroCountdownDuration() )
			break
		case eGameState.PickLoadout:
			float timeBeforeCharacterSelection = CharSelect_GetIntroCountdownDuration() + CharSelect_GetPickingDelayBeforeAll()
		
			float timeToSelectAllCharacters = CharSelect_GetPickingDelayOnFirst()
			for ( int pickIndex = 0; pickIndex < MAX_TEAM_PLAYERS; pickIndex++ )
				timeToSelectAllCharacters += Survival_GetCharacterSelectDuration( pickIndex ) + CharSelect_GetPickingDelayAfterEachLock()
		
			float timeAfterCharacterSelection = CharSelect_GetPickingDelayAfterAll() + CharSelect_GetOutroTransitionDuration()

			float timeBeforeChampionPresentation = CharSelect_PlayerSquadIntroEnabled() ? CharSelect_GetOutroSquadPresentDuration() : 0.0
			float timeAfterChampionPresentation = CharSelect_ChampionSquadIntroEnabled() ? CharSelect_GetOutroChampionPresentDuration() : 0.0
				
			SetGlobalNetTime( "squadPresentationStartTime", referenceTime + timeBeforeCharacterSelection + timeToSelectAllCharacters + timeAfterCharacterSelection )
			SetGlobalNetTime( "championSquadPresentationStartTime", referenceTime + timeBeforeCharacterSelection + timeToSelectAllCharacters + timeAfterCharacterSelection + timeBeforeChampionPresentation )
			SetGlobalNetTime( "pickLoadoutGamestateEndTime", referenceTime + timeBeforeCharacterSelection + timeToSelectAllCharacters + timeAfterCharacterSelection + timeBeforeChampionPresentation + timeAfterChampionPresentation )
			break
	}
}

void function PlayPickLoadoutMusic( bool introCountdownEnabled )
{
	if ( !Survival_CharacterSelectEnabled() )
		return

	foreach ( player in GetPlayerArray() )
	{
		string pickLoadoutMusicID = MusicPack_GetCharacterSelectMusic( LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_MusicPack() ) )
		EmitSoundOnEntityOnlyToPlayer( player, player, pickLoadoutMusicID )
	}

	wait fabs( CharSelect_GetIntroMusicStartTime() )

	if ( introCountdownEnabled )
		wait CharSelect_GetIntroTransitionDuration()
}

#endif

void function GameState_EntitiesDidLoad()
{

}
