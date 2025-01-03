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
    vector first_cp = < 10582.5, 6708.2, 42873.4 >
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
    file.cp_angle[player] <- <0,-90,0>
    file.last_cp[player] <- false

	ItemFlavor playerCharacter = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_CharacterClass() )
	asset characterSetFile = CharacterClass_GetSetFile( playerCharacter )
	player.SetPlayerSettingsWithMods( characterSetFile, [] )

    CharacterSelect_AssignCharacter( ToEHI( player ), file.characters[8] )
	player.TakeOffhandWeapon(OFFHAND_TACTICAL)
	player.TakeOffhandWeapon(OFFHAND_ULTIMATE)


    player.SetPersistentVar("gen", 0)
    

    
      thread
  (
    void function() : ( player )
    {
        wait 3.0
    player.SetOrigin(file.cp_table[player])
    player.SetAngles(file.cp_angle[player])
    LocalMsg(player, "#FS_STRING_VAR", "", 9, 5.0, "Strafe It", "By: Loy & Treeree", "", false)

      }
  )()
}

void
function strafeitmap_load() {
    // Props
    entity prop
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9093.509, -22383.3, 46094.26 >, < 0, -149.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10106.86, -22924.78, 47839.24 >, < 0, -104.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8053.878, -24633.42, 47326.36 >, < 0, -105.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7719.991, -23653.62, 47326.36 >, < 0, -105.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8122.672, -23263.79, 46140.25 >, < 0, -30, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7922.538, -24598.12, 47198.36 >, < 0, 74.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8473.937, -23714.84, 47326.36 >, < -90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8202.549, -23009.75, 46140.25 >, < 0, -90, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8883.763, -22000.59, 48223.86 >, < -90, -104.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.381, -24609.67, 46463.16 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7761.277, -25200.23, 46813.46 >, < -90, 75.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11873.06, -24512.19, 46956.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 7916.303, -23224.42, 46140.36 >, < 0, -89.9999, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8405.607, -23969.84, 47326.36 >, < 90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 9310.19, -22484.41, 46076.96 >, < -90, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8326.151, -23092.58, 47134.16 >, < 0, -105.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 8412.325, -24192.05, 47199.36 >, < 0, -104.9999, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10084.94, -22049.92, 46332.26 >, < 0, -60, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7929.669, -25128.16, 46752.46 >, < 0, 75.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8392.608, -22845.37, 47134.11 >, < 0, -105, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7889.383, -24721.86, 47326.36 >, < 90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 9373.741, -22594.48, 46076.96 >, < -90, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.456, -24034.65, 46168.86 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12267.48, -22677.19, 46755.63 >, < 0, -150, 89.9999 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10342.06, -21662.45, 46631.36 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8850.634, -22124.23, 48095.86 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7922.538, -24598.12, 47134.36 >, < 0, -105.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x64_05.rmdl", < 11741.9, -21602.85, 46285.53 >, < 50.9783, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9092.729, -22383.75, 46161.06 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_05.rmdl", < 13089.14, -22194.14, 51042.73 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10100.04, -22459.15, 48095.75 >, < 0, 165.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11804.56, -21717.59, 46286.53 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10548.17, -21543.45, 46631.36 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11538.87, -24407.12, 47308.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10753.42, -21424.95, 46688.46 >, < 0, -149.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11873.06, -24512.19, 47308.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10945.68, -21313.95, 46602.46 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.511, -24609.18, 46265.16 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 7896.205, -24943.68, 47199.36 >, < 0, -104.9999, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11932.59, -24290.03, 46956.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 7916.433, -23224.55, 46215.46 >, < 0, -89.9999, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9186.822, -22380.27, 48223.86 >, < 0, -104.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.456, -24034.65, 46070.66 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11932.59, -24290.03, 47308.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9729.627, -22359.76, 48223.86 >, < 0, -104.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7831.572, -24937.88, 46957.76 >, < 0, -14.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7626.654, -23723.38, 46135.86 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11523.72, -21211.16, 46623.66 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 13310.85, -22066.14, 51042.73 >, < 0, -150, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7670.768, -25043.46, 46941.46 >, < -89.972, -14.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10549.3, -23258.34, 47942.75 >, < 0, 150.0003, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.27, -23764.29, 47661.29 >, < 0, 90.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7957.711, -24466.85, 47326.36 >, < -90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10342.06, -21662.45, 46706.46 >, < 0, -149.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 8941.144, -22281, 48223.86 >, < 0, -14.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10438.73, -23194.27, 47622.18 >, < 0, 150.0003, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13161.43, -22319.15, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7389.511, -24609.18, 46363.36 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10945.68, -21313.95, 46677.56 >, < 0, -149.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9509.797, -22368.94, 45999.46 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8307.396, -23810.91, 47326.36 >, < 0, -105.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9852.779, -22392.96, 48095.75 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10073.63, -23048.39, 47839.45 >, < 0, -104.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/fx/water_bubble_pop_fx.rmdl", < 12407.04, -24536.21, 47248.46 >, < 0, -104.9999, 0 >, true, 50000, -1, 8 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10931.18, -24140.55, 47310.75 >, < 0, 75.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8438.764, -23846.11, 47198.36 >, < 0, 74.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.225, -24322.88, 46167.56 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10548.17, -21543.45, 46706.46 >, < 0, -149.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 9128.619, -22362.92, 46188.86 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13024.78, -22082.46, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7692.788, -23476.19, 46135.86 >, < 0, 75, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11538.87, -24407.12, 46956.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7791.172, -24562.92, 47326.36 >, < 0, -105.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10549.65, -23258.54, 47621.68 >, < 0, 150.0003, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11590.63, -24213.93, 47308.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 8500.484, -22442.77, 47166.21 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11302.02, -21339.16, 46623.66 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7547.129, -25010.33, 46383.66 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8202.679, -23009.88, 46215.36 >, < 0, -90, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 9467.487, -22321.92, 48223.86 >, < 0, -14.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/pipes/slum_pipe_large_blue_512_01.rmdl", < 8583.745, -22133.58, 47859.11 >, < 0.0001, 75.0001, 180 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7918.045, -25109.72, 46685.46 >, < -90, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10236.5, -21962.42, 46513.86 >, < 0, -60, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11178.38, -24207, 47310.76 >, < 0, -14.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8438.764, -23846.11, 47134.36 >, < 0, -105.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9310.461, -22413.4, 48095.86 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7831.572, -24937.88, 46445.76 >, < 0, -14.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13383.3, -22191.05, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13246.65, -21954.36, 51122.83 >, < 90, 120, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7757.24, -25215.3, 46701.76 >, < 0, 165.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12267.48, -22677.19, 46500.43 >, < 0, -150, 89.9999 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7827.535, -24952.95, 46557.46 >, < -90, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9426.745, -22416.89, 46068.86 >, < 0, -60, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10753.42, -21424.95, 46613.36 >, < 0, -149.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8835.163, -22758.44, 46144.26 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7659.273, -25024.54, 46530.46 >, < 0, -104.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7851.357, -23688.82, 47198.36 >, < 0, 74.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.27, -23764.69, 47340.21 >, < 0, 90.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10438.81, -23194.32, 47942.22 >, < 0, 150.0003, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7794.406, -25076.59, 47117.36 >, < 0, -104.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 8781.562, -21393.77, 47954 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 7824.92, -24034.76, 47199.36 >, < 0, -104.9999, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.47, -23636.49, 47340.71 >, < 0, 90.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7886.531, -23557.55, 47326.36 >, < -90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7659.144, -25025.03, 47008.46 >, < 0, -104.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/lava_land/volcanic_rock_01a.rmdl", < 10360.73, -22346.8, 44662.46 >, < 0, -52.0598, 0 >, true, 50000, -1, 20 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 13436.42, -21993.64, 51122.83 >, < 90, -150, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12407.04, -24536.21, 47216.76 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 9381.891, -22441.4, 45999.36 >, < 0, -149.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/props/charm/charm_nessy.rmdl", < 13203.31, -22006.29, 46426.46 >, < 25.6606, 136.0995, 93.6839 >, true, 300, -1, 10 )
    prop = MapEditor_CreateProp( $"mdl/props/charm/charm_nessy.rmdl", < 13203.31, -22006.29, 46427.46 >, < 0, 30.0001, -29.9999 >, true, 300, -1, 10 )
    prop = MapEditor_CreateProp( $"mdl/timeshift/timeshift_bench_01.rmdl", < 13231.84, -22033.7, 46389.53 >, < 0, 30.0001, 0 >, true, 300, -1, 1 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8613.461, -22886.44, 46144.25 >, < 0, -60, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7299.875, -24944.1, 46383.66 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8570.104, -23881.4, 47326.36 >, < 0, -105.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.225, -24322.88, 46265.76 >, < 0, -15, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7847.229, -24940.11, 46623.86 >, < 0, 165.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7655.699, -25039.42, 46829.76 >, < 0, 75.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10073.61, -23048.49, 48159.63 >, < 0, -104.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 7743.613, -25212.06, 46880.46 >, < 0, -14.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12978.12, -22258.24, 51122.83 >, < 90, -150, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7851.357, -23688.82, 47134.36 >, < 0, -105.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8974.272, -22157.36, 48223.86 >, < 0, -104.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7933.113, -25113.76, 46573.76 >, < 0, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7543.327, -24035.13, 46268.66 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7982.697, -23724.11, 47326.36 >, < 0, -105.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 7466.095, -24323.37, 46365.56 >, < 0, 165, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7670.768, -25043.46, 46463.46 >, < -90, -14.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/desertlands/construction_bldg_platform_02.rmdl", < 11617.56, -20975.69, 47002.46 >, < 0, 30, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; prop.MakeInvisible(); prop.kv.contents = CONTENTS_SOLID | CONTENTS_NOGRAPPLE
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10106.68, -22925.04, 48159.63 >, < 0, -104.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11590.63, -24213.93, 46956.76 >, < 0, 165.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9434.1, -22446.53, 48223.86 >, < 0, -104.9999, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 8718.151, -21630.43, 47617.21 >, < 0, -15, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 7827.535, -24952.95, 47069.46 >, < -90, -104.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12228.85, -22607.46, 46472.23 >, < 0, 120, -135 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 8122.85, -23263.74, 46215.36 >, < 0, -30, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 8603.453, -22057.91, 48096.11 >, < 0, -105, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 10497.47, -23636.59, 47660.75 >, < 0, 90.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 7818.202, -23812.55, 47326.36 >, < 90, -105.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )

    // VerticalZipLines
    MapEditor_CreateZiplineFromUnity( < 8491.206, -22476.62, 47638.11 >, < 0, 75, 0 >, < 8491.206, -22476.62, 47513.11 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8708.873, -21664.28, 48088.11 >, < 0, 75, 0 >, < 8708.873, -21664.28, 47968.11 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8708.873, -21664.28, 47671.3 >, < 0, 75, 0 >, < 8708.873, -21664.28, 47571.3 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 8491.206, -22476.62, 47220.71 >, < 0, 75, 0 >, < 8491.206, -22476.62, 47130.71 >, < 0, 75, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )

    // Buttons
    AddCallback_OnUseEntity( CreateFRButton(< 11484.89, -21092.7, 46639.16 >, < 0, 29.9999, 0 >, "%use% Start/Stop Timer"), void function(entity panel, entity ent, int input)
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
    trigger = MapEditor_CreateTrigger( < 10095.38, -22457.39, 48162.46 >, < 0, -14.9999, 0 >, 127.5, 50, false )
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
file.cp_angle[ent] <- < 0, -59.9999, 0 >
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
    trigger = MapEditor_CreateTrigger( < 8084.926, -23990.99, 46922.46 >, < 0, -14.9999, 0 >, 664.515, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 7691.419, -23478.01, 46202.76 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7717.808, -23410.44, 46202.76 > )
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

file.cp_table[ent] <- < 7717.808, -23410.44, 46202.76 >
file.cp_angle[ent] <- < 0, -104.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7301.301, -24945.71, 46450.86 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7231.658, -24927.05, 46450.86 > )
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

