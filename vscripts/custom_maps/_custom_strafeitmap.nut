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
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 3947.3, 42276.8 >, < 0, -89.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11358.61, 4554.145, 44021.79 >, < 0, -44.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11811.84, 1921.895, 43508.9 >, < 0, -45.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10796.36, 2122.643, 43508.9 >, < 0, -45.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10660.1, 2666.291, 42322.8 >, < 0, 29.9999, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11715.6, 1825.8, 43380.9 >, < 0, 134.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11226.35, 2744.968, 43508.9 >, < -90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10480.03, 2862.485, 42322.8 >, < 0, -30.0001, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9946.689, 3957.01, 44406.4 >, < -90, -45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11459.02, 1358.301, 42645.7 >, < 0, -135.0001, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12156.41, 1385.09, 42996 >, < -90, 135.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13616.45, 5290.014, 43139.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10522.82, 2507.253, 42322.9 >, < 0, -30, -90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11413.03, 2558.292, 43508.9 >, < 90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 10578.9, 4084.4, 42259.5 >, < -90, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10613.57, 2928.109, 43316.7 >, < 0, -45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 11608.83, 2453.004, 43381.9 >, < 0, -45, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10590, 4972.6, 42514.8 >, < 0, 0, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 12178.19, 1566.958, 42935 >, < 0, 135.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10432.71, 3109.271, 43316.65 >, < 0, -45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11806.18, 1735.219, 43508.9 >, < 90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 10706, 4084.4, 42259.5 >, < -90, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11038.08, 1779.241, 42351.4 >, < 0, 45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12224.5, 6549.1, 42938.17 >, < 0, -90.0001, 89.9999 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5389, 42813.9 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10037.2, 3866.5, 44278.4 >, < 0, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11715.6, 1825.8, 43316.9 >, < 0, -45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x64_05.rmdl", < 11031.3, 6631.101, 42468.07 >, < 50.9783, -0.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 3946.4, 42343.6 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_05.rmdl", < 12217, 7502.2, 47225.27 >, < 0, -90.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10951.95, 4781.054, 44278.3 >, < 0, -134.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11162, 6628.001, 42469.07 >, < 0, -90.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5627, 42813.9 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13358.35, 5053.132, 43491.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5864, 42871 >, < 0, -89.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13616.45, 5290.014, 43491.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 6086, 42785 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11458.67, 1358.654, 42447.7 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 12001.69, 1630.218, 43381.9 >, < 0, -45, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13453.81, 5452.648, 43139.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10523, 2507.3, 42398 >, < 0, -30, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10427.03, 4029.63, 44406.4 >, < 0, -45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11038.08, 1779.241, 42253.2 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13453.81, 5452.648, 43491.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10680.67, 4509.968, 44406.4 >, < 0, -45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11964.36, 1577.14, 43140.3 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10810.11, 2006.93, 42318.4 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10583, 6638, 42806.2 >, < 0, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12217, 7758.2, 47225.27 >, < 0, -90.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 11975.39, 1385.09, 43124 >, < -90, 45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11868.7, 4770.535, 44125.3 >, < 0, -149.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 12280.85, 4472.501, 43843.83 >, < 0, 150.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11619.5, 1921.896, 43508.9 >, < -90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5389, 42889 >, < 0, -89.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 10218.22, 3866.5, 44406.4 >, < 0, 45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11757.93, 4706.809, 43804.73 >, < 0, -149.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12361.4, 7502.3, 47305.38 >, < 90, 180, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11458.67, 1358.654, 42545.9 >, < 0, 45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 6086, 42860.1 >, < 0, -89.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10578.7, 4315, 42182 >, < 0, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11226.28, 2552.706, 43508.9 >, < 0, -45.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10771, 4600.018, 44278.3 >, < 0, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11449.05, 4463.565, 44022 >, < 0, -44.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/fx/water_bubble_pop_fx.rmdl", < 13904.24, 5740.441, 43431 >, < 0, -44.9999, 0 >, true, 50000, -1, 8 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12823.66, 4660.145, 43493.3 >, < 0, 135.0002, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11322.45, 2648.872, 43380.9 >, < 0, 134.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11249.08, 1568.24, 42350.1 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5627, 42889 >, < 0, -89.901, -89.901 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10382.9, 3987.9, 42371.4 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12088.1, 7502.3, 47305.38 >, < 90, 180, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10629.1, 2187.8, 42318.4 >, < 0, 135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13358.35, 5053.132, 43139.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11619.43, 1729.633, 43508.9 >, < 0, -45.0001, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11869.05, 4770.735, 43804.23 >, < 0, -149.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13216.93, 5194.554, 43491.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 10137.99, 3403.993, 43348.75 >, < 0, 44.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10583, 6382, 42806.2 >, < 0, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11884.88, 1294.581, 42566.2 >, < 0, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10480.21, 2862.532, 42397.9 >, < 0, -30.0001, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 10516.83, 4301.866, 44406.4 >, < 0, 45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/pipes/slum_pipe_large_blue_512_01.rmdl", < 9911.853, 3630.693, 44041.65 >, < 0.0001, 135, 180 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12156.41, 1566.11, 42868 >, < -90, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10590, 5147.6, 42696.4 >, < 0, 0, 46 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 13004.8, 4841, 43493.3 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11322.45, 2648.872, 43316.9 >, < 0, -45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/desertlands/icelandic_moss_mod_01.rmdl", < 11724, 4324, 40845 >, < 0, 0, 0 >, true, 50000, -1, 41.4 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10517.54, 4120.14, 44278.4 >, < 0, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11964.36, 1577.14, 42628.3 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12361.4, 7758.5, 47305.38 >, < 90, 180, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12088.1, 7758.5, 47305.38 >, < 90, 180, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 12167.44, 1374.06, 42884.3 >, < 0, -134.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12224.5, 6549.1, 42682.97 >, < 0, -90.0001, 89.9999 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 11975.39, 1566.11, 42740 >, < -90, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10578.7, 4219.1, 42251.4 >, < 0, 0, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x352_01.rmdl", < 10383, 5864, 42795.9 >, < 0, -89.901, -89.901 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10578.7, 3536, 42326.8 >, < 0, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 11953.26, 1384.595, 42713 >, < 0, -45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10892.53, 2218.81, 43380.9 >, < 0, 134.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 12281.19, 4472.3, 43522.76 >, < 0, 150.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11758.01, 4706.858, 44124.77 >, < 0, -149.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 12065.9, 1475.6, 43299.9 >, < 0, -45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 9370.068, 4171.912, 44136.55 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x128_01.rmdl", < 11178.91, 2022.941, 43381.9 >, < 0, -45, 90 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 12170.27, 4536.574, 43523.26 >, < 0, 150.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10796.43, 2314.906, 43508.9 >, < -90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 11953.61, 1384.242, 43191 >, < 0, -44.9999, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/lava_land/volcanic_rock_01a.rmdl", < 10985, 5063, 40845 >, < 0, 7.9402, 0 >, true, 50000, -1, 20 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12217, 7903.2, 47305.38 >, < 89.972, -90.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 13904.24, 5740.441, 43399.3 >, < 0, -44.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 10577.5, 4168, 42181.9 >, < 0, -89.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/props/charm/charm_nessy.rmdl", < 12111.4, 7695, 42609 >, < 25.6606, -163.9005, 93.6839 >, true, 300, -1, 10 )
    prop = MapEditor_CreateProp( $"mdl/props/charm/charm_nessy.rmdl", < 12111.4, 7695, 42610 >, < 0, 90.0001, -29.9999 >, true, 300, -1, 10 )
    prop = MapEditor_CreateProp( $"mdl/timeshift/timeshift_bench_01.rmdl", < 12149.4, 7706, 42572.07 >, < 0, 90.0001, 0 >, true, 300, -1, 1 )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10578.7, 3280, 42326.8 >, < 0, 0, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11703.89, 1113.571, 42566.2 >, < 0, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 11418.69, 2744.968, 43508.9 >, < 0, -45.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11249.08, 1568.24, 42448.3 >, < 0, 45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 11974.12, 1589.586, 42806.4 >, < 0, -135, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11964.36, 1374.059, 43012.3 >, < 0, 135.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11449.12, 4463.495, 44342.18 >, < 0, -44.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_256_01.rmdl", < 12157.82, 1363.877, 43063 >, < 0, 45, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12217, 7374, 47305.38 >, < 89.972, -90.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10892.53, 2218.81, 43316.9 >, < 0, -45.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10127.71, 3957.01, 44406.4 >, < 0, -45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 12167.44, 1577.141, 42756.3 >, < 0, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11038.43, 1778.888, 42451.2 >, < 0, -135.0001, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10988.77, 2314.905, 43508.9 >, < 0, -45.0001, -90.0001 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 11249.43, 1567.887, 42548.1 >, < 0, -135.0001, 180 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 11975.39, 1385.09, 42646 >, < -90, 45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/desertlands/construction_bldg_platform_02.rmdl", < 10426, 6837, 43185 >, < 0, 90, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 3; prop.MakeInvisible(); prop.kv.contents = CONTENTS_SOLID | CONTENTS_NOGRAPPLE
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 11358.75, 4553.862, 44342.18 >, < 0, -44.9998, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 13216.93, 5194.554, 43139.3 >, < 0, -135, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10608.05, 4210.649, 44406.4 >, < 0, -45, 90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_128_01.rmdl", < 9543.309, 3998.671, 43799.75 >, < 0, 44.9999, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 11975.39, 1566.11, 43252 >, < -90, -45, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x128_06.rmdl", < 12144.8, 6550.5, 42654.77 >, < 0, 180, -135 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_frame_16x32_02.rmdl", < 10660.15, 2666.468, 42397.9 >, < 0, 29.9999, -90 >, false, 50000, -1, 1 )
    prop.kv.solid = 3; prop.Highlight_SetFunctions(0, 12, false, 136, 2.0, 2, false); prop.Highlight_SetParam(0, 0, < 1, 0, 0 > )

    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 9856.168, 3685.599, 44278.65 >, < 0, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_DEFAULT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_wall_128x352_04.rmdl", < 12170.36, 4536.524, 43843.3 >, < 0, 150.0001, 0 >, true, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )
    prop = MapEditor_CreateProp( $"mdl/thunderdome/thunderdome_cage_ceiling_256x256_06.rmdl", < 10983.11, 2128.229, 43508.9 >, < 90, -45.0001, 0 >, false, 50000, -1, 1 )
    prop.kv.solid = 1; Highlight_SetNeutralHighlight( prop, PROP_INTERACT_COLOR )

    // VerticalZipLines
    MapEditor_CreateZiplineFromUnity( < 10162.66, 3379.032, 43820.65 >, < 0, 135, 0 >, < 10162.66, 3379.032, 43695.65 >, < 0, 135, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 9567.986, 3973.71, 44270.65 >, < 0, 135, 0 >, < 9567.986, 3973.71, 44150.65 >, < 0, 135, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 9567.986, 3973.71, 43853.85 >, < 0, 135, 0 >, < 9567.986, 3973.71, 43753.85 >, < 0, 135, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )
    MapEditor_CreateZiplineFromUnity( < 10162.66, 3379.032, 43403.25 >, < 0, 135, 0 >, < 10162.66, 3379.032, 43313.25 >, < 0, 135, 0 >, true, -1, 1, 2, 1, 1, 0, 1, 0.7, 0, false, 1, false, 0, 0, [  ], [  ], [  ], 32, 60, 0 )

    // Buttons
    AddCallback_OnUseEntity( CreateFRButton(< 10461, 6663.6, 42821.7 >, < 0, 89.9998, 0 >, "%use% Start/Stop Timer"), void function(entity panel, entity ent, int input)
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
    trigger = MapEditor_CreateTrigger( < 10948.1, 4777.9, 44345 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10844.86, 4783.557, 44345 > )
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

file.cp_table[ent] <- < 10844.86, 4783.557, 44345 >
file.cp_angle[ent] <- < 0, 0.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 11619, 4811, 41769 >, < 0, 0, 0 >, 5000, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 11271, 2270, 43105 >, < 0, 45, 0 >, 664.515, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 10630, 2185.7, 42385.3 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10584.67, 2242.339, 42385.3 > )
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

