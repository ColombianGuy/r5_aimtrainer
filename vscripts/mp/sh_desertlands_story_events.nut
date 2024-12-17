#if(CLIENT)
global function ClDesertlandsStoryEvents_Init
global function IsS05TEnabled
global function IsS05T_Phase5Enabled
global function Warp_StartVisualEffect
global function InitHallwayTweakLights
#endif

#if(CLIENT)
const string WARP_ROOM_AMBIENT_SFX = "Warehouse_Ambient_Quad"
const asset WARP_ROOM_PLAYER_SCREEN_FX = $"P_ability_warp_screen"

const string WARP_ROOM_END_PLAYER_SCREEN_FX_SIGNAL = "S05T_Warp_Warp_StopVisualEffect"
const string WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL = "S05T_CleanupMinimap"

const array< table<string, float> > WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS =
[
	{ light_s5_column_03 = 0.05 },
	{ light_s5_column_02 = 0.05 },
	{ light_s5_column_01 = 0.05 }
]
#endif


#if(CLIENT)
const string WAYPOINTTYPE_S05T = "S05T_lightSequence"

const float WARP_ROOM_LIGHT_ACTIVATION_DELAY = 5.0
const float WARP_ROOM_POST_LIGHT_DELAY = 4.5
#endif

struct
{
	#if(CLIENT)
		var fakeMinimap_BaseRui
		var fakeMinimap_FrameRui
		var fakeMinimap_YouArrowRui
	#endif
} file


#if(CLIENT)
void function ClDesertlandsStoryEvents_Init()
{
	//if ( !IsS05TEnabled() )
		//return

	RegisterSignal( WARP_ROOM_END_PLAYER_SCREEN_FX_SIGNAL )
	RegisterSignal( WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL )

	PrecacheParticleSystem( WARP_ROOM_PLAYER_SCREEN_FX )
	//StatusEffect_RegisterEnabledCallback( eStatusEffect.s05t_warp_visual_effect, Warp_StartVisualEffect )
	//StatusEffect_RegisterDisabledCallback( eStatusEffect.s05t_warp_visual_effect, Warp_StopVisualEffect )

	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
	Waypoints_RegisterCustomType( WAYPOINTTYPE_S05T, WpInstance_HallwayLightSequence )
}
#endif


#if(CLIENT)
void function EntitiesDidLoad()
{
	#if(CLIENT)
		InitHallwayTweakLights()
	#endif
}
#endif //

const VAULT_MODEL_FADE_DIST = 2000.0

#if(CLIENT)
void function Warp_StartVisualEffect( entity player, int statusEffect, bool actuallyChanged )
{
	//if ( player != GetLocalViewPlayer() || (GetLocalViewPlayer() == GetLocalClientPlayer() && !actuallyChanged) )
		//return

	thread (void function() : ( player, statusEffect ) {
		EndSignal( player, "OnDeath" )
		EndSignal( player, WARP_ROOM_END_PLAYER_SCREEN_FX_SIGNAL )

		int fxHandle = StartParticleEffectOnEntityWithPos( player,
			GetParticleSystemIndex( WARP_ROOM_PLAYER_SCREEN_FX ),
			FX_PATTACH_ABSORIGIN_FOLLOW, -1, player.EyePosition(), <0, 0, 0> )

		EffectSetIsWithCockpit( fxHandle, true )

		OnThreadEnd( function() : ( fxHandle ) {
			CleanupFXHandle( fxHandle, false, true )
		} )

		while( true )
		{
			if ( !EffectDoesExist( fxHandle ) )
				break

			float severity = StatusEffect_GetSeverity( player, statusEffect )
			//
			EffectSetControlPointVector( fxHandle, 1, <severity, 999, 0> )

			WaitFrame()
		}
	})()
}
#endif //


#if(CLIENT)
void function Warp_StopVisualEffect( entity player, int statusEffect, bool actuallyChanged )
{
	if ( player != GetLocalViewPlayer() || (GetLocalViewPlayer() == GetLocalClientPlayer() && !actuallyChanged) )
		return

	player.Signal( WARP_ROOM_END_PLAYER_SCREEN_FX_SIGNAL )
}
#endif //

