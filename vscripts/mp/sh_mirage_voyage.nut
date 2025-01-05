#if CLIENT
global function ClMirageVoyage_Init
#endif // CLIENT

#if SERVER
global function MirageVoyage_Init
#endif // SERVER

global function IsMirageVoyageEnabled

#if SERVER
const array<string> MIRAGE_VOYAGE_ANIM_MOVER_SCRIPTNAMES =
[
	"mirage_voyage_nose_ref",
	"mirage_voyage_bar_ref",
	"mirage_voyage_grill_ref",
	"mirage_voyage_bar_dance_ref",
	"mirage_deck_right_ref",
	"mirage_deck_left_ref",
	"mirage_voyage_roof_ref"
]
#endif // SERVER


#if SERVER || CLIENT
const string MIRAGE_VOYAGE_MUSIC_CONTROLLER_SCRIPT_NAME = "mirage_voyage_music_target"
#endif


#if SERVER
const string MIRAGE_ROLLER_EJECTOR_SCRIPT_NAME = "loot_ball_ejector_model"

const asset MIRAGE_DECOY_MODEL_ASSET = $"mdl/Humans/class/medium/pilot_medium_holo.rmdl"
const asset LOOT_LAUNCHER_MODEL_OFF = $"mdl/desertlands/mirage_tt_lootcap_off.rmdl"
const asset LOOT_LAUNCHER_FX = $"P_tt_ship_ball_air_blast"
const asset MIRAGE_DECOY_FX = $"P_mirage_voyage_holo_trail"

const string FLAG_MIRAGE_VOYAGE_BUTTON_ENABLED = "party_button_enabled"
const string MIRAGE_VOYAGE_DECOY_SCRIPT_NAME = "mirage_voyage_decoy_model"
const string MIRAGE_VOYAGE_BUTTON_SCRIPT_NAME = "mirage_voyage_party_panel"
const string PARTY_MUSIC_ENT_SCRIPT_NAME = "mirage_voyage_party_music_target"

const string PARTY_BUTTON_DENY_SFX = "Survival_Train_EmergencyPanel_Deny"
const string PARTY_BUTTON_ACTIVATE_SFX = "Desertlands_Mirage_TT_PartySwitch_On"
const string PARTY_BUTTON_ACTIVATE_VO = "diag_mp_mirage_exp_partyBoatButton_3p"
const string PARTY_BUTTON_DISABLE_SFX = "Desertlands_Mirage_TT_PartySwitch_Off"
const string BALL_LAUNCHER_ACTIVATE_SFX = "Desertlands_Mirage_TT_LootBall_Launcher"
const string FAKE_DECOY_REGULAR_SFX = "Mirage_TT_Decoy_Small"
const string FAKE_DECOY_REGULAR_ACTIVATE_SFX = "Mirage_TT_Decoy_Activate_Small"
const string FAKE_DECOY_LARGE_SFX = "Mirage_TT_Decoy_Large"
const string FAKE_DECOY_LARGE_ACTIVATE_SFX = "Mirage_TT_Decoy_Activate_Large"
const string FIREWORKS_BURST_SFX = "Desertlands_Mirage_TT_Firework_SkyBurst"
const string FIREWORKS_STREAMER_SFX = "Desertlands_Mirage_TT_Firework_Streamer"
const string PARTY_MUSIC = "Music_TT_Mirage_PartyTrackButtonPress"

const string MIRAGE_PHONE = "mirage_cell_phone_model"

const float FAKE_DECOY_RESPAWN_WAIT_DURATION = 4.0
const float MIRAGE_VOYAGE_PARTY_DURATION = 20.0
const float MIRAGE_VOYAGE_FAKE_DECOY_FADE_DIST = 2000.0

const string FLAG_MIRAGE_VOYAGE_MAIN_FX = "party_button"

const string DANCEFLOOR_SCRIPT_NAME = "mirage_voyage_bar_dance_ref"