file.cp_table[ent] <- < 7231.658, -24927.05, 46450.86 >
file.cp_angle[ent] <- < 0, -14.9999, 0 >
    })
    DispatchSpawn( trigger )
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

file.cp_table[ent] <- < 11584.27, -21175.63, 46690.86 >
file.cp_angle[ent] <- < 0, -149.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10515.65, -23905.12, 46895.46 >, < 0, -14.9999, 0 >, 1357.5, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 8327.751, -23088.57, 47200.96 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8299.359, -23194.54, 47200.96 > )
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

file.cp_table[ent] <- < 8299.359, -23194.54, 47200.96 >
file.cp_angle[ent] <- < 0, 75.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7833.814, -24921.05, 47055.16 >, < 0, -14.9999, 0 >, 59.15, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7799.047, -25086.63, 47184.26 > )
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

file.cp_table[ent] <- < 7799.047, -25086.63, 47184.26 >
file.cp_angle[ent] <- < 0, 75.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9418.141, -22359.38, 47939.96 >, < 0, -14.9999, 0 >, 671, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 9508.273, -22369.7, 46085.56 >, < 0, -60, 0 >, 127.5, 70, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 9601.301, -22325.23, 46085.56 > )
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

file.cp_table[ent] <- < 9601.301, -22325.23, 46085.56 >
file.cp_angle[ent] <- < 0, -150, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8835.273, -22758.03, 46210.16 >, < 0, -60, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8900.501, -22729.61, 46210.16 > )
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

