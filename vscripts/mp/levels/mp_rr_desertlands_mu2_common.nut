global function Desertlands_MapInit_Common

global function CodeCallback_PreMapInit

const string HARVESTER_BEAM_MDL = $"mdl/fx/harvester_beam_mu1.rmdl"

const string SILO_PANEL_SCRIPTNAME = "silo_doors_panel"
const string SILO_PANEL_MDL = $"mdl/beacon/crane_room_monitor_console.rmdl"
const string SILO_MOVER_SCRIPTNAME = "silo_platform_mover"
const string SILO_PATH_SCRIPTNAME = "silo_platform_mover_path_end"
const string SILO_DOOR_FLAG_END = "drillsite_bunker_1_complete"
const string SILO_DOOR_LEFT_SCRIPTNAME = "silo_door_left"
const string SILO_DOOR_LEFT_MOVER_SCRIPTNAME = "silo_door_left_mover"
const string SILO_DOOR_RIGHT_SCRIPTNAME = "silo_door_right"
const string SILO_DOOR_RIGHT_MOVER_SCRIPTNAME = "silo_door_right_mover"
const string SILO_PLATFORM_SCRIPTNAME = "silo_rising_platform"
const string WAYPOINTTYPE_SILO_DOORS = "desertlands_silo_doors_waypoint"

const string SILO_PANEL_ACTIVATE_SFX = "Desertlands_MU2_Silo_Open"
const string SILO_DOORS_OPEN_SFX = "Desertlands_Fortress_Interactive_Panel"
const string SILO_ELEVATOR_LOOP_SFX = "Desertlands_MU2_Silo_Ascend_LP"
const string SILO_ELEVATOR_STOP_SFX = "Desertlands_MU2_Silo_Ascend_End"

//harevster assets
const float HARVESTER_USE_DURATION = 0.5
const asset HARVESTER_MODEL = $"mdl/props/crafting_siphon/crafting_siphon.rmdl"
const string HARVESTER_FULL_IDLE_ANIM = "source_full_idle"
const string HARVESTER_EMPTY_IDLE_ANIM = "source_empty_idle"
const string HARVESTER_FULL_TO_EMPTY_ANIM = "source_full_to_empty"
const string HARVESTER_MINIMAP_SCRIPTNAME = "crafting_harvester_minimap"

//workbench assets
const asset WORKBENCH_CLUSTER_AIRDROP_MODEL = $"mdl/props/crafting_replicator/crafting_replicator.rmdl"

//audio assets
const string HARVESTER_AMBIENT_LOOP = "Crafting_Extractor_AmbientLoop"
const string WORKBENCH_AMBIENT_LOOP = "Crafting_V2_0_Replicator_AmbientLoop"
const string HARVESTER_COLLECT_1P = "Crafting_Extractor_Collect_1P"
const string HARVESTER_COLLECT_3P = "Crafting_Extractor_Collect_3P"
const string HARVESTER_COLLECT_TEAM = "UI_InGame_Crafting_Extractor_Collect_Squad"
const string WORKBENCH_MENU_OPEN_START = "Crafting_ReplicateMenu_OpenStart"
const string WORKBENCH_MENU_OPEN_FAIL = "Crafting_ReplicateMenu_OpenFail"
const string WORKBENCH_MENU_OPEN_SUCCESS = "Crafting_ReplicateMenu_OpenSuccess"
const string WORKBENCH_CRAFTING_START_1P = "Crafting_V2_0_Replicator_Crafting_Start_1P"
const string WORKBENCH_CRAFTING_START_3P = "Crafting_V2_0_Replicator_Crafting_Start_3P"
const string WORKBENCH_CRAFTING_FINISH = "Crafting_Replicator_CraftingFinish"
const string WORKBENCH_CRAFTING_FINISH_WARNING = "Crafting_Replicater_WarningToEnd"
const string WORKBENCH_CRAFTING_LOOP = "Crafting_Replicator_CraftingLoop"
const string WORKBENCH_CRAFTING_DOOR_OPEN = "Crafting_V2_0_Replicator_Crafting_Finish_Eject"
const string WORKBENCH_CRAFTING_DOOR_CLOSE = "Crafting_V2_0_Replicator_Crafting_Close"

//minimap assets
const asset WORKBENCH_ICON_ASSET = $"rui/hud/gametype_icons/survival/crafting_workbench"
const asset WORKBENCH_ICON_LIMITED_ASSET = $"rui/hud/gametype_icons/survival/crafting_workbench_limited"
const asset WORKBENCH_ICON_AIRDROP_ASSET = $"rui/hud/gametype_icons/survival/crafting_workbench_airdrop"

const asset DISPENSER_WORKBENCH_ICON_ASSET = $"rui/hud/gametype_icons/survival/crafting_workbench_2"
const asset DISPENSER_WORKBENCH_ICON_AIRDROP_ASSET = $"rui/hud/gametype_icons/survival/crafting_workbench_airdrop_2"
const asset DISPENSER_CRAFTING_SMALL_WORKBENCH_ASSET = $"rui/hud/ping/icon_ping_crafting_2_hexagon"
global const asset CRAFTING_2_ZONE_ASSET = $"rui/hud/gametype_icons/survival/crafting_2_zone"

const asset HARVESTER_ICON_ASSET = $"rui/hud/gametype_icons/survival/crafting_harvester"
const asset CRAFTING_SMALL_HARVESTER_ASSET = $"rui/hud/gametype_icons/survival/crafting_small_harvester"
const asset CRAFTING_SMALL_WORKBENCH_ASSET = $"rui/hud/ping/icon_ping_crafting_hexagon"
global const asset CRAFTING_ZONE_ASSET = $"rui/hud/gametype_icons/survival/crafting_zone"
const asset CRAFTING_CURRENCY_ASSET = $"rui/hud/gametype_icons/survival/crafting_currency"