const int MIRAGE_VOYAGE_FILLER_FX_BPM = 256 //128
const int MIRAGE_VOYAGE_FILLER_FX_BEAT_COUNT = 92 //46
const table<string, table< int, bool > > FLAGS_MIRAGE_VOYAGE_FILLER_FX = {


	["F_A_01"] = { [1] = true, [2] = false, [8] = true, [9] = false, [17] = true, [18] = false, [25] = true, [26] = false, [33] = true, [34] = false, [41] = true, [42] = false, [49] = true, [50] = false, [57] = true, [58] = false, [65] = true, [72] = false, [75] = true, [76] = false, [79] = true, [80] = false, [83] = true, [84] = false, [87] = true, [88] = false, [91] = true, [92] = false, },
	["F_A_02"] = { [1] = true, [2] = false, [8] = true, [9] = false, [17] = true, [18] = false, [25] = true, [26] = false, [33] = true, [34] = false, [41] = true, [42] = false, [49] = true, [50] = false, [57] = true, [58] = false, [65] = true, [72] = false, [77] = true, [78] = false, [81] = true, [82] = false, [85] = true, [86] = false, [89] = true, [90] = false, [91] = true, [92] = false, },

	["F_B_01"] = { [1] = true, [2] = false, [9] = true, [10] = false, [19] = true, [20] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [27] = true, [28] = false, [29] = true, [30] = false, [31] = true, [32] = false, [33] = true, [34] = false, [35] = true, [36] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [43] = true, [44] = false, [45] = true, [46] = false, [47] = true, [48] = false, [49] = true, [50] = false, [51] = true, [52] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [73] = true, [74] = false, [77] = true, [78] = false, [81] = true, [82] = false, [85] = true, [86] = false, [91] = true, [92] = false, },
	["F_B_02"] = { [1] = true, [2] = false, [11] = true, [12] = false, [17] = true, [18] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [27] = true, [28] = false, [29] = true, [30] = false, [31] = true, [32] = false, [33] = true, [34] = false, [35] = true, [36] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [43] = true, [44] = false, [45] = true, [46] = false, [47] = true, [48] = false, [49] = true, [50] = false, [51] = true, [52] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [74] = true, [75] = false, [78] = true, [79] = false, [82] = true, [83] = false, [86] = true, [87] = false, [91] = true, [92] = false, },
	["F_B_03"] = { [1] = true, [2] = false, [13] = true, [14] = false, [15] = true, [16] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [27] = true, [28] = false, [29] = true, [30] = false, [31] = true, [32] = false, [33] = true, [34] = false, [35] = true, [36] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [43] = true, [44] = false, [45] = true, [46] = false, [47] = true, [48] = false, [49] = true, [50] = false, [51] = true, [52] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [75] = true, [76] = false, [79] = true, [80] = false, [83] = true, [84] = false, [87] = true, [88] = false, [91] = true, [92] = false, },
	["F_B_04"] = { [1] = true, [2] = false, [11] = true, [12] = false, [17] = true, [18] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [27] = true, [28] = false, [29] = true, [30] = false, [31] = true, [32] = false, [33] = true, [34] = false, [35] = true, [36] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [43] = true, [44] = false, [45] = true, [46] = false, [47] = true, [48] = false, [49] = true, [50] = false, [51] = true, [52] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [76] = true, [77] = false, [80] = true, [81] = false, [84] = true, [85] = false, [88] = true, [89] = false, [91] = true, [92] = false, },
	["F_B_05"] = { [1] = true, [2] = false, [9] = true, [10] = false, [19] = true, [20] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [27] = true, [28] = false, [29] = true, [30] = false, [31] = true, [32] = false, [33] = true, [34] = false, [35] = true, [36] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [43] = true, [44] = false, [45] = true, [46] = false, [47] = true, [48] = false, [49] = true, [50] = false, [51] = true, [52] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [77] = true, [78] = false, [81] = true, [82] = false, [85] = true, [86] = false, [89] = true, [90] = false, [91] = true, [92] = false, },

	["F_R_01"] = { [1] = true, [2] = false, [9] = true, [10] = false, [17] = true, [18] = false, [31] = true, [32] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [71] = true, [72] = false, [73] = true, [74] = false, [77] = true, [78] = false, [82] = true, [83] = false, [91] = true, [92] = false, },
	["F_R_02"] = { [1] = true, [2] = false, [11] = true, [12] = false, [19] = true, [20] = false, [29] = true, [30] = false, [37] = true, [38] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [71] = true, [72] = false, [74] = true, [75] = false, [78] = true, [79] = false, [83] = true, [84] = false, [91] = true, [92] = false, },
	["F_R_03"] = { [1] = true, [2] = false, [13] = true, [14] = false, [21] = true, [22] = false, [27] = true, [28] = false, [35] = true, [36] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [71] = true, [72] = false, [75] = true, [76] = false, [79] = true, [80] = false, [84] = true, [85] = false, [91] = true, [92] = false, },
	["F_R_04"] = { [1] = true, [2] = false, [15] = true, [16] = false, [23] = true, [24] = false, [25] = true, [26] = false, [33] = true, [34] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [71] = true, [72] = false, [76] = true, [77] = false, [80] = true, [81] = false, [85] = true, [86] = false, [91] = true, [92] = false, },

	["F_T_06"] = { [1] = true, [2] = false, [13] = true, [14] = false, [15] = true, [16] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [31] = true, [32] = false, [33] = true, [34] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [75] = true, [76] = false, [79] = true, [80] = false, [87] = true, [88] = false, [91] = true, [92] = false },
	["F_T_04"] = { [1] = true, [2] = false, [11] = true, [12] = false, [15] = true, [16] = false, [19] = true, [20] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [74] = true, [75] = false, [80] = true, [81] = false, [86] = true, [87] = false, [91] = true, [92] = false },
	["F_T_02"] = { [1] = true, [2] = false, [9] = true, [10] = false, [15] = true, [16] = false, [17] = true, [18] = false, [23] = true, [24] = false, [29] = true, [30] = false, [31] = true, [32] = false, [37] = true, [38] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [73] = true, [74] = false, [81] = true, [82] = false, [85] = true, [86] = false, [91] = true, [92] = false },
	["F_T_01"] = { [1] = true, [2] = false, [9] = true, [10] = false, [15] = true, [16] = false, [17] = true, [18] = false, [23] = true, [24] = false, [29] = true, [30] = false, [31] = true, [32] = false, [37] = true, [38] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [73] = true, [74] = false, [81] = true, [82] = false, [85] = true, [86] = false, [91] = true, [92] = false },
	["F_T_03"] = { [1] = true, [2] = false, [11] = true, [12] = false, [15] = true, [16] = false, [19] = true, [20] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [74] = true, [75] = false, [80] = true, [81] = false, [86] = true, [87] = false, [91] = true, [92] = false },
	["F_T_05"] = { [1] = true, [2] = false, [13] = true, [14] = false, [15] = true, [16] = false, [21] = true, [22] = false, [23] = true, [24] = false, [25] = true, [26] = false, [31] = true, [32] = false, [33] = true, [34] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [57] = true, [58] = false, [61] = true, [62] = false, [65] = true, [66] = false, [69] = true, [70] = false, [75] = true, [76] = false, [79] = true, [80] = false, [87] = true, [88] = false, [91] = true, [92] = false },

	["F_S_02"] = { [1] = true, [2] = false, [11] = true, [12] = false, [21] = true, [22] = false, [25] = true, [26] = false, [29] = true, [27] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [74] = true, [75] = false, [79] = true, [80] = false, [83] = true, [84] = false, [87] = true, [88] = false, [91] = true, [92] = false, },
	["F_S_03"] = { [1] = true, [2] = false, [13] = true, [14] = false, [19] = true, [20] = false, [25] = true, [26] = false, [29] = true, [27] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [75] = true, [76] = false, [80] = true, [81] = false, [84] = true, [85] = false, [88] = true, [89] = false, [91] = true, [92] = false, },
	["F_P_02"] = { [1] = true, [2] = false, [11] = true, [12] = false, [21] = true, [22] = false, [25] = true, [26] = false, [29] = true, [27] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [75] = true, [76] = false, [80] = true, [81] = false, [84] = true, [85] = false, [88] = true, [89] = false, [91] = true, [92] = false, },
	["F_P_03"] = { [1] = true, [2] = false, [13] = true, [14] = false, [19] = true, [20] = false, [25] = true, [26] = false, [29] = true, [27] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [74] = true, [75] = false, [79] = true, [80] = false, [83] = true, [84] = false, [87] = true, [88] = false, [91] = true, [92] = false, },
	["F_S_01"] = { [1] = true, [2] = false, [9] = true, [10] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [33] = true, [34] = false, [37] = true, [38] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [73] = true, [74] = false, [78] = true, [79] = false, [82] = true, [83] = false, [86] = true, [87] = false, [91] = true, [92] = false, },
	["F_S_04"] = { [1] = true, [2] = false, [15] = true, [16] = false, [17] = true, [18] = false, [27] = true, [28] = false, [31] = true, [32] = false, [33] = true, [34] = false, [37] = true, [38] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [76] = true, [77] = false, [81] = true, [82] = false, [85] = true, [86] = false, [89] = true, [90] = false, [91] = true, [92] = false, },
	["F_P_01"] = { [1] = true, [2] = false, [9] = true, [10] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [33] = true, [34] = false, [37] = true, [38] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [76] = true, [77] = false, [81] = true, [82] = false, [85] = true, [86] = false, [89] = true, [90] = false, [91] = true, [92] = false, },
	["F_P_04"] = { [1] = true, [2] = false, [15] = true, [16] = false, [17] = true, [18] = false, [27] = true, [28] = false, [31] = true, [32] = false, [33] = true, [34] = false, [37] = true, [38] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [73] = true, [74] = false, [78] = true, [79] = false, [82] = true, [83] = false, [86] = true, [87] = false, [91] = true, [92] = false, },

	["F_F_01"] = { [1] = true, [2] = false, [11] = true, [12] = false, [15] = true, [16] = false, [19] = true, [20] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [73] = true, [74] = false, [77] = true, [78] = false, [82] = true, [83] = false, [86] = true, [87] = false, [91] = true, [92] = false, },
	["F_F_02"] = { [1] = true, [2] = false, [9] = true, [10] = false, [13] = true, [14] = false, [17] = true, [18] = false, [21] = true, [22] = false, [25] = true, [26] = false, [29] = true, [30] = false, [33] = true, [34] = false, [37] = true, [38] = false, [41] = true, [42] = false, [45] = true, [46] = false, [49] = true, [50] = false, [53] = true, [54] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [74] = true, [75] = false, [78] = true, [79] = false, [83] = true, [84] = false, [87] = true, [88] = false, [91] = true, [92] = false, },
	["F_F_03"] = { [1] = true, [2] = false, [9] = true, [10] = false, [13] = true, [14] = false, [17] = true, [18] = false, [21] = true, [22] = false, [25] = true, [26] = false, [29] = true, [30] = false, [33] = true, [34] = false, [37] = true, [38] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [75] = true, [76] = false, [79] = true, [80] = false, [84] = true, [85] = false, [88] = true, [89] = false, [91] = true, [92] = false, },
	["F_F_04"] = { [1] = true, [2] = false, [11] = true, [12] = false, [15] = true, [16] = false, [19] = true, [20] = false, [23] = true, [24] = false, [27] = true, [28] = false, [31] = true, [32] = false, [35] = true, [36] = false, [39] = true, [40] = false, [43] = true, [44] = false, [47] = true, [48] = false, [51] = true, [52] = false, [55] = true, [56] = false, [59] = true, [60] = false, [63] = true, [64] = false, [67] = true, [68] = false, [71] = true, [72] = false, [76] = true, [77] = false, [80] = true, [81] = false, [85] = true, [86] = false, [89] = true, [90] = false, [91] = true, [92] = false, },


}
#endif // SERVER


