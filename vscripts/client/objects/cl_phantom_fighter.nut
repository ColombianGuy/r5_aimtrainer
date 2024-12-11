untyped

global function ClPhantomFighter_Init


bool initialized = false

function ClPhantomFighter_Init()
{
	if ( initialized )
		return
	initialized = true

	ModelFX_BeginData( "friend_lights", $"mdl/vehicle/straton/straton_imc_gunship_01.rmdl", "friend", true )
		//----------------------
		// ACL Lights - Friend
		//----------------------
		ModelFX_AddTagSpawnFX( "Light_Red0",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "Light_Red1",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "Light_Red2",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "Light_Green0",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "Light_Green1",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "Light_Green2",		$"acl_light_blue" )
		ModelFX_AddTagSpawnFX( "light_white",		$"acl_light_blue" )
	ModelFX_EndData()


	ModelFX_BeginData( "foe_lights", $"mdl/vehicle/straton/straton_imc_gunship_01.rmdl", "foe", true )
		//----------------------
		// ACL Lights - Foe
		//----------------------
		ModelFX_AddTagSpawnFX( "Light_Red0",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Red1",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Red2",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Green0",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Green1",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Green2",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "light_white",		$"acl_light_red" )
	ModelFX_EndData()


	ModelFX_BeginData( "thrusters", $"mdl/vehicle/straton/straton_imc_gunship_01.rmdl", "all", true )
		//----------------------
		// Thrusters
		//----------------------
		ModelFX_AddTagSpawnFX( "L_exhaust_rear_1", $"veh_gunship_jet_full" )
		ModelFX_AddTagSpawnFX( "L_exhaust_front_1", $"veh_gunship_jet_full" )

		ModelFX_AddTagSpawnFX( "R_exhaust_rear_1", $"veh_gunship_jet_full" )
		ModelFX_AddTagSpawnFX( "R_exhaust_front_1", $"veh_gunship_jet_full" )

		//----------------------
		// ACL Lights - All
		//----------------------
		ModelFX_AddTagSpawnFX( "Light_Red0",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Red1",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Red2",		$"acl_light_red" )
		ModelFX_AddTagSpawnFX( "Light_Green0",		$"acl_light_green" )
		ModelFX_AddTagSpawnFX( "Light_Green1",		$"acl_light_green" )
		ModelFX_AddTagSpawnFX( "Light_Green2",		$"acl_light_green" )
		ModelFX_AddTagSpawnFX( "light_white",		$"acl_light_blue" )


	ModelFX_EndData()


	ModelFX_BeginData( "gunshipDamage", $"mdl/vehicle/straton/straton_imc_gunship_01.rmdl", "all", true )
		//----------------------
		// Health effects
		//----------------------
		//ModelFX_AddTagHealthFX( 0.80, "L_exhaust_rear_1", $"P_veh_crow_exp_sml", true )
		ModelFX_AddTagHealthFX( 0.80, "L_exhaust_rear_1", $"xo_health_smoke_white", false )

		//ModelFX_AddTagHealthFX( 0.75, "R_exhaust_rear_1", $"P_veh_crow_exp_sml", true )
		ModelFX_AddTagHealthFX( 0.75, "R_exhaust_rear_1", $"xo_health_smoke_white", false )

		//ModelFX_AddTagHealthFX( 0.50, "L_exhaust_rear_1", $"P_veh_crow_exp_sml", true )
		ModelFX_AddTagHealthFX( 0.50, "L_exhaust_rear_1", $"veh_chunk_trail", false )

		//ModelFX_AddTagHealthFX( 0.45, "R_exhaust_rear_1", $"P_veh_crow_exp_sml", true )
		ModelFX_AddTagHealthFX( 0.45, "R_exhaust_rear_1", $"veh_chunk_trail", false )



	ModelFX_EndData()


	// ModelFX_BeginData( "gunshipExplode", $"models/vehicle/straton/straton_imc_gunship_01.mdl", "all", true )
	// 	//----------------------
	// 	// D`eath effects
	// 	//----------------------
	// 	//``ModelFX_AddTagBreakFX( null, "ORIGIN", "P_veh_exp_hornet", "Goblin_Dropship_Explode" )
	// ModelFX_EndData()
}