//initialization scriptnames
global const string HARVESTER_SCRIPTNAME = "crafting_harvester"

#if SERVER
global function Desertlands_MU1_MapInit_Common
global function Desertlands_MU1_EntitiesLoaded_Common
global function Desertlands_MU1_UpdraftInit_Common
#endif


#if SERVER
//Copied from _jump_pads. This is being hacked for the geysers.
const float JUMP_PAD_PUSH_RADIUS = 256.0
const float JUMP_PAD_PUSH_PROJECTILE_RADIUS = 32.0//98.0
const float JUMP_PAD_PUSH_VELOCITY = 2000.0
const float JUMP_PAD_VIEW_PUNCH_SOFT = 25.0
const float JUMP_PAD_VIEW_PUNCH_HARD = 4.0
const float JUMP_PAD_VIEW_PUNCH_RAND = 4.0
const float JUMP_PAD_VIEW_PUNCH_SOFT_TITAN = 120.0
const float JUMP_PAD_VIEW_PUNCH_HARD_TITAN = 20.0
const float JUMP_PAD_VIEW_PUNCH_RAND_TITAN = 20.0

const asset JUMP_PAD_MODEL = $"mdl/props/octane_jump_pad/octane_jump_pad.rmdl"

const float JUMP_PAD_ANGLE_LIMIT = 0.70
const float JUMP_PAD_ICON_HEIGHT_OFFSET = 48.0
const float JUMP_PAD_ACTIVATION_TIME = 0.5
const asset JUMP_PAD_LAUNCH_FX = $"P_grndpnd_launch"
const JUMP_PAD_DESTRUCTION = "jump_pad_destruction"

// Loot drones
const int NUM_LOOT_DRONES_TO_SPAWN = 12
const int NUM_LOOT_DRONES_WITH_VAULT_KEYS = 4
#endif

global struct UpdraftTriggerSettings
{
	//needs script_server_fps 20 so it feels like retail native implementation, otherwise reduce maxShakeActivationHeight to 375 and liftExitDuration to 1.5
	
	float minShakeActivationHeight = 500.0               // At what z-position to start shaking the player's view
	float maxShakeActivationHeight = 380 //400.0               // At what z-position will the player's view be shaking at the maximum
	float liftSpeed                = 300.0                   	// Maximum upward speed
	float liftAcceleration         = 100.0                 		// How fast to accelerate to the maximum upward speed
	float liftExitDuration         = 1.5 //2.5                   		// After clearing the updraft trigger, how many extra seconds to continue lifting for
}

struct
{
	bool siloDoorHasBeenActivated = false
	#if SERVER
	array<LootData> weapons
	array<LootData> items
	array<LootData> ordnance
	#endif

	UpdraftTriggerSettings&      updraftSettings = { ... }
	
	array<string> jumpJetAttachments = [ "vent_left", "vent_right" ]

} file

void function CodeCallback_PreMapInit()
{
}

void function Desertlands_MapInit_Common()
{
	printt( "Desertlands_MapInit_Common" )

	if (MapName() == eMaps.mp_rr_desertlands_mu3 )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_desertlands_mu3.rpak" )
	else
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_desertlands_mu2.rpak" )

	FlagInit( "PlayConveyerStartFX", true )
	FlagInit( "PlayConveyerEndFX", true )

	SetVictorySequencePlatformModel( $"mdl/rocks/desertlands_victory_platform.rmdl", < 0, 0, -10 >, < 0, 0, 0 > )

	#if SERVER
		PrecacheModel( SILO_PANEL_MDL )
		PrecacheModel( HARVESTER_BEAM_MDL )		

		AddCallback_EntitiesDidLoad( EntitiesDidLoad )
		SURVIVAL_SetPlaneHeight( 15250 )
		SURVIVAL_SetAirburstHeight( 2500 )
		SURVIVAL_SetMapCenter( <0, 0, 0> )
		// Survival_SetMapFloorZ( -8000 )

		RegisterSignal( "ReachedPathEnd" )
		AddSpawnCallback_ScriptName( "conveyor_rotator_mover", OnSpawnConveyorRotatorMover )
		AddSpawnCallbackEditorClass( "prop_dynamic", "script_survival_crafting_harvester", SetupFakeCraftingSiphon )
		AddSpawnCallbackEditorClass( "prop_dynamic", "script_survival_crafting_workbench_cluster", SetupFakeReplicator )
	#endif

	#if CLIENT
		Freefall_SetPlaneHeight( 15250 )
		Freefall_SetDisplaySeaHeightForLevel( -8961.0 )

		SetVictorySequenceLocation( <11092.6162, -20878.0684, 1561.52222>, <0, 267.894653, 0> )
		SetVictorySequenceSunSkyIntensity( 1.0, 0.5 )
		SetMinimapBackgroundTileImage( $"overviews/mp_rr_canyonlands_bg" )
	#endif
}

