global function ClientCodeCallback_MapInit
global function MinimapLabelsCanyonlandsMU2

struct
{
}
file

void function ClientCodeCallback_MapInit()
{
	Canyonlands_MapInit_Common()
	if (MapName() == eMaps.mp_rr_canyonlands_mu2_mv )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2_mv.rpak" )
	else if (MapName() == eMaps.mp_rr_canyonlands_mu2_tt )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2_tt.rpak" )
	else
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2.rpak" )
	MinimapLabelsCanyonlandsMU2()
	AddCallback_GameStateEnter( eGameState.WinnerDetermined, MU1_OnWinnerDetermined )
			AddCallback_EntitiesDidLoad( EntitiesDidLoad )
/*
                   
	ShPrecacheS05Ending()
                         
	ShPrecacheEvacShipAssets()
	ShPrecacheBreachAndClearAssets()
	ShPrecacheTreasureExtractionAssets()

	ClCryptoTVsInit()
	InitHatchBunkers()
	RegisterCLCryptoCallbacks()
	ClCanyonlandsStoryEvents_Init()
	ClCommonStoryEvents_Init()*/
}

void function MinimapLabelsCanyonlandsMU2()
{
	//SWAMPLAND
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_02_A" ) ), 0.93, 0.5, 0.6 ) //Swamps

	//INDUSTRIAL
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_04_A" ) ), 0.79, 0.62, 0.6 ) //Hydro Dam
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_11_A" ) ), 0.56, 0.91, 0.6 ) //Water Treatment
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_14_RUNOFF" ) ), 0.13, 0.40, 0.6 ) //Runoff

	//UNIQUE
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_13_ARENA" ) ), 0.24, 0.32, 0.6 ) //The Pit
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_18_A" ) ), 0.16, 0.7, 0.6 )//"Gauntlet"
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_03_B" ) ), 0.81, 0.51, 0.6 ) //Labs

	//MILITARY
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_04_B" ) ), 0.78, 0.74, 0.6 ) //Repulsor
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_07_C" ) ), 0.8, 0.84, 0.6 ) //Observatory
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_08_ARTILLERY" ) ), 0.54, 0.15, 0.6 ) //Artillery
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_15_AIRBASE" ) ), 0.13, 0.56, 0.6 ) //Airbase
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "JCT_10_13" ) ), 0.34, 0.45, 0.6 ) //Bunker Pass

	//COLONY
	//SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_01_A" ) ), 0.81, 0.22, 0.6 ) //Relay -> Now River Gorge

	// MU2
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_19_A" ) ), 0.92, 0.30, 0.6 ) //The Rig
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_01_B" ) ), 0.75, 0.37, 0.6 ) //Capacitor

	//LAGOON
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_09_A" ) ), 0.4, 0.3, 0.6 ) //"Containment"
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_06_A" ) ), 0.66, 0.53, 0.6 ) //"The Cage"

	//SLUM
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_12_A" ) ), 0.16, 0.23, 0.6 )//"Slum Lakes"
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_16_MALL" ) ), 0.49, 0.68, 0.6 ) //"Market"
	SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_16_RIG" ) ), 0.35, 0.73, 0.6 ) //"Skull Rig"
	if (MapName() == eMaps.mp_rr_canyonlands_mu2_mv )
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_20_A" ) ), 0.33, 0.8, 0.6 ) //"Skull Rig"
}

void function EntitiesDidLoad()
{
	//InitCryptoMap()
}

void function MU1_OnWinnerDetermined()
{
	array<entity> portalFXArray = GetEntArrayByScriptName( "wraith_tt_portal_fx" )

	if ( portalFXArray.len() == 0 )
	{
		Warning( "Warning! Incorrect number of portal FX entities found for destruction!" )
		return
	}

	foreach( entity fx in portalFXArray )
		fx.Destroy()
}