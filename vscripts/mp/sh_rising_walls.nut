#if SERVER
global function RisingWalls_Init

#if DEVELOPER
global function Debug_RisingWalls
#endif

#endif


#if CLIENT
global function ClRisingWalls_Init
global function ServerToClient_SetRisingWallAmbientGenericState
#endif


#if SERVER || CLIENT
global const string RISABLE_WALL_BRUSH_SCRIPTNAME = "risable_wall_brush"

const string RISABLE_WALL_HELPER_SCRIPTNAME = "rising_wall_helper"
const string RISABLE_WALL_PANEL_SCRIPTNAME = "risable_wall_top_panel"
const string RISABLE_WALL_MOVER_TOP_SCRIPTNAME = "risable_wall_top_mover"
const string RISABLE_WALL_MOVER_BASE_SCRIPTNAME = "risable_wall_base_mover"
const string RISABLE_WALL_MOVER_FLAP_SCRIPTNAME = "risable_wall_flap_mover"
const string RISABLE_WALL_FLOOR_MODEL_SCRIPTNAME = "rising_wall_floor_model"
const string RISABLE_WALL_FX_TRANSITION = "FX_wall_transition"
const string RISABLE_WALL_FX_COMPLETE = "FX_wall_complete"

const float WALL_RAISE_SEQ_DURATION = 20.0
const float DISPERSE_STICKY_LOOT_DURATION = 14.0
#endif //SERVER || CLIENT


#if SERVER
const asset RISABLE_WALL_PISTON_MDL = $"mdl/props/raisable_wall_hydraulic_arms/hydraulic_arm.rmdl"
const asset FX_WALL_TRANSITION = $"P_blastWall_steam_base"
const asset FX_WALL_COMPLETE = $"P_blastWall_impact"

const array< string > PISTON_ATTACHMENTS =
[
	"arm_point1",
	"arm_point2",
	"arm_point3",
	"arm_point4",
]

const string PISTON_ANIM_START_IDLE = "arm_idle2"
const string PISTON_ANIM_RISE = "arm_raise2"
const string PISTON_ANIM_END_IDLE = "arm_raise_idle2"

const vector WALL_TOP_END_ANGLE_OFFSET = < -90, 0, 0 >
const vector WALL_FLAP_END_ANGLE_OFFSET = < -70, 0, 0 >
const vector WALL_BASE_END_ANGLE_OFFSET = < 90, 0, 0 >

const string PANEL_ACTIVATE_SFX = "Desertlands_Fortress_Interactive_Panel"
#endif //SERVER


#if CLIENT
const string AMBIENT_GENERIC_SCRIPTNAME = "rising_wall_ambient_generic"

const float DIST_AMB_GEN_TO_HELPER_SQR = 1300000.0
#endif // CLIENT


struct RisableWallData
{
	array< entity > panels
	entity        	moverTop
	entity       	moverFlap
	entity        	moverBase
	entity        	baseWallBrush
	entity        	topWallBrush
	entity        	flapWallBrush

	bool hasStartedRising = false

	#if SERVER
		array< Point >  FXTransition
		array< Point >  FXComplete
		array< entity > fxEnts
		array< entity > pistons
		entity        	minimapObjLowered
		entity        	minimapObjMoving
		entity        	minimapObjRaised
	#endif // SERVER
}


struct
{
	table< EHI, RisableWallData > risableWallEHandleDataGroups

	#if SERVER && DEVELOPER
		bool debugEnabled = false
	#endif // SERVER && DEV
} file


#if SERVER
void function RisingWalls_Init()
{
	if ( !DoRisableWallEntsExist() )
		return

	if (MapName() != eMaps.mp_rr_desertlands_mu3 && MapName() != eMaps.mp_rr_desertlands_mu2)
		return;

	//PrecacheScriptString( RISABLE_WALL_BRUSH_SCRIPTNAME )

	PrecacheModel( RISABLE_WALL_PISTON_MDL )
	PrecacheEffect( FX_WALL_TRANSITION )
	PrecacheEffect( FX_WALL_COMPLETE )

	AddSpawnCallback_ScriptName( RISABLE_WALL_HELPER_SCRIPTNAME, OnRisableWallHelperSpawned )
}
#endif // SERVER