#if CLIENT
const string MIRAGE_VOYAGE_AMBIENT_GENERIC_SCRIPT_NAME = "mirage_tt_music_ambient_generic"
#endif



#if SERVER
struct FakeDecoyData
{
	entity decoy
	entity touchTrigger
	entity animRef
	entity ambientGeneric
	string loopingAnim
	bool   allowRespawn = false
	bool   isDissolving = false
	bool   shouldDieIfParterDies = false
	bool   shouldSyncToPartner = false
	bool   shouldScale = false
}
#endif // SERVER


#if SERVER
struct
{
	array<FakeDecoyData>                         nonPartyDecoyDataEntries
	array<FakeDecoyData>                         partyDataEntries
	table<entity, FakeDecoyData>                 decoyDataGroups
	table< FakeDecoyData, array<FakeDecoyData> > parterDecoyGroups
	entity                                       ambientGenericBigFireworks
	entity                                       skydiveTrigger

	bool partyLootBallsDeployed = false
	bool skydiveTriggerEnabled = true
} file
#endif // SERVER


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  #### ##    ## #### ########
//   ##  ###   ##  ##     ##
//   ##  ####  ##  ##     ##
//   ##  ## ## ##  ##     ##
//   ##  ##  ####  ##     ##
//   ##  ##   ###  ##     ##
//  #### ##    ## ####    ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if CLIENT
void function ClMirageVoyage_Init()
{
	if ( !IsMirageVoyageEnabled() )
		return
	AddCallback_EntitiesDidLoad( InitMirageVoyageMusicEnts )
}
#endif // CLIENT


