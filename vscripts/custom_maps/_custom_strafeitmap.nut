untyped
global function strafeitmap_init
// Code by: loy_ (Discord).
// Map by: loy_ (Discord) and treeree (Discord).

void
function strafeitmap_precache() {
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl" )
    PrecacheModel( $"mdl/props/charm/charm_nessy.rmdl" )
    PrecacheModel( $"mdl/timeshift/timeshift_bench_01.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_05.rmdl" )
    PrecacheModel( $"mdl/pipes/slum_pipe_large_blue_512_01.rmdl" )
    PrecacheModel( $"mdl/desertlands/icelandic_moss_mod_01.rmdl" )
    PrecacheModel( $"mdl/lava_land/volcanic_rock_01a.rmdl" )
    PrecacheModel( $"mdl/thunderdome/thunderdome_cage_ceiling_256x64_05.rmdl" )
    PrecacheModel( $"mdl/fx/water_bubble_pop_fx.rmdl" )
    file.characters = GetAllCharacters()
}

const PROP_DEFAULT_COLOR = "survival_item_common_cargobot"
const PROP_INTERACT_COLOR = "survival_item_epic_cargobot"

struct {
    vector first_cp = < 11584.27, -21175.63, 46690.86 >
    table < entity, vector > cp_table = {}
    table < entity, vector > cp_angle = {}
    table < entity, bool > last_cp = {}
    array<ItemFlavor> characters
}
file

 void function strafeitmap_init() {
    AddCallback_OnClientConnected(strafeitmap_player_setup)
    AddCallback_EntitiesDidLoad(strafeitmapEntitiesDidLoad)
    strafeitmap_precache()
}

void
function strafeitmapEntitiesDidLoad() {
    thread strafeitmap_load()
}

void
function strafeitmap_player_setup(entity player) {
    if (!IsValidPlayer(player))
		return

    file.cp_table[player] <- file.first_cp
    file.cp_angle[player] <- <0,-150,0>
    file.last_cp[player] <- false

    player.SetPersistentVar("gen", 0)

    LocalMsg(player, "#FS_STRING_VAR", "", 9, 5.0, "Strafe It", "By: Loy & Treeree", "", false)
    
      thread
  (
    void 
    function() : ( player ) {
        wait 3.0
        CharacterSelect_AssignCharacter( ToEHI( player ), file.characters[8] )
    	ItemFlavor playerCharacter = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_CharacterClass() )
    	asset characterSetFile = CharacterClass_GetSetFile( playerCharacter )
    	player.SetPlayerSettingsWithMods( characterSetFile, [] )
    	player.TakeOffhandWeapon(OFFHAND_TACTICAL)
    	player.TakeOffhandWeapon(OFFHAND_ULTIMATE)
        player.SetOrigin(file.cp_table[player])
        player.SetAngles(file.cp_angle[player])
      }
  )()
}

