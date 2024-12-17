global function InitCryptoMap
//global function CodeCallback_PreMapInit

#if SERVER
global function PrecacheCryptoMapAssets
//global function InitCryptoSquadTVs
	#if DEV
	/*global function DEV_SpawnBotsRandomlyForCryptoTT
	global function DEV_TestSatelliteBlendMatrix
	global function DEV_TestFireCryptoSatellite_Thread
	global function DEV_CryptoTT_FakeReturningToIdle*/
	#endif
#endif

#if CLIENT
/*global function ClCryptoTVsInit
global function SCB_DisplayEnemiesOnMinimap_CryptoTT
global function SCB_PlayFullAndMinimapSequence_CryptoTT
global function RegisterCLCryptoCallbacks*/
#endif

const float CRYPTO_MAP_WORLD_SCAN_SCALE = 80000
const float CRYPTO_MAP_SCAN_NOTIFICATION_DIST = 12500//18500
const float CRYPTO_MAP_PROJECTION_RADIUS = 352
const float CRYPTO_MAP_PROJECTION_RADIUS_BUFFER = 16
const float CRYPTO_WORLD_TO_HOLO_SCALE = 0.00685//SHOULD BE 0.0085, shrinking while geo gets fixed
const vector CRYPTO_HOLO_OFFSET = < -32, 32, 16 >
const float CRYPTO_TT_TRIGGER_RADIUS = 1536//704
const float CRYPTO_TT_HOLO_MAP_RUI_INTERACT_RADIUS = 576
const float CRYPTO_TT_TRIGGER_EXIT_RADIUS = CRYPTO_TT_TRIGGER_RADIUS + 256.0

const float CRYPTO_TT_BUTTON_USE_TIME = 5.0

const float CRYPTO_TT_MAP_SCAN_DELAY = 45.0
const float CRYPTO_TT_PREFIRE_TIME = 38.0/30

const float CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE = 10.0
const float CRYPTO_TT_ENEMY_MINIMAP_ICON_FADE_TIME = 10.0
const float CRYPTO_TT_TINT_DURATION = CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE + CRYPTO_TT_ENEMY_MINIMAP_ICON_FADE_TIME

#if SERVER

// Satellite animation
const string SIGNAL_CRYPTO_SATELLITE_END_WARMUP_BLEND = "cryptoSatEndWarmup"
const float CRYPTO_TT_SAT_BLEND_FIRE = 10.0
const float CRYPTO_TT_SAT_BLEND_BASE = 0.0
const float CRYPTO_TT_INPUT_DELAY = 0.5

const float CRYPTO_TT_MAP_DISPLAY_TIME = 30.0
const float CRYPTO_TT_DEAD_PLAYER_DISPLAY_TIME = 10.0

//TODO: Get correct colors for this
const vector CRYPTO_HOLO_MAP_CHAMPION_COLOR = TEAM_COLOR_YOU
const vector CRYPTO_HOLO_MAP_KILL_LEADER_COLOR = < 255, 70, 32 > // Red version of enemy
const vector CRYPTO_HOLO_MAP_REG_PLAYER_COLOR = TEAM_COLOR_ENEMY //TEAM_COLOR_ENEMY
const vector CRYPTO_HOLO_MAP_ACTIVATOR_COLOR = TEAM_COLOR_FRIENDLY * 2 //TEAM_COLOR_PARTY
const vector CRYPTO_HOLO_MAP_CIRCLE_NEXT_COLOR = TEAM_COLOR_FRIENDLY //TEAM_COLOR_PARTY * 0.7

// Drawing players on holo map
const float HOLO_MAP_MAX_PLAYER_RING_RADIUS = 60000 * CRYPTO_WORLD_TO_HOLO_SCALE
const array<float> HOLO_MAP_RING_SCALE_INTERVALS = [ 0.1, 0.25, 0.5, 1 ]
const array<float> HOLO_MAP_PLAYER_OPACITY_INTERVALS = [ 1.0, 0.85, 0.5, 0.1 ]
const float HOLO_MAP_PLAYER_PIN_HEIGHT = 16
const float CRYPTO_RADAR_PULSE_TIME = 5.0//2.35

// Draw deathfield
const float CRYPTO_TT_HOLO_MAP_DEATHFIELD_MAX_DRAW_SIZE = CRYPTO_MAP_WORLD_SCAN_SCALE
const vector CRYPTO_TT_HOLO_MAP_DEATHFIELD_COLOR = < 255, 160, 20 >

// Drawing circle on the holo map
const float CIRCLE_FX_SEGMENT_LEN_DEG = 360.0 / 64.0
const float CIRCLE_FX_SEPARATION_LEN_DEG = 0.0
const vector CRYPTO_TT_CIRCLE_DEFAULT_OFFSET = < 0, 0, 32 >

const array<asset> CRYPTO_MAP_PIECES = [ $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_01.rmdl",
	$"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_02.rmdl",
	$"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_03.rmdl",
	$"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_04.rmdl",
	$"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_05.rmdl" ]

const asset CRYPTO_MAP_CIRCLE_FX 			= $"P_holo_ar_radius_pc64_CP_1x20"
const asset CRYPTO_MAP_NEXT_CIRCLE_FX 		= $"P_map_holo_ring_CP"
const asset CRYPTO_MAP_PLAYER_FX 			= $"P_map_player_pt_enemy" //enemy
const asset CRYPTO_MAP_ACTIVATOR_SQUAD_FX	= $"P_map_player_pt_team" //team
const asset CRYPTO_MAP_SCAN_FX 				= $"P_crypto_holo_sat_scan"
#endif

#if CLIENT
const float CRYPTO_MAP_TOPO_ICON_WIDTH = 10.0
const float CRYPTO_MAP_TOPO_WIDTH = 178.0
const float CRYPTO_MAP_TOPO_HEIGHT = 128.0
const float CRYPTO_MAP_TOPO_FLYOUT_WIDTH = 8.0

const float CRYPTO_MAP_RUI_ORIENT_MIN_DIST = 8.0
const float CRYPTO_MAP_RUI_LOOKING_AT_ORIENT_MIN_DIST = 16.0	// Line this up with close fade dist in crypto_tt_holo_map.rui
const float CRYPTO_MAP_RUI_EXPANDED_LOOKING_AT_ORIENT_MIN_DIST = 48.0	// Line this up with close fade dist in crypto_tt_holo_map.rui
const vector CRYPTO_MAP_RUI_OFFSET = < CRYPTO_MAP_TOPO_ICON_WIDTH + 8.0, 64, 0 >
const vector CRYPTO_MAP_RUI_EXPANDED_OFFSET = < 80, 64, 0 >

const float CRYPTO_MAP_FOCUS_MIN_DISTANCE = 80.0
const float CRYPTO_MAP_FOCUS_BLOCK_RADIUS = 5.0
const float CRYPTO_MAP_FOCUS_ENTER_RADIUS = 10.0
const float CRYPTO_MAP_FOCUS_EXIT_RADIUS = 64.0

const float CRYPTO_MAP_FOCUS_TIME_TO_ACTIVATE = 1.0
const float CRYPTO_ACTIVATED_PANEL_INACTIVE_HIDE_TIME = 7.5

const vector CRYPTO_MAP_FOCUS_ENTER_OFFSET = < 0, 10, 0 >

enum eCryptoRUIColorIdxs
{
	NEUTRAL = 1,
	LOCKED,
	U_R_HERE

}


#endif

#if SERVER
struct HoloMapFXCircleData
{
	int             fxIdx
	entity          fxMover
	vector			moverOffset
	array<entity> 	fxEnts
	bool            wasInscribedArcFlipped
	int             hiddenFxIdx = -1// The index including and past which all fx are hidden
}

struct PlayerOnCryptoMapData
{
	float alpha
	vector color
	float revealDelay
	float distFromCryptoTT
	vector fxOrg
	int fxIdx
	entity player
	int activatingTeam
	entity activatingPlayer
	int statusEffectHandle
}
#endif

#if CLIENT
struct HoloMapRUIData
{
	var    	topo
	var    	rui
	var    	topo_FlyoutLine
	var		rui_FlyoutLine
	bool   	canExpand
	string 	hatchId
	vector 	origin
	vector 	originExpanded
	vector	originFlyout
	bool   	isExpanded
}
#endif

struct
{
	vector           	cryptoHoloMapOrigin
	vector           	cryptoHoloProjBasinOrigin
	entity           	cryptoHoloMapEnt

	#if SERVER
		entity           	cryptoSatProp
		array<entity> 		holoMapFXForClearnup

		table< int > teamToSquadCountInTVRange
		int numTeamsInSquadTVRange
		array<entity> allPlayersInSquadTVRange
		table< string, array<vector> > audioForCleanup

		bool satelliteBlendThinkActive
		float satelliteBlendThinkTarget
		float satelliteBlendTargetChangeTime
	#endif

	#if CLIENT
		bool playerInHoloRoom
		bool allCryptoRuisHidden
		//array<ApexScreenState> cryptoTTApexScreenStates
		array< HoloMapRUIData > allHoloMapRUIData
		array< HoloMapRUIData > expandableHoloMapRUIData
		HoloMapRUIData& holoMap_YouAreHere
	#endif
} file

void function CodeCallback_PreMapInit()
{
	AddCallback_OnNetworkRegistration( OnNetworkRegistration )
}

void function OnNetworkRegistration()
{
	//Remote_RegisterClientFunction( "SCB_DisplayEnemiesOnMinimap_CryptoTT", "float", 0.0, 9999.9, 32 )
	//Remote_RegisterClientFunction( "SCB_PlayFullAndMinimapSequence_CryptoTT", "bool", "float", 0.0, 9999.9, 32 )
}

#if SERVER
void function PrecacheCryptoMapAssets()
{
	for( int i; i < CRYPTO_MAP_PIECES.len(); i++ )
	{
		PrecacheModel( CRYPTO_MAP_PIECES[ i ] )
	}

	PrecacheParticleSystem( CRYPTO_MAP_CIRCLE_FX )
	PrecacheParticleSystem( CRYPTO_MAP_PLAYER_FX )
	PrecacheParticleSystem( CRYPTO_MAP_ACTIVATOR_SQUAD_FX )
	PrecacheParticleSystem( CRYPTO_MAP_NEXT_CIRCLE_FX )
	PrecacheParticleSystem( CRYPTO_MAP_SCAN_FX )
}
#endif

#if CLIENT
void function RegisterCLCryptoCallbacks()
{
	//AddCreateCallback( "trigger_cylinder_heavy", OnCryptoTTHoloMapRoomTriggerCreated )
}
#endif

////====================================================================================================================
//
//  ######   #######  ##     ##    ###    ########     ######## ##     ##
// ##    ## ##     ## ##     ##   ## ##   ##     ##       ##    ##     ##
// ##       ##     ## ##     ##  ##   ##  ##     ##       ##    ##     ##
//  ######  ##     ## ##     ## ##     ## ##     ##       ##    ##     ##
//       ## ##  ## ## ##     ## ######### ##     ##       ##     ##   ##
// ##    ## ##    ##  ##     ## ##     ## ##     ##       ##      ## ##
//  ######   ##### ##  #######  ##     ## ########        ##       ###
//
//======================================================================================================================