#if CLIENT
void function InitMirageVoyageMusicEnts()
{
	entity musicController = GetEntByScriptName( MIRAGE_VOYAGE_MUSIC_CONTROLLER_SCRIPT_NAME )
	entity ambientGeneric  = GetEntByScriptName( MIRAGE_VOYAGE_AMBIENT_GENERIC_SCRIPT_NAME )

	ambientGeneric.SetSoundCodeControllerEntity( musicController )
}
#endif // CLIENT


#if SERVER
void function MirageVoyage_Init()
{
	if ( !IsMirageVoyageEnabled() )
		return

	CreateAudioLogFunc()
	
	PrecacheModel( MIRAGE_DECOY_MODEL_ASSET )
	PrecacheModel( LOOT_LAUNCHER_MODEL_OFF )

	PrecacheParticleSystem( MIRAGE_DECOY_FX )
	PrecacheParticleSystem( LOOT_LAUNCHER_FX )

	FlagInit( FLAG_MIRAGE_VOYAGE_BUTTON_ENABLED )
	FlagInit( FLAG_MIRAGE_VOYAGE_MAIN_FX )

	AddCallback_OnSurvivalDeathFieldStageChanged( OnDeathFieldStageChanged_KillInitialParty )
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )
}
#endif // SERVER


#if SERVER
void function EntitiesDidLoad()
{
	if ( !IsMirageVoyageEnabled() )
		return

	// decoys
	foreach ( string scriptName in MIRAGE_VOYAGE_ANIM_MOVER_SCRIPTNAMES )
	{
		array<entity> animRefs = GetEntArrayByScriptName( scriptName )

		foreach ( entity refNode in animRefs )
		{
			switch ( scriptName )
			{
				case "mirage_voyage_nose_ref":
					// NON PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "Mirage_party_flying_holo1"
					data1.shouldDieIfParterDies = true
					file.nonPartyDecoyDataEntries.append( data1 )

					FakeDecoyData data2
					data2.animRef = refNode
					data2.loopingAnim = "Mirage_party_flying_holo2"
					data2.shouldDieIfParterDies = true
					file.nonPartyDecoyDataEntries.append( data2 )

					file.parterDecoyGroups[ data1 ] <- [ data2 ]
					file.parterDecoyGroups[ data2 ] <- [ data1 ]
					break

				case "mirage_voyage_grill_ref":
					// NON PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "mirage_BBQ_idle"
					file.nonPartyDecoyDataEntries.append( data1 )
					break

				case "mirage_voyage_bar_ref":
					// NON PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "Mirage_bar_talk_holo1"
					data1.shouldSyncToPartner = true
					file.nonPartyDecoyDataEntries.append( data1 )

					FakeDecoyData data2
					data2.animRef = refNode
					data2.loopingAnim = "Mirage_bar_talk_holo2"
					data2.shouldSyncToPartner = true
					file.nonPartyDecoyDataEntries.append( data2 )

					file.parterDecoyGroups[ data1 ] <- [ data2 ]
					file.parterDecoyGroups[ data2 ] <- [ data1 ]

					// NON PARTY
					FakeDecoyData data3
					data3.animRef = refNode
					data3.loopingAnim = "Mirage_bar_wait_holo1"
					file.nonPartyDecoyDataEntries.append( data3 )

					// PARTY
					FakeDecoyData data4
					data4.animRef = refNode
					data4.loopingAnim = "Mirage_bar_dance_holo1"
					file.partyDataEntries.append( data4 )
					break

				case "mirage_voyage_bar_dance_ref":
					// NON PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "Mirage_bar_dance_holo2"
					file.nonPartyDecoyDataEntries.append( data1 )

					// NON PARTY
					FakeDecoyData data2
					data2.animRef = refNode
					data2.loopingAnim = "mirage_hottub_holo1"
					data2.shouldSyncToPartner = true
					file.nonPartyDecoyDataEntries.append( data2 )

					// NON PARTY
					FakeDecoyData data3
					data3.animRef = refNode
					data3.loopingAnim = "mirage_hottub_holo2"
					data3.shouldSyncToPartner = true
					file.nonPartyDecoyDataEntries.append( data3 )

					file.parterDecoyGroups[ data2 ] <- [ data3 ]
					file.parterDecoyGroups[ data3 ] <- [ data2 ]

					// PARTY
					FakeDecoyData data4
					data4.animRef = refNode
					data4.loopingAnim = "mirage_hottubdance_holo1"
					data4.shouldDieIfParterDies = true
					file.partyDataEntries.append( data4 )

					// PARTY
					FakeDecoyData data5
					data5.animRef = refNode
					data5.loopingAnim = "mirage_hottubdance_holo2"
					data5.shouldDieIfParterDies = true
					file.partyDataEntries.append( data5 )

					file.parterDecoyGroups[ data4 ] <- [ data5 ]
					file.parterDecoyGroups[ data5 ] <- [ data4 ]

					// PARTY
					FakeDecoyData data6
					data6.animRef = refNode
					data6.loopingAnim = "mirage_danceoff_dancer_A1"
					data6.shouldSyncToPartner = true
					file.partyDataEntries.append( data6 )

					// PARTY
					FakeDecoyData data7
					data7.animRef = refNode
					data7.loopingAnim = "mirage_danceoff_dancer_B1"
					data7.shouldSyncToPartner = true
					file.partyDataEntries.append( data7 )

					file.parterDecoyGroups[ data6 ] <- [ data7 ]
					file.parterDecoyGroups[ data7 ] <- [ data6 ]

					// PARTY
					FakeDecoyData data8
					data8.animRef = refNode
					data8.loopingAnim = "mirage_danceoff_watch_C1"
					file.partyDataEntries.append( data8 )
					break

				case "mirage_deck_right_ref":
					// PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "mirage_justdance_grindsmack"
					data1.shouldScale = true
					file.partyDataEntries.append( data1 )
					break

				case "mirage_deck_left_ref":
					// PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "mirage_justdance_robot"
					data1.shouldScale = true
					file.partyDataEntries.append( data1 )
					break

				case "mirage_voyage_roof_ref":
					// PARTY
					FakeDecoyData data1
					data1.animRef = refNode
					data1.loopingAnim = "mirage_justdance_worm"
					data1.shouldScale = true
					file.partyDataEntries.append( data1 )
					break
			}
		}
	}

	// party button
	entity partyButton = InitMirageVoyagePartyButton()

	// skydive trigger
	//if ( Survival_IsPlaneEnabled() )
	{
		entity triggerRef     = GetEntByScriptName( "mirage_voyage_grill_ref" )
		file.skydiveTrigger = CreateEntity( "trigger_cylinder" )
		file.skydiveTrigger.SetRadius( 3000.0 )
		file.skydiveTrigger.SetAboveHeight( 4500.0 )
		file.skydiveTrigger.SetBelowHeight( 3000.0 )
		file.skydiveTrigger.SetOrigin( triggerRef.GetOrigin() )
		file.skydiveTrigger.kv.triggerFilterPlayer = "all"
		DispatchSpawn( file.skydiveTrigger )

		file.skydiveTrigger.SetEnterCallback( void function( entity trigger, entity ent ) : ( partyButton ) {
			if ( IsValid( ent ) && ent.IsPlayer() )
			{
				if ( GetGameState() >= eGameState.Playing && file.skydiveTriggerEnabled )
				{
					thread SetMirageVoyagePartyDisabled( partyButton )
					file.skydiveTriggerEnabled = false
					file.skydiveTrigger.Destroy()
				}
			}
		} )
	}

	//party ball launchers denying airdrops
	foreach ( entity launcherModel in GetEntArrayByScriptName( MIRAGE_ROLLER_EJECTOR_SCRIPT_NAME ) )
		CreateNonExpiringAirdropBadPlace( launcherModel.GetOrigin(), 72 )

	// initial state
	thread SetMirageVoyagePartyInitialState( partyButton )


	printf( "MIRAGE VOYAGE INITIALIZED" )
}
#endif // SERVER