void
function strafeitmap_load() {
    // Props
    entity prop
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.46, -24034.65, 46070.66 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8438.76, -23846.1, 47198.36 >, < 0, 75, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11523.72, -21211.16, 46623.66 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10549.3, -23258.34, 47942.76 >, < 0, 150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8850.63, -22124.23, 48095.86 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7655.7, -25039.42, 46829.76 >, < 0, 75, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8974.27, -22157.36, 48223.86 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 8941.14, -22281, 48223.86 >, < 0, -15, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7761.28, -25200.23, 46813.46 >, < -90, 75, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10548.17, -21543.45, 46631.36 >, < 0, -149.9, -89.9 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.51, -24609.18, 46363.36 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 8500.48, -22442.77, 47166.2 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7757.24, -25215.3, 46701.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7827.54, -24952.95, 47069.46 >, < -90, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.27, -23764.29, 47661.28 >, < 0, 90, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7692.79, -23476.18, 46135.86 >, < 0, 75, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7670.77, -25043.46, 46941.46 >, < -90, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11302.02, -21339.16, 46623.66 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8603.45, -22057.9, 48096.1 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13383.3, -22191.05, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.46, -24034.65, 46168.86 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9128.62, -22362.92, 46188.86 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10342.06, -21662.45, 46706.46 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7922.54, -24598.12, 47198.36 >, < 0, 75, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/lava_land/volcanic_rock_01a.rmdl", < 10360.73, -22346.8, 44662.46 >, < 0, -52.06, 0 >, true, 50000, -1, 20 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7851.36, -23688.82, 47134.36 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 7896.2, -24943.68, 47199.36 >, < 0, -105, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8202.55, -23009.74, 46140.26 >, < 0, -90, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.33, -24035.14, 46268.66 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 8781.56, -21393.77, 47954 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9509.8, -22368.94, 45999.46 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )

    prop = MapEditor_CreateProp( $"mdl/fx/water_bubble_pop_fx.rmdl", < 12407.04, -24536.21, 47248.46 >, < 0, -105, 0 >, true, 50000, -1, 8 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9186.82, -22380.27, 48223.86 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10073.61, -23048.49, 48159.64 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13246.65, -21954.36, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10548.17, -21543.45, 46706.46 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11590.63, -24213.93, 47308.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7743.61, -25212.06, 46880.46 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.51, -24609.18, 46265.16 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12407.04, -24536.21, 47216.76 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8392.61, -22845.37, 47134.1 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/pipes/slum_pipe_large_blue_512_01.rmdl", < 8583.74, -22133.58, 47859.1 >, < 0, 75, 180 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9093.51, -22383.3, 46094.26 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7918.04, -25109.72, 46685.46 >, < -90, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13161.43, -22319.15, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7659.27, -25024.54, 46530.46 >, < 0, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7547.13, -25010.33, 46383.66 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8122.67, -23263.78, 46140.26 >, < 0, -30, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13024.78, -22082.46, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 13310.85, -22066.14, 51042.73 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10106.68, -22925.04, 48159.64 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7791.17, -24562.92, 47326.36 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9729.63, -22359.76, 48223.86 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10084.94, -22049.92, 46332.26 >, < 0, -60, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10931.18, -24140.56, 47310.76 >, < 0, 75, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7794.41, -25076.59, 47117.36 >, < 0, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10945.68, -21313.95, 46677.56 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 9310.19, -22484.41, 46076.96 >, < -90, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/props/charm/charm_nessy.rmdl", < 13203.31, -22006.29, 46427.46 >, < 0, 30, -30 >, true, 300, -1, 10 )
    prop = MapEditor_CreateProp( $"mdl/timeshift/timeshift_bench_01.rmdl", < 13231.84, -22033.7, 46389.53 >, < 0, 30, 0 >, true, 300, -1, 1 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7933.11, -25113.76, 46573.76 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11930, -24299.69, 47308.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7299.88, -24944.1, 46383.66 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7922.54, -24598.12, 47134.36 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7818.2, -23812.55, 47326.36 >, < 90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7982.7, -23724.11, 47326.36 >, < 0, -105, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8202.68, -23009.88, 46215.36 >, < 0, -90, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9310.46, -22413.4, 48095.86 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7659.14, -25025.02, 47008.46 >, < 0, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9426.74, -22416.89, 46068.86 >, < 0, -60, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11538.87, -24407.12, 47308.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10342.06, -21662.45, 46631.36 >, < 0, -149.9, -89.9 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.47, -23636.58, 47660.76 >, < 0, 90, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 9467.49, -22321.92, 48223.86 >, < 0, -15, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8613.46, -22886.44, 46144.26 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8122.85, -23263.74, 46215.36 >, < 0, -30, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 7916.3, -23224.42, 46140.36 >, < 0, -90, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_05.rmdl", < 13089.14, -22194.14, 51042.73 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.22, -24322.88, 46167.56 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11590.63, -24213.93, 46956.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10549.65, -23258.54, 47621.68 >, < 0, 150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10438.81, -23194.32, 47942.22 >, < 0, 150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 7824.92, -24034.76, 47199.36 >, < 0, -105, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 7916.43, -23224.55, 46215.46 >, < 0, -90, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7831.57, -24937.88, 46957.76 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7957.48, -24467.72, 47326.36 >, < -90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7886.3, -23558.42, 47326.36 >, < -90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8473.7, -23715.71, 47326.36 >, < -90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10106.86, -22924.78, 47839.24 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10073.63, -23048.4, 47839.46 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11178.38, -24207, 47310.76 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 8718.15, -21630.42, 47617.2 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10236.5, -21962.42, 46513.86 >, < 0, -60, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9852.78, -22392.96, 48095.76 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8883.76, -22000.6, 48223.86 >, < -90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7847.23, -24940.11, 46623.86 >, < 0, 165, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11538.87, -24407.12, 46956.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12978.12, -22258.24, 51122.83 >, < 90, -150, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7831.57, -24937.88, 46445.76 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7719.99, -23653.62, 47326.36 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10438.73, -23194.27, 47622.18 >, < 0, 150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11875.65, -24502.53, 46956.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10100.04, -22459.15, 48095.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9434.1, -22446.52, 48223.86 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7929.67, -25128.16, 46752.46 >, < 0, 75, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8405.61, -23969.84, 47326.36 >, < 90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 9381.89, -22441.4, 45999.36 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12228.85, -22607.46, 46472.23 >, < 0, 120, -135 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10753.42, -21424.95, 46613.36 >, < 0, -149.9, -89.9 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7851.36, -23688.82, 47198.36 >, < 0, 75, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7626.65, -23723.38, 46135.86 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7889.38, -24721.86, 47326.36 >, < 90, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8438.76, -23846.1, 47134.36 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 9373.74, -22594.48, 46076.96 >, < -90, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.47, -23636.49, 47340.72 >, < 0, 90, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.1, -24323.37, 46365.56 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x64_05.rmdl", < 11741.9, -21602.84, 46285.53 >, < 50.98, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8570.1, -23881.4, 47326.36 >, < 0, -105, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8326.15, -23092.58, 47134.16 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/desertlands/construction_bldg_platform_02.rmdl", < 11617.56, -20975.69, 47002.46 >, < 0, 30, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; prop.MakeInvisible(); prop.kv.contents = CONTENTS_SOLID | CONTENTS_NOGRAPPLE
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7827.54, -24952.95, 46557.46 >, < -90, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8835.16, -22758.44, 46144.26 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.27, -23764.69, 47340.22 >, < 0, 90, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11804.56, -21717.58, 46286.53 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.38, -24609.67, 46463.16 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7670.77, -25043.46, 46463.46 >, < -90, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10753.42, -21424.95, 46688.46 >, < 0, -149.9, -89.9 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11875.65, -24502.53, 47308.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12267.48, -22677.19, 46755.63 >, < 0, -150, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12267.48, -22677.19, 46500.43 >, < 0, -150, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11930, -24299.69, 46956.76 >, < 0, 165, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10945.68, -21313.95, 46602.46 >, < 0, -149.9, -89.9 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 8412.32, -24192.05, 47199.36 >, < 0, -105, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8307.4, -23810.9, 47326.36 >, < 0, -105, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13436.42, -21993.64, 51122.83 >, < 90, -150, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9092.73, -22383.76, 46161.06 >, < 0, -149.9, -89.9 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8053.88, -24633.42, 47326.36 >, < 0, -105, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.22, -24322.88, 46265.76 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )

    // VerticalZipLines
    MapEditor_CreateZiplineFromUnity( < 8491.21, -22476.62, 47220.7 >, < 0, 75, 0 >, < 8491.21, -22476.62, 47130.7 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8714.13, -21644.67, 48088.1 >, < 0, 75, 0 >, < 8714.13, -21644.67, 47963.1 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8491.21, -22476.62, 47638.1 >, < 0, 75, 0 >, < 8491.21, -22476.62, 47513.1 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8708.87, -21664.28, 47671.3 >, < 0, 75, 0 >, < 8708.87, -21664.28, 47571.3 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )

    // Buttons
    AddCallback_OnUseEntity( CreateFRButton(< 11484.89, -21092.7, 46639.16 >, < 0, 30, 0 >, "%use% Start/Stop Timer"), void function(entity panel, entity ent, int input)
    {
if (IsValidPlayer(ent)) {
    if (ent.GetPersistentVar("gen") == 0) {
        ent.p.isTimerActive = true
        ent.SetPersistentVar("gen", Time())
        ent.SetVelocity(<0,0,0>)
        LocalMsg(ent, "#FS_STRING_VAR", "", 4, 1.0, "Timer Started", "", "", false)
    } else {
        ent.SetPersistentVar("gen", 0)
        ent.p.isTimerActive = false
        LocalMsg(ent, "#FS_STRING_VAR", "", 4, 1.0, "Timer Stopped", "", "", false)
    }
    file.last_cp[ent] <- false
    ent.TakeOffhandWeapon(OFFHAND_TACTICAL)
    ent.TakeOffhandWeapon(OFFHAND_ULTIMATE)
}
    })


    // Triggers
    entity trigger
    trigger = MapEditor_CreateTrigger( < 11238.4, -21282.36, 46690.86 >, < 0, -60, 0 >, 200, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.last_cp[ent]) {
    file.last_cp[ent] = false
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0) {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60

        LocalMsg(ent, "#FS_STRING_VAR", "", 2, 5.0, format("%d:%02d", minutes, seconds), "FINAL TIME", "", false)
        ent.SetPersistentVar("gen", 0)
    } else {
        LocalMsg(ent, "#FS_STRING_VAR", "", 2, 5.0, "YOU FINISHED!", "CONGRATULATIONS", "", false)
    }
}