#if CLIENT
void function ClRisingWalls_Init()
{
	if ( !DoRisableWallEntsExist() )
		return

	if (MapName() != eMaps.mp_rr_desertlands_mu3 && MapName() != eMaps.mp_rr_desertlands_mu2)
		return;

	AddCreateCallback( "info_target", OnRisableWallHelperSpawned )

	RegisterMinimapPackage( "prop_dynamic", eMinimapObject_prop_script.RISING_WALL_DOWN, MINIMAP_OBJECT_RUI, MinimapPackage_RisingWall_Down, FULLMAP_OBJECT_RUI, MinimapPackage_RisingWall_Down )
	RegisterMinimapPackage( "prop_dynamic", eMinimapObject_prop_script.RISING_WALL_MOVING, MINIMAP_OBJECT_RUI, MinimapPackage_RisingWall_Moving, FULLMAP_OBJECT_RUI, MinimapPackage_RisingWall_Moving )
	RegisterMinimapPackage( "prop_dynamic", eMinimapObject_prop_script.RISING_WALL_UP, MINIMAP_OBJECT_RUI, MinimapPackage_RisingWall_Up, FULLMAP_OBJECT_RUI, MinimapPackage_RisingWall_Up )
}
#endif // CLIENT


#if CLIENT || SERVER
void function OnRisableWallHelperSpawned( entity helper )
{
	#if CLIENT
		if ( helper.GetScriptName() != RISABLE_WALL_HELPER_SCRIPTNAME )
			return
	#endif // CLIENT

	RisableWallData data
	EHI helperEHI = ToEHI( helper )

	foreach ( entity linkEnt in helper.GetLinkEntArray() )
	{
		string scriptName = linkEnt.GetScriptName()

		if ( scriptName == RISABLE_WALL_PANEL_SCRIPTNAME )
		{
			data.panels.append( linkEnt )

			// Get extra panel(s)
			string instanceName = data.panels[ 0 ].GetInstanceName()
			if ( instanceName == "" )
				Warning( "Risable wall instance at pos: " + data.panels[ 0 ].GetOrigin() + " needs an instance name." )
			else
				data.panels.extend( GetEntArrayByScriptName( format( "%s_extra_panel", instanceName ) ) )

			foreach ( entity wallPanel in data.panels )
			{
				#if SERVER
					wallPanel.AllowMantle()
					wallPanel.SetForceVisibleInPhaseShift( true )
					wallPanel.SetUsable()
					wallPanel.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS | USABLE_BY_ENEMIES )
					wallPanel.SetUsablePriority( USABLE_PRIORITY_LOW )
					wallPanel.SetSkin( 1 )
					wallPanel.SetUsePrompts( "#PRESS_TO_ACTIVATE_GENERIC", "#PRESS_TO_ACTIVATE_GENERIC" )
				#endif // SERVER

				AddCallback_OnUseEntity_ClientServer( wallPanel, CreateRisableWallPanelFunc( data, helper ) )
			}
		}
		else if ( scriptName == RISABLE_WALL_MOVER_BASE_SCRIPTNAME )
		{
			data.moverBase = linkEnt
			#if SERVER
				SetupRisingWallMover( data.moverBase )
			#endif // SERVER

			data.baseWallBrush = RisingWalls_SetupWallBrushes( data.moverBase )
		}
		else if ( scriptName == RISABLE_WALL_MOVER_TOP_SCRIPTNAME )
		{
			data.moverTop = linkEnt
			#if SERVER
				SetupRisingWallMover( data.moverTop )
			#endif // SERVER

			data.topWallBrush = RisingWalls_SetupWallBrushes( data.moverTop )
		}
		else if ( scriptName == RISABLE_WALL_MOVER_FLAP_SCRIPTNAME )
		{
			data.moverFlap = linkEnt
			#if SERVER
				SetupRisingWallMover( data.moverFlap )
			#endif // SERVER

			data.flapWallBrush = RisingWalls_SetupWallBrushes( data.moverFlap )
		}
		#if SERVER
		else if ( scriptName == RISABLE_WALL_FLOOR_MODEL_SCRIPTNAME )
		{
			RisingWalls_SetupPistons( linkEnt, data )
		}
		else if ( scriptName == RISABLE_WALL_FX_TRANSITION )
		{
			Point pointFXTrans
			pointFXTrans.origin = linkEnt.GetOrigin()
			pointFXTrans.angles = linkEnt.GetAngles()
			data.FXTransition.append( pointFXTrans )
			linkEnt.Destroy()
		}
		else if ( scriptName == RISABLE_WALL_FX_COMPLETE )
		{
			Point pointFXComplete
			pointFXComplete.origin = linkEnt.GetOrigin()
			pointFXComplete.angles = linkEnt.GetAngles()
			data.FXComplete.append( pointFXComplete )
			linkEnt.Destroy()
		}
		#endif // SERVER
	}

	#if SERVER
		//link all the other movers and panel
		data.panels[ 0 ].SetParent( data.moverTop )
		data.moverFlap.SetParent( data.moverTop )
		data.moverTop.SetParent( data.moverBase )
		//data.moverBase.SetPusherMovesNearbyVehicles( true )

		SURVIVAL_AddRisingWallToMinimap( data, eMinimapObject_prop_script.RISING_WALL_DOWN )
	#endif // SERVER

	file.risableWallEHandleDataGroups[ helperEHI ] <- data
}
#endif // CLIENT || SERVER