#if SERVER
void function OnDeathFieldStageChanged_KillInitialParty( int stage, float nextCircleStartTime )
{
	if ( stage > 0 )
		return

	if ( IsValid( file.skydiveTrigger ) )
	{
		entity partyButton = GetEntByScriptName( MIRAGE_VOYAGE_BUTTON_SCRIPT_NAME )
		thread SetMirageVoyagePartyDisabled( partyButton )
		file.skydiveTriggerEnabled = false
		file.skydiveTrigger.Destroy()
	}
}
#endif


#if SERVER
void function SetMirageVoyagePartyInitialState( entity partyButton )
{
	thread SetMirageVoyagePartyActive( partyButton, true )
}
#endif

bool function IsMirageVoyageEnabled()
{
	if (MapName() != eMaps.mp_rr_desertlands_mu1 &&
		MapName() != eMaps.mp_rr_desertlands_mu1_tt &&
		MapName() != eMaps.mp_rr_desertlands_64k_x_64k_tt &&
		MapName() != eMaps.mp_rr_canyonlands_mu2_mv 
		
	)
		return false
	return true
}


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ########     ###    ########  ######## ##    ##    ########  ##     ## ######## ########  #######  ##    ##
//  ##     ##   ## ##   ##     ##    ##     ##  ##     ##     ## ##     ##    ##       ##    ##     ## ###   ##
//  ##     ##  ##   ##  ##     ##    ##      ####      ##     ## ##     ##    ##       ##    ##     ## ####  ##
//  ########  ##     ## ########     ##       ##       ########  ##     ##    ##       ##    ##     ## ## ## ##
//  ##        ######### ##   ##      ##       ##       ##     ## ##     ##    ##       ##    ##     ## ##  ####
//  ##        ##     ## ##    ##     ##       ##       ##     ## ##     ##    ##       ##    ##     ## ##   ###
//  ##        ##     ## ##     ##    ##       ##       ########   #######     ##       ##     #######  ##    ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
entity function InitMirageVoyagePartyButton()
{
	entity button = GetEntByScriptName( MIRAGE_VOYAGE_BUTTON_SCRIPT_NAME )

	button.AllowMantle()
	button.SetForceVisibleInPhaseShift( true )
	button.SetUsable()
	button.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS | USABLE_BY_ENEMIES )
	button.SetUsablePriority( USABLE_PRIORITY_LOW )
	button.SetUsePrompts( "#VOYAGE_PARTY_HINT", "#VOYAGE_PARTY_HINT" )
	button.SetSkin( 0 )
	AddCallback_OnUseEntity_ServerOnly( button, CreatePartyButtonFunc( button ) )
	return button
}
#endif // SERVER


#if SERVER
void functionref( entity panel, entity player, int useInputFlags ) function CreatePartyButtonFunc( entity panel )
{
	return void function( entity panel, entity player, int useInputFlags ) : ()
	{
		thread OnPartyButtonActivate( panel, player, useInputFlags )
	}
}
#endif // SERVER