file.cp_table[ent] <- < 11584.27, -21175.62, 46690.86 >
file.cp_angle[ent] <- < 0, -150, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8823.05, -22345.46, 46922.46 >, < 0, -15, 0 >, 1349, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10515.65, -23905.12, 46895.46 >, < 0, -15, 0 >, 1357.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7547.34, -25010.46, 46450.86 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7231.66, -24927.05, 46450.86 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 7231.66, -24927.05, 46450.86 >
file.cp_angle[ent] <- < 0, -15, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7793.39, -25076.83, 47184.26 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7799.05, -25086.63, 47184.26 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 7799.05, -25086.63, 47184.26 >
file.cp_angle[ent] <- < 0, 75, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10987.81, -24155.13, 47377.06 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10860.89, -24121.12, 47377.06 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 10860.89, -24121.12, 47377.06 >
file.cp_angle[ent] <- < 0, -15, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10459.5, -23021.86, 45586.46 >, < 0, -60, 0 >, 5000, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12368.12, -24515.68, 46874.46 >, < 0, -15, 0 >, 709.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 11504.79, -21128.56, 46690.86 >, < 0, -60, 0 >, 200, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.last_cp[ent]) {
    file.last_cp[ent] = false
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0) {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60

        LocalMsg(ent, "#FS_STRING_VAR", "", 2, 5.0, format("%d:%02d", minutes, seconds), "FINAL TIME", "", false)
        ent.SetPersistentVar("gen", 0)
    } else {
        LocalMsg(ent, "#FS_STRING_VAR", "", 2, 5.0, "YOU FINISHED!", "CONGRATULATIONS", "", false)
    }
}