#if SERVER
void function SetupSiloPanels()
{
	array<string> flagsToSet
	array<entity> newPanels
	foreach ( entity oldPanel in GetEntArrayByScriptName( SILO_PANEL_SCRIPTNAME ) )
	{
		entity panel = CreatePropDynamic( SILO_PANEL_MDL, oldPanel.GetOrigin(), oldPanel.GetAngles(), SOLID_VPHYSICS )
		newPanels.append( panel )

		if ( oldPanel.HasKey( "scr_flagToggle" ) )
		{
			string flagRequired = expect string( oldPanel.kv.scr_flagToggle )
			flagsToSet.append( flagRequired )
		}

		oldPanel.Destroy()
	}

	foreach ( string flagToSet in flagsToSet )
	{
		if ( !FlagExists( flagToSet ) )
			FlagInit( flagToSet )
	}

	foreach ( entity panel in newPanels )
	{
		panel.AllowMantle()
		panel.SetForceVisibleInPhaseShift( true )
		panel.SetUsable()
		panel.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS | USABLE_BY_ENEMIES )
		panel.SetUsablePriority( USABLE_PRIORITY_LOW )
		panel.SetSkin( 1 )
		panel.SetUsePrompts( "#SILO_DOOR_PANEL_HINT", "#SILO_DOOR_PANEL_HINT" )
		AddCallback_OnUseEntity( panel, CreateSiloPanelFunc( flagsToSet, newPanels ) )
	}

	// Make sure panels exist before trying to set up doors
	// TODO: MegC: this is temporary fix to allow art team to compile Desertlands without Zone 1
	/*if ( newPanels.len() > 0 )
	{
		// character abilities on the doors
		array<entity> siloDoors
		siloDoors.append( GetEntByScriptName( SILO_DOOR_LEFT_SCRIPTNAME ) )
		siloDoors.append( GetEntByScriptName( SILO_DOOR_RIGHT_SCRIPTNAME ) )

		array<entity> siloDoorMovers
		siloDoorMovers.append( GetEntByScriptName( SILO_DOOR_LEFT_MOVER_SCRIPTNAME ) )
		siloDoorMovers.append( GetEntByScriptName( SILO_DOOR_RIGHT_MOVER_SCRIPTNAME ) )

		foreach ( entity mover in siloDoorMovers )
			thread WaitForLootInitFinishedAndSetupDoors( mover )
	}*/
}


void function WaitForLootInitFinishedAndSetupDoors( entity mover )
{
	FlagWait( "Survival_LootSpawned" )

	if ( IsValid( mover ) )
	{
		mover.AllowZiplines()
	}
}

void functionref( entity activePanel, entity player, int useInputFlags ) function CreateSiloPanelFunc( array<string> flagsToSet, array<entity> allPanels )
{
	return void function( entity activePanel, entity player, int useInputFlags ) : ( flagsToSet, allPanels )
	{
		thread OnSiloPanelActivate( activePanel, allPanels, flagsToSet )
	}
}

void function OnSiloPanelActivate( entity activePanel, array<entity> allPanels, array<string> flagsToSet )
{
	if ( file.siloDoorHasBeenActivated )
		return

	file.siloDoorHasBeenActivated = true

	//entity siloPlatform = GetEntByScriptName( SILO_PLATFORM_SCRIPTNAME )
	entity platformMover   = GetEntByScriptName( SILO_MOVER_SCRIPTNAME )
	entity pathEnd = GetEntByScriptName( SILO_PATH_SCRIPTNAME )

	/*array<entity> siloDoors
	siloDoors.append( GetEntByScriptName( SILO_DOOR_LEFT_SCRIPTNAME ) )
	siloDoors.append( GetEntByScriptName( SILO_DOOR_RIGHT_SCRIPTNAME ) )*/

	/*array<entity> siloDoorMovers
	siloDoorMovers.append( GetEntByScriptName( SILO_DOOR_LEFT_MOVER_SCRIPTNAME ) )
	siloDoorMovers.append( GetEntByScriptName( SILO_DOOR_RIGHT_MOVER_SCRIPTNAME ) )*/

	// panels
	foreach ( entity panel in allPanels )
	{
		if ( IsValid( panel ) )
		{
			panel.UnsetUsable()
			panel.SetSkin( 2 )
		}
	}

	// handle objects on the doors and lift
	platformMover.SetPusher( true )
	platformMover.DisallowZiplines()

	/*foreach ( entity doorMover in siloDoorMovers )
	{
		doorMover.SetPusher( true )
		doorMover.DisallowZiplines()
		//doorMover.DisallowObjectPlacement()
	}*/

	//entity wp = CreateWaypoint_Custom( WAYPOINTTYPE_SILO_DOORS )

	/*foreach ( entity door in siloDoors )
	{
		CleanUpPermanentsParentedToDynamicEnt( door )
		AddEntToInvalidEntsForPlacingPermanentsOnto( door )
		AddEntityDestroyedCallback( door,
			void function( entity ent ) : ( door )
			{
				RemoveEntFromInvalidEntsForPlacingPermanentsOnto( ent )
			}
		)
	}*/

	// move the doors and lift
	foreach	( string flagToSet in flagsToSet )
		FlagSet( flagToSet )

	EmitSoundAtPosition( TEAM_ANY, activePanel.GetOrigin(), SILO_PANEL_ACTIVATE_SFX, activePanel )
	EmitSoundAtPosition( TEAM_ANY, pathEnd.GetOrigin(), SILO_DOORS_OPEN_SFX, pathEnd )
	EmitSoundOnEntity( platformMover, SILO_ELEVATOR_LOOP_SFX )

	FlagWait( SILO_DOOR_FLAG_END )

	EmitSoundOnEntity( platformMover, SILO_ELEVATOR_STOP_SFX )

	// handle abilities on lift
	//wp.SetWaypointInt( 0, 1 )

	platformMover.AllowZiplines()
	//AddToAllowedAirdropDynamicEntities( siloPlatform )
}

#endif
#if SERVER

void function EntitiesDidLoad()
{
	
	if( GetCurrentPlaylistVarBool( "firingrange_aimtrainerbycolombia", false ) )
		return

	SetupSiloPanels()
	Desertlands_MU1_EntitiesLoaded_Common()

	GeyserInit()
	Updrafts_Init()

	FillLootTable()
	
	if( Gamemode() == eGamemodes.SURVIVAL && MapName() != eMaps.mp_rr_desertlands_64k_x_64k_tt ) 
	{
		thread function () : ()
		{
			InitLootDrones()
			InitLootDronePaths()
			InitLootRollers()
			SpawnLootDrones( 12 )
		}()
	}
}
#endif