#if SERVER
void function OnPartyButtonActivate( entity button, entity player, int useInputFlags )
{
	if ( Flag( FLAG_MIRAGE_VOYAGE_BUTTON_ENABLED ) )
	{
		EmitSoundOnEntityOnlyToPlayer( button, player, PARTY_BUTTON_DENY_SFX )
		return
	}

	SetMirageVoyagePartyActive( button, false )
	SetMirageVoyagePartyDisabled( button )
}
#endif // SERVER


#if SERVER
void function SetMirageVoyagePartyActive( entity button, bool activatedFromPlaneDrop )
{
	FlagSet( FLAG_MIRAGE_VOYAGE_BUTTON_ENABLED )

	// fx
	FlagSet( FLAG_MIRAGE_VOYAGE_MAIN_FX )

	if ( !activatedFromPlaneDrop )
		thread FillerFXSequence()

	// change the console skin
	button.SetUsePrompts( "Party Already Active", "Party Already Active" )
	button.SetSkin( 1 )

	// play music
	SetPartyMusic( true )

	// console button
	EmitSoundOnEntity( button, PARTY_BUTTON_ACTIVATE_SFX )

	// fireworks sfx
	entity fireworksRefEnt = GetEntByScriptName( "fireworks_burst_target" )
	file.ambientGenericBigFireworks = CreateEntity( "ambient_generic" )
	file.ambientGenericBigFireworks.SetOrigin( fireworksRefEnt.GetOrigin() )
	file.ambientGenericBigFireworks.SetSoundName( FIREWORKS_BURST_SFX )
	file.ambientGenericBigFireworks.SetEnabled( true )
	DispatchSpawn( file.ambientGenericBigFireworks )

	entity danceFloorEnt = GetEntByScriptName( DANCEFLOOR_SCRIPT_NAME )
	//danceFloorEnt.SetSkin( 1 )

	// remove the non party decoys
	foreach ( FakeDecoyData data in file.nonPartyDecoyDataEntries )
	{
		TryDissolveFakeMirageDecoy( data )
		data.allowRespawn = false
	}

	// first time loot balls
	if ( !activatedFromPlaneDrop )
	{
		if ( !file.partyLootBallsDeployed )
		{
			foreach ( entity launcher in GetEntArrayByScriptName( MIRAGE_ROLLER_EJECTOR_SCRIPT_NAME ) )
			{
				StartParticleEffectInWorld( GetParticleSystemIndex( LOOT_LAUNCHER_FX ), launcher.GetOrigin(), <0, 0, 0> )
				EmitSoundOnEntity( launcher, BALL_LAUNCHER_ACTIVATE_SFX )

				launcher.SetModel( LOOT_LAUNCHER_MODEL_OFF )

				entity launchRoller = SpawnLootRoller_DispatchSpawn( launcher.GetOrigin(), launcher.GetAngles() )
				thread LaunchLootRoller( launchRoller, <0, 0, 1>, 1200.0 )
			}

			file.partyLootBallsDeployed = true
		}
	}

	EmitSoundOnEntity( button, PARTY_BUTTON_ACTIVATE_VO )

	wait 1.0

	// create the party decoys
	if ( !activatedFromPlaneDrop )
	{
		foreach ( FakeDecoyData data in file.partyDataEntries )
			CreateFakeMirageDecoy( data )
	}

	wait MIRAGE_VOYAGE_PARTY_DURATION

	//if ( IsValid( danceFloorEnt ) )
		//danceFloorEnt.SetSkin( 0 )
}
#endif // SERVER


#if SERVER
void function FillerFXSequence()
{
	float desiredTimeIncrement = 60.0 / float( MIRAGE_VOYAGE_FILLER_FX_BPM )
	float totalDesiredTime     = 0.0
	float startTime            = Time()

	Assert( desiredTimeIncrement > 0 )

	for ( int idx = 1; idx < MIRAGE_VOYAGE_FILLER_FX_BEAT_COUNT + 1; idx++ )
	{
		foreach ( string fxFlag, table<int, bool> sequenceTable in FLAGS_MIRAGE_VOYAGE_FILLER_FX )
		{
			bool effectTurningOn = false

			if ( idx in sequenceTable )
			{
				if ( sequenceTable[ idx ] )
				{
					effectTurningOn = true
				}
				else
				{
					effectTurningOn = false
				}
			}

			if ( !effectTurningOn )
				continue

				EmitSoundOnEntity( GetEntByScriptName( "F_F_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_B_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_S_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_T_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_A_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_R_sound" ), FIREWORKS_STREAMER_SFX )
				EmitSoundOnEntity( GetEntByScriptName( "F_P_sound" ), FIREWORKS_STREAMER_SFX )
		}

		// Loop to keep the server virtual machine in line with the bpm, which needs more precision than .1 second increments can give us
		totalDesiredTime += desiredTimeIncrement

		while( true )
		{
			float totalWaitedDuration = Time() - startTime

			if ( totalWaitedDuration >= totalDesiredTime )
				break
			else
				WaitFrame()
		}
	}
}
#endif


