//Made by @CafeFPS

global function PathTT_Init
global function IsPathTTEnabled

#if SERVER && DEVELOPER
global function TpToPathTT
#endif

const string BOXING_RING_MODEL = "mdl/test/davis_test/pathfinder_tt_ring_shield.rmdl"
global const string BOXING_RING_SCRIPTNAME = "pathfinder_tt_ring_shield"
const string PLAYER_PASS_THROUGH_RING_SHIELD_SOUND = "Player_Enter_Ring_v1"

struct
{
	entity trigger
#if SERVER
	int numPlayersInRing
	int numTeamsInRing

	//array<BoxingRingPlayerData> allRingPlayerData

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

void function PathTT_Init()
{
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
//	RegisterNetworkedVariable( "PathTT_IsCrowdActive", SNDC_GLOBAL, SNVT_BOOL, false )

	RegisterSignal( "OnStartTouch" )
	RegisterSignal( "OnEndTouch" )
}

bool function IsPathTTEnabled()	
{
	// if ( GetCurrentPlaylistVarBool( "path_tt_enabled", true ) )
	// {
		// return HasEntWithScriptName( "path_tt_jumbo_screen_ko" )
	// }

	return GetCurrentPlaylistVarBool( "path_tt_enabled", true ) //false
}

void function EntitiesDidLoad()
{
	if ( !IsPathTTEnabled() )
		return

	// PrecacheWeapon( $"mp_weapon_melee_boxing_ring" )
	// PrecacheWeapon( $"melee_boxing_ring" )

	// InitPathTTBoxingRing()
	InitPathTTBoxingRingEntities()
}

void function InitPathTTBoxingRingEntities()
{
	array<entity> enterTrigArr = GetEntArrayByScriptName( "path_tt_ring_trig" )
	if ( enterTrigArr.len() == 1 )
	{
		#if SERVER
			PathTT_SetupMainTrigger( enterTrigArr[ 0 ] )
		#elseif CLIENT
			thread Cl_PathTT_MonitorIsPlayerInBoxingRing( enterTrigArr[ 0 ] )
		#endif
		file.trigger = enterTrigArr[ 0 ]
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

		entity ringShieldTarget = ringShieldTargets[ 0 ]
		entity ringShield = CreatePropScript( GetAssetFromString( BOXING_RING_MODEL ), ringShieldTarget.GetOrigin(), ringShieldTarget.GetAngles(), SOLID_VPHYSICS, 1 )
		//ringShield.kv.CollisionGroup = TRACE_COLLISION_GROUP_NONE
		ringShield.kv.CollisionGroup = TRACE_COLLISION_GROUP_BLOCK_WEAPONS
		ringShield.kv.contents = int( ringShield.kv.contents ) | CONTENTS_NOGRAPPLE | CONTENTS_BLOCKLOS
		ringShield.kv.renderamt = 10
		ringShield.kv.collide_human = 0
		ringShield.SetScriptName( BOXING_RING_SCRIPTNAME )
		//DispatchSpawn( ringShield )
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

		//thread PathTT_AlternateHolograms()
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
void function PathTT_SetupMainTrigger( entity trigger )
{
	trigger.kv.triggerFilterUseNew = 1
	trigger.kv.triggerFilterPlayer = "all"
	trigger.kv.triggerFilterPhaseShift = "any"
	trigger.kv.triggerFilterNpc = "none"
	trigger.kv.triggerFilterNonCharacter = 0
	trigger.kv.triggerFilterTeamMilitia = 1
	trigger.kv.triggerFilterTeamIMC = 1
	trigger.kv.triggerFilterTeamNeutral = 1
	trigger.kv.triggerFilterTeamBeast = 1
	trigger.kv.triggerFilterTeamOther = 1
	trigger.ConnectOutput( "OnStartTouch", PathTT_OnMainTriggerStartTouch )
	trigger.ConnectOutput( "OnEndTouch", PathTT_OnMainTriggerEndTouch )
}

void function PathTT_OnMainTriggerStartTouch( entity trigger, entity player, entity caller, var value )
{
	printt( "entered pathtt trigger" )
	PathTT_GiveBoxingHandsAndSaveWeapons( player )
}

void function PathTT_OnMainTriggerEndTouch( entity trigger, entity player, entity caller, var value )
{
	printt( "out of pathtt trigger" )
	PathTT_ReturnWeapons( player )
}

void function PathTT_GiveBoxingHandsAndSaveWeapons( entity player )
{
	StorePilotWeapons( player )
	player.TakeOffhandWeapon(OFFHAND_MELEE)
	player.TakeNormalWeaponByIndexNow( WEAPON_INVENTORY_SLOT_PRIMARY_2 )
	player.GiveWeapon( "mp_weapon_melee_boxing_ring", WEAPON_INVENTORY_SLOT_PRIMARY_2 )
	player.GiveOffhandWeapon( "melee_boxing_ring", OFFHAND_MELEE )
}

void function PathTT_ReturnWeapons( entity player )
{
	RetrievePilotWeapons( player )
}

#if DEVELOPER
void function TpToPathTT()
{
	gp()[0].SetOrigin( <-15581.3467, 22193.5137, -6671.96875> )
	gp()[0].SetAngles( <0, -147.998596, 0> )
}
#endif

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
#endif

#if SERVER
void function PathTT_SetCrowdAmbienceActive( bool active )
{
	foreach( entity ambient in file.boxingRingCrowdAmbients_active )
	{
		ambient.SetEnabled( active )
	}

//	SetGlobalNetBool( "PathTT_IsCrowdActive", active )
}
#endif

#if CLIENT
void function PathTT_PlayerPassThroughRingShieldCeremony( entity player )
{
	vector org = player.GetOrigin()





		// Signal( player, "DeployableBreachChargePlacement_End" )
		EmitSoundAtPosition( TEAM_UNASSIGNED, org, PLAYER_PASS_THROUGH_RING_SHIELD_SOUND )

}
#endif