#if SERVER
void function SetupFakeReplicator( entity ent)
{
	ent.Hide()

	vector origin = ent.GetOrigin()
	vector angles = ent.GetAngles()
	array<entity> links = ent.GetLinkEntArray()
	array<entity> parentLinks = ent.GetLinkParentArray()
	entity par = ent.GetParent()

	entity replicator = CreateMaterialHarvester( WORKBENCH_CLUSTER_AIRDROP_MODEL, origin, angles, 6, 15000, false )
	replicator.SetCanBeMeleed( false )

	//entity ambGenericPassive = CraftingSiphon_CreateAmbientGeneric( replicator.GetOrigin(), HARVESTER_AMBIENT_LOOP, true )

	DispatchSpawn( replicator )
	replicator.SetFadeDistance( 15000 )
	//replicator.SetScriptName( replicator_SCRIPTNAME )

	replicator.SetUsable()
	replicator.SetUsableByGroup("pilot")
	replicator.AddUsableValue( USABLE_CUSTOM_HINTS )
	replicator.SetUsePrompts( "%use% Replicate", "%use% Replicate" )

	
	thread PlayAnim( replicator, "crafting_replicator_ready_groundidle" )
	AddCallback_OnUseEntity( replicator, OnRepUse )
	#if CLIENT
	AddEntityCallback_GetUseEntOverrideText( replicator, Crafting_Harvester_UseTextOverride )
	#endif
}


void function OnRepUse( entity replicator, entity playerUser, int useInputFlags )
{	
	replicator.UnsetUsable()

	thread PlayBattleChatterLineDelayedToSpeakerAndTeam( playerUser, "bc_MatsPickedUp", 0.80 )

	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_Start_1P" )
	EmitSoundOnEntityExceptToPlayer( replicator, playerUser, "Crafting_Replicator_Start_3P" )
	//entity ambGenericPassive = CraftingSiphon_CreateAmbientGeneric( replicator.GetOrigin(), HARVESTER_AMBIENT_LOOP, false )

	thread RepAnims( replicator, playerUser )
}

void function RepAnims( entity replicator, entity playerUser )
{	
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_DoorOpen" )
	waitthread PlayAnim( replicator, "crafting_replicator_open" )
	wait 1
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicater_WarningToEnd" )
	wait 2
	thread PlayAnim( replicator, "crafting_replicator_close" )
	wait 0.7
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_DoorClose" )
	wait 1
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_Menu_Deny" )
	wait 1
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_Menu_Deny" )
	wait 1
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Crafting_Replicator_Menu_Deny" )
	wait 1
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "weapon_vortex_gun_explosivewarningbeep" )
	wait 1
	StartParticleEffectOnEntityWithPos( replicator, GetParticleSystemIndex( $"P_trophy_sys_dmg" ), FX_PATTACH_CUSTOMORIGIN_FOLLOW, -1, <0, 0, 60>, <0, 0, 0> )
	EmitSoundOnEntityOnlyToPlayer( replicator, playerUser, "Pilot_Mvmt_Execution_Cloak_AndroidSparks" )
	Dev_PrintMessage( playerUser, "CRAFTING SYSTEM IS STILL WIP", "We are working hard to bring new content into R5Reloaded, Crafting is one of them!", 5, "UI_CraftingTable_Purchase_Accept_1P" )
	wait 5
	replicator.SetUsable()
}


void function SetupFakeCraftingSiphon( entity ent)
{
	ent.Hide()

	vector origin = ent.GetOrigin()
	vector angles = ent.GetAngles()
	array<entity> links = ent.GetLinkEntArray()
	array<entity> parentLinks = ent.GetLinkParentArray()
	entity par = ent.GetParent()

	entity harvester = CreateMaterialHarvester( HARVESTER_MODEL, origin, angles, 6, 15000, false )
	harvester.SetCanBeMeleed( false )

	entity ambGenericPassive = CraftingSiphon_CreateAmbientGeneric( harvester.GetOrigin(), HARVESTER_AMBIENT_LOOP, true )

	DispatchSpawn( harvester )
	harvester.SetFadeDistance( 15000 )
	harvester.SetScriptName( HARVESTER_SCRIPTNAME )

	harvester.SetUsable()
	harvester.SetUsableByGroup("pilot")
	harvester.AddUsableValue( USABLE_CUSTOM_HINTS )
	harvester.SetUsePrompts( "%use% Extract", "%use% Extract" )

	
	thread PlayAnim( harvester, "source_full_idle" )
	AddCallback_OnUseEntity( harvester, OnCraftUse )
	#if CLIENT
	AddEntityCallback_GetUseEntOverrideText( harvester, Crafting_Harvester_UseTextOverride )
	#endif
}

void function OnCraftUse( entity harvester, entity playerUser, int useInputFlags )
{	
	harvester.UnsetUsable()

	thread PlayBattleChatterLineDelayedToSpeakerAndTeam( playerUser, "bc_MatsPickedUp", 0.80 )

	EmitSoundOnEntityOnlyToPlayer( harvester, playerUser, HARVESTER_COLLECT_1P )
	EmitSoundOnEntityExceptToPlayer( harvester, playerUser, HARVESTER_COLLECT_3P )
	entity ambGenericPassive = CraftingSiphon_CreateAmbientGeneric( harvester.GetOrigin(), HARVESTER_AMBIENT_LOOP, false )

	thread CraftAnims( harvester, playerUser )
}

