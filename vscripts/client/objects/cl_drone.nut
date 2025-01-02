global function ClDrone_Init
const DRONE_ATTACK_PLASMA_MODEL = $"mdl/robots/drone_air_attack/drone_air_attack_plasma.rmdl"
const DRONE_ATTACK_ROCKETS_MODEL = $"mdl/robots/drone_air_attack/drone_air_attack_rockets.rmdl"
const DRONE_GLOW_EYE_FRIENDLY = $"P_stalker_eye_friend"
const DRONE_GLOW_EYE_ENEMY = $"P_stalker_eye_foe"

const DRONE_GLOW_MAIN_FRIENDLY = $"PP_spectre_light_friend"
const DRONE_GLOW_MAIN_ENEMY = $"P_spectre_light_foe"

void function ClDrone_Init()
{
	array<asset> models
	models.append( DRONE_ATTACK_PLASMA_MODEL )
	models.append( DRONE_ATTACK_ROCKETS_MODEL )

	foreach( asset model in models )
	{
		//----------------------
		// DRONE_BASE_MODEL Lights - Friend
		//----------------------
		ModelFX_BeginData( "friend_lights", model, "friend", true )
			ModelFX_AddTagSpawnFX( "FX_EYE", DRONE_GLOW_EYE_FRIENDLY )
			ModelFX_AddTagSpawnFX( "FX_ANTENA", DRONE_GLOW_MAIN_FRIENDLY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_R", DRONE_GLOW_MAIN_FRIENDLY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_R_F", DRONE_GLOW_MAIN_FRIENDLY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_L", DRONE_GLOW_MAIN_FRIENDLY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_L_F", DRONE_GLOW_MAIN_FRIENDLY )
		ModelFX_EndData()

		//----------------------
		// DRONE_BASE_MODEL Lights - Foe
		//----------------------
		ModelFX_BeginData( "foe_lights", model, "foe", true )
			ModelFX_AddTagSpawnFX( "FX_EYE", DRONE_GLOW_EYE_ENEMY )
			ModelFX_AddTagSpawnFX( "FX_ANTENA", DRONE_GLOW_MAIN_ENEMY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_R", DRONE_GLOW_MAIN_ENEMY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_R_F", DRONE_GLOW_MAIN_ENEMY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_L", DRONE_GLOW_MAIN_ENEMY )
			ModelFX_AddTagSpawnFX( "FX_LIGHT_L_F", DRONE_GLOW_MAIN_ENEMY )
		ModelFX_EndData()
	}
}