file.cp_table[ent] <- < 11584.27, -21175.62, 46690.86 >
file.cp_angle[ent] <- < 0, -150, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8835.27, -22758.03, 46210.16 >, < 0, -60, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8900.5, -22729.6, 46210.16 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 8900.5, -22729.6, 46210.16 >
file.cp_angle[ent] <- < 0, -150, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9418.14, -22359.38, 47939.96 >, < 0, -15, 0 >, 671, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 13309.88, -22066.47, 51108.16 >, < 0, 30, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 13372.06, -22030.57, 51108.16 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 13372.06, -22030.57, 51108.16 >
file.cp_angle[ent] <- < 0, -150, 0 >
file.last_cp[ent] <- true
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7691.42, -23478.01, 46202.76 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7717.81, -23410.44, 46202.76 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 7717.81, -23410.44, 46202.76 >
file.cp_angle[ent] <- < 0, -105, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9508.27, -22369.7, 46085.56 >, < 0, -60, 0 >, 127.5, 70, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 9601.3, -22325.23, 46085.56 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 9601.3, -22325.23, 46085.56 >
file.cp_angle[ent] <- < 0, -150, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12407.56, -24536.79, 47282.96 >, < 0, -105, 0 >, 68.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !ent.IsPlayer() || ent.GetPhysics == MOVETYPE_NOCLIP)
    return

ent.SetOrigin(< 13372.06, -22030.57, 51108.16 >)
ent.SetAngles(< 0, -150, 0 >)
ent.SetVelocity( < 0, 0, 0 > )
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7833.81, -24921.05, 47055.16 >, < 0, -15, 0 >, 59.15, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7799.05, -25086.63, 47184.26 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 7799.05, -25086.63, 47184.26 >
file.cp_angle[ent] <- < 0, 75, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9852.91, -22392.42, 48162.46 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10048.66, -22365.16, 48162.46 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 10048.66, -22365.16, 48162.46 >
file.cp_angle[ent] <- < 0, -60, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10095.38, -22457.4, 48162.46 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10048.66, -22365.16, 48162.46 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 10048.66, -22365.16, 48162.46 >
file.cp_angle[ent] <- < 0, -60, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8084.93, -23990.99, 46922.46 >, < 0, -15, 0 >, 664.515, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8327.75, -23088.57, 47200.96 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8299.36, -23194.54, 47200.96 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 8299.36, -23194.54, 47200.96 >
file.cp_angle[ent] <- < 0, 75, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8633.56, -22065.85, 48162.46 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8556.94, -21963.44, 48162.46 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 8556.94, -21963.44, 48162.46 >
file.cp_angle[ent] <- < 0, -38.48, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7301.3, -24945.71, 46450.86 >, < 0, -15, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7231.66, -24927.05, 46450.86 > )
{
    int gen = ent.GetPersistentVarAsInt("gen")

    if (gen != 0)
    {
        float final_time = Time() - gen
        float minutes = final_time / 60
        float seconds = final_time % 60
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, format("%d:%02d", minutes, seconds), "", "", false)
    } else
    {
        LocalMsg(ent, "#FS_STRING_VAR", "", 1, 5.0, "CHECKPOINT", "", "", false)
    }
}