void function CraftAnims( entity harvester, entity playerUser )
{	
	waitthread PlayAnim( harvester, "source_full_to_empty" )
	thread PlayAnim( harvester, "source_empty_idle" )
	wait 2
	Dev_PrintMessage( playerUser, "CRAFTING SYSTEM IS STILL WIP", "We are working hard to bring new content into R5Reloaded, Crafting is one of them!", 2, "UI_CraftingTable_Purchase_Accept_1P" )
}

entity function CraftingSiphon_CreateAmbientGeneric( vector origin, string alias, bool active )
{
	entity ambGeneric = CreateEntity( "ambient_generic" )
	ambGeneric.SetOrigin( origin )
	ambGeneric.SetSoundName( alias )
	ambGeneric.SetEnabled( active )
	DispatchSpawn( ambGeneric )
	return ambGeneric
}

entity function CreateMaterialHarvester( asset model, vector ornull origin = null, vector ornull angles = null, int solidType = 0, float fadeDist = -1, bool dispatchSpawn = true )
{
	entity materialHarvester = CreateEntity( "prop_dynamic" )
	materialHarvester.SetValueForModelKey( model )
	materialHarvester.kv.fadedist = fadeDist
	materialHarvester.kv.renderamt = 255
	materialHarvester.kv.rendercolor = "255 255 255"
	materialHarvester.kv.solid = solidType // 0 = no collision, 2 = bounding box, 6 = use vPhysics, 8 = hitboxes only
	if ( origin )
	{
		// hack: Setting origin twice. SetOrigin needs to happen before DispatchSpawn, otherwise the prop may not touch triggers
		materialHarvester.SetOrigin( expect vector( origin ) )
		if ( angles )
			materialHarvester.SetAngles( expect vector( angles ) )
	}

	if ( dispatchSpawn )
		DispatchSpawn( materialHarvester )

	if ( origin )
	{
		// hack: Setting origin twice. SetOrigin needs to happen after DispatchSpawn, otherwise origin is snapped to nearest whole unit
		materialHarvester.SetOrigin( expect vector( origin ) )
		if ( angles )
			materialHarvester.SetAngles( expect vector( angles ) )
	}

	materialHarvester.SetFadeDistance( fadeDist )

	return materialHarvester
}
#endif

#if CLIENT
string function Crafting_Harvester_UseTextOverride( entity ent )
{
	entity player = GetLocalViewPlayer()

	CustomUsePrompt_Show( ent )
	CustomUsePrompt_SetSourcePos( ent.GetOrigin() + < 0, 0, 30 > )

	CustomUsePrompt_SetAdditionalText( "%ping% " + Localize( "#COMMS_PING" ) ) //removing for 14.1 due to shared crafting materials removing the need for pinging harvestors for teammates
	CustomUsePrompt_SetText( Localize("#CRAFTING_HARVESTER_USE_PROMPT") )
	CustomUsePrompt_SetLineColor( GetCraftingColor() )
	CustomUsePrompt_SetHintImage( CRAFTING_CURRENCY_ASSET )
	CustomUsePrompt_SetShouldCenterImage( true )

	if ( PlayerIsInADS( player ) )
		CustomUsePrompt_ShowSourcePos( false )
	else
		CustomUsePrompt_ShowSourcePos( true )

	return ""
}

vector function GetCraftingColor()
{
	return SrgbToLinear( <0, 255, 240> / 255.0 )
}
#endif

//=================================================================================================
//=================================================================================================
//
//  ##     ## ##     ##    ##       ######   #######  ##     ## ##     ##  #######  ##    ##
//  ###   ### ##     ##  ####      ##    ## ##     ## ###   ### ###   ### ##     ## ###   ##
//  #### #### ##     ##    ##      ##       ##     ## #### #### #### #### ##     ## ####  ##
//  ## ### ## ##     ##    ##      ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ##
//  ##     ## ##     ##    ##      ##       ##     ## ##     ## ##     ## ##     ## ##  ####
//  ##     ## ##     ##    ##      ##    ## ##     ## ##     ## ##     ## ##     ## ##   ###
//  ##     ##  #######   ######     ######   #######  ##     ## ##     ##  #######  ##    ##
//
//=================================================================================================
//=================================================================================================

#if SERVER
void function Desertlands_MU1_MapInit_Common()
{
	AddSpawnCallback_ScriptName( "conveyor_rotator_mover", OnSpawnConveyorRotatorMover )

	Desertlands_MapInit_Common()
	PrecacheParticleSystem( JUMP_PAD_LAUNCH_FX )

	//SURVIVAL_SetDefaultLootZone( "zone_medium" )

	//LaserMesh_Init()
	FlagSet( "DisableDropships" )

	AddDamageCallbackSourceID( eDamageSourceId.burn, OnBurnDamage )

	svGlobal.evacEnabled = false //Need to disable this on a map level if it doesn't support it at all
}

void function OnBurnDamage( entity player, var damageInfo )
{
	if ( !player.IsPlayer() )
		return

	// sky laser shouldn't hurt players in plane
	if ( player.GetPlayerNetBool( "playerInPlane" ) )
	{
		DamageInfo_SetDamage( damageInfo, 0 )
	}
}

void function OnSpawnConveyorRotatorMover( entity mover )
{
	thread ConveyorRotatorMoverThink( mover )
}