#if(CLIENT)
void function InitHallwayTweakLights()
{
	foreach ( table<string, float> tweakLightTable in WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS )
	{
		foreach ( string scriptName, float brightness in tweakLightTable )
		{
			array<entity> lights = GetEntArrayByScriptName( scriptName )

			foreach ( entity light in lights )
				light.SetTweakLightBrightness( 0.0 )
		}
	}
}
#endif //

#if(CLIENT)
void function WpInstance_HallwayLightSequence( entity wp )
{
	const int MAX_SQUAD_COUNT_TO_CHECK = 5

	entity viewPlayer        = GetLocalViewPlayer()
	bool isPartOfWarpSequence = false
	array<entity> teamPlayers

	for ( int idx = 0; idx < MAX_SQUAD_COUNT_TO_CHECK; idx++ )
	{
		entity wpEnt = wp.GetWaypointEntity( idx )

		if ( IsValid( wpEnt ) )
		{
			if ( wpEnt == viewPlayer )
			{
				isPartOfWarpSequence = true
			}
			else if ( wpEnt.IsPlayer() && wpEnt.GetTeam() == viewPlayer.GetTeam() )
			{
				teamPlayers.append( wpEnt )
			}
		}
	}

	if ( isPartOfWarpSequence )
		thread HallwayLightSequence( wp, teamPlayers )
}
#endif //


#if(CLIENT)
void function HallwayLightSequence( entity wp, array<entity> teamPlayers )
{
	EndSignal( wp, "OnDestroy" )

	bool lightsHaveTurnedOn_0 = false
	bool lightsHaveTurnedOn_1 = false
	bool lightsHaveTurnedOn_2 = false

	CreateFakeMinimap( teamPlayers )
	EmitSoundOnEntity( GetLocalClientPlayer(), WARP_ROOM_AMBIENT_SFX )

	OnThreadEnd(
		function() : ()
		{
			DestroyFakeMinimap()

			foreach ( table<string, float> tweakLightTable in WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS )
			{
				foreach ( string scriptName, float brightness in tweakLightTable )
				{
					array<entity> lights = GetEntArrayByScriptName( scriptName )

					foreach ( entity light in lights )
						light.SetTweakLightBrightness( 0.0 )
				}
			}
		}
	)

	while( true )
	{
		int lightValue = wp.GetWaypointInt( 0 )

		if ( lightValue == 0 && !lightsHaveTurnedOn_0 )
		{
			foreach ( string scriptName, float brightness in WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS[0] )
			{
				array<entity> lights = GetEntArrayByScriptName( scriptName )

				foreach ( entity light in lights )
					light.SetTweakLightBrightness( brightness )
			}

			lightsHaveTurnedOn_0 = true
		}
		else if ( lightValue == 1 && !lightsHaveTurnedOn_1 )
		{
			foreach ( string scriptName, float brightness in WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS[1] )
			{
				array<entity> lights = GetEntArrayByScriptName( scriptName )

				foreach ( entity light in lights )
					light.SetTweakLightBrightness( brightness )
			}

			lightsHaveTurnedOn_1 = true
		}
		else if ( lightValue == 2 && !lightsHaveTurnedOn_2 )
		{
			foreach ( string scriptName, float brightness in WARP_ROOM_TWEAK_LIGHT_NAME_BRIGHTNESS_GROUPS[2] )
			{
				array<entity> lights = GetEntArrayByScriptName( scriptName )

				foreach ( entity light in lights )
					light.SetTweakLightBrightness( brightness )
			}

			lightsHaveTurnedOn_2 = true
		}

		WaitFrame()
	}
}
#endif //

const float FAKE_MINIMAP_SCALE = 6.0
const float FAKE_MINIMAP_DISPLAY_DIST = 2500.0
const float FAKE_MINIMAP_MAP_CORNER_X = -24000.0
const float FAKE_MINIMAP_MAP_CORNER_Y = 10000.0