#if CLIENT || SERVER
entity function RisingWalls_SetupWallBrushes( entity mover )
{
    entity wallBrush = null
    #if SERVER
    foreach ( entity childEnt in GetChildren( mover ) )
    #elseif CLIENT
    foreach ( entity childEnt in mover.GetChildren() )
    #endif
    {
        string className

        #if SERVER
            className = childEnt.GetClassName()
        #else
            className = expect string( childEnt.GetNetworkedClassName() )
        #endif

        if ( className == "func_brush" )
        {
            childEnt.SetScriptName( RISABLE_WALL_BRUSH_SCRIPTNAME )

            wallBrush = childEnt
            break
        }
    }

    Assert( wallBrush != null, "Rising Walls enabled but no func_brush named " + RISABLE_WALL_BRUSH_SCRIPTNAME + " was found." )
    return wallBrush
}
#endif // CLIENT || SERVER


#if SERVER
void function RisingWalls_SetupPistons( entity floorModel, RisableWallData data )
{
	foreach ( string attachment in PISTON_ATTACHMENTS )
	{
		int pistonAttachId = floorModel.LookupAttachment( attachment )
		vector origin      = floorModel.GetAttachmentOrigin( pistonAttachId )
		vector angles      = floorModel.GetAttachmentAngles( pistonAttachId )

		entity piston = CreatePropDynamic( RISABLE_WALL_PISTON_MDL, origin, angles, SOLID_VPHYSICS )
		//SetIsPermanentEntity( piston, true )
		thread PlayAnim( piston, PISTON_ANIM_START_IDLE )
		data.pistons.append( piston )
	}

	// there's also a static version of the floor model in the map. The dynamic one is just for getting attachment positions
	floorModel.Destroy()
}
#endif // SERVER


#if SERVER
void function SURVIVAL_AddRisingWallToMinimap( RisableWallData data, int customState )
{
	entity minimapEnt

	if ( customState == eMinimapObject_prop_script.RISING_WALL_DOWN )
	{
		data.minimapObjLowered = RisingWalls_CreateMinimapProp( data.moverBase, data.minimapObjLowered, "risingWallIconDown" )
		minimapEnt = data.minimapObjLowered
	}
	else if ( customState == eMinimapObject_prop_script.RISING_WALL_MOVING )
	{
		data.minimapObjMoving = RisingWalls_CreateMinimapProp( data.moverBase, data.minimapObjMoving, "risingWallIconMoving" )
		minimapEnt = data.minimapObjMoving
	}
	else if ( customState == eMinimapObject_prop_script.RISING_WALL_UP )
	{
		data.minimapObjRaised = RisingWalls_CreateMinimapProp( data.moverBase, data.minimapObjRaised, "risingWallIconUp" )
		minimapEnt = data.minimapObjRaised
	}

	minimapEnt.Minimap_SetCustomState( customState )
	foreach ( player in GetPlayerArray() )
		minimapEnt.Minimap_AlwaysShow( 0, player )
}
#endif // SERVER


#if SERVER
entity function RisingWalls_CreateMinimapProp( entity moverBase, entity minimapObj, string targetName )
{
	minimapObj = CreatePropScript( $"mdl/dev/empty_model.rmdl", moverBase.GetOrigin(), moverBase.GetAngles() + < 0, -90, 0 > )
	SetTargetName( minimapObj, targetName )

	return minimapObj
}
#endif // SERVER


#if SERVER
void function SetupRisingWallMover( entity mover )
{
	FlagWait( "Survival_LootSpawned" )

	if ( IsValid( mover ) )
	{
		mover.AllowZiplines()
		mover.AllowMantle()
	}
}
#endif // SERVER


#if SERVER || CLIENT
void functionref( entity panel, entity player, int useInputFlags ) function CreateRisableWallPanelFunc( RisableWallData data, entity helper )
{
	return void function( entity panel, entity player, int useInputFlags ) : ( data, helper )
	{
		thread OnRisableWallPanelActivate( data, helper, panel, player )
	}
}
#endif //SERVER || CLIENT