file.cp_table[ent] <- < 8900.501, -22729.61, 46210.16 >
file.cp_angle[ent] <- < 0, -149.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12368.12, -24515.68, 46874.46 >, < 0, -14.9999, 0 >, 709.5, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 8823.054, -22345.46, 46922.46 >, < 0, -14.9999, 0 >, 1349, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 7547.342, -25010.46, 46450.86 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7231.658, -24927.05, 46450.86 > )
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

file.cp_table[ent] <- < 7231.658, -24927.05, 46450.86 >
file.cp_angle[ent] <- < 0, -14.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10987.81, -24155.13, 47377.05 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10860.89, -24121.12, 47377.05 > )
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

file.cp_table[ent] <- < 10860.89, -24121.12, 47377.05 >
file.cp_angle[ent] <- < 0, -14.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9852.91, -22392.43, 48162.46 >, < 0, -14.9999, 0 >, 127.5, 50, false )
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
file.cp_angle[ent] <- < 0, -59.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 8633.559, -22065.85, 48162.46 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 8556.942, -21963.44, 48162.46 > )
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

file.cp_table[ent] <- < 8556.942, -21963.44, 48162.46 >
file.cp_angle[ent] <- < 0, -38.481, 0 >
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

file.cp_table[ent] <- < 11584.27, -21175.63, 46690.86 >
file.cp_angle[ent] <- < 0, -149.9999, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12407.55, -24536.79, 47282.96 >, < 0, -104.9999, 0 >, 68.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !ent.IsPlayer() || ent.GetPhysics == MOVETYPE_NOCLIP)
    return