#if(CLIENT)
void function CreateFakeMinimap( array<entity> teamPlayers )
{
	entity localPlayer = GetLocalClientPlayer()

	if ( !IsValid( localPlayer ) )
		return

	Minimap_DisableDraw()

	file.fakeMinimap_BaseRui = CreateMinimapRui( MINIMAP_BASE_RUI, MINIMAP_Z_BASE + 1 )
	file.fakeMinimap_FrameRui = CreateMinimapRui( MINIMAP_FRAME_RUI, MINIMAP_Z_FRAME + 1 )
	file.fakeMinimap_YouArrowRui = CreateMinimapRui( MINIMAP_YOU_RUI, MINIMAP_Z_YOU + 1 )

	RuiSetImage( file.fakeMinimap_BaseRui, "mapImage", $"rui/events/s05_tease/s05_tease_minimap" )
	RuiSetImage( file.fakeMinimap_BaseRui, "mapBgTileImage", GetMinimapBackgroundTileImage() )

	RuiSetFloat( file.fakeMinimap_BaseRui, "minimapSizeScale", 1.0 )
	RuiSetFloat( file.fakeMinimap_FrameRui, "minimapSizeScale", 1.0 )
	RuiSetFloat( file.fakeMinimap_YouArrowRui, "minimapSizeScale", 1.0 )

	RuiSetFloat3( file.fakeMinimap_BaseRui, "mapCorner", <FAKE_MINIMAP_MAP_CORNER_X, FAKE_MINIMAP_MAP_CORNER_Y, 0> )
	RuiSetFloat( file.fakeMinimap_BaseRui, "displayDist", FAKE_MINIMAP_DISPLAY_DIST )
	RuiSetFloat( file.fakeMinimap_BaseRui, "mapScale", FAKE_MINIMAP_SCALE )

	UpdatePlayerRuiTracking_FakeMinimap( localPlayer )

	foreach ( entity teamPlayer in teamPlayers )
		thread FakeMinimap_PlayerObjectThread( teamPlayer )
}
#endif


#if(CLIENT)
void function DestroyFakeMinimap()
{
	Signal( GetLocalViewPlayer(), WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL )

	RuiDestroyIfAlive( file.fakeMinimap_BaseRui )
	RuiDestroyIfAlive( file.fakeMinimap_FrameRui )
	RuiDestroyIfAlive( file.fakeMinimap_YouArrowRui )

	Minimap_EnableDraw()
}
#endif


#if(CLIENT)
void function UpdatePlayerRuiTracking_FakeMinimap( entity player )
{
	Assert( player == GetLocalClientPlayer() )

	entity viewPlayer = GetLocalViewPlayer()

	RuiTrackFloat3( file.fakeMinimap_BaseRui, "playerPos", viewPlayer, RUI_TRACK_ABSORIGIN_FOLLOW )
	RuiTrackFloat3( file.fakeMinimap_BaseRui, "playerAngles", viewPlayer, RUI_TRACK_CAMANGLES_FOLLOW )
	RuiTrackFloat( file.fakeMinimap_BaseRui, "minimapZoomScale", player, RUI_TRACK_MINIMAP_ZOOM_SCALE )

	RuiTrackFloat( file.fakeMinimap_YouArrowRui, "minimapZoomScale", viewPlayer, RUI_TRACK_MINIMAP_ZOOM_SCALE )

	RuiTrackInt( file.fakeMinimap_YouArrowRui, "objectFlags", viewPlayer, RUI_TRACK_MINIMAP_FLAGS )
	RuiTrackInt( file.fakeMinimap_YouArrowRui, "customState", viewPlayer, RUI_TRACK_MINIMAP_CUSTOM_STATE )
	RuiTrackFloat3( file.fakeMinimap_YouArrowRui, "playerAngles", viewPlayer, RUI_TRACK_CAMANGLES_FOLLOW )
	#if(true)
		RuiTrackInt( file.fakeMinimap_YouArrowRui, "teamMemberIndex", viewPlayer, RUI_TRACK_PLAYER_TEAM_MEMBER_INDEX )
	#endif //
	RuiTrackInt( file.fakeMinimap_YouArrowRui, "squadID", viewPlayer, RUI_TRACK_SQUADID )
}
#endif