void function ConveyorRotatorMoverThink( entity mover )
{
	mover.EndSignal( "OnDestroy" )

	entity rotator = GetEntByScriptName( "conveyor_rotator" )
	entity startNode
	entity endNode

	array<entity> links = rotator.GetLinkEntArray()
	foreach ( l in links )
	{
		if ( l.GetValueForKey( "script_noteworthy" ) == "end" )
			endNode = l
		if ( l.GetValueForKey( "script_noteworthy" ) == "start" )
			startNode = l
	}


	float angle1 = VectorToAngles( startNode.GetOrigin() - rotator.GetOrigin() ).y
	float angle2 = VectorToAngles( endNode.GetOrigin() - rotator.GetOrigin() ).y

	float angleDiff = angle1 - angle2
	angleDiff = (angleDiff + 180) % 360 - 180

	float rotatorSpeed = float( rotator.GetValueForKey( "rotate_forever_speed" ) )
	float waitTime     = fabs( angleDiff ) / rotatorSpeed

	Assert( IsValid( endNode ) )

	while ( true )
	{
		mover.WaitSignal( "ReachedPathEnd" )

		mover.SetParent( rotator, "", true )

		wait waitTime

		mover.ClearParent()
		mover.SetOrigin( endNode.GetOrigin() )
		mover.SetAngles( endNode.GetAngles() )

		thread MoverThink( mover, [ endNode ] )
	}
}

void function Desertlands_MU1_UpdraftInit_Common( entity player )
{
	//ApplyUpdraftModUntilTouchingGround( player )
	//thread PlayerSkydiveFromCurrentPosition( player )
	//thread BurnPlayerOverTime( player )
}

void function Desertlands_MU1_EntitiesLoaded_Common()
{
	entity HarvestFX = CreatePropDynamic( HARVESTER_BEAM_MDL, <-2541, -11265, -6243>, <0, 0, 0> )
	entity HarvestFX2 = CreatePropDynamic( HARVESTER_BEAM_MDL, <-2541, -11265, 24820>, <0, 0, 0> )
	entity HarvestFX3 = CreatePropDynamic( HARVESTER_BEAM_MDL, <-2541, -11265, 55642>, <0, 0, 0> )
}

//Geyster stuff
void function GeyserInit()
{
	array<entity> geyserTargets = GetEntArrayByScriptName( "geyser_jump" )
	foreach ( target in geyserTargets )
	{
		thread GeyersJumpTriggerArea( target )
		//target.Destroy()
	}
}

void function GeyersJumpTriggerArea( entity jumpPad )
{
	Assert ( IsNewThread(), "Must be threaded off" )
	jumpPad.EndSignal( "OnDestroy" )

	vector origin = OriginToGround( jumpPad.GetOrigin() )
	vector angles = jumpPad.GetAngles()

	entity trigger = CreateEntity( "trigger_cylinder_heavy" )
	SetTargetName( trigger, "geyser_trigger" )
	trigger.SetOwner( jumpPad )
	trigger.SetRadius( JUMP_PAD_PUSH_RADIUS )
	trigger.SetAboveHeight( 32 )
	trigger.SetBelowHeight( 16 ) //need this because the player or jump pad can sink into the ground a tiny bit and we check player feet not half height
	trigger.SetOrigin( origin )
	trigger.SetAngles( angles )
	trigger.SetTriggerType( TT_JUMP_PAD )
	trigger.SetLaunchScaleValues( JUMP_PAD_PUSH_VELOCITY, 1.25 )
	trigger.SetViewPunchValues( JUMP_PAD_VIEW_PUNCH_SOFT, JUMP_PAD_VIEW_PUNCH_HARD, JUMP_PAD_VIEW_PUNCH_RAND )
	trigger.SetLaunchDir( <0.0, 0.0, 1.0> )
	trigger.UsePointCollision()
	trigger.kv.triggerFilterNonCharacter = "0"
	DispatchSpawn( trigger )
	trigger.SetEnterCallback( Geyser_OnJumpPadAreaEnter )

	entity traceBlocker = CreateTraceBlockerVolume( trigger.GetOrigin(), 24.0, true, CONTENTS_BLOCK_PING | CONTENTS_NOGRAPPLE, TEAM_MILITIA, GEYSER_PING_SCRIPT_NAME )
	traceBlocker.SetBox( <-192, -192, -16>, <192, 192, 3000> )

	//DebugDrawCylinder( origin, < -90, 0, 0 >, JUMP_PAD_PUSH_RADIUS, trigger.GetAboveHeight(), 255, 0, 255, true, 9999.9 )
	//DebugDrawCylinder( origin, < -90, 0, 0 >, JUMP_PAD_PUSH_RADIUS, -trigger.GetBelowHeight(), 255, 0, 255, true, 9999.9 )

	OnThreadEnd(
		function() : ( trigger )
		{
			trigger.Destroy()
		} )

	WaitForever()
}


void function Geyser_OnJumpPadAreaEnter( entity trigger, entity ent )
{
	Geyser_JumpPadPushEnt( trigger, ent, trigger.GetOrigin(), trigger.GetAngles() )
}


void function Geyser_JumpPadPushEnt( entity trigger, entity ent, vector origin, vector angles )
{
	if ( Geyser_JumpPad_ShouldPushPlayerOrNPC( ent ) )
	{
		if ( ent.IsPlayer() )
		{
			entity jumpPad = trigger.GetOwner()
			if ( IsValid( jumpPad ) )
			{
				int fxId = GetParticleSystemIndex( JUMP_PAD_LAUNCH_FX )
				StartParticleEffectOnEntity( jumpPad, fxId, FX_PATTACH_ABSORIGIN_FOLLOW, 0 )
			}
			thread Geyser_JumpJetsWhileAirborne( ent )
		}
		else
		{
			EmitSoundOnEntity( ent, "JumpPad_LaunchPlayer_3p" )
			EmitSoundOnEntity( ent, "JumpPad_AirborneMvmt_3p" )
		}
	}
}