#if SERVER
void function SetMirageVoyagePartyDisabled( entity button )
{
	FlagClear( FLAG_MIRAGE_VOYAGE_MAIN_FX )

	// sound/music
	SetPartyMusic( false )

	if ( IsValid( file.ambientGenericBigFireworks ) )
		file.ambientGenericBigFireworks.Destroy()

	EmitSoundOnEntity( button, PARTY_BUTTON_DISABLE_SFX )

	// dissolve party decoys
	foreach ( FakeDecoyData data in file.partyDataEntries )
	{
		TryDissolveFakeMirageDecoy( data )
		data.allowRespawn = false
	}

	// wait for party decoys to be fully cleaned up
	while( true )
	{
		bool partyDecoysFullyDissolved = true

		foreach ( FakeDecoyData data in file.partyDataEntries )
		{
			if ( data.isDissolving )
			{
				partyDecoysFullyDissolved = false
				break
			}
		}

		WaitFrame() // buffer even if all decoys are dissolved

		if ( partyDecoysFullyDissolved )
			break
	}

	foreach ( FakeDecoyData data in file.nonPartyDecoyDataEntries )
		CreateFakeMirageDecoy( data )

	wait 1

	button.SetUsePrompts( "Press %use% To Party", "Press %use% To Party" )
	button.SetSkin( 0 )

	FlagClear( FLAG_MIRAGE_VOYAGE_BUTTON_ENABLED )
}
#endif // SERVER


#if SERVER
void function SetPartyMusic( bool partyOn )
{
	entity musicController = GetEntByScriptName( MIRAGE_VOYAGE_MUSIC_CONTROLLER_SCRIPT_NAME )

	if ( partyOn )
	{
		musicController.SetSoundCodeControllerValue( 100.0 )
		EmitSoundOnEntity( GetEntByScriptName( PARTY_MUSIC_ENT_SCRIPT_NAME ), PARTY_MUSIC )
	}
	else
	{
		musicController.SetSoundCodeControllerValue( 0.0 )
	}
}
#endif // SERVER


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ########  ########  ######   #######  ##    ##  ######
//  ##     ## ##       ##    ## ##     ##  ##  ##  ##    ##
//  ##     ## ##       ##       ##     ##   ####   ##
//  ##     ## ######   ##       ##     ##    ##     ######
//  ##     ## ##       ##       ##     ##    ##          ##
//  ##     ## ##       ##    ## ##     ##    ##    ##    ##
//  ########  ########  ######   #######     ##     ######
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
void function CreateFakeMirageDecoy( FakeDecoyData data )
{
	data.decoy = CreatePropDynamic( MIRAGE_DECOY_MODEL_ASSET, data.animRef.GetOrigin(), data.animRef.GetAngles(), 6, MIRAGE_VOYAGE_FAKE_DECOY_FADE_DIST )
	Attachment result = data.decoy.Anim_GetAttachmentAtTime( data.loopingAnim, "ORIGIN", 0.0 )
	data.decoy.SetOrigin( result.position )
	data.decoy.SetAngles( result.angle )

	file.decoyDataGroups[data.decoy] <- data

	if ( data.shouldScale )
		data.decoy.SetModelScale( 4.0 )

	data.allowRespawn = true

	// damage setup
	data.decoy.SetMaxHealth( 50 )
	data.decoy.SetHealth( 50 )
	data.decoy.SetScriptName( MIRAGE_VOYAGE_DECOY_SCRIPT_NAME )
	data.decoy.SetBlocksRadiusDamage( false )
	data.decoy.SetTakeDamageType( DAMAGE_YES )
	data.decoy.SetDeathNotifications( true )
	data.decoy.SetCanBeMeleed( true )
	data.decoy.e.canBurn = true
	data.decoy.SetPassThroughThickness( 0 )

	// highlight
	Highlight_SetNeutralHighlight( data.decoy, "decoy_prop"  )

	// anim
	thread PlayAnim( data.decoy, data.loopingAnim, data.animRef, null, 0.0 )

	if ( data in file.parterDecoyGroups && data.shouldSyncToPartner )
	{
		foreach ( FakeDecoyData partnerData in file.parterDecoyGroups[ data ] )
		{
			if ( !IsValid( partnerData.decoy ) )
				continue

			float cycle = partnerData.decoy.GetCycle()
			data.decoy.SetCycle( cycle )
			break
		}
	}

	vector decoyOrigin = data.decoy.GetAttachmentOrigin( data.decoy.LookupAttachment( "ORIGIN" ) )

	// sounds
	if ( data.shouldScale )
	{
		EmitSoundOnEntity( data.decoy, FAKE_DECOY_LARGE_ACTIVATE_SFX )
		data.ambientGeneric = CreateEntity( "ambient_generic" )
		data.ambientGeneric.SetSoundName( FAKE_DECOY_LARGE_SFX )
	}
	else
	{
		EmitSoundOnEntity( data.decoy, FAKE_DECOY_REGULAR_ACTIVATE_SFX )
		data.ambientGeneric = CreateEntity( "ambient_generic" )
		data.ambientGeneric.SetSoundName( FAKE_DECOY_REGULAR_SFX )
	}

	data.ambientGeneric.SetOrigin( decoyOrigin )
	data.ambientGeneric.SetEnabled( true )
	DispatchSpawn( data.ambientGeneric )

	// fx
	entity fxEnt = StartParticleEffectOnEntity_ReturnEntity( data.decoy, GetParticleSystemIndex( MIRAGE_DECOY_FX ), FX_PATTACH_POINT_FOLLOW, data.decoy.LookupAttachment( "CHESTFOCUS" ) )
	fxEnt.DisableHibernation()

	// callbacks
	AddEntityCallback_OnDamaged( data.decoy, OnFakeMirageDecoyDamaged )

	AddEntityDestroyedCallback( data.decoy, OnFakeMirageDecoyKilled )

	// touch trigger
	if ( !data.shouldScale )
	{
		data.touchTrigger = CreateEntity( "trigger_cylinder" )

		data.touchTrigger.SetRadius( 16.0 )
		data.touchTrigger.SetAboveHeight( 72.0 )
		data.touchTrigger.SetBelowHeight( 0.0 )
		data.touchTrigger.SetOrigin( decoyOrigin )
		data.touchTrigger.kv.triggerFilterPlayer = "all"
		DispatchSpawn( data.touchTrigger )

		data.touchTrigger.SetParent( data.decoy, "ORIGIN" )

		data.touchTrigger.SetEnterCallback( void function( entity trigger, entity ent ) : ( data ) {
			if ( IsValid( ent ) && ent.IsPlayer() )
			{
				TryDissolveFakeMirageDecoy( data )
			}
		} )
	}
}
#endif // SERVER


