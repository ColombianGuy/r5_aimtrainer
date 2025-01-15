global function CodeCallback_MapInit
global function CryptoTTButton

const array <string> dialogue_ash = [
	"diag_mp_questTBG_assembleRelic_relicAi_02_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_03_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_04_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_05_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_06_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_07_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_08_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_09_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_10_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_11_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_12_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_13_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_14_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_15_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_16_3p"
	"diag_mp_questTBG_assembleRelic_relicAi_17_3p"
]

void function CodeCallback_MapInit()
{
	//thread S5_Quest()
	//thread CryptoTTIdle()
	//thread InitCryptoMap()
	thread InitLootRollers()
	///Canyonlands_MU1_CommonMapInit()
		
	//PrecacheModel( $"mdl/props/quest_s05/object.rmdl" )
	//PrecacheModel( $"mdl/props/quest_s05/object_eyes.rmdl" )
	//PrecacheModel( $"mdl/props/quest_s05/object_body.rmdl" )

	if (MapName() == eMaps.mp_rr_canyonlands_mu2_mv )
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2_mv.rpak" )
	else if (MapName() == eMaps.mp_rr_canyonlands_mu2_tt )
	{
		PrecacheModel( $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_01.rmdl")
		PrecacheModel( $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_02.rmdl")
		PrecacheModel( $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_03.rmdl")
		PrecacheModel( $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_04.rmdl")
		PrecacheModel( $"mdl/levels_terrain/mp_rr_canyonlands/crypto_holo_map_05.rmdl")
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2_tt.rpak" )
	}
	else
		MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_canyonlands_mu2.rpak" )
}

void function CryptoTTIdle()
{
	wait 0.01
	entity satellite = GetEntByScriptName( "crypto_tt_satellite_prop" )
	thread PlayAnim( satellite, "crypto_satellite_dish_idle" )
}

void function MainButton()
{
	wait 2
	entity panel = GetEntByScriptName( "crypto_map_switch" )
	thread CryptoTTButton( panel )
}

void function CryptoTTButton( entity panel )
{

	panel.SetSkin(0) // green

	panel.SetUsable()
	panel.SetUsableValue( USABLE_BY_ALL | USABLE_CUSTOM_HINTS )
	panel.SetUsePrompts( "Hold %use% to scan map", "Hold %use% to scan map" )
	
	//SetCallback_CanUseEntityCallback( panel, CryptoTTPanel_CanUseFunction )
	AddCallback_OnUseEntity( panel, OnCryptoTTPanelUse )

	#if CLIENT
	AddEntityCallback_GetUseEntOverrideText( panel, CryptoTTPanel_TextOverride )
	#endif // CLIENT
}

bool function CryptoTTPanel_CanUseFunction( entity playerUser, entity panel )
{
	return true
}

void function OnCryptoTTPanelUse( entity panel, entity playerUser, int useInputFlags )
{
	ExtendedUseSettings settings

	settings.successSound = LOOT_VAULT_AUDIO_ACCESS
	#if CLIENT
		settings.displayRui = $"ui/health_use_progress.rpak"
		settings.displayRuiFunc = DisplayRuiForCryptoTTPanel
		settings.loopSound = LOOT_VAULT_AUDIO_STATUSBAR
		settings.icon = $"rui/hud/gametype_icons/survival/data_knife"
		settings.hint = "Activating Map Scan"
	#elseif SERVER
		settings.successFunc = TTPanelUseSuccess
		settings.duration = 5.0
		settings.exclusiveUse = true
		settings.movementDisable = true
		settings.holsterWeapon = true
	#endif

	thread ExtendedUse( panel, playerUser, settings )
}

void function TTPanelUseSuccess( entity panel, entity player, ExtendedUseSettings settings )
{
	panel.SetSkin(1) // red
	panel.UnsetUsable()
	panel.SetUsePrompts( "", "" )

	//panel.Dissolve( ENTITY_DISSOLVE_CORE, <0,0,0>, 1000 )

	//PlayBattleChatterLineToSpeakerAndTeam( player, "bc_vaultOpened" )

	entity satellite = GetEntByScriptName( "crypto_tt_satellite_prop" )
		thread PlayAnim( satellite, "crypto_satellite_dish_activate" )
	EmitSoundOnEntity( satellite, "Canyonlands_Crypto_TT_Satellite_Dish_Activate" )
}

#if CLIENT
string function CryptoTTPanel_TextOverride( entity panel )
{
	return "Hold %use% to scan map"
}

void function DisplayRuiForCryptoTTPanel( entity ent, entity player, var rui, ExtendedUseSettings settings )
{
	DisplayRuiForCryptoTTPanel_Internal( rui, settings.icon, Time(), Time() + settings.duration, settings.hint )
}

void function DisplayRuiForCryptoTTPanel_Internal( var rui, asset icon, float startTime, float endTime, string hint )
{
	RuiSetBool( rui, "isVisible", true )
	RuiSetImage( rui, "icon", icon )
	RuiSetGameTime( rui, "startTime", startTime )
	RuiSetGameTime( rui, "endTime", endTime )
	RuiSetString( rui, "hintKeyboardMouse", hint )
	RuiSetString( rui, "hintController", hint )
}
#endif

void function S5_Quest()
{
    entity ash = CreatePropDynamic( $"mdl/props/quest_s05/object_body.rmdl", <-24755,22020,-340>, <0,0,0> )
	thread PlayAnim( ash, "obj_body_quest_se05_idle" )
	
	ash.SetUsable()
	ash.SetUsePrompts( "%&use% Complete Quest", "%&use% Complete Quest" )
	AddCallback_OnUseEntity( ash, Ash_OnUse )
	thread testaudio(ash)
}

void function testaudio( entity ash )
{
	wait 10
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
	wait 7
	thread EmitSoundOnEntity( ash, dialogue_ash.getrandom() )
}

void function stopaudio( entity ash )
{
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_02_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_03_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_04_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_05_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_06_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_07_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_08_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_09_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_10_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_11_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_12_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_13_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_14_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_15_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_16_3p" )
	thread StopSoundOnEntity( ash, "diag_mp_questTBG_assembleRelic_relicAi_17_3p" )
}

void function Ash_OnUse( entity ash, entity user, int useInputFlags )
{
	thread StartQuest(ash, user, useInputFlags)
	ash.UnsetUsable()
	EmitSoundOnEntity( gp()[0], "Music_Quest_Bunker_EndAnimation" )
	thread stopaudio(ash)
}

void function StartQuest( entity ash, entity user, int useInputFlags )
{
	entity player = gp()[0]
	player.SetOrigin( ash.GetOrigin() + <5,0,20> )
	player.SetAngles( <0, 0, 0> )
	player.FreezeControlsOnServer()
	//thread ToggleHud()

	thread PlayAnim( ash, "obj_body_quest_se05" )
	
	PlayFirstPersonAnimation( player, "ptpov_quest_se05" )
	wait 43
	ScreenFade( player, 0, 0, 0, 255, 0, 6, FFADE_OUT )
	wait 3
	player.SetOrigin( <-28860,22954,2070> )
	player.SetAngles( <-4, -10, 0> )
	wait 3
	StopSoundOnEntity( player, "Music_Quest_Bunker_EndAnimation" )
	ScreenFade( player, 0, 0, 0, 255, 5, 0, FFADE_IN )
	player.UnfreezeControlsOnServer()
	//thread ToggleHud()
	wait 5
	ash.SetUsable()
	thread PlayAnim( ash, "obj_body_quest_se05_idle" )
}