void function Geyser_JumpJetsWhileAirborne( entity player )
{
	if ( !IsPilot( player ) )
		return
	player.EndSignal( "OnDeath" )
	player.EndSignal( "OnDestroy" )
	player.Signal( "JumpPadStart" )
	player.EndSignal( "JumpPadStart" )
	player.EnableSlowMo()
	player.DisableMantle()

	EmitSoundOnEntityExceptToPlayer( player, player, "JumpPad_LaunchPlayer_3p" )
	EmitSoundOnEntityExceptToPlayer( player, player, "JumpPad_AirborneMvmt_3p" )

	array<entity> jumpJetFXs
	array<string> attachments = [ "vent_left", "vent_right" ]
	int team                  = player.GetTeam()
	foreach ( attachment in attachments )
	{
		int friendlyID    = GetParticleSystemIndex( TEAM_JUMPJET_DBL )
		entity friendlyFX = StartParticleEffectOnEntity_ReturnEntity( player, friendlyID, FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( attachment ) )
		friendlyFX.SetOwner( player )
		SetTeam( friendlyFX, team )
		friendlyFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY
		jumpJetFXs.append( friendlyFX )

		int enemyID    = GetParticleSystemIndex( ENEMY_JUMPJET_DBL )
		entity enemyFX = StartParticleEffectOnEntity_ReturnEntity( player, enemyID, FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( attachment ) )
		SetTeam( enemyFX, team )
		enemyFX.kv.VisibilityFlags = ENTITY_VISIBLE_TO_ENEMY
		jumpJetFXs.append( enemyFX )
	}

	OnThreadEnd(
		function() : ( jumpJetFXs, player )
		{
			foreach ( fx in jumpJetFXs )
			{
				if ( IsValid( fx ) )
					fx.Destroy()
			}

			if ( IsValid( player ) )
			{
				player.DisableSlowMo()
				player.EnableMantle()
				StopSoundOnEntity( player, "JumpPad_AirborneMvmt_3p" )
			}
		}
	)

	WaitFrame()

	wait 0.1

	while( IsValid( player ) && !player.IsOnGround() )
	{
		WaitFrame()
	}
}


bool function Geyser_JumpPad_ShouldPushPlayerOrNPC( entity target )
{
	if ( target.IsTitan() )
		return false

	if ( IsSuperSpectre( target ) )
		return false

	if ( IsTurret( target ) )
		return false

	if ( IsDropship( target ) )
		return false

	return true
}


///////////////////////
///////////////////////
//// Updrafts

const string UPDRAFT_TRIGGER_SCRIPT_NAME = "skydive_dust_devil"
void function Updrafts_Init()
{
	array<entity> triggers = GetEntArrayByScriptName( UPDRAFT_TRIGGER_SCRIPT_NAME )
	
	foreach ( entity trigger in triggers )
	{
		//Warning( "[+] Spawning Cafe's Updraft Trigger pos at " + trigger.GetOrigin() )

		trigger.SetEnterCallback( PlayerEnterUpdraftTrigger )
	}
}

void function BurnPlayerOverTime( entity trigger, entity player )
{
	Assert( IsValid( player ) )
	player.EndSignal( "OnDestroy" )
	player.EndSignal( "OnDeath" )
	
	for ( int i = 0; i < 8; ++i )
	{
		if( !player.p.isPlayerUpdrafting )
			break

		if ( !player.IsPhaseShifted() )
		{
			player.TakeDamage( 5, null, null, { damageSourceId = eDamageSourceId.burn, damageType = DMG_BURN } )
		}

		wait 0.5
	}
}

void function PlayerEnterUpdraftTrigger( entity trigger, entity player )
{
	if( !IsValid( player ) )
		return
	
	if ( !player.IsPlayer() )
		return

	float entZ = player.GetOrigin().z

	thread Player_EnterUpdraft( trigger, player, file.updraftSettings.minShakeActivationHeight + entZ, entZ - file.updraftSettings.maxShakeActivationHeight, max( -5750.0, entZ - file.updraftSettings.maxShakeActivationHeight ), file.updraftSettings.liftSpeed, file.updraftSettings.liftAcceleration, file.updraftSettings.liftExitDuration )
}

//Made by @CafeFPS
void function Player_EnterUpdraft( entity trigger, entity player, float minHeight, float maxHeight, float activationHeight, float liftSpeed, float liftAcceleration, float liftExitDuration )
{
	EndSignal( player, "OnDestroy" )
	EndSignal( player, "OnDeath" )
	
	array<entity> fxs
	
	OnThreadEnd(
		function() : ( player, fxs )
		{
			if( IsValid( player ) )
			{
				player.p.isPlayerUpdrafting = false
				player.kv.airSpeed = player.GetPlayerSettingFloat( "airSpeed" )
				player.kv.airAcceleration = player.GetPlayerSettingFloat( "airAcceleration" )
				player.SetThirdPersonShoulderModeOff()
				
				player.Anim_Stop()
				StopSoundOnEntity( player, "Survival_InGameFlight_Travel_1P" )
				StopSoundOnEntity( player, "Survival_InGameFlight_Travel_3P" )
				
				DeployAndEnableWeapons( player )
			}
			
			foreach( entity ent in fxs )
			{
				if( IsValid( ent ) )
				{
					EffectStop( ent )
					ent.Destroy()
				}
			}
		} )

	while ( player.GetOrigin().z > activationHeight )
		WaitFrame()

	player.p.isPlayerUpdrafting = true
	player.kv.airSpeed = 300
	player.kv.airAcceleration = 1000 
	HolsterAndDisableWeapons( player )
	
	// Play freefall landing anim + jumpjets fx
	// Can't play the anim and make it move at the same time kral pls help (use wattson temp)
	// player.Anim_NonScriptedPlay("animseq/humans/class/light/pilot_light_wattson/mp_pilot_freefall_anticipate.rseq" )
	// thread PlayAnim( player, "animseq/humans/class/light/pilot_light_wattson/mp_pilot_freefall_anticipate.rseq", player, "", 0 )
	// player.Anim_DisableUpdatePosition()
	// player.Anim_DisableAnimDelta()

	EmitSoundOnEntityOnlyToPlayer( player, player, "Survival_InGameFlight_Land_Start_1P" )
	EmitSoundOnEntityExceptToPlayer( player, player, "Survival_InGameFlight_Land_Start_3P" )
	
	player.SetThirdPersonShoulderModeOn()
	
	thread BurnPlayerOverTime( trigger, player )

	//Jumpjet fx
	foreach ( string attachment in file.jumpJetAttachments )
	{
		int landingFXID = GetParticleSystemIndex( $"P_surv_team_land_jet" )
		entity handle = StartParticleEffectOnEntity_ReturnEntity( player, landingFXID, FX_PATTACH_POINT_FOLLOW, player.LookupAttachment( attachment ) )
		SetTeam( handle, player.GetTeam() )
		EffectSetControlPointVector( handle, 1, GetSkydiveSmokeColorForTeam( player.GetTeam() ) )
		fxs.append( handle )
	}
	
	float velocity

	while ( trigger.IsTouching( player ) )
	{
		velocity += liftAcceleration
		
		vector playerCurrentVel = < player.GetVelocity().x, player.GetVelocity().y, velocity >

		player.SetVelocity( ClampVelocity( playerCurrentVel, liftSpeed ) )

		WaitFrame()
	}

	// Player is out of trigger, use liftExitDuration
	float starttime = Time()
	float endTime = starttime + liftExitDuration
	
	while ( Time() < endTime )
	{
		velocity += liftAcceleration
		
		vector playerCurrentVel = < player.GetVelocity().x, player.GetVelocity().y, velocity >

		player.SetVelocity( ClampVelocity( playerCurrentVel, liftSpeed ) )

		WaitFrame()
	}
}