#if SERVER
void function InitCryptoSquadTVs()
{
	/*array<entity> cryptoProxyEnterTrig_Raw = GetEntArrayByScriptName( "crypto_tt_proximity_enter_trig" )
	array<entity> cryptoProxyExitTrig_Raw = GetEntArrayByScriptName( "crypto_tt_proximity_exit_trig" )
	if ( cryptoProxyEnterTrig_Raw.len() != 1 && cryptoProxyExitTrig_Raw.len() != 1 )
	{
		Warning( "!!! Warning !!! Missing crypto proximity trig!" )
		return
	}

	cryptoProxyEnterTrig_Raw[ 0 ].SetEnterCallback( OnPlayerEnterSquadTVRange )
	cryptoProxyExitTrig_Raw[ 0 ].SetLeaveCallback( OnPlayerLeaveSquadTVRange )*/
}

void function OnPlayerEnterSquadTVRange( entity trigger, entity player )
{
	/*if ( file.allPlayersInSquadTVRange.contains( player ) )
	{
		Warning( "!!! WARNING !!! Player entered squad TV range, but same player is already stored in array!!" )
		return
	}

	file.allPlayersInSquadTVRange.append( player )

	int playerTeam = player.GetTeam()
	bool firstInSquad = false

	if ( !( playerTeam in file.teamToSquadCountInTVRange ) )
	{
		firstInSquad = true
		file.teamToSquadCountInTVRange[ playerTeam ] <- 1
	}
	else
	{
		if ( file.teamToSquadCountInTVRange[ playerTeam ] < 1 )
			firstInSquad = true

		file.teamToSquadCountInTVRange[ playerTeam ]++
	}

	if ( firstInSquad )
	{
		file.numTeamsInSquadTVRange++

		// Subtract 1 to remove the squad of who's looking at it. This will result in lots of -1 cases, so bottom out at 0.
		SvApexScreens_SetEventIntA( CryptoTT_GetModifiedSquadNumber() )
	}*/
}

void function OnPlayerLeaveSquadTVRange( entity trigger, entity player )
{
	/*file.allPlayersInSquadTVRange.fastremovebyvalue( player )

	int playerTeam = player.GetTeam()
	if ( playerTeam in file.teamToSquadCountInTVRange )
	{
		file.teamToSquadCountInTVRange[ playerTeam ]--
		if ( file.teamToSquadCountInTVRange[ playerTeam ] <= 0 )
			file.numTeamsInSquadTVRange--

		SvApexScreens_SetEventIntA( CryptoTT_GetModifiedSquadNumber() )
	}
	else
		Warning( "!!! WARNING !!! Player left crypto tt TV range trigger without ever entering!" )*/
}

int function CryptoTT_GetModifiedSquadNumber()
{
	return 0//maxint( file.numTeamsInSquadTVRange - 1, 0 )
}
#endif // SERVER


//======================================================================================================================
//
// ##     ##  #######  ##        #######     ##     ##    ###    ########
// ##     ## ##     ## ##       ##     ##    ###   ###   ## ##   ##     ##
// ##     ## ##     ## ##       ##     ##    #### ####  ##   ##  ##     ##
// ######### ##     ## ##       ##     ##    ## ### ## ##     ## ########
// ##     ## ##     ## ##       ##     ##    ##     ## ######### ##
// ##     ## ##     ## ##       ##     ##    ##     ## ##     ## ##
// ##     ##  #######  ########  #######     ##     ## ##     ## ##
//
//======================================================================================================================


void function InitCryptoMap()
{
	wait 2
	// Dev safeties
	array<entity> cryptoHoloMapEnt_Raw = GetEntArrayByScriptName( "crypto_tt_holo_map_center" )
	if ( cryptoHoloMapEnt_Raw.len() != 1 )
	{
		Warning( "!!! Warning !!! Missing ent for crypto holo map " + cryptoHoloMapEnt_Raw.len() )
		foreach( entity mapEnt in cryptoHoloMapEnt_Raw )
		{
			DebugDrawSphere( mapEnt.GetOrigin(), 4, 255, 0, 0, true, 10.0 )
			printt( "!!! Entity:", mapEnt )
		}
		return
	}

	array<entity> cryptoSwitch_Raw = GetEntArrayByScriptName( "crypto_map_switch" )
	if ( cryptoSwitch_Raw.len() != 1 )
	{
		Warning( "!!! Warning !!! Incorrect number of crypto map switches! " + cryptoSwitch_Raw.len() )
		return
	}

	#if SERVER
		array<entity> cryptoSatelliteRaw = GetEntArrayByScriptName( "crypto_tt_satellite_prop" )
		if ( cryptoSatelliteRaw.len() != 1 )
		{
			Warning( "!!! WARNING !!! Incorrect number of crypto satellite instances found:", cryptoSatelliteRaw.len() )
			return
		}
	#endif
	file.cryptoHoloMapEnt 				= cryptoHoloMapEnt_Raw[ 0 ]
	file.cryptoHoloProjBasinOrigin 		= file.cryptoHoloMapEnt.GetOrigin()
	file.cryptoHoloMapOrigin 			= file.cryptoHoloProjBasinOrigin
	file.cryptoHoloMapOrigin 			+= LocalDirToWorldDir( CRYPTO_HOLO_OFFSET, file.cryptoHoloMapEnt )


	#if SERVER
		for( int i; i < CRYPTO_MAP_PIECES.len(); i++ )
		{
			entity mapPiece = CreatePropDynamic( CRYPTO_MAP_PIECES[ i ], file.cryptoHoloMapOrigin, file.cryptoHoloMapEnt.GetAngles() )
			mapPiece.SetModelScale( CRYPTO_WORLD_TO_HOLO_SCALE )
		}
	#endif


	/*#if CLIENT
		// RUIs for hatch bunkers
		AddCallback_ItemFlavorLoadoutSlotDidChange_AnyPlayer( Loadout_Character(), CryptoTT_OnPlayerChangeLoadout )
		entity player = GetLocalViewPlayer()

		foreach ( string id in HATCH_ZONE_IDS )
		{
			entity ruiTarget
			bool isQuestHatch = id == "12_treasure"
			if ( isQuestHatch )
				ruiTarget = GetEntByScriptName( format( HATCH_DOOR_LEAVE_SCRIPTNAME, id ) )
			else
				ruiTarget = GetEntByScriptName( format( HATCH_DOOR_ENTRANCE_SCRIPTNAME, id ) )

			vector origin          = WorldToCryptoMapPos( ruiTarget.GetOrigin() ) + < 0, 0, 64 >
			bool bunkerIsUnlocked  = IsHatchBunkerUnlocked( id )
			HoloMapRUIData ruiData = CryptoTT_CreateAndRegisterHoloMapRUIData( origin, CryptoTT_GetIconAssetForBunker( id ), CryptoTT_GetColorIdxForBunker( id ), !isQuestHatch && bunkerIsUnlocked )
			RuiSetBool( ruiData.rui, "isLocked", !bunkerIsUnlocked )
			ruiData.hatchId = id
			CryptoTT_UpdateHoloMapRUIText( ruiData, id, CryptoTT_IsPlayerCrypto( player ) )
		}

		vector uRHereOrigin = WorldToCryptoMapPos( file.cryptoHoloMapOrigin ) + < 0, 0, 64 >
		file.holoMap_YouAreHere = CryptoTT_CreateAndRegisterHoloMapRUIData( uRHereOrigin, $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_u_r_here", eCryptoRUIColorIdxs.U_R_HERE, false )
		RuiSetFloat( file.holoMap_YouAreHere.rui, "unfocusedOpacity", 0.75 )
		RuiSetString( file.holoMap_YouAreHere.rui, "collapsedText", "" )
		CryptoTT_HoloMap_OrientHoloRuis( player )
	#endif

	entity cryptoTTSwitch = cryptoSwitch_Raw[ 0 ]
	CryptoTT_HoloMap_SetButtonUsable( cryptoTTSwitch )*/

	#if SERVER
		file.cryptoSatProp = cryptoSatelliteRaw[ 0 ]
		entity hackTestScriptMover = CreateExpensiveScriptMover( file.cryptoSatProp.GetOrigin(), file.cryptoSatProp.GetAngles(), SOLID_VPHYSICS )
		file.cryptoSatProp.SetParent( hackTestScriptMover )
		thread PlayAnim( file.cryptoSatProp, "crypto_satellite_dish_idle" )

		//thread DrawDeathFieldOnCryptoTTMap()

		// Create trigger cylinder heavy for holo map room
		/*entity holoMapRoomTrigger = CreateEntity( "trigger_cylinder_heavy" )
		{
			SetTargetName( holoMapRoomTrigger, "ctt_holo_room_trig" )
			holoMapRoomTrigger.SetOwner( file.cryptoHoloMapEnt )
			holoMapRoomTrigger.SetCylinderRadius( CRYPTO_TT_TRIGGER_RADIUS )
			holoMapRoomTrigger.SetAboveHeight( 704 )
			holoMapRoomTrigger.SetBelowHeight( 16 )
			holoMapRoomTrigger.SetOrigin( file.cryptoHoloMapOrigin )
			holoMapRoomTrigger.SetTriggerType( TT_CROWD_PUSHER )
			holoMapRoomTrigger.SetCrowdPusherParams( 0.0, 0.0, 0.0, 0.0 )
			holoMapRoomTrigger.kv.triggerFilterNonCharacter = "0"
		}
		DispatchSpawn( holoMapRoomTrigger )*/
	#endif
}