#if(CLIENT)
void function FakeMinimap_PlayerObjectThread( entity ent )
{
	asset minimapAsset = MINIMAP_PLAYER_RUI

	entity viewPlayer = GetLocalViewPlayer()

	ent.SetDoDestroyCallback( true )
	ent.EndSignal( "OnDestroy" )
	EndSignal( viewPlayer, WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL )

	table<string, var> e

	OnThreadEnd(
		function() : ( e, minimapAsset )
		{
			if ( "rui" in e )
			{
				var rui = e["rui"]
				if ( rui != null )
					RuiDestroy( rui )
			}
		}
	)

	while ( IsValid( ent ) )
	{
		if ( !("rui" in e) && IsValid( viewPlayer ) )
		{
			e["rui"] <- CreateMinimapRuiForEnt( ent, viewPlayer, minimapAsset )
			break
		}
		waitthread WaitForEntUpdate( ent, viewPlayer )
	}

	WaitForever()
}
#endif


#if(CLIENT)
var function CreateMinimapRuiForEnt( entity ent, entity viewPlayer, asset minimapAsset )
{
	int zOrder = ent.Minimap_GetZOrder()
	var rui    = CreateMinimapRui( minimapAsset, MINIMAP_Z_BASE + zOrder )

	Minimap_RuiSetPlayerData( rui )

	RuiTrackFloat3( rui, "objectPos", ent, RUI_TRACK_ABSORIGIN_FOLLOW )
	RuiTrackFloat3( rui, "objectAngles", ent, RUI_TRACK_EYEANGLES_FOLLOW )
	if ( ent.IsClientOnly() )
	{
		RuiSetInt( rui, "objectFlags", ent.e.clientEntMinimapFlags )
		RuiSetInt( rui, "customState", ent.e.clientEntMinimapCustomState )
	}
	else
	{
		RuiTrackInt( rui, "objectFlags", ent, RUI_TRACK_MINIMAP_FLAGS )
		RuiTrackInt( rui, "customState", ent, RUI_TRACK_MINIMAP_CUSTOM_STATE )
	}
	RuiSetFloat( rui, "displayDist", FAKE_MINIMAP_DISPLAY_DIST )
	RuiTrackFloat( rui, "minimapZoomScale", viewPlayer, RUI_TRACK_MINIMAP_ZOOM_SCALE )
	RuiSetFloat( rui, "minimapSizeScale", 1.0 )

	FakeMinimapPackage_PlayerInit( ent, rui )

	RuiSetVisible( rui, true )

	return rui
}
#endif


#if(CLIENT)
void function Minimap_RuiSetPlayerData( var rui )
{
	entity viewPlayer = GetLocalViewPlayer()

	RuiTrackFloat3( rui, "playerPos", viewPlayer, RUI_TRACK_ABSORIGIN_FOLLOW )
	RuiTrackFloat3( rui, "playerAngles", viewPlayer, RUI_TRACK_CAMANGLES_FOLLOW )
}
#endif


#if(CLIENT)
void function WaitForEntUpdate( entity ent, entity viewPlayer )
{
	EndSignal( ent, "SettingsChanged", "OnDeath", "TeamChanged", WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL )

	EndSignal( viewPlayer, "SettingsChanged", "OnDeath", "TeamChanged", WARP_ROOM_DESTROY_FAKE_TEAM_RUIS_SIGNAL )

	WaitForever()
}
#endif


#if(CLIENT)
void function FakeMinimapPackage_PlayerInit( entity ent, var rui )
{
	RuiTrackGameTime( rui, "lastFireTime", ent, RUI_TRACK_LAST_FIRED_TIME )
	#if(true)
		RuiTrackInt( rui, "teamMemberIndex", ent, RUI_TRACK_PLAYER_TEAM_MEMBER_INDEX )
	#endif

	RuiSetInt( rui, "squadIDLocalPlayer", GetLocalViewPlayer().GetSquadID() )
	RuiTrackInt( rui, "squadID", ent, RUI_TRACK_SQUADID )
}
#endif

#if(CLIENT)
bool function IsS05TEnabled()
{
	return GetCurrentPlaylistVarBool( "s5t_enabled", true )
}
#endif //


#if(CLIENT)
bool function IsS05T_Phase5Enabled()
{
	return true
}
#endif //