#if SERVER || CLIENT
void function OnRisableWallPanelActivate( RisableWallData data, entity helper, entity activePanel, entity playerUser )
{
	if ( data.hasStartedRising )
		return

	data.hasStartedRising = true

	array< entity > wallBrushes = [ data.baseWallBrush, data.flapWallBrush ]

	#if SERVER
		foreach ( entity panel in data.panels )
		{
			panel.SetSkin( 2 )
			panel.UnsetUsable()
		}

		foreach ( brush in wallBrushes )
			CleanUpPermanentsParentedToDynamicEnt( brush )

		array< entity > movers = [ data.moverBase, data.moverTop, data.moverFlap ]
		foreach ( mover in movers )
		{
			mover.SetPusher( true )
			mover.DisallowZiplines()
		}

		//data.moverBase.DisallowObjectPlacement()
		//data.moverFlap.DisallowObjectPlacement()

		foreach ( player in GetPlayerArray() )
			data.minimapObjLowered.Minimap_Hide( 0, player )

		SURVIVAL_AddRisingWallToMinimap( data, eMinimapObject_prop_script.RISING_WALL_MOVING )
	#endif // SERVER

	foreach ( brush in wallBrushes )
	{
		AddEntToInvalidEntsForPlacingPermanentsOnto( brush )
		AddEntityDestroyedCallback( brush,
			void function( entity ent ) : ( brush )
			{
				RemoveEntFromInvalidEntsForPlacingPermanentsOnto( ent )
			}
		)
	}

	AddRefEntAreaToInvalidOriginsForPlacingPermanentsOnto( data.moverBase, < -94, -896, -32 >, < 122, 890, 24 > )
	entity moverBase = data.moverBase
	AddEntityDestroyedCallback( data.moverBase,
		void function( entity ent ) : ( moverBase )
		{
			RemoveRefEntAreaFromInvalidOriginsForPlacingPermanentsOnto( ent )
		}
	)

	#if SERVER
		//CleanUpPermanentsInInvalidAreas()
	#endif // SERVER

	#if SERVER && DEV
		if ( file.debugEnabled )
			Debug_OnRisableWallPanelActivate( data )
	#endif // SERVER && DEV

	#if SERVER
		OnThreadEnd(
			function() : ( data )
			{
				StopWallFx( data )
			}
		)

		EmitSoundOnEntity( activePanel, PANEL_ACTIVATE_SFX )

		RisingWalls_RotateMover( data.moverBase, WALL_BASE_END_ANGLE_OFFSET )
		RisingWalls_RotateMover( data.moverTop, WALL_TOP_END_ANGLE_OFFSET )
		RisingWalls_RotateMover( data.moverFlap, WALL_FLAP_END_ANGLE_OFFSET )

		foreach ( entity player in GetPlayerArray() )
			Remote_CallFunction_NonReplay( player, "ServerToClient_SetRisingWallAmbientGenericState", helper, true )

		foreach ( Point point in data.FXTransition )
			data.fxEnts.append( StartParticleEffectInWorld_ReturnEntity( GetParticleSystemIndex( FX_WALL_TRANSITION ), point.origin, point.angles ) )

		foreach ( entity piston in data.pistons )
			thread AnimatePiston( piston, data )
	#endif // SERVER

	wait DISPERSE_STICKY_LOOT_DURATION

	#if SERVER
		vector throwLootVelocity = data.moverFlap.GetUpVector() * 275.0
		array< entity > flapChildren = GetChildren( data.flapWallBrush )
		foreach ( entity child in flapChildren )
		{
			if ( child.GetClassName() == "prop_survival" )
			{
				child.ClearParent()
				thread FakePhysicsThrow_Retail( null, child, throwLootVelocity, true )
			}
		}
	#endif // SERVER

	wait WALL_RAISE_SEQ_DURATION - DISPERSE_STICKY_LOOT_DURATION

	#if SERVER
		foreach ( Point point in data.FXComplete )
			StartParticleEffectInWorld( GetParticleSystemIndex( FX_WALL_COMPLETE ), point.origin, point.angles )

		foreach( mover in movers )
			mover.AllowZiplines()

		foreach ( player in GetPlayerArray() )
			data.minimapObjMoving.Minimap_Hide( 0, player )

		SURVIVAL_AddRisingWallToMinimap( data, eMinimapObject_prop_script.RISING_WALL_UP )
	#endif // SERVER

	AddToAllowedAirdropDynamicEntities( data.topWallBrush )

	#if SERVER
		foreach ( entity player in GetPlayerArray() )
			Remote_CallFunction_NonReplay( player, "ServerToClient_SetRisingWallAmbientGenericState", helper, false )
	#endif // SERVER
}
#endif // SERVER || CLIENT