file.cp_table[ent] <- < 10584.67, 2242.339, 42385.3 >
file.cp_angle[ent] <- < 0, -45, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 11706, 1114, 42633.4 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 11655.02, 1063.018, 42633.4 > )
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

file.cp_table[ent] <- < 11655.02, 1063.018, 42633.4 >
file.cp_angle[ent] <- < 0, 45, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10502, 6355.3, 42873.4 >, < 0, 0, 0 >, 200, 50, false )
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

file.cp_table[ent] <- < 10582.5, 6708.2, 42873.4 >
file.cp_angle[ent] <- < 0, -90, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12412, 4418, 43078 >, < 0, 45, 0 >, 1357.5, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 10610.9, 2931.5, 43383.5 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10688.47, 2853.931, 43383.5 > )
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

file.cp_table[ent] <- < 10688.47, 2853.931, 43383.5 >
file.cp_angle[ent] <- < 0, 135, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 11950.9, 1587.5, 43237.7 >, < 0, 45, 0 >, 59.15, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 12076.91, 1474.602, 43366.8 > )
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

file.cp_table[ent] <- < 12076.91, 1474.602, 43366.8 >
file.cp_angle[ent] <- < 0, 135, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10524.6, 4240.4, 44122.5 >, < 0, 45, 0 >, 671, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 10578.6, 4313.3, 42268.1 >, < 0, 0, 0 >, 127.5, 70, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10586.6, 4416.1, 42268.1 > )
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

