//Script by @CafeFPS

global function ClientCodeCallback_MapInit

struct
{

}
file

void function ClientCodeCallback_MapInit()
{
	MinimapLabelsCloudcity()
	PathTT_Init()
	Olympus_MapInit_Common()
}

void function MinimapLabelsCloudcity()
{
	if (MapName() == eMaps.mp_rr_olympus_mu1 )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_olympus_mu1.rpak" )
	else if (MapName() == eMaps.mp_rr_olympus_tt )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_olympus_tt.rpak" )
	else
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_olympus.rpak" )

		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_12_A" ) ), 0.51, 0.85, 0.6 ) //Downtown
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_15_A" ) ), 0.80, 0.72, 0.6 ) //RND
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_13_C" ) ), 0.58, 0.68, 0.6 ) //Solar Wave
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_07_A" ) ), 0.51, 0.55, 0.6 ) //Labs
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_09_A" ) ), 0.78, 0.44, 0.6 ) //Gardens
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_08_A" ) ), 0.60, 0.44, 0.6 ) //UNDERBELLY
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_05_A" ) ), 0.44, 0.41, 0.6 ) //Turbine
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_06_B" ) ), 0.32, 0.53, 0.6 ) //Estate
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_10_A" ) ), 0.09, 0.63, 0.6 ) //Marina
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_11_A" ) ), 0.19, 0.71, 0.6 ) //Hydroponics
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_01_A" ) ), 0.23, 0.39, 0.6 ) //Highrises
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_02_B" ) ), 0.28, 0.27, 0.6 ) //Ship
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_03_A" ) ), 0.5, 0.3, 0.6 )   //Power Grid
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_04_A" ) ), 0.65, 0.26, 0.6 ) //Rift
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_14_B" ) ), 0.78, 0.56, 0.6 ) //Grow Towers
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_02_A" ) ), 0.37, 0.20, 0.6 ) //Docks
		SURVIVAL_AddMinimapLevelLabel( GetZoneMiniMapNameForZoneId( MapZones_GetZoneIdForTriggerName( "Z_02_C" ) ), 0.37, 0.3, 0.6 ) //Docks
}