#if SERVER || CLIENT
void function RisingWalls_RotateMover( entity mover, vector angleOffset )
{
	mover.NonPhysicsSetRotateModeLocal( true )
	mover.NonPhysicsRotateTo( mover.GetLocalAngles() + angleOffset, WALL_RAISE_SEQ_DURATION, 0.0, 0.0 )
}
#endif // SERVER || CLIENT


#if CLIENT
void function ServerToClient_SetRisingWallAmbientGenericState( entity helper, bool shouldEnable )
{
	if ( !IsValid( helper ) )
		return

	foreach ( entity ambientGeneric in GetEntArrayByScriptName( AMBIENT_GENERIC_SCRIPTNAME ) )
	{
		// MegC: Not ideal way to get the ambient_generic.. Couldn't access it with AddCreateCallback (too buried in instances / func brushes?)
		// This might be the simplest solution without LevelEd changes which would require recompiles of multiple Desertlands maps
		if ( IsValid( ambientGeneric ) && DistanceSqr( ambientGeneric.GetOrigin(), helper.GetOrigin() ) < DIST_AMB_GEN_TO_HELPER_SQR )
		{
			if ( !shouldEnable )
				ambientGeneric.Destroy()
			else
				ambientGeneric.SetEnabled( true )
		}
	}
}
#endif // CLIENT


#if SERVER
void function StopWallFx( RisableWallData data )
{
	foreach ( fx in data.fxEnts )
	{
		EffectStop( fx )
	}
}
#endif // SERVER


#if SERVER
void function AnimatePiston( entity piston, RisableWallData data )
{
	PlayAnim( piston, PISTON_ANIM_RISE )
	PlayAnim( piston, PISTON_ANIM_END_IDLE )
}
#endif // SERVER


#if CLIENT
void function MinimapPackage_RisingWall_Down( entity ent, var rui )
{
	//#if MINIMAP_DEBUG
	//	printt( "Adding 'rui/hud/minimap/icon_map_wall_open' icon to minimap" )
	//#endif
	RuiSetImage( rui, "defaultIcon", $"rui/hud/minimap/icon_map_wall_open" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}


void function MinimapPackage_RisingWall_Moving( entity ent, var rui )
{
	//#if MINIMAP_DEBUG
	//	printt( "Adding 'rui/hud/minimap/icon_map_wall_moving' icon to minimap" )
	//#endif
	RuiSetImage( rui, "defaultIcon", $"rui/hud/minimap/icon_map_wall_moving" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}


void function MinimapPackage_RisingWall_Up( entity ent, var rui )
{
	//#if MINIMAP_DEBUG
		//printt( "Adding 'rui/hud/minimap/icon_map_wall_blocking' icon to minimap" )
	//#endif
	RuiSetImage( rui, "defaultIcon", $"rui/hud/minimap/icon_map_wall_blocking" )
	RuiSetImage( rui, "clampedDefaultIcon", $"" )
	RuiSetBool( rui, "useTeamColor", false )
}
#endif // CLIENT


#if SERVER || CLIENT
bool function DoRisableWallEntsExist()
{
	return GetCurrentPlaylistVarBool( "risable_walls_enabled", true )
}
#endif // SERVER || CLIENT


#if SERVER && DEVELOPER
void function Debug_RisingWalls()
{
	file.debugEnabled = true
}

void function Debug_OnRisableWallPanelActivate( RisableWallData data )
{
	/*float debugDrawTime = WALL_RAISE_SEQ_DURATION + 10.0
	DebugDrawSphere( data.moverBase.GetOrigin(), 8, COLOR_RED, true, debugDrawTime, true, 16 )


	foreach ( Point point in data.FXTransition )
		printt( "FX TRANSITION -> pos: " + point.origin + " ang: " + point.angles )
	foreach ( Point point in data.FXComplete )
		printt( "FX COMPLETE -> pos: " + point.origin + " ang: " + point.angles )

	thread Debug_ShowFlapAndTopRotationPivots_Thread( data, debugDrawTime )*/
}

void function Debug_ShowFlapAndTopRotationPivots_Thread( RisableWallData data, float duration )
{
	/*EndSignal( data.moverTop, "OnDestroy" )
	EndSignal( data.moverFlap, "OnDestroy" )

	float curTime = Time()

	while( true )
	{
		if ( Time() > curTime + duration || !file.debugEnabled )
			return

		DebugDrawSphere( data.moverTop.GetOrigin(), 8, COLOR_GREEN, true, 0.1 )
		DebugDrawSphere( data.moverFlap.GetOrigin(), 8, COLOR_BLUE, true, 0.1 )

		WaitFrame()
	}*/
}
#endif // SERVER && DEV