file.cp_table[ent] <- < 10586.6, 4416.1, 42268.1 >
file.cp_angle[ent] <- < 0, -90.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10578.4, 3536.3, 42392.7 >, < 0, 0, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10586.4, 3607, 42392.7 > )
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

file.cp_table[ent] <- < 10586.4, 3607, 42392.7 >
file.cp_angle[ent] <- < 0, -90, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 13867, 5717, 43057 >, < 0, 45, 0 >, 709.5, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 10215, 3732, 43105 >, < 0, 45, 0 >, 1349, 50, false )
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
    trigger = MapEditor_CreateTrigger( < 11885.1, 1294.7, 42633.4 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 11655.02, 1063.018, 42633.4 > )
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

file.cp_table[ent] <- < 11655.02, 1063.018, 42633.4 >
file.cp_angle[ent] <- < 0, 45, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12864.6, 4701.9, 43559.6 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 12771.69, 4608.986, 43559.6 > )
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

file.cp_table[ent] <- < 12771.69, 4608.986, 43559.6 >
file.cp_angle[ent] <- < 0, 45, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10770.6, 4600.4, 44345 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 10844.86, 4783.557, 44345 > )
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

file.cp_table[ent] <- < 10844.86, 4783.557, 44345 >
file.cp_angle[ent] <- < 0, 0.0001, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 9878.1, 3707.7, 44345 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 9751.104, 3692.552, 44345 > )
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