#if SERVER
void function OnFakeMirageDecoyDamaged( entity decoy, var damageInfo )
{
	DamageInfo_SetDamage( damageInfo, 0 )

	if ( !IsValid( decoy ) )
		return

	FakeDecoyData data = file.decoyDataGroups[decoy]

	if ( data.shouldScale )
		return

	TryDissolveFakeMirageDecoy( data )

	if ( data in file.parterDecoyGroups && data.shouldDieIfParterDies )
	{
		foreach ( FakeDecoyData partnerData in file.parterDecoyGroups[ data ] )
			TryDissolveFakeMirageDecoy( partnerData )
	}
}
#endif // SERVER


#if SERVER
void function TryDissolveFakeMirageDecoy( FakeDecoyData data )
{
	if ( data.isDissolving || !IsValid( data.decoy ) )
		return

	data.isDissolving = true

	data.decoy.Dissolve( ENTITY_DISSOLVE_CHAR, <0,0,0>, 1000 )

	if ( !data.shouldScale )
		data.touchTrigger.Destroy()

	data.ambientGeneric.Destroy()

	EmitSoundAtPosition( TEAM_ANY, data.decoy.GetOrigin(), "Mirage_PsycheOut_Decoy_End_3P", data.decoy )
}
#endif // SERVER


#if SERVER
void function OnFakeMirageDecoyKilled( entity decoy )
{
	thread OnFakeMirageDecoyKilled_Thread( decoy )
}
#endif // SERVER


#if SERVER
void function OnFakeMirageDecoyKilled_Thread( entity decoy )
{
	FakeDecoyData data = file.decoyDataGroups[ decoy ]
	data.isDissolving = false

	delete file.decoyDataGroups[ decoy ]

	if ( !data.allowRespawn )
		return

	wait FAKE_DECOY_RESPAWN_WAIT_DURATION

	if ( data.allowRespawn )
		CreateFakeMirageDecoy( data )
}
#endif // SERVER


#if SERVER
void function CreateAudioLogFunc()
{
	entity audioLodModel = CreatePropDynamic( $"mdl/desertlands/mirage_phone_01.rmdl", < 0, 0, 0 >, < 0, 0, 0 > )
	if ( IsMapDesertlands() )
	{
		audioLodModel.SetOrigin(< -23554, -6324, -2929.17 > )
		audioLodModel.SetAngles(< 40.962, -55.506, 17.1326 > )
	}
	else
	{
		audioLodModel.SetOrigin(< -11458.6, -20108.9, 3434.01 > )
		audioLodModel.SetAngles(< 0, -152.312, 1.09681e-06 > )
	}
	audioLodModel.Hide()
	audioLodModel.SetUsable()
	audioLodModel.SetUsePrompts( "%use% PLAY AUDIO LOG", "%use% PLAY AUDIO LOG" )
	AddCallback_OnUseEntity( audioLodModel, void function(entity audioLodModel, entity player, int useInputFlags )
		{
			if ( IsMapDesertlands() )
			{
				thread OnAudioLogActivate_Desertlands( audioLodModel, player, useInputFlags )
			}
			else
			{
				thread OnAudioLogActivate_Canyonlands( audioLodModel, player, useInputFlags )
			}
		}
	)
}
#endif // SERVER


#if SERVER
void function OnAudioLogActivate_Desertlands( entity log, entity player, int useInputFlags )
{
	const float MIRAGE_AUDIO_LOG_DURATION = 52.0
	log.UnsetUsable()

	EmitSoundAtPosition( TEAM_UNASSIGNED, log.GetCenter(), "diag_mp_mirage_tt_01_3p", log )

	wait MIRAGE_AUDIO_LOG_DURATION + 5

	log.SetUsable()
}

const table< string, float > CLANDS_AUDIO_LOG_LINE_LIST = {
	[ "diag_mp_evelyn_audioLog_01_3p" ] = 6.4671,
	[ "diag_mp_evelyn_audioLog_02_3p" ] = 14.1581,
	[ "diag_mp_evelyn_audioLog_03_3p" ] = 10.995,
	[ "diag_mp_evelyn_audioLog_04_3p" ] = 17.6371,
	[ "diag_mp_evelyn_audioLog_05_3p" ] = 17.0419,
	[ "diag_mp_evelyn_audioLog_06_3p" ] = 13.6662,
	[ "diag_mp_evelyn_audioLog_07_3p" ] = 17.6067,
	[ "diag_mp_evelyn_audioLog_08_3p" ] = 11.7979

}

void function OnAudioLogActivate_Canyonlands( entity log, entity player, int useInputFlags )
{
	log.UnsetUsable()

	foreach( string alias, float duration in CLANDS_AUDIO_LOG_LINE_LIST )
	{
		EmitSoundOnEntity( log, alias )
		wait duration
	}

	wait 5

	log.SetUsable()
}
#endif // SERVER

#if SERVER
bool function IsMapCanyonlands()
{
	return GetMapName().find( "mp_rr_canyonlands" ) == 0
}

bool function IsMapDesertlands()
{
	return GetMapName().find( "mp_rr_desertlands" ) == 0
}
#endif