file.cp_table[ent] <- < 7231.66, -24927.05, 46450.86 >
file.cp_angle[ent] <- < 0, -15, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10567.29, -21936.56, 47939.96 >, < 0, -15, 0 >, 671, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !IsAlive(ent) || ent.GetPhysics() == MOVETYPE_NOCLIP)
    return

if (!(ent in file.cp_table))
    file.cp_table[ent] <- file.first_cp

ent.SetOrigin(file.cp_table[ent])

if (!(ent in file.cp_angle))
    file.cp_angle[ent] <- < 0, 0, 0 >

ent.SetAngles(file.cp_angle[ent])
ent.SetVelocity(< 0, 0, 0 >)
    })
    DispatchSpawn( trigger )



    // Text Info Panels
    MapEditor_CreateTextInfoPanel( "Strafe It", "by: Loy & Treeree", < 11486.01, -21094.64, 46810.16 >, < 0, 120, 0 >, false, 2 )


    // Invis Buttons
    Invis_Button( < 7570.3, -23407.9, 46162.34 >, < 0, 75, 0 >, false, < 8900.5, -22729.6, 46210.16 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7917.9, -25141.12, 47143.84 >, < 0, -105, 0 >, false, < 7231.66, -24927.05, 46450.86 >, < 0, -15, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8797.6, -22623.1, 46170.74 >, < 0, 30, 0 >, false, < 9601.3, -22325.23, 46085.56 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11005.93, -24301.38, 47337.24 >, < 0, 165, 0 >, true, < 13372.06, -22030.57, 51108.16 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9793.36, -22517.84, 48122.24 >, < 0, 165, 0 >, false, < 8556.94, -21963.44, 48162.46 >, < 0, -38.48, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8468.68, -23086.09, 47160.64 >, < 0, -105, 0 >, true, < 8556.94, -21963.44, 48162.46 >, < 0, -38.48, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8450.49, -23154, 47160.64 >, < 0, -105, 0 >, false, < 7799.05, -25086.62, 47184.26 >, < 0, 75, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8548.78, -22184.09, 48122.58 >, < 0, 165, 0 >, true, < 10048.66, -22365.16, 48162.46 >, < 0, -60, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8736.72, -22658.25, 46170.74 >, < 0, 30, 0 >, true, < 7717.81, -23410.44, 46202.76 >, < 0, -105, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11207.48, -21246.01, 46650.14 >, < 0, 30, 0 >, true, < 9601.3, -22325.23, 46085.56 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12998.37, -22287.31, 51069.21 >, < 0, 120, 0 >, true, < 11584.27, -21175.62, 46690.86 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12963.22, -22226.43, 51069.21 >, < 0, 120, 0 >, false, < 10860.89, -24121.12, 47377.06 >, < 0, -15, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7298.29, -25084.46, 46410.14 >, < 0, 165, 0 >, true, < 7799.05, -25086.63, 47184.26 >, < 0, 75, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7230.39, -25066.27, 46410.14 >, < 0, 165, 0 >, false, < 7717.81, -23410.44, 46202.76 >, < 0, -105, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9645.18, -22444.82, 46025.94 >, < 0, -150, 0 >, false, < 11584.27, -21175.62, 46690.86 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9861.26, -22536.03, 48122.24 >, < 0, 165, 0 >, true, < 10860.89, -24121.12, 47377.06 >, < 0, -15, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7936.1, -25073.21, 47143.84 >, < 0, -105, 0 >, true, < 8299.36, -23194.54, 47200.96 >, < 0, 75, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10938.02, -24283.18, 47337.24 >, < 0, 165, 0 >, false, < 10048.66, -22365.16, 48162.46 >, < 0, -60, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11268.36, -21210.86, 46650.14 >, < 0, 30, 0 >, false, < 13372.06, -22030.57, 51108.16 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8480.88, -22165.9, 48122.58 >, < 0, 165, 0 >, false, < 8299.36, -23194.54, 47200.96 >, < 0, 75, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9510.48, -22211.51, 46025.94 >, < 0, 30, 0 >, true, < 8900.5, -22729.6, 46210.16 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7552.1, -23475.8, 46162.34 >, < 0, 75, 0 >, true, < 7231.66, -24927.05, 46450.86 >, < 0, -15, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
}