/*#if CLIENT
void function OnCryptoTTHoloMapRoomTriggerCreated( entity trigger )
{
	if ( trigger.GetTargetName() != "ctt_holo_room_trig" )
		return

	trigger.SetClientEnterCallback( CryptoTT_PlayerEnterRoomTrig )
}
#endif

void function CryptoTT_HoloMap_SetButtonUsable( entity prop )
{
	#if SERVER
		CryptoTT_HoloMap_SetButtonUsable_Server( prop )
	#endif

	AddCallback_OnUseEntity_ClientServer( prop, HoloMap_OnUse )
	SetCallback_CanUseEntityCallback( prop, HoloMap_CanUse )
}

bool function HoloMap_CanUse( entity user, entity button )
{
	if ( Bleedout_IsBleedingOut( user ) )
		return false

	if ( user.ContextAction_IsActive() )
		return false

	entity activeWeapon = user.GetActiveWeapon( eActiveInventorySlot.mainHand )
	if ( IsValid( activeWeapon ) && activeWeapon.IsWeaponOffhand() )
		return false

	if ( button.e.isBusy )
		return false


	return true
}

#if SERVER
void function CryptoTT_HoloMap_SetButtonUsable_Server( entity switchEnt )
{
	switchEnt.SetUsable()
	switchEnt.SetFadeDistance( 100000 )
	switchEnt.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS | USABLE_BY_ENEMIES )
	switchEnt.SetUsablePriority( USABLE_PRIORITY_LOW )
	switchEnt.SetUsePrompts( "#CRYPTO_HOLO_MAP_USE", "#CRYPTO_HOLO_MAP_USE" )

	switchEnt.SetSkin( 0 )
}

#endif // SERVER

void function HoloMap_OnUse( entity panel, entity user, int useInputFlags )
{
	if ( !(useInputFlags & USE_INPUT_LONG) )
		return

	ExtendedUseSettings settings

	settings.duration = CRYPTO_TT_BUTTON_USE_TIME
	settings.useInputFlag = IN_USE_LONG
	settings.successSound = "lootVault_Access"

	#if CLIENT
		settings.loopSound = "survival_titan_linking_loop"
		settings.displayRuiFunc = DisplayHoldUseRUIForCryptoTTSatellite
		settings.displayRui = $"ui/health_use_progress.rpak"
		settings.icon = $"rui/hud/gametype_icons/survival/data_knife"
		settings.hint = Localize( "#HINT_SAT_ACTIVATE" )

	#endif //CLIENT

	settings.successFunc = CryptoTTScan_UseSuccess

	#if SERVER
		settings.failureFunc = CryptoTTScan_UseFailure
		settings.startFunc = CryptoTTScan_UseStart

		settings.exclusiveUse = true
		settings.setUsableOnSuccess = false
		settings.movementDisable = true
		settings.holsterWeapon = true
	#endif //SERVER

	thread ExtendedUse( panel, user, settings )
}

#if CLIENT
void function DisplayHoldUseRUIForCryptoTTSatellite( entity ent, entity player, var rui, ExtendedUseSettings settings )
{
	DisplayHoldUseRUIForCryptoTTSatellite_Internal( rui, settings.icon, Time(), Time() + settings.duration, settings.hint )
}

void function DisplayHoldUseRUIForCryptoTTSatellite_Internal( var rui, asset icon, float startTime, float endTime, string hint )
{
	RuiSetBool( rui, "isVisible", true )
	RuiSetImage( rui, "icon", icon )
	RuiSetGameTime( rui, "startTime", startTime )
	RuiSetGameTime( rui, "endTime", endTime )
	RuiSetString( rui, "hintKeyboardMouse", hint )
	RuiSetString( rui, "hintController", hint )
}
#endif

#if SERVER

#if DEV
	void function DEV_TestFireCryptoSatellite_Thread()
	{
		ExtendedUseSettings blankSettings
		CryptoTTScan_UseStart( null, null, blankSettings )

		wait CRYPTO_TT_BUTTON_USE_TIME
		CryptoTTScan_UseSuccess( GP( 0 ), GetEntByScriptName( "crypto_map_switch" ), blankSettings )
	}
#endif // DEV

void function CryptoTTScan_UseStart( entity button, entity player, ExtendedUseSettings settings )
{
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )

	if ( !file.satelliteBlendThinkActive )
		thread CryptoTT_SatelliteWarmupPoseParamsThink()

	vector intSoundOrg = CryptoTT_GetInteriorSoundEmitOrigin()
	vector extSoundOrg = CryptoTT_GetExteriorStatelliteSoundEmitOrigin()
	EmitSoundAtPosition( TEAM_UNASSIGNED, intSoundOrg, "Canyonlands_Cryto_TT_Warmup_Sequence" )
	EmitSoundAtPosition( TEAM_UNASSIGNED, extSoundOrg, "Canyonlands_Cryto_TT_Warmup_Sequence_Exterior" )
}

vector function CryptoTT_GetExteriorStatelliteSoundEmitOrigin()
{
	int attach = file.cryptoSatProp.LookupAttachment( "sat_center" )
	return file.cryptoSatProp.GetAttachmentOrigin( attach ) + ( file.cryptoSatProp.GetAttachmentUp( attach ) * 320.0 )
}

vector function CryptoTT_GetInteriorSoundEmitOrigin()
{
	return file.cryptoHoloMapOrigin + < 0, 0, 128 >
}

void function CryptoTTScan_UseFailure( entity button, entity player, ExtendedUseSettings settings )
{
	vector intSoundOrg = CryptoTT_GetInteriorSoundEmitOrigin()
	vector extSoundOrg = CryptoTT_GetExteriorStatelliteSoundEmitOrigin()

	EmitSoundAtPosition( TEAM_UNASSIGNED, intSoundOrg, "Canyonlands_Cryto_TT_Warmup_Sequence_Interrupt" )
	EmitSoundAtPosition( TEAM_UNASSIGNED, extSoundOrg, "Canyonlands_Cryto_TT_Warmup_Sequence_Exterior_Interrupt" )

	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
}

#if DEV
void function DEV_CryptoTT_FakeReturningToIdle()
{
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	thread CryptoTT_SatelliteWarmupPoseParamsThink( 9.9 )
}
#endif

void function CryptoTT_SetSatelliteBlendValueTarget( float newTarget )
{
	file.satelliteBlendThinkTarget = newTarget
}

void function CryptoTT_SetSatelliteIdleBlend( float newVal )
{
	int poseID = file.cryptoSatProp.LookupPoseParameterIndex( "transition" )
	file.cryptoSatProp.SetPoseParameter( poseID, newVal )
}

const float POSE_DECAY_TIME = CRYPTO_TT_BUTTON_USE_TIME * 2.0
void function CryptoTT_SatelliteWarmupPoseParamsThink( float initialPoseOverride = 0 )
{
	file.satelliteBlendThinkActive = true

	float poseParamValue = initialPoseOverride
	float lastBlendTarget = -1//file.satelliteBlendThinkTarget
	int poseID = file.cryptoSatProp.LookupPoseParameterIndex( "transition" )

	float blendPoseEndTime
	float blendPoseStartTime
	float blendPoseLastStartTimeToBasePose
	float blendPoseGraphStartValue
	float satelliteBlendTargetChangeTime
	while ( true )
	{
		if ( lastBlendTarget != file.satelliteBlendThinkTarget )
		{
			blendPoseGraphStartValue = poseParamValue
			satelliteBlendTargetChangeTime = Time()

			if ( file.satelliteBlendThinkTarget == CRYPTO_TT_SAT_BLEND_FIRE )
			{
				blendPoseEndTime = Time() + CRYPTO_TT_BUTTON_USE_TIME
				blendPoseStartTime = Time() + CRYPTO_TT_INPUT_DELAY
			}
			else
			{
				float timeToBasePose = ( poseParamValue / CRYPTO_TT_SAT_BLEND_FIRE ) * POSE_DECAY_TIME
				blendPoseEndTime = Time() + timeToBasePose
				blendPoseStartTime = Time()
				blendPoseLastStartTimeToBasePose = Time()
			}
		}

		float timeElapsedSinceInputChanged = Time() - satelliteBlendTargetChangeTime
		bool isInputDebouncing = ( file.satelliteBlendThinkTarget == CRYPTO_TT_SAT_BLEND_FIRE ) && ( timeElapsedSinceInputChanged < CRYPTO_TT_INPUT_DELAY )
		if ( isInputDebouncing )
		{
			poseParamValue = GraphCapped( Time(), blendPoseLastStartTimeToBasePose, blendPoseEndTime, blendPoseGraphStartValue, CRYPTO_TT_SAT_BLEND_BASE )
		}
		else
			poseParamValue = GraphCapped( Time(), blendPoseStartTime, blendPoseEndTime, blendPoseGraphStartValue, file.satelliteBlendThinkTarget )

		lastBlendTarget = file.satelliteBlendThinkTarget
		file.cryptoSatProp.SetPoseParameter( poseID, poseParamValue )

		if( ( poseParamValue == CRYPTO_TT_SAT_BLEND_BASE && !isInputDebouncing ) || poseParamValue == CRYPTO_TT_SAT_BLEND_FIRE )
			break

		WaitFrame()
	}

	file.satelliteBlendThinkActive = false
}

#if DEV
void function DEV_TestSatelliteBlendMatrix()
{
	if ( file.satelliteBlendThinkActive )
	{
		printt( "    | WARNING! Satellite blend think is already active! Wait until it's finished before calling this..." )
		return
	}

	printt( "    | ---- Blending to fire pose..." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	thread CryptoTT_SatelliteWarmupPoseParamsThink()

	wait 2
	printt( "    | ---- Now to base..." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	wait 1
	printt( "    | ---- Back to fire..." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	wait 1

	printt( "    | ---- Testing rapid back and forth. Satellite shouldn't move here." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	wait 0.2
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	wait 0.1
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	wait 0.3
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	wait 0.1
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	wait 0.2
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	wait 0.3
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	wait 0.1
	printt( "    | ---- Almost fire..." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_FIRE )
	wait 3.0

	printt( "    | ---- Finally, base..." )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
}
#endif // DEV
#endif

void function CryptoTTScan_UseSuccess( entity button, entity player, ExtendedUseSettings settings )
{
	#if SERVER
		thread CryptoTTScan_UseSuccess_Thread( button, player )
	#endif
	#if CLIENT
		thread CryptoTT_ShowSatelliteChargeRUI_Thread()
	#endif
}

#if CLIENT
const float CRYPTO_TT_CHARGE_RUI_WAIT_BEFORE_REVEAL = 5.0
void function CryptoTT_ShowSatelliteChargeRUI_Thread()
{
	wait CRYPTO_TT_CHARGE_RUI_WAIT_BEFORE_REVEAL

	float visualizedChargeTime = ( CRYPTO_TT_MAP_SCAN_DELAY + CRYPTO_TT_PREFIRE_TIME ) - CRYPTO_TT_CHARGE_RUI_WAIT_BEFORE_REVEAL
	float startTime = Time()
	float endTime = Time() + visualizedChargeTime
	while ( Time() < endTime )
	{
		float percentProgress = ( Time() - startTime ) / visualizedChargeTime
		percentProgress = min( 1.0, max( 0.0, percentProgress ) )
		int progressForText = int( percentProgress * 100 )
		RuiSetString( file.holoMap_YouAreHere.rui, "collapsedText", Localize( "#CTT_SAT_CHARGE_PERCENT_SIGN", progressForText ) )
		WaitFrame()
	}

	RuiSetString( file.holoMap_YouAreHere.rui, "collapsedText", Localize( "#CTT_SAT_CHARGE_PERCENT_SIGN", 100 ) )
	wait 2.0

	RuiSetString( file.holoMap_YouAreHere.rui, "collapsedText", "" )
}
#endif

#if SERVER
void function CryptoTTScan_UseSuccess_Thread( entity button, entity player )
{
	vector intSoundOrg = CryptoTT_GetInteriorSoundEmitOrigin()
	EmitSoundAtPosition( TEAM_UNASSIGNED, intSoundOrg, "Canyonlands_Scr_Cryto_TT_Prefire_Sequence" )
	thread AnimateCryptoTTSatellite()
	CryptoTTScan_SetUnusable( button )

	wait CRYPTO_TT_PREFIRE_TIME

	StopSoundAtPosition( intSoundOrg, "Canyonlands_Scr_Cryto_TT_Prefire_Sequence" )
	EmitSoundAtPosition( TEAM_UNASSIGNED, intSoundOrg, "Canyonlands_Scr_Cryto_TT_Fire_Sequence_3P" )
	EmitSoundAtPosition( TEAM_UNASSIGNED, CryptoTT_GetExteriorStatelliteSoundEmitOrigin(), "Canyonlands_Scr_Cryto_TT_Fired_Distant" )

	CryptoTT_DisplayPlayersOnHoloMap( player )

	SURVIVAL_ShowSurveyRegionOnSquadMaps( player )

	// Next deathfield
	DeathFieldStageData deathField
	int currentDeathFieldStageValue               = int( max( 0, SURVIVAL_GetCurrentDeathFieldStage() ) )
	int realm                                     = Survival_Loot_GetDefaultRealm()
	array< DeathFieldStageData > deathfieldStages = SURVIVAL_GetDeathFieldStages( realm )
	deathField 									  = deathfieldStages[ int( min( currentDeathFieldStageValue + 1, deathfieldStages.len() - 1 ) ) ]

	// Map pulse
	int mapPulseFX = GetParticleSystemIndex( CRYPTO_MAP_SCAN_FX )
	vector fxOrigin = WorldToCryptoMapPos( button.GetOrigin() )
	file.holoMapFXForClearnup.append( StartParticleEffectInWorld_ReturnEntity( mapPulseFX, fxOrigin, < 0, 0, 0 > ) )
	EmitSoundAtPosition( TEAM_UNASSIGNED, fxOrigin, "Canyonlands_Scr_Cryto_TT_Pulse_Expands" )

	// Next circle
	HoloMapFXCircleData fxCircleData = CreateWorldCircleOnCryptoMap( deathField.endPos, deathField.endRadius, CRYPTO_HOLO_MAP_CIRCLE_NEXT_COLOR, CRYPTO_TT_CIRCLE_DEFAULT_OFFSET, CRYPTO_MAP_NEXT_CIRCLE_FX )
	thread DeleteHolomapFX_Delayed( fxCircleData, CRYPTO_TT_MAP_DISPLAY_TIME )
	vector soundOrigin = WorldToCryptoMapPos( deathField.endPos )
	EmitSoundAtPosition( TEAM_UNASSIGNED, soundOrigin, "Canyonlands_Scr_Cryto_TT_Next_Circle" )

	thread CryptoTTScan_SetUsableAfterDelay( button, CRYPTO_TT_MAP_SCAN_DELAY )

	wait 5.0
	EmitSoundAtPosition( TEAM_UNASSIGNED, intSoundOrg, "Canyonlands_Scr_Cryto_TT_Cooldown" )
	EmitSoundAtPosition( TEAM_UNASSIGNED, CryptoTT_GetExteriorStatelliteSoundEmitOrigin(), "Canyonlands_Scr_Cryto_TT_Cooldown_Exterior" )
}

void function DrawDeathFieldOnCryptoTTMap()
{
	FlagWait( "DeathFieldCalculationComplete" )

	DeathFieldData dfData = SURVIVAL_GetDeathFieldData( Survival_Loot_GetDefaultRealm() )
	float radius = DeathField_GetRadiusForTime( Time(), dfData.codeIndex )

	// Don't draw deathfield until it's within a more reasonable size
	while ( radius > CRYPTO_TT_HOLO_MAP_DEATHFIELD_MAX_DRAW_SIZE )
	{
		radius = DeathField_GetRadiusForTime( Time(), dfData.codeIndex )
		WaitFrame()
	}

	HoloMapFXCircleData fxCircleData = CreateWorldCircleOnCryptoMap( dfData.center, radius, CRYPTO_TT_HOLO_MAP_DEATHFIELD_COLOR, < 0, 0, 64 > )

	while ( true )
	{
		dfData = SURVIVAL_GetDeathFieldData( Survival_Loot_GetDefaultRealm() )
		radius = DeathField_GetRadiusForTime( Time(), dfData.codeIndex )

		UpdateWorldCircleOnCryptoMap( fxCircleData, dfData.center, radius )

		wait 0.099
	}
}

void function CryptoTTScan_SetUnusable( entity button )
{
	button.UnsetUsable()
	button.SetSkin( 1 )
}

void function CryptoTTScan_SetUsableAfterDelay( entity button, float delay )
{
	wait delay
	button.SetUsable()
	button.SetSkin( 0 )
}

void function DeleteHolomapFX_Delayed( HoloMapFXCircleData fxCircleData, float delay )
{
	wait delay
	DeleteHoloMapFXCircleData( fxCircleData )

	foreach( entity fxEnt in file.holoMapFXForClearnup )
		fxEnt.Destroy()

	file.holoMapFXForClearnup.clear()
}

void function DeleteHoloMapFXCircleData( HoloMapFXCircleData fxCircleData )
{
	int numFxEnts = fxCircleData.fxEnts.len()
	for( int i; i < numFxEnts; i++ )
		fxCircleData.fxEnts.pop().Destroy()

	fxCircleData.fxEnts.clear()
}

void function AnimateCryptoTTSatellite()
{
	waitthread PlayAnim( file.cryptoSatProp,"crypto_satellite_dish_activate" )
	CryptoTT_SetSatelliteBlendValueTarget( CRYPTO_TT_SAT_BLEND_BASE )
	CryptoTT_SetSatelliteIdleBlend( 0.0 )
	thread PlayAnim( file.cryptoSatProp, "crypto_satellite_dish_idle" )
}

HoloMapFXCircleData function CreateWorldCircleOnCryptoMap( vector worldOrigin, float radius, vector color, vector fxOffset = CRYPTO_TT_CIRCLE_DEFAULT_OFFSET, asset fxOverride = $"", bool debug = false )
{
	HoloMapFXCircleData newData

	if ( fxOverride == $"" )
		newData.fxIdx = GetParticleSystemIndex( CRYPTO_MAP_CIRCLE_FX )
	else
		newData.fxIdx = GetParticleSystemIndex( fxOverride)

	newData.fxMover = CreateScriptMover()
	newData.moverOffset = fxOffset

	int circleFXIdx = newData.fxIdx
	float usableArcDist = 360.0
	float minFXArcDist = CIRCLE_FX_SEGMENT_LEN_DEG + CIRCLE_FX_SEPARATION_LEN_DEG
	if ( 360.0 > minFXArcDist )
		usableArcDist = 360.0 - CIRCLE_FX_SEPARATION_LEN_DEG

	int numFXArcsToPlace = int( 360.0 / CIRCLE_FX_SEGMENT_LEN_DEG )
	for( int i; i < numFXArcsToPlace; i++ )
	{
		// Spawn and angle the full circle, but leave them hidden
		float targetAngle = ( CIRCLE_FX_SEPARATION_LEN_DEG + ( CIRCLE_FX_SEGMENT_LEN_DEG * i ) ) % 360.0
		entity newFxEnt = StartParticleEffectOnEntityWithPos_ReturnEntity( newData.fxMover, circleFXIdx, FX_PATTACH_ABSORIGIN_FOLLOW, -1, newData.fxMover.GetOrigin(), < 0, targetAngle, 0 > )
		EffectSetControlPointVector( newFxEnt, 1, color )
		EffectSetControlPointVector( newFxEnt, 4, < 0.0, 0, 0 > )
		newData.fxEnts.append( newFxEnt )
	}

	UpdateWorldCircleOnCryptoMap( newData, worldOrigin, radius, debug )
	return newData
}

void function UpdateWorldCircleOnCryptoMap( HoloMapFXCircleData fxCircleData, vector worldOrigin, float radius, bool debug = false )
{
	Assert( fxCircleData.fxMover != null, "Warning! FxCircleData has an invalid parent! Did you call CreateWorldCircleOnCryptoMap first?" )

	vector drawPosition = WorldToCryptoMapPos( worldOrigin )
	drawPosition.z = file.cryptoHoloMapOrigin.z
	DisplayCircleOnCryptoMap( fxCircleData, drawPosition, radius * CRYPTO_WORLD_TO_HOLO_SCALE, debug )
}

// http://paulbourke.net/geometry/circlesphere/   <-- The following circle intersect math kindly provided by this webpage
void function DisplayCircleOnCryptoMap( HoloMapFXCircleData fxCircleData, vector origin, float radius, bool debug = false )
{
	float projectionRadius = CRYPTO_MAP_PROJECTION_RADIUS - CRYPTO_MAP_PROJECTION_RADIUS_BUFFER

	// The [start, end] in angles, within which to draw the circle. Defaults to full circle. If circle intersects bounds of projection radius, draw a partial circle.
	array<float> circleDrawAngleBounds = [ 0.0, 360.0 ]

	if ( debug )
	{
		DebugDrawCircle( origin, < 0, 0, 0 >, radius, 255, 255, 0, true, 1.0, 32 )
		DebugDrawCircle( file.cryptoHoloProjBasinOrigin, < 0, 0, 0 >, projectionRadius, 255, 0, 0, true, 1.0, 32 )
	}

	if ( IsCircleAEncompassingCircleB( origin, radius, file.cryptoHoloProjBasinOrigin, projectionRadius ) )
		return

	// Get intersection of circle and projection area
	if ( CirclesAreIntersecting( file.cryptoHoloProjBasinOrigin, projectionRadius, origin, radius ) )
	{
		array<vector> intersectionPoints = GetCircleToCircleIntersectionPoints( file.cryptoHoloProjBasinOrigin, projectionRadius, origin, radius, debug )
		// Convert the intersection points to degree angles, calculate the degree arc of the circle to draw
		// Have to use the relative origin of the circle to the map center, since GetCircleToCircleIntersectionPoints calculations are all done relative to map center
		vector relOrigin = origin - file.cryptoHoloProjBasinOrigin
		array<float> intersectionAngles
		array<float> intersectionAnglesDeg
		for( int i; i < 2; i++ )
		{
			vector localIntersectPoint = intersectionPoints[ i ] - relOrigin

			intersectionAngles.append( atan2( localIntersectPoint.y, localIntersectPoint.x ) )
			intersectionAnglesDeg.append( RadToDeg( intersectionAngles[ i ] ) )
			if ( intersectionAnglesDeg[ i ] < 0 )
				intersectionAnglesDeg[ i ] += 360
		}

		// Determine order of points such that range is p0 -> p1
		float arcLen = GetArcLengthDeg( intersectionAnglesDeg[ 0 ], intersectionAnglesDeg[ 1 ] )

		float midPoint_Angle = ( intersectionAnglesDeg[ 0 ] + ( arcLen * 0.5 ) ) % 360.0
		float midPoint_Angle_Inverse = ( midPoint_Angle + 180 ) % 360
		vector midPoint              = ( AnglesToForward( < 0, midPoint_Angle, 0 > ) * radius ) + origin
		vector midPoint_Inverse      = ( AnglesToForward( < 0, midPoint_Angle_Inverse, 0 > ) * radius ) + origin

		float midPointDist        = DistanceSqr( midPoint, file.cryptoHoloProjBasinOrigin )
		float midPointInverseDist = DistanceSqr( midPoint_Inverse, file.cryptoHoloProjBasinOrigin )

		if ( midPointInverseDist < midPointDist )
		{
			intersectionAnglesDeg.reverse()
			if ( !fxCircleData.wasInscribedArcFlipped )
				fxCircleData.wasInscribedArcFlipped = true
		}
		else
		{
			if ( fxCircleData.wasInscribedArcFlipped )
				fxCircleData.wasInscribedArcFlipped = false
		}

		circleDrawAngleBounds.clear()
		circleDrawAngleBounds.extend( intersectionAnglesDeg )
	}

	DrawFXCircleFromSegments( fxCircleData, origin, radius, circleDrawAngleBounds )
}

// Place the FX segments according to the range to draw
const float CRYPTO_HOLO_MAP_RECREATE_CIRCLE_FX_DEBOUNCE = 1.0
void function DrawFXCircleFromSegments( HoloMapFXCircleData fxCircleData, vector origin, float radius, array<float> circleDrawAngleBounds )
{
	float visibleArcLen = GetArcLengthDeg( circleDrawAngleBounds[ 0 ], circleDrawAngleBounds[ 1 ] )

	float usableVisibleArcLen  = visibleArcLen
	float fxSegmentTotalArcLen = CIRCLE_FX_SEGMENT_LEN_DEG + CIRCLE_FX_SEPARATION_LEN_DEG
	if ( visibleArcLen > fxSegmentTotalArcLen )
		usableVisibleArcLen = visibleArcLen - CIRCLE_FX_SEPARATION_LEN_DEG

	int circleFXIdx            = fxCircleData.fxIdx//GetParticleSystemIndex( CRYPTO_MAP_CIRCLE_FX )
	int numFXSegmentsToShow    = int( usableVisibleArcLen / fxSegmentTotalArcLen )
	int numShownFx             = fxCircleData.hiddenFxIdx
	int numNewFXToShow         = numFXSegmentsToShow - numShownFx
	if ( numNewFXToShow > 0 )
	{
		// Set mover rotaion back by #fx to add
		vector moverAngles = fxCircleData.fxMover.GetAngles()
		// Let's say there are 10 new segments to show. If the mover is facing the middle of the arc that represents the total visible range, then the
		// new space to fill is theoretically divided evenly on both sides of this visible arc. The mover will rotate half the length of new segments to show,
		// so that it's flush with one edge. This makes room for the full 10 on the other side. The 10 to show will then be revealed. Since the segments are revealed
		// in the forwards (positive) direction, the mover will counter-rotate negatively.
		float adjustedArcEndBound = circleDrawAngleBounds[ 0 ] > circleDrawAngleBounds[ 1 ] ? ( circleDrawAngleBounds[ 1 ] + 360.0 ) : circleDrawAngleBounds[ 1 ]
		float visibleArcLength = adjustedArcEndBound - circleDrawAngleBounds[ 0 ]
		float visibleArcCenter = ( circleDrawAngleBounds[ 0 ] + ( visibleArcLength * 0.5 ) ) % 360.0

		moverAngles.y = ( visibleArcCenter + ( fxSegmentTotalArcLen * ( numShownFx + numNewFXToShow ) * -0.5 ) ) % 360.0
		fxCircleData.fxMover.SetAngles( moverAngles )
	}

	if ( fxCircleData.fxMover.GetOrigin() != origin )
		fxCircleData.fxMover.SetOrigin( origin + fxCircleData.moverOffset )

	int numFx = fxCircleData.fxEnts.len()
	for( int i; i < numFx; i++ )
	{
		entity fxEnt = fxCircleData.fxEnts[ i ]

		EffectSetControlPointVector( fxEnt, 2, <radius, 0, 0 > )

		// Show FX if they're to be revealed. Using this set up so I can have a fade system later.
		if ( i > fxCircleData.hiddenFxIdx && i <= ( fxCircleData.hiddenFxIdx + numNewFXToShow ) )
			EffectSetControlPointVector( fxEnt, 4, < 1.0, 0, 0 > )
	}

	fxCircleData.hiddenFxIdx += numNewFXToShow
}

float function GetArcLengthDeg( float startDeg, float endDeg )
	{
		if ( endDeg < startDeg )
			endDeg += 360

	return fabs( startDeg - endDeg )
}

bool function CirclesAreIntersecting( vector org1, float rad1, vector org2, float rad2 )
{
	float distBetweenCircles = Distance( org1, org2 )

	// New circle inside projection radius
	if ( distBetweenCircles < fabs( rad1 - rad2 ) )
		return false
	else if ( distBetweenCircles < fabs( rad2 - rad1 ) )
		return false

	// Circles are literally the same
	else if ( distBetweenCircles == 0 && rad2 == rad1 )
		return false

	// Circles aren't touching
	else if ( distBetweenCircles > ( rad1 + rad2 ) )
		return false

	return true
}

bool function IsCircleAEncompassingCircleB( vector org1, float rad1, vector org2, float rad2 )
{
	float distBetweenCircles = Distance( org1, org2 )
	if ( ( distBetweenCircles < fabs( rad1 - rad2 ) ) && ( rad1 > rad2 ) )
		return true

	return false
}

// Holomap org, holomap rad, new circle org, new circle rad
array<vector> function GetCircleToCircleIntersectionPoints( vector org1, float rad1, vector org2, float rad2, bool debugDraw = false )
{
	float distBetweenCircles = Distance( org1, org2 )
	float distProjectorToIntersectCenter = ( ( rad1 * rad1 ) - ( rad2 * rad2 ) + ( distBetweenCircles * distBetweenCircles ) ) / ( 2.0 * distBetweenCircles )

	vector intersectDir    = Normalize( org2 - org1 )
	vector intersectCenter = intersectDir * distProjectorToIntersectCenter

	float intersectHeight = sqrt( ( rad1 * rad1 ) - ( distProjectorToIntersectCenter * distProjectorToIntersectCenter ) )
	vector heightDir      = CrossProduct( file.cryptoHoloMapEnt.GetUpVector(), intersectDir )

	array<vector> intersectionPoints = [ intersectCenter + ( heightDir * intersectHeight ), intersectCenter - ( heightDir * intersectHeight ) ]

	if ( debugDraw )
	{
		// Circle origins
		DebugDrawLine( org1, org1 + < 0, 0, 32 >, 255, 0, 0, true, 1.0 )
		DebugDrawLine( org2, org2 + < 0, 0, 32 >, 0, 255, 0, true, 1.0 )

		// Lines to intersection points
		DebugDrawLine( org2, intersectionPoints[ 0 ] + org1, 255, 255, 255, true, 1.0 )
		DebugDrawLine( org2, intersectionPoints[ 1 ] + org1, 0, 0, 0, true, 1.0 )
	}

	return intersectionPoints
}

void function CryptoTT_DisplayPlayersOnHoloMap( entity activatingPlayer = null )
{
	const float PLAYER_BAND_RING_PROJ_HEIGHT = 32
	vector ringCenter = WorldToCryptoMapPos( file.cryptoHoloMapOrigin ) + < 0, 0, PLAYER_BAND_RING_PROJ_HEIGHT >
	float firstRingRadius = HOLO_MAP_MAX_PLAYER_RING_RADIUS * HOLO_MAP_RING_SCALE_INTERVALS[ 0 ]
	vector offsetDir = Normalize( FlattenVec( file.cryptoHoloMapOrigin - ringCenter ) )

	array<table> playerRangeBandData
	int numHoloMapRingScaleIntervals = HOLO_MAP_RING_SCALE_INTERVALS.len()

	for( int i; i < numHoloMapRingScaleIntervals; i++ )
	{
		float curRingRadius = HOLO_MAP_MAX_PLAYER_RING_RADIUS * HOLO_MAP_RING_SCALE_INTERVALS[ i ]
		vector curRingCenter = ringCenter
		playerRangeBandData.append( { center = curRingCenter, radius = curRingRadius } )
	}

	// Get all player locations
	array<entity> allPlayers = GetPlayerArray_AliveConnected()
	array<vector> mappedOriginsXY
	int numPlayers = allPlayers.len()

	EncodedEHandle killLeaderEHandle = SurvivalCommentary_GetKillLeaderEEH()
	entity killLeaderPlayer = GetEntityFromEncodedEHandle( killLeaderEHandle )

	table< int, array<entity> > teamNumToSquad
	table< entity, vector > playerToMappedOrg
	table< int, vector > teamNumToColor

	array<PlayerOnCryptoMapData> allPlayersOnMapData

	int playerFXIdx = GetParticleSystemIndex( CRYPTO_MAP_PLAYER_FX )
	int activatorSquadFXIdx = GetParticleSystemIndex( CRYPTO_MAP_ACTIVATOR_SQUAD_FX )
	int fxIdxToUse = playerFXIdx
	for( int i; i < numPlayers; i++ )
	{

		// Calculating these in the loop because of R5DEV-133412
		int killLeaderTeam = -1
		if ( IsValid( killLeaderPlayer ) )
			killLeaderTeam = killLeaderPlayer.GetTeam()

		int championTeam = SurvivalCommentary_GetChampionTeam()

		fxIdxToUse = playerFXIdx

		int activatingPlayerTeam = -1
		if ( IsValid( activatingPlayer ) )
			activatingPlayerTeam = activatingPlayer.GetTeam()

		vector color = CRYPTO_HOLO_MAP_REG_PLAYER_COLOR
		float alpha = HOLO_MAP_PLAYER_OPACITY_INTERVALS.top() // Init alpha to the lowest possible
		entity curPlayer = allPlayers[ i ]
		int team = curPlayer.GetTeam()
		switch( team )
		{
			case activatingPlayerTeam:
				color = CRYPTO_HOLO_MAP_ACTIVATOR_COLOR
				fxIdxToUse = activatorSquadFXIdx
				Remote_CallFunction_NonReplay( curPlayer, "SCB_DisplayEnemiesOnMinimap_CryptoTT", Time() + CRYPTO_TT_MAP_DISPLAY_TIME )
				Remote_CallFunction_NonReplay( curPlayer, "SCB_PlayFullAndMinimapSequence_CryptoTT", true, CRYPTO_TT_TINT_DURATION )
				break
			case killLeaderTeam:
				color = CRYPTO_HOLO_MAP_KILL_LEADER_COLOR
				break
			case championTeam:
				color = CRYPTO_HOLO_MAP_CHAMPION_COLOR
				break
		}

		if ( team != activatingPlayerTeam )
			Remote_CallFunction_NonReplay( curPlayer, "SCB_PlayFullAndMinimapSequence_CryptoTT", false, CRYPTO_TT_TINT_DURATION )

		if( team in teamNumToSquad )
		{
			teamNumToSquad[ team ].append( curPlayer )
		}
		else
		{
			teamNumToSquad[ team ] <- [ curPlayer ]
			teamNumToColor[ team ] <- color
		}

		float playerDistToCryptoMap = Distance2D( curPlayer.GetOrigin(), file.cryptoHoloMapOrigin )
		float playerDistToRangeBand = playerDistToCryptoMap * CRYPTO_WORLD_TO_HOLO_SCALE
		for( int j; j < numHoloMapRingScaleIntervals; j++ )
		{
			if ( playerDistToRangeBand > playerRangeBandData[ j ].radius )
				continue
			alpha = HOLO_MAP_PLAYER_OPACITY_INTERVALS[ j ]
			break
		}

		vector origin = curPlayer.GetOrigin()
		vector mappedOrigin = WorldToCryptoMapPos( origin )
		mappedOriginsXY.append( mappedOrigin )
		playerToMappedOrg[ curPlayer ] <- mappedOrigin

		PlayerOnCryptoMapData newData
		newData.alpha = alpha
		newData.color = color
		newData.fxOrg = mappedOrigin
		newData.fxIdx = fxIdxToUse
		newData.player = curPlayer
		newData.activatingTeam = activatingPlayer.GetTeam()
		newData.activatingPlayer = activatingPlayer
		newData.revealDelay = ( playerDistToCryptoMap / CRYPTO_MAP_WORLD_SCAN_SCALE ) * CRYPTO_RADAR_PULSE_TIME
		newData.distFromCryptoTT = playerDistToCryptoMap
		allPlayersOnMapData.append( newData )
	}

	allPlayersOnMapData.sort( SortPlayersOnCryptoMapCloseToFar )
	thread CryptoTT_PerformCallbackOnSortedCryptoScannedPlayersOverTime( allPlayersOnMapData, CryptoTT_RevealPlayerOnMinimapAndStartSonar )
	thread CryptoTT_PerformCallbackOnSortedCryptoScannedPlayersOverTime_Delayed( allPlayersOnMapData, CryptoTT_EndSonarOnRevealedPlayers, 5.0 )
}

int function SortPlayersOnCryptoMapCloseToFar( PlayerOnCryptoMapData a, PlayerOnCryptoMapData b )
{
	if ( a.revealDelay > b.revealDelay )
		return 1

	if ( a.revealDelay < b.revealDelay )
		return -1

	return 0
}

void function CryptoTT_PerformCallbackOnSortedCryptoScannedPlayersOverTime_Delayed( array<PlayerOnCryptoMapData> playersOnMapData, void functionref( PlayerOnCryptoMapData ) callback, float delay )
{
	wait delay
	CryptoTT_PerformCallbackOnSortedCryptoScannedPlayersOverTime( playersOnMapData, callback )
}

void function CryptoTT_PerformCallbackOnSortedCryptoScannedPlayersOverTime( array<PlayerOnCryptoMapData> playersOnMapData, void functionref( PlayerOnCryptoMapData ) callback )
{
	float startTime = Time()
	int numPlayersToDraw = playersOnMapData.len()
	int idx_draw
	while ( true )
	{
		if ( idx_draw >= numPlayersToDraw )
			break

		float elapsedTime = Time() - startTime
		PlayerOnCryptoMapData playerData = playersOnMapData[ idx_draw ]
		if ( elapsedTime >= playerData.revealDelay )
		{
			if ( IsValid( playerData.player ) )
				callback( playerData )
			idx_draw++
		}
		else
			WaitFrame()
	}
}

void function CryptoTT_RevealPlayerOnMinimapAndStartSonar( PlayerOnCryptoMapData playerData )
{
	entity newFxEnt = StartParticleEffectInWorld_ReturnEntity( playerData.fxIdx, playerData.fxOrg, < 0, 0, 0 > )
	EffectSetControlPointVector( newFxEnt, 1, playerData.color )
	EffectSetControlPointVector( newFxEnt, 3, < playerData.alpha, 0, 0 > )

	EmitSoundAtPosition( TEAM_UNASSIGNED, playerData.fxOrg, "Canyonlands_Scr_Cryto_TT_Players_Indicator" )

	file.holoMapFXForClearnup.append( newFxEnt )
	if ( ( playerData.player.GetTeam() != playerData.activatingTeam ) && ( playerData.distFromCryptoTT < CRYPTO_MAP_SCAN_NOTIFICATION_DIST ) )
	{
		playerData.statusEffectHandle =  StatusEffect_AddEndless( playerData.player, eStatusEffect.crypto_tt_scanned_visual, 1.0 )
		SonarStart_No3PVisuals( playerData.player, file.cryptoHoloMapOrigin, playerData.activatingTeam, playerData.activatingPlayer )

	}
}

void function CryptoTT_EndSonarOnRevealedPlayers( PlayerOnCryptoMapData playerData )
{
	if ( !IsValid( playerData.player ) )
		return

	if ( ( playerData.player.GetTeam() != playerData.activatingTeam ) && ( playerData.distFromCryptoTT < CRYPTO_MAP_SCAN_NOTIFICATION_DIST ) )
	{

		StatusEffect_Stop( playerData.player, playerData.statusEffectHandle )
		SonarEnd( playerData.player, playerData.activatingTeam, playerData.activatingPlayer )
	}
}

void function CryptoTT_AddSoundToCleanup( string soundName, vector org )
{
	if ( soundName in file.audioForCleanup )
		file.audioForCleanup[ soundName ].append( org )
	else
		file.audioForCleanup[ soundName ] <- [ org ]
}

void function CryptoTT_CleanUpSoundByName( string soundName )
{
	if ( !( soundName in file.audioForCleanup ) )
	{
		Warning( "!!! WARNING !!! Tried to clean up Crypto TT sound name that wasn't in table:", soundName )
		return
	}

	foreach( vector org in file.audioForCleanup[ soundName ] )
		StopSoundAtPosition( org, soundName )

	delete file.audioForCleanup[ soundName ]
}

#if DEV
const int DEV_NUM_BOTS_TO_SPAWN = 30
void function DEV_SpawnBotsRandomlyForCryptoTT()
{
	int playerArrayLastIdx = GetPlayerArray().len() - 1
	ServerCommand( "bots " + DEV_NUM_BOTS_TO_SPAWN )

	array<entity> allPlayers = GetPlayerArray()
	int numPlayers = allPlayers.len()
	for( int i; i < numPlayers; i++ )
	{
		if ( !allPlayers[ i ].IsBot() )
			continue

		vector randomPoint = OriginToGround( GetRandomPointInCircle( < 0, 0, 10000 >, 25000 ) ) + < 0, 0, 256.0 >
		allPlayers[ i ].SetOrigin( randomPoint )
	}
}
#endif // DEV
#endif // SERVER

vector function WorldToCryptoMapPos( vector origin )
{
	entity holoMapEnt = file.cryptoHoloMapEnt
	vector mappedPoint = ( origin.x * holoMapEnt.GetRightVector() ) + ( origin.y * holoMapEnt.GetForwardVector() ) + ( origin.z * holoMapEnt.GetUpVector() )
	mappedPoint *= CRYPTO_WORLD_TO_HOLO_SCALE
	return mappedPoint + file.cryptoHoloMapOrigin
}

#if CLIENT

void function ClCryptoTVsInit()
{
	ScreenOverrideInfo cryptoTTOverrideInfo
	cryptoTTOverrideInfo.scriptNameRequired = "ctt_tv"
	cryptoTTOverrideInfo.skipStandardVars = true
	cryptoTTOverrideInfo.ruiAsset = $"ui/apex_screen_ctt.rpak"
	cryptoTTOverrideInfo.vars.float3s[ "logoSize" ] <- < 10, 10, 0 >
	cryptoTTOverrideInfo.vars.images[ "logo" ] <- $"rui/hud/common/crypto_logo"
	cryptoTTOverrideInfo.bindEventIntA = true
	ClApexScreens_AddScreenOverride( cryptoTTOverrideInfo )
}

void function SCB_PlayFullAndMinimapSequence_CryptoTT( bool shouldTintMap, float tintDuration )
{
	FullMap_PlayCryptoPulseSequence( file.cryptoHoloMapOrigin, shouldTintMap, tintDuration )
}

void function SCB_DisplayEnemiesOnMinimap_CryptoTT( float endTime )
{
	thread CryptoTT_DisplayEnemiesOnMinimap_Thread( endTime )
}

void function CryptoTT_DisplayEnemiesOnMinimap_Thread( float endTime )
{
	entity player = GetLocalViewPlayer()
	if ( !IsValid( player ) )
		return

	int team = player.GetTeam()
	array<entity> aliveEnemies = GetPlayerArrayOfEnemies_Alive( team )

	float timeToWait = endTime - Time()
	float timeToStartFade = Time() + CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE
	float timeToEndFade = timeToStartFade + CRYPTO_TT_ENEMY_MINIMAP_ICON_FADE_TIME

	array<var> fullMapRuis
	array<var> minimapRuis
	array<entity> entsForTracking
	foreach( entity enemy in aliveEnemies )
	{
		// Full map
		var fRui = FullMap_AddEnemyLocation( enemy )
		//RuiSetBool( fRui, "additive", true )
		fullMapRuis.append( fRui )

		var mRui = Minimap_AddEnemyToMinimap( enemy )
		minimapRuis.append( mRui )
		RuiSetGameTime( mRui, "fadeStartTime", timeToStartFade )
		RuiSetGameTime( mRui, "fadeEndTime", timeToEndFade )
	}

	EmitSoundOnEntity( player, "Canyonlands_Scr_Cryto_TT_Allies_Enemies_Revealed" )

	if ( timeToWait > 0 )
	{
		// Fullmap RUI starts fading out when the "fadeOutEndTime" gametime is set. Wait, fade, wait again, destroy.
		float testIsThereTimeUntilStartFade = timeToWait - CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE
		if ( testIsThereTimeUntilStartFade > 0 )
		{
			timeToWait -= CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE
			wait CRYPTO_TT_ENEMY_MINIMAP_ICON_TIME_BEFORE_FADE
			foreach( var fRui in fullMapRuis )
			{
				RuiSetGameTime( fRui, "fadeOutEndTime", timeToEndFade )
			}

		}
		wait timeToWait
	}

	foreach( var ruiToDestroy in fullMapRuis )
	{
		Fullmap_RemoveRui( ruiToDestroy )
		RuiDestroy( ruiToDestroy )
	}

	foreach( var ruiToDestroy in minimapRuis)
	{
		Minimap_CommonCleanup( ruiToDestroy )
	}
}

void function CryptoTT_PlayerEnterRoomTrig( entity trigger, entity player )
{
	if ( !file.playerInHoloRoom )
	{
		CryptoTT_SetPlayerInHoloRoom( true )
		thread CryptoTT_MonitorPlayerInHoloRoom_Thread( trigger, player )
		thread CryptoTT_HoloMap_OrientRuiThink( trigger, player )
		thread CryptoTT_HoloMap_ExpandRUIThink( trigger, player )
	}

	if ( file.allCryptoRuisHidden )
	{
		CryptoTT_SetAllRUIHidden( false )
	}
}

void function CryptoTT_SetPlayerInHoloRoom( bool isInHoloRoom )
{
	file.playerInHoloRoom = isInHoloRoom
}

// TODO: QA - will this break if I die in the room and go to spectate? Should this instead just pause functionality until player is valid again? Big yike. Test local w/ a bot in the room
void function CryptoTT_MonitorPlayerInHoloRoom_Thread( entity trigger, entity player )
{
	EndSignal( player, "OnDestroy" )
	EndSignal( player, "OnDeath" )

	// Hide all RUI when the player dies to avoid having to handle a player spectating someone. Rui will become visible if the player enters after respawning.
	OnThreadEnd(
		function() : ( player )
		{
			if ( !IsAlive( player ) )
			{
				CryptoTT_SetAllRUIHidden( true )
				CryptoTT_SetPlayerInHoloRoom( false )
			}
		}
	)

	// No exit callbacks exist, so end it when the player leaves the radius
	while ( file.playerInHoloRoom )
	{
		// TODO: CRASHES WHEN PLAYER IS SPECTATOR
		vector playerOrg = player.GetOrigin()
		float dist2D = Distance2D( trigger.GetOrigin(), playerOrg )
		if ( dist2D > CRYPTO_TT_TRIGGER_EXIT_RADIUS )
			CryptoTT_SetPlayerInHoloRoom( false )

		WaitFrame()
	}
}

void function CryptoTT_SetAllRUIHidden( bool shouldHide )
{
	file.allCryptoRuisHidden = shouldHide
	foreach( HoloMapRUIData ruiData in file.allHoloMapRUIData )
	{
		RuiSetBool( ruiData.rui, "forceHide", shouldHide )
		if ( ruiData.canExpand )
			RuiSetBool( ruiData.rui_FlyoutLine, "forceHide", shouldHide )
	}
}

void function CryptoTT_HoloMap_OrientRuiThink( entity trigger, entity player )
{
	EndSignal( player, "OnDestroy" )
	EndSignal( player, "OnDeath" )

	while ( file.playerInHoloRoom )
	{
		// Point appropriate topos at player
		CryptoTT_HoloMap_OrientHoloRuis( player )

		WaitFrame()
	}
}

void function CryptoTT_HoloMap_OrientHoloRuis( entity player )
{
	foreach( HoloMapRUIData ruiData in file.allHoloMapRUIData )
	{
		vector forward     = player.CameraPosition() - ruiData.origin
		bool playerLookingAtRUI = DotProduct( AnglesToForward( player.CameraAngles() ), forward ) < 0
		vector forwardNorm = Normalize( < forward.x, forward.y, 0 > )
		vector rightDir    = CrossProduct( forwardNorm, < 0, 0, 1 > )

		// If rui is in expanded state, recalculate "center of billboard" target, and orientation directions, to match the expanded RUI.
		float rightOffset = CRYPTO_MAP_RUI_OFFSET.x
		if ( ruiData.isExpanded )
		{
			rightOffset = CRYPTO_MAP_RUI_EXPANDED_OFFSET.x

			rightOffset = ( CRYPTO_MAP_TOPO_WIDTH * 0.5 ) + 10
			forward = player.CameraPosition() - ruiData.originExpanded
			forwardNorm = Normalize( < forward.x, forward.y, 0 > )
			rightDir = CrossProduct( forwardNorm, < 0, 0, 1 > )

			// Orient the topo for the flyout line
			{
				vector expandedRuiLeftCorner  = ruiData.originExpanded - (rightDir * ((rightOffset * 0.5) + 16))
				vector flyoutTopoBottomCorner = ruiData.origin - < 0, 0, CRYPTO_MAP_TOPO_HEIGHT * 0.5 >
				vector cornerToCorner         = expandedRuiLeftCorner - flyoutTopoBottomCorner
				vector cornerToCornerMidpoint = (expandedRuiLeftCorner + flyoutTopoBottomCorner) * 0.5

				vector flyoutDown             = Normalize( cornerToCorner )
				vector flyoutForwardNorm      = Normalize( FlattenVec( player.CameraPosition() - cornerToCornerMidpoint ) )
				vector flyoutRight            = Normalize( CrossProduct( flyoutDown, flyoutForwardNorm ) )

				RuiTopology_UpdatePos( ruiData.topo_FlyoutLine, flyoutTopoBottomCorner - (flyoutRight * 4), flyoutRight * CRYPTO_MAP_TOPO_FLYOUT_WIDTH, flyoutDown * (Length( cornerToCorner ) + 4) )
			}

		}

		float distToRUI = Length2D( forward )
		float minDist   = CRYPTO_MAP_RUI_LOOKING_AT_ORIENT_MIN_DIST
		if ( ruiData.isExpanded )
			minDist = CRYPTO_MAP_RUI_EXPANDED_LOOKING_AT_ORIENT_MIN_DIST

		// Either player isn't looking at the rui (in which case set orientation more freely to avoid orientation snaps), or player IS looking and orientation has to freeze earlier
		bool shouldSkipOrientation = ( distToRUI < CRYPTO_MAP_RUI_ORIENT_MIN_DIST ) || ( playerLookingAtRUI && ( distToRUI < minDist ) )
		if ( shouldSkipOrientation )
			continue

		float rightWidth   = CRYPTO_MAP_TOPO_WIDTH
		vector down        = CrossProduct( forwardNorm, rightDir )
		float downHeight   = CRYPTO_MAP_TOPO_HEIGHT

		RuiTopology_UpdatePos( ruiData.topo,  CryptoTT_GetRuiOriginToUse( ruiData ) - ( rightDir * rightOffset ) - ( down * CRYPTO_MAP_RUI_OFFSET.y ), rightDir * rightWidth, down * downHeight )
	}
}

const float CRYPTO_TT_VIS_TRACE_INTERVAL = 0.1
const float CAN_EXPAND_RADIUS_FROM_MAP = 640
const float CAN_EXPAND_RADIUS_FROM_MAP_SQR = CAN_EXPAND_RADIUS_FROM_MAP * CAN_EXPAND_RADIUS_FROM_MAP
// Determines if one of the holo map RUIs should expand to show more info.
void function CryptoTT_HoloMap_ExpandRUIThink( entity trigger, entity player, bool debug = false)
{
	EndSignal( player, "OnDestroy" )
	EndSignal( player, "OnDeath" )

	HoloMapRUIData activatedPanel
	HoloMapRUIData focusCandidate
	HoloMapRUIData prevFocusCandidate
	float focusCandidateStartTime
	float activatedFocusCandidateStartTime
	float traceFrac
	float lastTraceTime
	while ( file.playerInHoloRoom )
	{
		float playerDistToMapSqr = Distance2DSqr( player.GetOrigin(), file.cryptoHoloMapOrigin )
		bool playerCloseEnoughToExpandRUI = playerDistToMapSqr <= CAN_EXPAND_RADIUS_FROM_MAP_SQR

		vector playerCamOrg 		= player.CameraPosition()
		bool closestAngleOverridden = false
		float closestAngle 			= 90.0
		float closestDistance 		= 10000000
		bool closestDistIsBlocking 	= false
		int closestAngleIdx 		= -1
		int closestDistanceIdx 		= -1
		array<HoloMapRUIData> focusCandidates
		int numRuis = file.expandableHoloMapRUIData.len()

		int testVisColGroup = TRACE_COLLISION_GROUP_NONE
		int testVisCollMask = (TRACE_MASK_VISIBLE_AND_NPCS | CONTENTS_BLOCKLOS | CONTENTS_BLOCK_PING | CONTENTS_HITBOX)

		// Only trace 10 times/second (or whatever the interval is)
		if ( playerCloseEnoughToExpandRUI && ( ( Time() - lastTraceTime ) > CRYPTO_TT_VIS_TRACE_INTERVAL ) )
		{
			vector orgStart = playerCamOrg
			vector orgEnd = playerCamOrg + ( AnglesToForward( player.CameraAngles() ) * CRYPTO_TT_TRIGGER_EXIT_RADIUS )
			TraceResults tr = TraceLine( orgStart, orgEnd, [player], testVisCollMask, testVisColGroup )
			traceFrac = tr.fraction
			vector hitPos = orgStart + ( orgEnd - orgStart ) * tr.fraction
			lastTraceTime = Time()
		}

		// If the player is too far away, skip the logic to determine if they're focusing on a RUI. Just run script to collapse already-expanded RUI.
		if ( playerCloseEnoughToExpandRUI )
		{
			for( int i; i < numRuis; i++ )
			{
				HoloMapRUIData ruiData = file.expandableHoloMapRUIData[ i ]
				bool isActivatedPanel = ruiData.topo == activatedPanel.topo

				// Get the origin to focus on
				vector viewTargetOrigin = CryptoTT_GetRuiOriginToUse( ruiData )//ruiData.origin
				vector offsetUpDir      = < 0, 0, 1 >//AnglesToUp( player.CameraAngles() )
				vector offsetFwdDir     = Normalize( viewTargetOrigin - playerCamOrg )
				vector offsetRightDir   = CrossProduct( offsetFwdDir, offsetUpDir )
				vector offset           = CRYPTO_MAP_FOCUS_ENTER_OFFSET

				viewTargetOrigin += ( offsetRightDir * offset.x ) + ( offsetUpDir * offset.y )

				float distToTarget = Distance( viewTargetOrigin, playerCamOrg )
				if ( distToTarget < CRYPTO_MAP_FOCUS_MIN_DISTANCE )
					continue

				// Player's view is obstructed. Point of obstruction os closer than the RUI to focus on so... there's no line of sight
				float traceDist = traceFrac * CRYPTO_TT_TRIGGER_EXIT_RADIUS
				if ( distToTarget > traceDist )
					continue

				// Get the FOV to focus within - Calculated from a target worldspace radius
				float radiusTarget = isActivatedPanel ? CRYPTO_MAP_FOCUS_EXIT_RADIUS : CRYPTO_MAP_FOCUS_ENTER_RADIUS
				float fovTarget = asin( radiusTarget / distToTarget ) * RAD_TO_DEG
				float fovBlockTarget = asin( CRYPTO_MAP_FOCUS_BLOCK_RADIUS / distToTarget ) * RAD_TO_DEG

				if ( debug )
				{
					vector debugColor = < 255, 0, 0 >
					if ( isActivatedPanel )
						debugColor = < 0, 255, 0 >
					DebugDrawFOVCircle( viewTargetOrigin, player.CameraPosition(), fovTarget, int( debugColor.x ), int( debugColor.y ), int( debugColor.z ), true, 0.1 )
					DebugDrawFOVCircle( viewTargetOrigin, player.CameraPosition(), fovBlockTarget, 255, 255, 0, true, 0.1 )
					if ( isActivatedPanel )
						DebugDrawSphere( ruiData.originExpanded, 4, 255, 255, 255, true, 0.1 )
				}

				// Of all targets player is looking at (looking within FOV range), get the closest to look direction, and closest to the player.
				vector playerToRuiDir = Normalize( viewTargetOrigin - playerCamOrg )
				float facingDot = DotProduct( playerToRuiDir, AnglesToForward( player.CameraAngles() ) )
				float dotAngle = DotToAngle( facingDot )

				if ( dotAngle < fovTarget )
				{
					// Save this index if it's the new closest angle.
					// If this is the active panel, override it to be closest match. Only closest dist with FOV block can override looking at the active panel.
					if ( isActivatedPanel || ( ( dotAngle < closestAngle ) && !closestAngleOverridden ) )
					{
						closestAngle = dotAngle
						closestAngleIdx = i
						if ( isActivatedPanel )
						{
							closestAngleOverridden = true
						}
					}

					float dist2D = Distance2D( playerCamOrg, viewTargetOrigin )
					if ( dist2D < closestDistance )
					{
						closestDistance = dist2D
						closestDistanceIdx = i
						closestDistIsBlocking = dotAngle < fovBlockTarget
					}
				}
			}
		}

		if ( closestAngleIdx >= 0 && closestDistanceIdx >= 0 )
		{
			prevFocusCandidate = focusCandidate
			// Only take closest distance if the closest target is "blocking" what's behind it, since player is looking at it so direclty
			if ( closestAngleIdx != closestDistanceIdx )
			{
				float closestAngleDist = Distance2D( file.expandableHoloMapRUIData[ closestAngleIdx ].origin, playerCamOrg )
				if ( closestDistIsBlocking )
					focusCandidate = file.expandableHoloMapRUIData[ closestDistanceIdx ]
				else
					focusCandidate = file.expandableHoloMapRUIData[ closestAngleIdx ]
			}
			else
				focusCandidate = file.expandableHoloMapRUIData[ closestAngleIdx ]
		}
		// Set focus candidate to a blank struct (effectively setting it to null)
		else if ( focusCandidate.topo != null )
		{
			focusCandidate = CryptoTT_CreateEmptyHoloMapRUIData()
		}

		// If new candidate, start the timer
		if ( prevFocusCandidate.topo != focusCandidate.topo )
		{
			focusCandidateStartTime = Time()
			if ( IsValid( focusCandidate.topo ) && focusCandidate.canExpand)
			{
				RuiSetBool( focusCandidate.rui, "isFocused", true )
				RuiSetGameTime( focusCandidate.rui, "startFocusTime", Time() )
				if ( focusCandidate.topo != activatedPanel.topo )
					EmitSoundAtPosition( TEAM_UNASSIGNED, focusCandidate.origin, "Canyonlands_Cryto_TT_Holo_Icon_Focus" )
			}

			if ( IsValid( prevFocusCandidate.topo ) )
				RuiSetBool( prevFocusCandidate.rui, "isFocused", false )

		}
		else if ( ( focusCandidate.topo != null ) && ( Time() - focusCandidateStartTime > CRYPTO_MAP_FOCUS_TIME_TO_ACTIVATE ) )
		{
			// Dethrone old activated RUI
			if ( activatedPanel.topo != null && activatedPanel.topo != focusCandidate.topo )
			{
				CryptoTT_SetHoloMapRUIExpandedState( activatedPanel, false )
			}

			// Activate new RUI
			if ( activatedPanel.topo != focusCandidate.topo )
			{
				CryptoTT_SetHoloMapRUIExpandedState( focusCandidate, true )
				activatedPanel = focusCandidate
				activatedFocusCandidateStartTime = Time()
				focusCandidate = CryptoTT_CreateEmptyHoloMapRUIData()
			}
		}

		if ( focusCandidate.topo == activatedPanel.topo )
		{
			activatedFocusCandidateStartTime = Time()
		}

		// Hide active panel if it's not looked at for period of time
		if ( Time() - activatedFocusCandidateStartTime > CRYPTO_ACTIVATED_PANEL_INACTIVE_HIDE_TIME )
		{
			if ( activatedPanel.topo != null )
				CryptoTT_SetHoloMapRUIExpandedState( activatedPanel, false )

			activatedPanel = CryptoTT_CreateEmptyHoloMapRUIData()
			activatedFocusCandidateStartTime = Time()

			if ( IsValid( focusCandidate.topo ) )
				focusCandidateStartTime = Time()
		}

		WaitFrame()
	}
}

HoloMapRUIData function CryptoTT_CreateEmptyHoloMapRUIData()
{
	HoloMapRUIData newData
	return newData
}

void function CryptoTT_SetHoloMapRUIExpandedState( HoloMapRUIData ruiData, bool isExpanded )
{
	RuiSetBool( ruiData.rui, "isExpanded", isExpanded )
	ruiData.isExpanded = isExpanded

	if ( IsValid( ruiData.topo_FlyoutLine ) )
		RuiSetBool( ruiData.rui_FlyoutLine, "isVisible", isExpanded )

	if ( isExpanded )
	{
		RuiSetFloat( ruiData.rui, "fadeCloseDistance", CRYPTO_MAP_RUI_EXPANDED_LOOKING_AT_ORIENT_MIN_DIST)
		RuiSetFloat( ruiData.rui_FlyoutLine, "fadeCloseDistance", CRYPTO_MAP_RUI_EXPANDED_LOOKING_AT_ORIENT_MIN_DIST)

		vector expandedOrigin = CryptoTT_GenerateNewRuiExpandedOrigin( ruiData )
		ruiData.originExpanded = expandedOrigin

		RuiSetFloat3( ruiData.rui, "ruiOrigin", expandedOrigin )
		RuiSetFloat3( ruiData.rui_FlyoutLine, "ruiOrigin", expandedOrigin )

		EmitSoundAtPosition( TEAM_UNASSIGNED, ruiData.origin, "Canyonlands_Cryto_TT_Holo_Text_Expand" )
	}
	else
	{
		RuiSetFloat( ruiData.rui, "fadeCloseDistance", CRYPTO_MAP_RUI_LOOKING_AT_ORIENT_MIN_DIST )
		RuiSetFloat3( ruiData.rui, "ruiOrigin", ruiData.origin )
	}

	// Update RUI immediately to avoid popping
	entity player = GetLocalViewPlayer()
	if ( IsValid( player ) )
		CryptoTT_HoloMap_OrientHoloRuis( player )
}

vector function CryptoTT_GenerateNewRuiExpandedOrigin( HoloMapRUIData ruiData )
{
	entity player = GetLocalViewPlayer()
	if ( !IsValid( player ) )
		return < 0, 0, 0 >

	vector forward     = player.CameraPosition() - ruiData.origin
	vector forwardNorm = Normalize( < forward.x, forward.y, 0 > )
	vector rightDir    = CrossProduct( forwardNorm, < 0, 0, 1 > )

	// If rui is in expanded state, recalculate "center of billboard" target, and orientation directions, to match the expanded RUI.
	float rightOffset = CRYPTO_MAP_RUI_EXPANDED_OFFSET.x
	return ruiData.origin + ( rightDir * rightOffset )//CRYPTO_MAP_TOPO_WIDTH * 0.5 )//rightOffset )
}

HoloMapRUIData function CryptoTT_CreateAndRegisterHoloMapRUIData( vector origin, asset collapsedIcon, int colorIdx, bool canExpand )
{
	HoloMapRUIData newData

	newData.origin = origin
	vector topoRight =  < 0, 0, CRYPTO_MAP_TOPO_WIDTH >
	vector topoUp = < 0, 0, CRYPTO_MAP_TOPO_WIDTH >
	vector topoOrg = origin + ( topoRight * -0.5 ) + ( topoUp * 0.5 )
	newData.topo = RuiTopology_CreatePlane( topoOrg, topoRight, topoUp, true )

	newData.rui = RuiCreate( $"ui/crypto_tt_holo_map_icon_bunker.rpak", newData.topo, RUI_DRAW_WORLD, RuiCalculateDistanceSortKey( GetLocalViewPlayer().EyePosition(), origin ) )//1 )
	RuiSetImage( newData.rui, "collapsedIcon", collapsedIcon )
	RuiSetFloat3( newData.rui, "ruiOrigin", newData.origin )
	RuiSetInt( newData.rui, "widgetColorIndex", colorIdx )
	RuiSetBool( newData.rui, "isFocused", false )
	newData.canExpand = canExpand

	if ( canExpand )
	{
		// Reusing these vars just for simplicity
		topoRight =  < 0, 0, CRYPTO_MAP_TOPO_FLYOUT_WIDTH >
		topoUp = < 0, 0, CRYPTO_MAP_TOPO_HEIGHT >
		topoOrg = origin + ( topoRight * -0.5 ) + ( topoUp * 0.5 )
		newData.topo_FlyoutLine = RuiTopology_CreatePlane( topoOrg, topoRight, topoUp, true )

		newData.rui_FlyoutLine = RuiCreate( $"ui/crypto_tt_holo_map_flyout_line.rpak", newData.topo_FlyoutLine, RUI_DRAW_WORLD, RuiCalculateDistanceSortKey( GetLocalViewPlayer().EyePosition(), origin ) )//1 )
		RuiSetFloat3( newData.rui_FlyoutLine, "ruiOrigin", newData.origin )
		RuiSetInt( newData.rui_FlyoutLine, "widgetColorIndex", colorIdx )
		file.expandableHoloMapRUIData.append( newData )
	}

	file.allHoloMapRUIData.append( newData )

	return newData
}

void function CryptoTT_OnPlayerChangeLoadout( EHI playerEHI, ItemFlavor character )
{
	bool isCrypto = CryptoTT_IsCharacterLoadoutCrypto( character )

	foreach( HoloMapRUIData ruiData in file.expandableHoloMapRUIData )
	{
		CryptoTT_UpdateHoloMapRUIText( ruiData, ruiData.hatchId, isCrypto )
	}
}

bool function CryptoTT_IsPlayerCrypto( entity player )
{
	ItemFlavor character = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_Character() )
	return CryptoTT_IsCharacterLoadoutCrypto( character )
}

bool function CryptoTT_IsCharacterLoadoutCrypto( ItemFlavor character )
{
	return Localize( ItemFlavor_GetShortName( character ) ) == Localize( "#character_crypto_NAME_SHORT" )
}

void function CryptoTT_UpdateHoloMapRUIText( HoloMapRUIData ruiData, string hatchId, bool isCrypto )
{
	string titleText
	string descText
	// If not crypto, desc text will be overridden
	switch( hatchId )
	{
		case "16":
			titleText = "#CTT_BUNKER_NAME_Z16"
			descText = "#CTT_BUNKER_DESC_Z16"
			break
		case "6":
			titleText = "#CTT_BUNKER_NAME_Z6"
			descText = "#CTT_BUNKER_DESC_Z6"
			break
		case "5":
			titleText = "#CTT_BUNKER_NAME_Z5"
			descText = "#CTT_BUNKER_DESC_Z5"
			break
		case "12":
			titleText = "#CTT_BUNKER_NAME_Z12"
			descText = "#CTT_BUNKER_DESC_Z12"
			break
		case "12_treasure":
			titleText = "#CTT_BUNKER_NAME_Z12_MYSTERY"
			break
	}


	if ( !IsHatchBunkerUnlocked( hatchId ) )
	{
		descText = "#CTT_BUNKER_DESC_LOCKED"
	}
	else if ( !isCrypto )
		descText = "#CTT_BUNKER_DESC_NONCRYPTO"

	RuiSetString( ruiData.rui, "collapsedText", Localize( titleText ) )
	RuiSetString( ruiData.rui, "expandedTitleText", Localize( "#CTT_BUNKER_TITLE" ) )
	RuiSetString( ruiData.rui, "expandedDescTitleText", Localize( titleText ) )
	RuiSetString( ruiData.rui, "expandedDesc", Localize( descText ) )
}

asset function CryptoTT_GetIconAssetForBunker( string hatchId )
{
	if ( !IsHatchBunkerUnlocked( hatchId ) )
		return $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_bunker_locked"

	switch( hatchId )
	{
		case "5":
			return $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_bunker_z5"
		case "6":
			return $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_bunker_z6"
		case "12":
			return $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_bunker_z12"
		case "16":
			return $"rui/hud/crypto_tt_holo_map/icon_crypto_tt_holomap_bunker_z16"
	}

	unreachable
}

int function CryptoTT_GetColorIdxForBunker( string hatchId )
{
	if ( IsHatchBunkerUnlocked( hatchId ) )
		return eCryptoRUIColorIdxs.NEUTRAL
	else
		return eCryptoRUIColorIdxs.LOCKED

	unreachable
}

vector function CryptoTT_GetRuiOriginToUse( HoloMapRUIData ruiData )
{
	if ( ruiData.isExpanded )
		return ruiData.originExpanded
	else
		return ruiData.origin

	unreachable
}
#endif*/