ent.SetOrigin(< 13372.06, -22030.57, 51108.16 >)
ent.SetAngles(< 0, -149.9999, 0 >)
ent.SetVelocity( < 0, 0, 0 > )
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 7793.39, -25076.83, 47184.26 >, < 0, -14.9999, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 7799.047, -25086.63, 47184.26 > )
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

file.cp_table[ent] <- < 7799.047, -25086.63, 47184.26 >
file.cp_angle[ent] <- < 0, 75.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 13309.88, -22066.47, 51108.16 >, < 0, 30.0001, 0 >, 127.5, 50, false )
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
file.cp_angle[ent] <- < 0, -149.9999, 0 >
file.last_cp[ent] <- true
    })
    DispatchSpawn( trigger )

    // Text Info Panels
    MapEditor_CreateTextInfoPanel( "Strafe It", "by: Loy & Treeree", < 11486.01, -21094.64, 46810.16 >, < 0, 120.0001, 0 >, false, 2 )


    // Invis Buttons
    Invis_Button( < 7230.387, -25066.27, 46410.14 >, < 0, 165, 0 >, false, < 7717.808, -23410.44, 46202.76 >, < 0, -104.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12998.37, -22287.31, 51069.21 >, < 0, 120, 0 >, true, < 11584.27, -21175.63, 46690.86 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7917.904, -25141.12, 47143.84 >, < 0, -104.9999, 0 >, false, < 7231.658, -24927.05, 46450.86 >, < 0, -14.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7570.296, -23407.9, 46162.34 >, < 0, 75.0001, 0 >, false, < 8900.502, -22729.61, 46210.16 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7552.101, -23475.8, 46162.34 >, < 0, 75.0001, 0 >, true, < 7231.658, -24927.05, 46450.86 >, < 0, -14.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11005.93, -24301.38, 47337.23 >, < 0, 165.0001, 0 >, true, < 13372.06, -22030.57, 51108.16 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9793.359, -22517.84, 48122.23 >, < 0, 165, 0 >, false, < 8556.942, -21963.44, 48162.46 >, < 0, -38.481, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8548.785, -22184.09, 48122.59 >, < 0, 165, 0 >, true, < 10048.66, -22365.16, 48162.46 >, < 0, -59.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8797.602, -22623.1, 46170.74 >, < 0, 30.0001, 0 >, false, < 9601.301, -22325.23, 46085.56 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8468.68, -23086.09, 47160.64 >, < 0, -104.9999, 0 >, true, < 8556.942, -21963.44, 48162.46 >, < 0, -38.481, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12963.22, -22226.43, 51069.21 >, < 0, 120, 0 >, false, < 10860.89, -24121.12, 47377.05 >, < 0, -14.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8450.485, -23153.99, 47160.64 >, < 0, -104.9999, 0 >, false, < 7799.048, -25086.63, 47184.26 >, < 0, 75.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9861.265, -22536.03, 48122.23 >, < 0, 165, 0 >, true, < 10860.89, -24121.12, 47377.05 >, < 0, -14.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8480.881, -22165.9, 48122.59 >, < 0, 165, 0 >, false, < 8299.358, -23194.54, 47200.96 >, < 0, 75.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7936.099, -25073.21, 47143.84 >, < 0, -104.9999, 0 >, true, < 8299.359, -23194.54, 47200.96 >, < 0, 75.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 7298.291, -25084.46, 46410.14 >, < 0, 165, 0 >, true, < 7799.047, -25086.63, 47184.26 >, < 0, 75.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 8736.72, -22658.25, 46170.74 >, < 0, 30.0001, 0 >, true, < 7717.808, -23410.44, 46202.76 >, < 0, -104.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9645.179, -22444.82, 46025.94 >, < 0, -149.9999, 0 >, false, < 11584.27, -21175.63, 46690.86 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11268.36, -21210.86, 46650.14 >, < 0, 30.0001, 0 >, false, < 13372.06, -22030.57, 51108.16 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10938.03, -24283.18, 47337.23 >, < 0, 165.0001, 0 >, false, < 10048.66, -22365.16, 48162.46 >, < 0, -59.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9510.477, -22211.51, 46025.94 >, < 0, 30.0001, 0 >, true, < 8900.501, -22729.61, 46210.16 >, < 0, -149.9999, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11207.48, -21246.01, 46650.14 >, < 0, 30.0001, 0 >, true, < 9601.301, -22325.23, 46085.56 >, < 0, -150, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
}