file.cp_table[ent] <- < 9751.104, 3692.552, 44345 >
file.cp_angle[ent] <- < 0, 21.5189, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 10502, 6662.9, 42873.4 >, < 0, 0, 0 >, 200, 50, false )
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

file.cp_table[ent] <- < 10582.5, 6708.2, 42873.4 >
file.cp_angle[ent] <- < 0, -90, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 13905, 5740.6, 43465.5 >, < 0, -44.9999, 0 >, 68.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    if (!IsValidPlayer(ent) || !ent.IsPlayer() || ent.GetPhysics == MOVETYPE_NOCLIP)
    return

ent.SetOrigin(< 12216.8, 7829, 47290.7 >)
ent.SetAngles(< 0, -90, 0 >)
ent.SetVelocity( < 0, 0, 0 > )
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12065.6, 1474.6, 43366.8 >, < 0, 45, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 12076.91, 1474.602, 43366.8 > )
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

file.cp_table[ent] <- < 12076.91, 1474.602, 43366.8 >
file.cp_angle[ent] <- < 0, 135, 0 >
    })
    DispatchSpawn( trigger )
    trigger = MapEditor_CreateTrigger( < 12216.8, 7757.2, 47290.7 >, < 0, 90.0001, 0 >, 127.5, 50, false )
    trigger.SetEnterCallback( void function( entity trigger, entity ent )
    {
    
if (!IsValidPlayer(ent) || !IsAlive(ent))
    return

if (file.cp_table[ent] != < 12216.8, 7829, 47290.7 > )
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

file.cp_table[ent] <- < 12216.8, 7829, 47290.7 >
file.cp_angle[ent] <- < 0, -90, 0 >
file.last_cp[ent] <- true
    })
    DispatchSpawn( trigger )

    // Text Info Panels
    MapEditor_CreateTextInfoPanel( "Strafe It", "by: Loy & Treeree", < 10463.23, 6663.6, 42992.7 >, < 0, -179.9999, 0 >, false, 2 )


    // Invis Buttons
    Invis_Button( < 11774.95, 992.3051, 42592.68 >, < 0, -135.0001, 0 >, false, < 10584.67, 2242.34, 42385.3 >, < 0, -45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12252.3, 7377, 47251.75 >, < 0, -180, 0 >, true, < 10582.5, 6708.2, 42873.4 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12183.53, 1550.288, 43326.38 >, < 0, -45, 0 >, false, < 11655.02, 1063.018, 42633.4 >, < 0, 45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10508.72, 2115.861, 42344.88 >, < 0, 135, 0 >, false, < 10586.4, 3607, 42392.7 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10558.43, 2066.151, 42344.88 >, < 0, 135, 0 >, true, < 11655.02, 1063.018, 42633.4 >, < 0, 45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 13000.31, 4644.467, 43519.78 >, < 0, -135, 0 >, true, < 12216.8, 7829, 47290.7 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10849.44, 4486.121, 44304.78 >, < 0, -135, 0 >, false, < 9751.104, 3692.552, 44345 >, < 0, 21.5189, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9938.114, 3575.163, 44305.13 >, < 0, -135, 0 >, true, < 10844.86, 4783.557, 44345 >, < 0, 0.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10442.71, 3571.14, 42353.28 >, < 0, 90, 0 >, false, < 10586.6, 4416.1, 42268.1 >, < 0, -90.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10679.21, 3054.79, 43343.18 >, < 0, -45, 0 >, true, < 9751.104, 3692.552, 44345 >, < 0, 21.5189, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12182, 7377, 47251.75 >, < 0, -180, 0 >, false, < 12771.69, 4608.986, 43559.6 >, < 0, 45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10728.92, 3005.08, 43343.18 >, < 0, -45, 0 >, false, < 12076.91, 1474.602, 43366.8 >, < 0, 135, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10899.15, 4535.831, 44304.78 >, < 0, -135, 0 >, true, < 12771.69, 4608.986, 43559.6 >, < 0, 45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 9888.404, 3525.453, 44305.13 >, < 0, -135, 0 >, false, < 10688.47, 2853.931, 43383.5 >, < 0, 135, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12133.82, 1599.998, 43326.38 >, < 0, -45, 0 >, true, < 10688.47, 2853.931, 43383.5 >, < 0, 135, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 11824.66, 1042.015, 42592.68 >, < 0, -135.0001, 0 >, true, < 12076.91, 1474.602, 43366.8 >, < 0, 135, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10442.71, 3500.84, 42353.28 >, < 0, 90, 0 >, true, < 10584.67, 2242.339, 42385.3 >, < 0, -45, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10712.11, 4394.3, 42208.48 >, < 0, -89.9999, 0 >, false, < 10582.5, 6708.2, 42873.4 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10455.06, 6416.997, 42832.68 >, < 0, 90, 0 >, false, < 12216.8, 7829, 47290.7 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 12950.6, 4594.757, 43519.78 >, < 0, -135, 0 >, false, < 10844.86, 4783.557, 44345 >, < 0, 0.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10442.71, 4394.3, 42208.48 >, < 0, 90, 0 >, true, < 10586.4, 3607, 42392.7 >, < 0, -90, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
    Invis_Button( < 10455.06, 6346.697, 42832.68 >, < 0, 90, 0 >, true, < 10586.6, 4416.1, 42268.1 >, < 0, -90.0001, 0 >, "", "", 4, 5, "#FS_STRING_VAR" )
}