vector function ClampVelocity(vector velocity, float maxSpeed) 
{
    float speed = velocity.Length()

    if (speed > maxSpeed) 
	{
        velocity = velocity * (maxSpeed / speed)
    }
    return velocity
}
#endif


                           // 888                                .d888                            888    d8b
                           // 888                               d88P"                             888    Y8P
                           // 888                               888                               888
 // .d8888b 888  888 .d8888b  888888 .d88b.  88888b.d88b.       888888 888  888 88888b.   .d8888b 888888 888  .d88b.  88888b.  .d8888b
// d88P"    888  888 88K      888   d88""88b 888 "888 "88b      888    888  888 888 "88b d88P"    888    888 d88""88b 888 "88b 88K
// 888      888  888 "Y8888b. 888   888  888 888  888  888      888    888  888 888  888 888      888    888 888  888 888  888 "Y8888b.
// Y88b.    Y88b 888      X88 Y88b. Y88..88P 888  888  888      888    Y88b 888 888  888 Y88b.    Y88b.  888 Y88..88P 888  888      X88
 // "Y8888P  "Y88888  88888P'  "Y888 "Y88P"  888  888  888      888     "Y88888 888  888  "Y8888P  "Y888 888  "Y88P"  888  888  88888P'

#if SERVER
void function RespawnItem(entity item, string ref, int amount = 1, int wait_time=6)
//By @CafeFPS CafeFPS. Tomado del firing range.

{
	vector pos = item.GetOrigin()
	vector angles = item.GetAngles()
	item.WaitSignal("OnItemPickup")

	wait wait_time
	StartParticleEffectInWorld( GetParticleSystemIndex( $"P_impact_shieldbreaker_sparks" ), pos, angles )
	thread RespawnItem(SpawnGenericLoot(ref, pos, angles, amount), ref, amount)
}
#endif

#if SERVER
void function FillLootTable()
//By @CafeFPS CafeFPS. Adaptado del firing range.
{
	file.ordnance.extend(SURVIVAL_Loot_GetByType( eLootType.ORDNANCE ))
	file.weapons.extend(SURVIVAL_Loot_GetByType( eLootType.MAINWEAPON ))
}

void function SpawnGrenades(vector pos, vector ang, int wait_time = 6, array which_nades = ["thermite", "frag", "arc"], int num_rows = 1)
//By michae\l/#1125 & @CafeFPS
{
    vector posfixed = pos
	int i;
    for (i = 0; i < num_rows; i++)
    {
        if(i != 0) {posfixed += <30, 0 - which_nades.len() * 30, 0>}
            foreach(nade in which_nades)
        {
            LootData item
			posfixed = posfixed + <0, 30, 0>
            if(nade == "thermite") {
                item = file.ordnance[0]
            }
            else if(nade == "frag") {
                item = file.ordnance[1]
			}
            else if(nade == "arc") {
                item = file.ordnance[2]
        }
		entity loot = SpawnGenericLoot(item.ref, posfixed, ang, 1)
		thread RespawnItem(loot, item.ref, 1, wait_time)
		}
	}
}

entity function CreateEditorPropLobby(asset a, vector pos, vector ang, bool mantle = false, float fade = 2000, int realm = -1)
{
    entity e = CreatePropDynamic(a,pos,ang,SOLID_VPHYSICS,fade)
    e.kv.fadedist = fade
    if(mantle) e.AllowMantle()

    if (realm > -1) {
        e.RemoveFromAllRealms()
        e.AddToRealm(realm)
    }

    string positionSerialized = pos.x.tostring() + "," + pos.y.tostring() + "," + pos.z.tostring()
    string anglesSerialized = ang.x.tostring() + "," + ang.y.tostring() + "," + ang.z.tostring()

    e.SetScriptName("editor_placed_prop")
    e.e.gameModeId = realm
   // printl("[editor]" + string(a) + ";" + positionSerialized + ";" + anglesSerialized + ";" + realm)

    return e
}

#endif
