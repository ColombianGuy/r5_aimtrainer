#if SERVER
global function Bloodhound_TT_Init
global function MaybeActivateBloodTTDefense_Thread
global function ClientCallback_BloodTT_StoryPropDialogueAborted
global function GetBloodhoundTTAssetsToPrecache
#endif

#if SERVER && DEV
global function Bloodhound_TT_SpawnProwlers
global function Bloodhound_TT_KillProwlers
global function Bloodhound_TT_TestSpotlight
global function TestBlackMarketBloodTTAlarm
#endif

#if CLIENT
global function ClBloodhound_TT_Init
global function SCB_BloodTT_SetCustomSpeakerIdx
#endif


#if SERVER || CLIENT
global function Bloodhound_TT_RegisterNetworking
global function GetBloodTTRewardPanelForLoot
global function IsBloodhoundTTEnabled

global const string HATCH_MDL_SCRIPTNAME = "prowler_hatch_model"
#endif


#if SERVER
const string FLAG_PROWLER_CHALLENGE_INITIATED = "ProwlerChallengeInitiated"
const string FLAG_PROWLER_CHALLENGE_COMPLETE_0 = "ProwlerChallenge0Complete"
const string FLAG_PROWLER_CHALLENGE_COMPLETE_1 = "ProwlerChallenge1Complete"
const string FLAG_PROWLER_CHALLENGE_COMPLETE_2 = "ProwlerChallenge2Complete"
const string FLAG_CHALLENGE_ACTIVE = "BloodTTChallengeIsActive"
const string FLAG_CHALLENGE_INCOMPLETE_REMINDER_ACTIVE = "BloodTTChallengeReminderActive"
const string FLAG_CHALLENGE_COMPLETE_REMINDER_ACTIVE = "BloodTTChallengeCompleteReminderActive"
const string SIGNAL_CANCEL_ARENA_REMINDER = "CancelBloodArenaReminderBuffer"
const string SIGNAL_HATCH_SPOTLIGHT_ON = "HatchSpotlightOn"
const string SIGNAL_PLAYER_LEFT_ARENA = "OnPlayerLeaveBloodArena"

const string SIGNAL_MAYBE_ACTIVATE_LOBA_DEFENSE = "MaybeActivateBloodTTDefense_Thread"
const string SIGNAL_REWARD_DOOR_OPENING = "OnRewardDoorOpening"
const string SIGNAL_MAKE_LOOTING_PLAYER_HIGH_THREAT = "OnMakeBlackMarketPlayerHighThreat"
const string REWARD_DOOR_ALARM_FX = "P_crow_door_alarm"
const string REWARD_ROOM_ALARM_FX = "P_crow_door_room_light"
const string REWARD_DOOR_SOUND = "Loba_Ultimate_Staff_VaultAlarm"

const int PROWLER_TEAM = 104
const string PROWLER_MDL = "mdl/Creatures/prowler/prowler_apex.rmdl"
const string SPOTLIGHT_MDL = $"mdl/fx/prowler_hatch_tt_beam.rmdl"
const string SPOTLIGHT_FX = "P_prowler_hatch_light"

const string SPOTLIGHT_ACTIVATE_SFX = "Desertlands_Emit_Bloodhound_TT_Spotlight"
const string SPOTLIGHT_ACTIVATE_SPECIAL_SFX = "Desertlands_Emit_Bloodhound_TT_Trialstart"

const string HATCH_REF_SCRIPTNAME = "prowler_spawn_ref"
const string ARENA_TRIGGER_SCRIPTNAME = "blood_tt_arena_trigger"
const string ARENA_DOOR_INSTANCENAME = "blood_tt_arena_door"
const string NAV_SEPARATOR_SCRIPTNAME = "blood_tt_navseparator_tier"
const string ARENA_DOOR_SFX = "Desertlands_Emit_Bloodhound_TT_StoneDoor"
const array<string> REWARD_SUCCESS_VO_LINES =
[
	"diag_mp_bloodhound_btr_challengeComplete_01_3p",
	"diag_mp_bloodhound_btr_challengeComplete_02_3p",
	"diag_mp_bloodhound_btr_challengeComplete_03_3p",
	"diag_mp_bloodhound_btr_challengeComplete_04_3p"
]

const float LIGHTSHOW_ENDING_BUFFER = 5.0

//-------Chargerifle Hologram -------//
const string HOLOGRAM_FX = "P_holo_bhtt_chargerifle"
const string HOLOGRAM_BASE = "mdl/props/holo_spray/holo_spray_base.rmdl"

const array<int> SMART_LOOT_ATTACHMENT_FILTER_GROUP = [eWeaponAttachmentType.BARREL, eWeaponAttachmentType.MAG, eWeaponAttachmentType.STOCK]
const array<int> SMART_LOOT_GEAR_FILTER_GROUP = [eLootType.ARMOR, eLootType.HELMET, eLootType.INCAPSHIELD, eLootType.BACKPACK ]
#endif


#if SERVER || CLIENT
const asset BLOOD_TT_CSV_DIALOGUE = $"datatable/dialogue/blood_tt_dialogue.rpak"
const asset BLOOD_TT_ANNOUNCER_CSV_DIALOGUE = $"datatable/dialogue/blood_tt_announcer_dialogue.rpak"
const string BLOOD_TT_PANEL_TIER_0_SCRIPTNAME = "prowler_console_tier0"
const string BLOOD_TT_PANEL_TIER_1_SCRIPTNAME = "prowler_console_tier1"
const string BLOOD_TT_PANEL_TIER_2_SCRIPTNAME = "prowler_console_tier2"

const string STORY_PROP_HUNT_SCRIPTNAME = "blood_tt_story_hunt"
const string STORY_PROP_TECH_SCRIPTNAME = "blood_tt_story_tech"
const string STORY_PROP_TECH_TARGET_SCRIPTNAME = "blood_tt_story_tech_target"
const string STORY_PROP_SPIRITUAL_SCRIPTNAME = "blood_tt_story_spiritual"

const string SIGNAL_STORY_PROP_DIALOGUE_ABORTED = "BloodTTStoryPropDialogueAborted"

const array<string> DIALOGUE_LINES_STORY_PROP_HUNT =
[
	"bc_bloodhound_storyOfTheHunt_01",
	"bc_bloodhound_storyOfTheHunt_02",
	"bc_bloodhound_storyOfTheHunt_03",
]

const array<string> DIALOGUE_LINES_STORY_PROP_TECH =
[
	"bc_bloodhound_storyOfTheWeapon_01",
	"bc_bloodhound_storyOfTheWeapon_02",
	"bc_bloodhound_storyOfTheWeapon_03",
]

const array<string> DIALOGUE_LINES_STORY_PROP_SPIRITUAL =
[
	"bc_bloodhound_storyOfTheGuide_01",
	"bc_bloodhound_storyOfTheGuide_02",
	"bc_bloodhound_storyOfTheGuide_03",
	"bc_bloodhound_storyOfTheGuide_04",
	"bc_bloodhound_storyOfTheGuide_05",
	"bc_bloodhound_storyOfTheGuide_06",
]

const string LOUDSPEAKER_SCRIPTNAME = "bloodhound_tt_loudspeaker_target"
#endif // SERVER || CLIENT


struct RewardPanelData
{
	entity panel
	Point& doorStartPoint
	int    challengeIdx
}


#if SERVER
enum eLightShowType
{
	RANDOM_DIR,
	CLOCKWISE,
	COUNTER_CLOCKWISE
}


struct BloodTTHatchData
{
	entity hatchModel
	entity ref
	entity fxEnt
}


struct HatchChallengeData
{
	array< array<int> > hatchLightShowIndexGroups
	array< array<int> > hatchStartIndexGroups
	array< array<int> > hatchEndIndexGroups
	int                 prowlerSkinIdx = 0
}
#endif // SERVER


#if SERVER || CLIENT
struct StoryPropUsabilityData
{
	bool propsUsable = true
}
#endif // SERVER || CLIENT

struct
{
	#if SERVER || CLIENT
		array<entity>          allStoryProps
		array<RewardPanelData> panelDatas

		#if SERVER
			array<BloodTTHatchData> hatchDatas
			int                     lastCompletedChallenge = -1
			array<entity>    arenaDoors
			array<entity>    uniqueSpotlights
			int                     customDialogueQueue

			array<HatchChallengeData> tier0ChallengeDatas
			array<HatchChallengeData> tier1ChallengeDatas
			array<HatchChallengeData> tier2ChallengeDatas

			array<string> rewardSuccessDialogueLines

			int           prowlerDeaths = 0
			int           totalNumProwlers = 0
			array<entity> aliveProwlers

			table<entity, StoryPropUsabilityData> playerStoryPropDatas

			entity        arenaTrigger
			entity        arenaTriggerOuter
			array<entity> bloodhoundPlayersThatHaveEnteredArena
			array<int>    teamIdxsThatCompletedChallenge
			array<int>    teamIdxsRemindedMidChallenge
			array<int>    teamIdxsRemindedPostChallenge
			array<entity> playersLeftArenaDoNotRemind

			//table<int, TeamLootTracker> lootTrackers

			array<entity> storedRewardRareTargets
			array<entity> storedRewardHighTargets
			array<entity> storedRewardUltraTargets

			int 		  teamActivatingPanel

		#elseif CLIENT
			StoryPropUsabilityData& clientStoryPropData
		#endif
	#endif // SERVER || CLIENT
} file


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
void function ClBloodhound_TT_Init()
{
	if (MapName() != eMaps.mp_rr_desertlands_mu2 && MapName() != eMaps.mp_rr_desertlands_mu1_tt)
		return

	AddCallback_EntitiesDidLoad( EntitiesDidLoad )

	StoryPropUsabilityData data
	file.clientStoryPropData = data

	RegisterSignal( SIGNAL_STORY_PROP_DIALOGUE_ABORTED )

//	AddCallback_OnAbortDialogue( OnAbortDialogue )

	AddCreateCallback( "prop_dynamic", OnCreate_PropDynamic )
	AddDestroyCallback( "prop_dynamic", OnDestroy_PropDynamic )

	//PrecacheScriptString( HATCH_MDL_SCRIPTNAME )
}
#endif

void function Bloodhound_TT_RegisterNetworking()
{
	Remote_RegisterClientFunction( "SCB_BloodTT_SetCustomSpeakerIdx", "int", 0, NUM_TOTAL_DIALOGUE_QUEUES )
	Remote_RegisterUntypedFunction_deprecated( "ClientCallback_BloodTT_StoryPropDialogueAborted" )
}

#if SERVER
void function Bloodhound_TT_Init()
{
	if (MapName() != eMaps.mp_rr_desertlands_mu2 && MapName() != eMaps.mp_rr_desertlands_mu1_tt)
		return
	
	AddCallback_EntitiesDidLoad( EntitiesDidLoad )

	AddSpawnCallback( "prop_dynamic", ArenaDoorSpawned )
	PrecacheModel( SPOTLIGHT_MDL )

	AddSpawnCallback_ScriptName( STORY_PROP_HUNT_SCRIPTNAME, SpawnStoryProps_Server )
	AddSpawnCallback_ScriptName( STORY_PROP_SPIRITUAL_SCRIPTNAME, SpawnStoryProps_Server )
	AddSpawnCallback_ScriptName( STORY_PROP_TECH_TARGET_SCRIPTNAME, SpawnTechPropHologram )
	AddSpawnCallback_ScriptName( ARENA_TRIGGER_SCRIPTNAME, SpawnArenaTrigger )
	AddSpawnCallback_ScriptName( BLOOD_TT_PANEL_TIER_0_SCRIPTNAME, SpawnTierPanel )
	AddSpawnCallback_ScriptName( BLOOD_TT_PANEL_TIER_1_SCRIPTNAME, SpawnTierPanel )
	AddSpawnCallback_ScriptName( BLOOD_TT_PANEL_TIER_2_SCRIPTNAME, SpawnTierPanel )

	AddCallback_OnClientConnected( Blood_TT_OnClientConnected )
	AddCallback_OnClientDisconnected( Blood_TT_OnClientDisconnected )
	//AddCallback_OnClientConnectionRestored( Blood_TT_OnClientConnected )

	//PrecacheScriptString( HATCH_MDL_SCRIPTNAME )
}
#endif // SERVER


#if SERVER
void function ArenaDoorSpawned( entity door )
{
	if ( door.GetInstanceName() != ARENA_DOOR_INSTANCENAME )
		return

	door.SetTakeDamageType( DAMAGE_NO )
	door.e.canBurn = false
	door.SetCanBeMeleed( false )

	file.arenaDoors.append( door )

	thread WaitAndSetInitialDoorState( door )
}


void function WaitAndSetInitialDoorState( entity door )
{
	WaitSignal( door, "ScriptedDoorReady" )

	OpenDoor( door, null )
	//LockDoor( door )
}
#endif


#if SERVER
void function Blood_TT_OnClientConnected( entity player )
{
	if ( !( player in file.playerStoryPropDatas ) )
	{
		StoryPropUsabilityData data
		file.playerStoryPropDatas[ player ] <- data
	}

	// If it's 0, it hasn't been set
	if ( file.customDialogueQueue > 0 )
		Remote_CallFunction_NonReplay( player, "SCB_BloodTT_SetCustomSpeakerIdx", file.customDialogueQueue )
}
#endif


#if SERVER
void function Blood_TT_OnClientDisconnected( entity player )
{
	if ( player in file.playerStoryPropDatas )
		delete file.playerStoryPropDatas[ player ]
}
#endif


void function EntitiesDidLoad()
{
	if ( !IsBloodhoundTTEnabled() )
		return

	//RegisterCSVDialogue( BLOOD_TT_CSV_DIALOGUE )
	//RegisterCSVDialogue( BLOOD_TT_ANNOUNCER_CSV_DIALOGUE )

#if SERVER
	//PrecacheScriptString( STORY_PROP_TECH_SCRIPTNAME )

	FlagInit( FLAG_PROWLER_CHALLENGE_INITIATED )
	FlagInit( FLAG_PROWLER_CHALLENGE_COMPLETE_0 )
	FlagInit( FLAG_PROWLER_CHALLENGE_COMPLETE_1 )
	FlagInit( FLAG_PROWLER_CHALLENGE_COMPLETE_2 )
	FlagInit( FLAG_CHALLENGE_ACTIVE )
	FlagInit( FLAG_CHALLENGE_INCOMPLETE_REMINDER_ACTIVE )
	FlagInit( FLAG_CHALLENGE_COMPLETE_REMINDER_ACTIVE )

	RegisterSignal( SIGNAL_CANCEL_ARENA_REMINDER )
	RegisterSignal( SIGNAL_HATCH_SPOTLIGHT_ON )
	RegisterSignal( SIGNAL_PLAYER_LEFT_ARENA )
	RegisterSignal( SIGNAL_STORY_PROP_DIALOGUE_ABORTED )
	RegisterSignal( SIGNAL_MAYBE_ACTIVATE_LOBA_DEFENSE )
	RegisterSignal( SIGNAL_REWARD_DOOR_OPENING )
	RegisterSignal( SIGNAL_MAKE_LOOTING_PLAYER_HIGH_THREAT )

	file.rewardSuccessDialogueLines = clone(REWARD_SUCCESS_VO_LINES)
	file.rewardSuccessDialogueLines.randomize()

	//				13	0
	//			12			1
	//		11					2
	//		10					3
	//		9					4
	//			8			5
	//				7	6
	//

	// challenge 0 data sets
	HatchChallengeData tier0_1
	tier0_1.hatchLightShowIndexGroups = [ [ 11, 12, 13, 0, 1, 2 ], [ 9, 8, 7, 6, 5, 4 ] ]
	tier0_1.hatchStartIndexGroups = [ [11], [9] ]
	tier0_1.hatchEndIndexGroups = [ [2], [4] ]
	file.tier0ChallengeDatas.append( tier0_1 )

	HatchChallengeData tier0_2
	tier0_2.hatchLightShowIndexGroups = [ [ 11, 12, 13, 0, 1 ], [ 9, 8, 7, 6, 5 ] ]
	tier0_2.hatchStartIndexGroups = [ [11], [9] ]
	tier0_2.hatchEndIndexGroups = [ [1], [5] ]
	file.tier0ChallengeDatas.append( tier0_2 )

	HatchChallengeData tier0_3
	tier0_3.hatchLightShowIndexGroups = [ [ 11, 12, 13 ], [ 9, 8, 7 ] ]
	tier0_3.hatchStartIndexGroups = [ [11], [9] ]
	tier0_3.hatchEndIndexGroups = [ [13], [7] ]
	file.tier0ChallengeDatas.append( tier0_3 )

	// challenge 1 data sets
	HatchChallengeData tier1_1
	tier1_1.hatchLightShowIndexGroups = [ [ 2, 1, 0, 13, 12, 11 ], [ 4, 5, 6, 7, 8, 9 ] ]
	tier1_1.hatchStartIndexGroups = [ [1, 2], [4, 5] ]
	tier1_1.hatchEndIndexGroups = [ [11, 12], [9, 8] ]
	file.tier1ChallengeDatas.append( tier1_1 )

	HatchChallengeData tier1_2
	tier1_2.hatchLightShowIndexGroups = [ [ 2, 1, 0, 13, 12 ], [ 4, 5, 6, 7, 8 ] ]
	tier1_2.hatchStartIndexGroups = [ [1, 2], [4, 5] ]
	tier1_2.hatchEndIndexGroups = [ [12, 13], [8, 7] ]
	file.tier1ChallengeDatas.append( tier1_2 )

	HatchChallengeData tier1_3
	tier1_3.hatchLightShowIndexGroups = [ [ 2, 1, 0 ], [ 4, 5, 6 ] ]
	tier1_3.hatchStartIndexGroups = [ [1, 2], [4, 5] ]
	tier1_3.hatchEndIndexGroups = [ [0, 1], [6, 5] ]
	file.tier1ChallengeDatas.append( tier1_3 )

	// challenge 2 data sets
	HatchChallengeData tier2_1
	tier2_1.hatchLightShowIndexGroups = [ [ 12, 11, 10, 9, 8 ], [ 1, 2, 3, 4, 5 ] ]
	tier2_1.hatchStartIndexGroups = [ [11, 12, 13], [2, 1, 0] ]
	tier2_1.hatchEndIndexGroups = [ [9, 8, 7], [4, 5, 6] ]
	file.tier2ChallengeDatas.append( tier2_1 )

	HatchChallengeData tier2_2
	tier2_2.hatchLightShowIndexGroups = [ [ 12, 11, 10 ], [ 1, 2, 3 ] ]
	tier2_2.hatchStartIndexGroups = [ [11, 12, 13], [2, 1, 0] ]
	tier2_2.hatchEndIndexGroups = [ [11, 10, 9], [2, 3, 4] ]
	file.tier2ChallengeDatas.append( tier2_2 )

	file.customDialogueQueue = RequestCustomDialogueQueueIndex()

	// loot for the prowler challenges
	if( !BloodHountTT_IsSmarLootEnabled() ) //If using new smart loot system, don't use the old method of creating and filling rewards.
		thread CreateBloodhoundTTLootRewards()
	else
		thread SetUpBloodhoundTTSmartLootRewards()

	// set up prowler hatches
	for ( int idx = 0; idx < GetEntArrayByScriptName( HATCH_MDL_SCRIPTNAME ).len(); idx++ )
	{
		BloodTTHatchData data
		data.hatchModel = GetEntByScriptNameInInstance( HATCH_MDL_SCRIPTNAME, format( "prowler_cages_%i", idx ) )
		data.hatchModel.kv.intensity = 0

		foreach ( entity linkEnt in data.hatchModel.GetLinkEntArray() )
		{
			if ( linkEnt.GetScriptName() == HATCH_REF_SCRIPTNAME )
				data.ref = linkEnt
		}

		file.hatchDatas.append( data )
	}

	printf( "BLOODHOUND TT INITIALIZED" )
	#endif // SERVER
}

#if CLIENT
void function SCB_BloodTT_SetCustomSpeakerIdx( int speakerIdx )
{
	// init the loudspeaker ents
	RegisterCustomDialogueQueueSpeakerEntities( speakerIdx, GetEntArrayByScriptName( LOUDSPEAKER_SCRIPTNAME ) )
}
#endif

// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ##        #######   #######  ########
//  ##       ##     ## ##     ##    ##
//  ##       ##     ## ##     ##    ##
//  ##       ##     ## ##     ##    ##
//  ##       ##     ## ##     ##    ##
//  ##       ##     ## ##     ##    ##
//  ########  #######   #######     ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
//void function PrintPos( array<entity> targets )
//{
//	string vectors = "[ "
//	foreach ( entity ent in targets )
//	{
//		vectors += "<" + ent.GetOrigin().x + ", " + ent.GetOrigin().y + ", " + ent.GetOrigin().z + ">, "
//	}
//	printf( vectors )
//}

void function SetUpBloodhoundTTSmartLootRewards()
{
	array <entity> ammoTargets        = GetEntArrayByScriptName( "blood_tt_loot_ammo_target" )
	array <entity> healthTargets      = GetEntArrayByScriptName( "blood_tt_loot_health_target" )
	array <entity> rewardRareTargets  = GetEntArrayByScriptName( "blood_tt_loot_reward_target_rare" )
	array <entity> rewardHighTargets  = GetEntArrayByScriptName( "blood_tt_loot_reward_target_high" )
	array <entity> rewardUltraTargets = GetEntArrayByScriptName( "blood_tt_loot_reward_target_ultra" )

	array <vector> ammoTargetPositions        = [ <-25718.7, 24341, -2867>, <-25669.2, 24311.3, -2867>, <-25625.4, 24298.6, -2867>, <-25670.7, 24352.4, -2867>, <-25737.1, 24387.7, -2867>, <-25584.4, 24300, -2867>, <-25581.6, 24345.3, -2867>, <-25684.8, 24423.1, -2867>, <-25714.5, 24455.6, -2867> ]
	array <vector> healthTargetPositions      = [ <-25889.9, 24633.8, -2870.71>, <-25870.1, 24653.6, -2870.5>, <-25372.3, 24155.8, -2872>, <-25392.1, 24136, -2872>, <-25375.1, 24670.6, -2872>, <-25355.3, 24650.8, -2872> ]
	array <vector> rewardRareTargetPositions  = [ <-25900.1, 24625.1, -2824>, <-25880.3, 24644.9, -2824>, <-25860.5, 24664.7, -2824> ]
	array <vector> rewardHighTargetPositions  = [ <-25359.5, 24162.8, -2824>, <-25399.1, 24123.3, -2824>, <-25379.3, 24143.1, -2824> ]
	array <vector> rewardUltraTargetPositions = [ <-25376.5, 24688.9, -2824>, <-25356.7, 24669.1, -2824>, <-25336.9, 24649.3, -2824> ]

	bool hasPositionHack = BloodHountTT_UseLootPositionOverrideHack()

	// ammo
	int i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + ammoTargets.len() + "/" + ammoTargetPositions.len())
	#endif
	foreach ( entity target in ammoTargets )
	{
		string itemRef        = SURVIVAL_GetWeightedItemFromGroup( "ammo" )
		LootData ammoLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )

		vector position = target.GetOrigin()
		if ( hasPositionHack )
		{
			if ( i >= ammoTargetPositions.len() )
				break

			position = ammoTargetPositions[i]
		}
		i++

		entity spawnedItem    = SpawnGenericLoot( itemRef, position, <-1, -1, -1>, ammoLootData.countPerDrop )
		target.Destroy()
	}

	// health
	i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + healthTargets.len() + "/" + healthTargetPositions.len())
	#endif
	foreach ( entity target in healthTargets )
	{
		string itemRef

		switch( i )
		{
			case 0:
			case 1: //rewards for the first challenge
				itemRef = SURVIVAL_GetWeightedItemFromGroup( "Health_Low" )
				break
			case 2:
			case 3: //rewards for the second challenge
				itemRef = SURVIVAL_GetWeightedItemFromGroup( "Health_High" )
				break
			case 4:
			case 5: //rewards for the final challenge
				itemRef = SURVIVAL_GetWeightedItemFromGroup( "secret_bin_loot_improved" )
				break
			default:
				itemRef = SURVIVAL_GetWeightedItemFromGroup( "Health_Medium" )
				break
		}

		LootData itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )

		vector position = target.GetOrigin()
		if ( hasPositionHack )
		{
			if ( i >= healthTargetPositions.len() )
				break

			position = healthTargetPositions[i]
		}
		i++

		entity spawnedItem    = SpawnGenericLoot( itemRef, position, target.GetAngles(), itemLootData.countPerDrop )
		target.Destroy()
	}

	file.storedRewardRareTargets = rewardRareTargets
	file.storedRewardHighTargets = rewardHighTargets
	file.storedRewardUltraTargets = rewardUltraTargets
}

void function PopulateBloodTTRewardsByLevel( int currentChallengeLevel )
{
	array <entity> targetsArray

	switch( currentChallengeLevel )
	{
		case 0:
			targetsArray = file.storedRewardRareTargets
			break
		case 1:
			targetsArray = file.storedRewardHighTargets
			break
		case 2:
			targetsArray = file.storedRewardUltraTargets
			break
		default:
			targetsArray = file.storedRewardRareTargets
			break
	}

	string itemRef
	vector position
	entity spawnedItem
	LootData itemLootData

	bool useFallBackRewards = false

	array <string> potentialGearRewards
	array <string> potentialWeaponRewards

	array <entity> teamToReward = GetPlayerArrayOfTeam( file.teamActivatingPanel )

//	array <string> disabledLootRefs = Crafting_GetDisabledGroundLoot()

	//populate potential smart loot options
	foreach( teamMember in teamToReward )
	{
		//roll gear
		potentialGearRewards.extend( SmartLoot_GetLoot( teamMember, true, true, SMART_LOOT_GEAR_FILTER_GROUP, [] , [] ) )

		for( int weaponIndex = WEAPON_INVENTORY_SLOT_PRIMARY_0; weaponIndex <= WEAPON_INVENTORY_SLOT_PRIMARY_1; weaponIndex++ )
		{
			//roll attachments
			potentialWeaponRewards.extend( SmartLoot_GetLoot( teamMember, true, true, [], SMART_LOOT_ATTACHMENT_FILTER_GROUP , [weaponIndex] ) )
		}
	}

	if( potentialGearRewards.len() <= 0 && potentialWeaponRewards.len() <= 0 )
		useFallBackRewards = true

	//populate loot reward targets from the array of smart loot (or fall back options failing that)
	foreach( entity targetEnt in targetsArray )
	{
		if( !useFallBackRewards )
		{
			int indexToDrop

			//look to see if either gear or weapons smart loot offerings are empty and pick the correct supported loot rolls accordingly
			if( potentialGearRewards.len() > 0 && potentialWeaponRewards.len() > 0 )
			{
				int rollForGear = RandomInt( 100 )
				if( rollForGear > BloodHountTT_GetGearChanceDropRate() )
				{
					indexToDrop = RandomInt( potentialGearRewards.len() )

					itemRef = potentialGearRewards[indexToDrop]
					potentialGearRewards.fastremove( indexToDrop )
				}
				else
				{
					indexToDrop = RandomInt( potentialWeaponRewards.len() )

					itemRef = potentialWeaponRewards[indexToDrop]
					potentialWeaponRewards.fastremove( indexToDrop )
				}
			}
			else if( potentialGearRewards.len() > 0 && potentialWeaponRewards.len() <= 0  )
			{
				indexToDrop = RandomInt( potentialGearRewards.len() )

				itemRef = potentialGearRewards[indexToDrop]
				potentialGearRewards.fastremove( indexToDrop )
			}
			else if( potentialWeaponRewards.len() > 0 && potentialGearRewards.len() <= 0  )
			{
				indexToDrop = RandomInt( potentialWeaponRewards.len() )

				itemRef = potentialWeaponRewards[indexToDrop]
				potentialWeaponRewards.fastremove( indexToDrop )
			}
			else
			{
				itemRef = SURVIVAL_GetWeightedItemFromGroup( "loot_roller_contents_epic" )
			}
		}
		else
		{
			itemRef = SURVIVAL_GetWeightedItemFromGroup( "loot_roller_contents_epic" ) //fallback to epic loot roller rewards if smart loot is empty or failed for whatever reason
		}

		//while( disabledLootRefs.contains( itemRef ) || SURVIVAL_Loot_IsRefDisabled( itemRef ) ) //reroll from  to  loot roller rewards if the currently selected item is disabled for whatever reason
		//{
		//	itemRef = SURVIVAL_GetWeightedItemFromGroup( "loot_roller_contents_rare" )
		//}

		itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )

		//forcibly upgrade items if your are deeper into the challenge
		if( currentChallengeLevel == 1 && itemLootData.tier < 2 )
		{
			itemRef = LootHelper_UpgradeLootRefToTier( itemRef, 2 )
			itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )
		}
		//forcibly upgrade items if your are deeper into the challenge
		else if( currentChallengeLevel == 2 && itemLootData.tier < 4 )
		{
			itemRef = LootHelper_UpgradeLootRefToTier( itemRef, 4 )
			itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )
		}

		if( itemLootData.lootType == eLootType.ARMOR && itemLootData.tier > 4 )
		{
			itemRef = LootHelper_UpgradeLootRefToTier( itemRef, 4 )
			itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )
		}

		position = targetEnt.GetOrigin()

		spawnedItem    = SpawnGenericLoot( itemRef, position, targetEnt.GetAngles(), itemLootData.countPerDrop )

		targetEnt.Destroy()
	}

	targetsArray.clear()
}

void function CreateBloodhoundTTLootRewards()
{
	array<entity> ammoTargets        = GetEntArrayByScriptName( "blood_tt_loot_ammo_target" )
	array<entity> healthTargets      = GetEntArrayByScriptName( "blood_tt_loot_health_target" )
	array<entity> rewardRareTargets  = GetEntArrayByScriptName( "blood_tt_loot_reward_target_rare" )
	array<entity> rewardHighTargets  = GetEntArrayByScriptName( "blood_tt_loot_reward_target_high" )
	array<entity> rewardUltraTargets = GetEntArrayByScriptName( "blood_tt_loot_reward_target_ultra" )

	//printf("BLOOD TT LOOT")
	//PrintPos( ammoTargets )
	//PrintPos( healthTargets )
	//PrintPos( rewardRareTargets )
	//PrintPos( rewardHighTargets )
	//PrintPos( rewardUltraTargets )

	array<vector> ammoTargetPositions        = [ <-25718.7, 24341, -2867>, <-25669.2, 24311.3, -2867>, <-25625.4, 24298.6, -2867>, <-25670.7, 24352.4, -2867>, <-25737.1, 24387.7, -2867>, <-25584.4, 24300, -2867>, <-25581.6, 24345.3, -2867>, <-25684.8, 24423.1, -2867>, <-25714.5, 24455.6, -2867> ]
	array<vector> healthTargetPositions      = [ <-25889.9, 24633.8, -2870.71>, <-25870.1, 24653.6, -2870.5>, <-25372.3, 24155.8, -2872>, <-25392.1, 24136, -2872>, <-25375.1, 24670.6, -2872>, <-25355.3, 24650.8, -2872> ]
	array<vector> rewardRareTargetPositions  = [ <-25900.1, 24625.1, -2824>, <-25880.3, 24644.9, -2824>, <-25860.5, 24664.7, -2824> ]
	array<vector> rewardHighTargetPositions  = [ <-25359.5, 24162.8, -2824>, <-25399.1, 24123.3, -2824>, <-25379.3, 24143.1, -2824> ]
	array<vector> rewardUltraTargetPositions = [ <-25376.5, 24688.9, -2824>, <-25356.7, 24669.1, -2824>, <-25336.9, 24649.3, -2824> ]

	//populate final item rewards
	array<string> finalRewardRefs
	finalRewardRefs.append( SURVIVAL_GetWeightedItemFromGroup( "crate_jackpot_items" ) )

	int itemsAppended = 0
	bool addedAnItem = false
	while( true )
	{
		string goldItemRef = SURVIVAL_GetWeightedItemFromGroup( "gold_items" )

		if ( finalRewardRefs.contains( goldItemRef ) )
		{
			WaitFrame()
			continue
		}
		else
		{
			finalRewardRefs.append( goldItemRef )
			itemsAppended++
		}

		if ( itemsAppended > 1 )
			break
	}
	finalRewardRefs.randomize()


	// ammo
	bool hasPositionHack = GetCurrentPlaylistVarBool( "blood_tt_loot_override_hack", true )
	int i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + ammoTargets.len() + "/" + ammoTargetPositions.len())
	#endif
	foreach ( entity target in ammoTargets )
	{
		string itemRef        = SURVIVAL_GetWeightedItemFromGroup( "ammo" )
		LootData ammoLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )

		vector position = target.GetOrigin()
		if ( BloodHountTT_UseLootPositionOverrideHack() )
		{
			if ( i >= ammoTargetPositions.len() )
				break

			position = ammoTargetPositions[i]
		}
		i++

		entity spawnedItem    = SpawnGenericLoot( itemRef, position, <-1, -1, -1>, ammoLootData.countPerDrop )
		target.Destroy()
	}

	// health
	i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + healthTargets.len() + "/" + healthTargetPositions.len())
	#endif
	foreach ( entity target in healthTargets )
	{
		string itemRef        = SURVIVAL_GetWeightedItemFromGroup( "Health_Medium" )
		LootData itemLootData = SURVIVAL_Loot_GetLootDataByRef( itemRef )

		vector position = target.GetOrigin()
		if ( BloodHountTT_UseLootPositionOverrideHack() )
		{
			if ( i >= healthTargetPositions.len() )
				break

			position = healthTargetPositions[i]
		}
		i++

		entity spawnedItem    = SpawnGenericLoot( itemRef, position, target.GetAngles(), itemLootData.countPerDrop )
		target.Destroy()
	}

	// reward rare
	i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + rewardRareTargets.len() + "/" + rewardRareTargetPositions.len())
	#endif
	foreach ( entity target in rewardRareTargets )
	{
		string itemRef     = SURVIVAL_GetWeightedItemFromGroup( "loot_roller_contents_rare" )

		vector position = target.GetOrigin()
		if ( BloodHountTT_UseLootPositionOverrideHack() )
		{
			if ( i >= rewardRareTargetPositions.len() )
				break

			position = rewardRareTargetPositions[i]
		}
		i++

		entity spawnedItem = SpawnGenericLoot( itemRef, position, target.GetAngles() )
		target.Destroy()
	}

	bool highJackpotItemSpawned = false
	// reward high
	i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + rewardHighTargets.len() + "/" + rewardHighTargetPositions.len())
	#endif
	foreach ( entity target in rewardHighTargets )
	{
		string itemRef = SURVIVAL_GetWeightedItemFromGroup( "loot_roller_contents_epic" )

		if ( !highJackpotItemSpawned )
		{
			itemRef = SURVIVAL_GetWeightedItemFromGroup( "crate_jackpot_items" )
			highJackpotItemSpawned = true
		}

		vector position = target.GetOrigin()
		if ( BloodHountTT_UseLootPositionOverrideHack() )
		{
			if ( i >= rewardHighTargetPositions.len() )
				break

			position = rewardHighTargetPositions[i]
		}
		i++

		entity spawnedItem = SpawnGenericLoot( itemRef, position, target.GetAngles() )
		target.Destroy()
	}

	// reward ultra
	i = 0
	#if DEVELOPER
		printf("BLOOD TT LOOT - " + rewardUltraTargets.len() + "/" + rewardUltraTargetPositions.len())
	#endif
	foreach ( int idx, entity target in rewardUltraTargets )
	{
		vector position = target.GetOrigin()
		if ( BloodHountTT_UseLootPositionOverrideHack() )
		{
			if ( i >= rewardUltraTargetPositions.len() )
				break

			position = rewardUltraTargetPositions[i]
		}
		i++
		entity spawnedItem = SpawnGenericLoot( finalRewardRefs[idx], position, target.GetAngles() )
		target.Destroy()
	}
}
#endif


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ######## ########  ####    ###    ##        ######
//     ##    ##     ##  ##    ## ##   ##       ##    ##
//     ##    ##     ##  ##   ##   ##  ##       ##
//     ##    ########   ##  ##     ## ##        ######
//     ##    ##   ##    ##  ######### ##             ##
//     ##    ##    ##   ##  ##     ## ##       ##    ##
//     ##    ##     ## #### ##     ## ########  ######
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
void functionref( entity panel, entity player, int useInputFlags ) function CreateProwlerPanelFunc( entity panel )
{
	return void function( entity panel, entity player, int useInputFlags ) : ()
	{
		thread OnProwlerPanelActivate( panel, player )
	}
}


void function OnProwlerPanelActivate( entity panel, entity player )
{
	int panelIdx = -1

	foreach ( RewardPanelData data in file.panelDatas )
	{
		if ( data.panel == panel )
		{
			panelIdx = data.challengeIdx
			break
		}
	}

	if ( panelIdx > file.lastCompletedChallenge + 1 )
		return

	panel.UnsetUsable()
	panel.SetSkin( 1 )

	HatchChallengeData data
	switch ( panelIdx )
	{
		case 0:
			data = file.tier0ChallengeDatas.getrandom()
			PIN_Interact( player, "BloodhoundTT_panel_activate_1" )
			break

		case 1:
			data = file.tier1ChallengeDatas.getrandom()
			PIN_Interact( player, "BloodhoundTT_panel_activate_2" )
			break

		case 2:
			data = file.tier2ChallengeDatas.getrandom()
			PIN_Interact( player, "BloodhoundTT_panel_activate_3" )
			break
	}

	HatchChallengeSequence( data, panelIdx, player, panel )
}


void function HatchChallengeSequence( HatchChallengeData data, int currentChallengeLevel, entity activatingPlayer, entity panel )
{
	const float CHALLENGE_0_INTRO_VO_DURATION = 3.5
	const float CHALLENGE_1_INTRO_VO_DURATION = 4.2
	const float CHALLENGE_2_INTRO_VO_DURATION = 4.3

	FlagSet( FLAG_PROWLER_CHALLENGE_INITIATED )
	FlagSet( FLAG_CHALLENGE_ACTIVE )

	int activatingPlayerTeamIdx = activatingPlayer.GetTeam()
	file.teamActivatingPanel = activatingPlayerTeamIdx

	// used to send info to the client that the props are unusable now
	foreach ( entity prop in file.allStoryProps )
	{
		array<entity> otherProps = clone(file.allStoryProps)
		otherProps.fastremovebyvalue( prop )

		foreach ( entity otherProp in otherProps )
			prop.LinkToEnt( otherProp )
	}

	// initial burst of lights
	foreach ( array<int> hatchIndexes in data.hatchStartIndexGroups )
	{
		foreach ( int idx in hatchIndexes )
			thread LightShow_CreateSpotLightFX( idx, false )

		EmitSoundOnEntity( GetMiddleHatch( hatchIndexes ), SPOTLIGHT_ACTIVATE_SFX )
	}

	// doors
	foreach ( entity door in file.arenaDoors )
		CloseDoor( door, null )

	// intro dialogue start
	wait 0.5

	string dialogueIntro
	float dialogueDuration

	switch ( currentChallengeLevel )
	{
		case 0:
			dialogueIntro = "diag_mp_bloodhound_btr_challengeprowlerround1_02_3p"
			dialogueDuration = CHALLENGE_0_INTRO_VO_DURATION
			break

		case 1:
			dialogueIntro = "diag_mp_bloodhound_btr_challengeprowlerround2_01_3p"
			dialogueDuration = CHALLENGE_1_INTRO_VO_DURATION
			break

		case 2:
			dialogueIntro = "diag_mp_bloodhound_btr_challengeprowlerround3_01_3p"
			dialogueDuration = CHALLENGE_2_INTRO_VO_DURATION
			break
	}
	//LoudSpeaker_PlaySingle( dialogueIntro )
	EmitSoundOnEntity( panel, dialogueIntro )

	wait dialogueDuration

	// turn off the spotlights...
	wait 0.5

	foreach ( array<int> hatchIndexes in data.hatchStartIndexGroups )
	{
		foreach ( int idx in hatchIndexes )
			thread LightShow_TurnOffSpotlight( idx )
	}

	wait 0.5

	// do the light show!
	file.prowlerDeaths = 0
	file.totalNumProwlers = data.hatchEndIndexGroups[ 0 ].len() * 2

	foreach ( int idx, array<int> lightShowIndexes in data.hatchLightShowIndexGroups )
		thread LightShowSequenceAndSpawnProwler( lightShowIndexes, data.hatchEndIndexGroups[ idx ], data.prowlerSkinIdx )

	// make players not on the activating team higher priority to the prowlers
	foreach ( entity touchingEnt in file.arenaTrigger.GetTouchingEntities() )
	{
		if ( !IsValid( touchingEnt ) || !touchingEnt.IsPlayer() || Bleedout_IsBleedingOut( touchingEnt ) )
			continue

		if ( touchingEnt.GetTeam() == activatingPlayerTeamIdx )
			continue

		thread MakePlayerHigherPriorityThreatToProwler( touchingEnt )
	}

	// wait for prowlers to be eliminated
	string flagToWait
	switch ( currentChallengeLevel )
	{
		case 0:
			flagToWait = FLAG_PROWLER_CHALLENGE_COMPLETE_0
			break

		case 1:
			flagToWait = FLAG_PROWLER_CHALLENGE_COMPLETE_1
			break

		case 2:
			flagToWait = FLAG_PROWLER_CHALLENGE_COMPLETE_2
			break
	}

	FlagWait( flagToWait )

	printt( "PROWLERS DEAD" )

	FlagClear( FLAG_CHALLENGE_ACTIVE )

	if ( currentChallengeLevel > 1 )
	{
		foreach ( entity door in file.arenaDoors )
			OpenDoor( door, null )
	}

	wait 1

	string rewardVoLine = file.rewardSuccessDialogueLines.getrandom()
	EmitSoundOnEntity( panel, rewardVoLine )
	//LoudSpeaker_PlaySingle( rewardVoLine )
	file.rewardSuccessDialogueLines.fastremovebyvalue( rewardVoLine )

	wait 1

	thread OpenBloodTTRewardsDoor( currentChallengeLevel )

	wait 3

	// used to send info to the client that the props are usable now
	foreach ( entity prop in file.allStoryProps )
	{
		foreach ( entity linkEnt in prop.GetLinkEntArray() )
			prop.UnlinkFromEnt( linkEnt )
	}

	file.lastCompletedChallenge++
	switch ( currentChallengeLevel )
	{
		case 0:
			file.panelDatas[ 1 ].panel.SetSkin( 0 )
			file.panelDatas[ 1 ].panel.SetUsePrompts( "#BLOOD_TT_PANEL_1_HINT", "#BLOOD_TT_PANEL_1_HINT" )
			file.panelDatas[ 2 ].panel.SetUsePrompts( "#BLOOD_TT_PANEL_2_DISABLED_HINT", "#BLOOD_TT_PANEL_2_DISABLED_HINT" )
			break

		case 1:
			file.panelDatas[ 2 ].panel.SetSkin( 0 )
			file.panelDatas[ 2 ].panel.SetUsePrompts( "#BLOOD_TT_PANEL_2_HINT", "#BLOOD_TT_PANEL_2_HINT" )
			break

		case 2:
			file.panelDatas[ 2 ].panel.SetSkin( 1 )
			file.panelDatas[ 2 ].panel.UnsetUsable()
			printt( "BLOODHOUND TT COMPLETE" )
			break
	}

	                    
		/*if( UpgradeCore_IsEnabled() )
		{
			if( currentChallengeLevel == 2 )
			{
				UpgradeCore_GrantXp_BloodHoundTTComplete( file.teamActivatingPanel )
			}
		}*/
       

}


void function OpenBloodTTRewardsDoor( int currentChallengeLevel )
{
	const float DOOR_MOVE_DURATION = 4.0

	if( BloodHountTT_IsSmarLootEnabled() )
	{
		PopulateBloodTTRewardsByLevel( currentChallengeLevel )
	}

	entity panel        = file.panelDatas[ currentChallengeLevel ].panel
	entity navSeparator = GetEntByScriptName( format( NAV_SEPARATOR_SCRIPTNAME + "%i", currentChallengeLevel ) )
	entity doorMover    = panel.GetLinkEnt()
	EmitSoundAtPosition( TEAM_ANY, doorMover.GetOrigin(), ARENA_DOOR_SFX, doorMover )
	doorMover.NonPhysicsMoveTo( doorMover.GetOrigin() + <0, 0, -86>, DOOR_MOVE_DURATION, 1.0, 1.0 )

	GradeFlagsClear( panel, eGradeFlags.IS_LOCKED )
	Signal( panel, SIGNAL_REWARD_DOOR_OPENING )

	wait DOOR_MOVE_DURATION

	ToggleNPCPathsForEntity( navSeparator, true )
	navSeparator.NotSolid()
}


void function MakePlayerHigherPriorityThreatToProwler( entity player )
{
	EndSignal( player, SIGNAL_PLAYER_LEFT_ARENA )
	EndSignal( player, "OnDeath" )
	EndSignal( player, "BleedOut_OnStartDying" )

	player.SetNPCPriorityOverride( 20 )

	OnThreadEnd(
		function() : ( player )
		{
			if ( IsAlive( player ) )
				player.ClearNPCPriorityOverride()
		}
	)

	WaitForever()
}


entity function GetMiddleHatch( array<int> spotlightIndexes )
{
	entity middleHatch

	switch ( spotlightIndexes.len() )
	{
		case 1:
		case 2:
			middleHatch = file.hatchDatas[ spotlightIndexes[0] ].hatchModel
			break

		case 3:
		case 4:
			middleHatch = file.hatchDatas[ spotlightIndexes[1] ].hatchModel
			break

		case 5:
			middleHatch = file.hatchDatas[ spotlightIndexes[2] ].hatchModel
			break
	}

	return middleHatch
}


const float SPOTLIGHT_FADE_IN_TIME = 0.4
const float SPOTLIGHT_FADE_OUT_TIME = 0.5


void function LightShow_CreateSpotLightFX( int spotlightIdx, bool playSound )
{
	BloodTTHatchData data = file.hatchDatas[ spotlightIdx ]

	Signal( data.hatchModel, SIGNAL_HATCH_SPOTLIGHT_ON )

	if ( playSound )
		EmitSoundOnEntity( data.hatchModel, SPOTLIGHT_ACTIVATE_SFX )

	data.hatchModel.SetSkin( 1 )
	//entity SpotLight = CreatePropDynamic( $"mdl/fx/prowler_hatch_tt_beam.rmdl", data.hatchModel.GetOrigin(), data.hatchModel.GetAngles() + <0,270,0> )
	//SpotLight.SetParent(data.hatchModel)

	WaitFrame()

	data.hatchModel.kv.intensity = 1
	//data.fxEnt = StartParticleEffectOnEntity_ReturnEntity( data.hatchModel, GetParticleSystemIndex( $"P_prowler_hatch_light" ), FX_PATTACH_POINT_FOLLOW, data.hatchModel.LookupAttachment( "FX_LIGHT" ) )
}


void function LightShow_TurnOffSpotlight( int spotlightIdx )
{
	BloodTTHatchData data = file.hatchDatas[ spotlightIdx ]

	EndSignal( data.hatchModel, SIGNAL_HATCH_SPOTLIGHT_ON )

	OnThreadEnd(
		function() : ( data )
		{
			data.hatchModel.SetSkin( 0 )
			data.hatchModel.kv.intensity = 0
		}
	)

	//EffectStop( data.fxEnt )
	PROTO_FadeModelIntensityOverTime( data.hatchModel, SPOTLIGHT_FADE_OUT_TIME, 1, 0 )
}


void function LightShowSequenceAndSpawnProwler( array<int> spotlightIndexes, array<int> endIndexes, int prowlerSkinIdx )
{
	// cycle through all the lights on the way to the ending spotlights...
	foreach ( int idx in spotlightIndexes )
	{
		thread LightShowIndividualLight( idx )

		WaitFrame()
		WaitFrame()
		WaitFrame()
		WaitFrame()
	}

	wait 0.5

	// create the ending spotlights which hold on for a bit...
	array<entity> endSpotlightFxEnts

	foreach ( int idx in endIndexes )
		thread LightShow_CreateSpotLightFX( idx, false )

	EmitSoundOnEntity( GetMiddleHatch( endIndexes ), SPOTLIGHT_ACTIVATE_SPECIAL_SFX )

	// open the hatches and create prowlers
	foreach ( int idx in endIndexes )
		thread SpawnProwlerAndAnimate( idx, prowlerSkinIdx )

	wait LIGHTSHOW_ENDING_BUFFER

	foreach ( int idx in endIndexes )
		thread LightShow_TurnOffSpotlight( idx )
}


void function LightShowIndividualLight( int idx )
{
	LightShow_CreateSpotLightFX( idx, true )

	WaitFrame()
	WaitFrame()
	WaitFrame()
	WaitFrame()
	WaitFrame()

	LightShow_TurnOffSpotlight( idx )
}


void function SpawnProwlerAndAnimate( int hatchIdx, int prowlerSkinIdx )
{
	BloodTTHatchData data = file.hatchDatas[ hatchIdx ]

	//spawn prowler
	entity prowler = CreateNPCFromAISettings( "npc_prowler", PROWLER_TEAM, data.ref.GetOrigin(), data.ref.GetAngles() )
	DispatchSpawn( prowler )
	//prowler.ai.npcType = eNPC.PROWLER

	prowler.SetSkin( prowlerSkinIdx )
	prowler.SetNPCFlag( NPC_NO_MOVING_PLATFORM_DEATH, true )
	prowler.SetAutoSquad()

	AddEntityCallback_OnKilled( prowler, OnProwlerKilled )

	int waveNum = file.lastCompletedChallenge == -1 ? 1 : file.lastCompletedChallenge + 2
	AddEntityCallback_OnKilled( prowler, void function ( entity npc, var damageInfo ) : ( waveNum )
	{
		entity player = DamageInfo_GetAttacker(damageInfo)
		//if ( IsValid( player ) && player.IsPlayer() )
			//PIN_PlayerItemDestruction( player, ITEM_DESTRUCTION_TYPES.PROWLER, { death_pos = npc.GetOrigin(), bloodhound_tt_wave = waveNum, } 
		
	} )

	file.aliveProwlers.append( prowler )

	EndSignal( prowler, "OnDeath" )

	//animate prowler out of hatch
	thread PlayAnim( prowler, "pr_bloodhoundTT_hatch_spawn", data.ref )
	thread PlayAnim( data.hatchModel, "prop_bloodhoundTT_hatch_spawn", data.ref )

	// give prowler knowledge of all player positions in the arena
	while( true )
	{
		UpdateEnemyMemoryWithinRadius( prowler, 3000 )

		wait 2
	}
}


void function OnProwlerKilled( entity prowler, var DamageInfo )
{
	entity arenaTrigger = GetEntByScriptName( ARENA_TRIGGER_SCRIPTNAME )
	file.prowlerDeaths++
	file.aliveProwlers.fastremovebyvalue( prowler )

	bool dropSmartLootDefault = false
	                           
		dropSmartLootDefault = true
       

	if ( GetCurrentPlaylistVarBool("blood_tt_drops_smart_loot", dropSmartLootDefault) )
	{
		//array<string> lootRewards = AI_Loot_SpawnReward( prowler, GetLootParams(), DamageInfo )
	}

	if ( file.prowlerDeaths < file.totalNumProwlers )
	{
		if ( file.prowlerDeaths == file.totalNumProwlers - 1 )
		{
			thread WaitAndRemindOneProwlerLeft( arenaTrigger )
		}
		return
	}

	string flagToSet
	if ( file.lastCompletedChallenge + 1 == 0 )
	{
		flagToSet = FLAG_PROWLER_CHALLENGE_COMPLETE_0
	}
	else if ( file.lastCompletedChallenge + 1 == 1 )
	{
		flagToSet = FLAG_PROWLER_CHALLENGE_COMPLETE_1
	}
	else if ( file.lastCompletedChallenge + 1 == 2 )
	{
		flagToSet = FLAG_PROWLER_CHALLENGE_COMPLETE_2

		// anyone in the arena is now considered to have completed the challenge.
		foreach ( entity ent in file.arenaTrigger.GetTouchingEntities() )
		{
			if ( !ent.IsPlayer() )
				continue

			int teamIdx = ent.GetTeam()

			if ( file.teamIdxsThatCompletedChallenge.contains( teamIdx ) )
				continue

			file.teamIdxsThatCompletedChallenge.append( teamIdx )
		}
	}

	FlagSet( flagToSet )
}

//bool function IsInRangeToSpawnLoot( vector npcPos, vector playerPos, AILootSpawnParams params )
//{
//	return true
//}

/*AILootSpawnParams function GetLootParams()
{
	AILootSpawnParams params

	params.playlistVarPrefix = "blood_tt"
	params.ammoDropEnabled = GetCurrentPlaylistVarBool( "blood_tt_ammo_lootdrop_enabled", true )
	params.ordnanceChance = GetCurrentPlaylistVarFloat( "blood_tt_ordnance_lootdrop_percent", 0.20 )
	params.helmetChance = GetCurrentPlaylistVarFloat( "blood_tt_helmet_lootdrop_percent", 0.10 )
	params.consumableChance = GetCurrentPlaylistVarFloat( "blood_tt_consumable_lootdrop_percent", 1.0 )
	params.epicConsumableChance = GetCurrentPlaylistVarFloat( "blood_tt_epic_consumable_lootdrop_percent", 0.1 )
	params.ammoRatio = GetCurrentPlaylistVarFloat( "blood_tt_lootdrop_ammoratio", 0.25 )
	params.attachmentDropChance = GetCurrentPlaylistVarFloat( "blood_tt_lootdrop_percent", 0.75 )
	//params.InRangeForLootFunc = IsInRangeToSpawnLoot
	//params.lootTrackers = file.lootTrackers

	return params
}*/

void function WaitAndRemindOneProwlerLeft( entity panel )
{
	const array<string> PROWLER_REMINDER_VO_LINES = ["diag_mp_bloodhound_btr_challengeProwlerOneLeft_01_3p", "diag_mp_bloodhound_btr_challengeProwlerOneLeft_02_3p", "diag_mp_bloodhound_btr_challengeProwlerOneLeft_03_3p"]

	if ( file.lastCompletedChallenge + 1 == 0 )
		FlagEnd( FLAG_PROWLER_CHALLENGE_COMPLETE_0 )
	else if ( file.lastCompletedChallenge + 1 == 1 )
		FlagEnd( FLAG_PROWLER_CHALLENGE_COMPLETE_1 )
	else if ( file.lastCompletedChallenge + 1 == 2 )
		FlagEnd( FLAG_PROWLER_CHALLENGE_COMPLETE_2 )

	wait 10.0

	foreach ( entity touchingEnt in file.arenaTrigger.GetTouchingEntities() )
	{
		if ( touchingEnt.IsPlayer() )
		{
			if ( IsAlive( touchingEnt ) )
			{
				//LoudSpeaker_PlaySingle( PROWLER_REMINDER_VO_LINES.getrandom() )
				EmitSoundOnEntity( panel, PROWLER_REMINDER_VO_LINES.getrandom() )
				return
			}
		}
	}
}
#endif // SERVER


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ##        #######  ##     ## ########   ######  ########  ########    ###    ##    ## ######## ########
//  ##       ##     ## ##     ## ##     ## ##    ## ##     ## ##         ## ##   ##   ##  ##       ##     ##
//  ##       ##     ## ##     ## ##     ## ##       ##     ## ##        ##   ##  ##  ##   ##       ##     ##
//  ##       ##     ## ##     ## ##     ##  ######  ########  ######   ##     ## #####    ######   ########
//  ##       ##     ## ##     ## ##     ##       ## ##        ##       ######### ##  ##   ##       ##   ##
//  ##       ##     ## ##     ## ##     ## ##    ## ##        ##       ##     ## ##   ##  ##       ##    ##
//  ########  #######   #######  ########   ######  ##        ######## ##     ## ##    ## ######## ##     ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
void function Arena_OnEnter( entity trigger, entity player )
{
	if ( !IsValid( player ) || !player.IsPlayer() )
		return

	if ( !Flag( FLAG_PROWLER_CHALLENGE_INITIATED ) )
	{
		// if the challenges haven't been initiated yet...
		TryPlayFirstTimeEntranceDialogueForBloodhoundPlayer( player )
	}
	else if ( Flag( FLAG_PROWLER_CHALLENGE_INITIATED ) && !Flag( FLAG_PROWLER_CHALLENGE_COMPLETE_2 ) )
	{
		// if the first challenge started and the last one isn't finished...
		thread TryPlayAudioForPlayersEnteringMidChallenge( trigger, player )
	}
	else if ( Flag( FLAG_PROWLER_CHALLENGE_COMPLETE_2 ) )
	{
		// if the final challenge is complete...
		thread TryPlayAudioForPlayersEnteringPostChallenge( trigger, player )
	}

	Signal( player, SIGNAL_CANCEL_ARENA_REMINDER )
}


void function Arena_OnLeave( entity trigger, entity player )
{
	if ( !IsValid( player ) || !player.IsPlayer() )
		return

	Signal( player, SIGNAL_PLAYER_LEFT_ARENA )

	thread WaitForBufferThenAllowPlayerForReminder( player )
}


void function WaitForBufferThenAllowPlayerForReminder( entity player )
{
	Signal( player, SIGNAL_CANCEL_ARENA_REMINDER )

	EndSignal( player, "OnDeath" )
	EndSignal( player, SIGNAL_CANCEL_ARENA_REMINDER )

	if ( !file.playersLeftArenaDoNotRemind.contains( player ) )
		file.playersLeftArenaDoNotRemind.append( player )

	OnThreadEnd(
		function() : ( player )
		{
			if ( file.playersLeftArenaDoNotRemind.contains( player ) )
				file.playersLeftArenaDoNotRemind.fastremovebyvalue( player )
		}
	)

	wait 10
}


void function TryPlayFirstTimeEntranceDialogueForBloodhoundPlayer( entity player )
{
	// if you aren't bloodhound, or you are bloodhound and have entered before, then cancel
	if ( !IsPlayerBloodhound( player ) || file.bloodhoundPlayersThatHaveEnteredArena.contains( player ) )
		return

	// if the situation is 'urgent'/combat is nearby...
	#if CLIENT
	if ( PlayerDeliveryShouldBeUrgent( player, player.GetOrigin() ) )
		return
	#endif

	//PlayBattleChatterLineToSpeakerAndTeam( player, "diag_mp_bloodhound_bc_btrJoinAnnounce_1p" )
	//EmitSoundOnEntity( player, "diag_mp_bloodhound_bc_btrJoinAnnounce_3p" )
	file.bloodhoundPlayersThatHaveEnteredArena.append( player )
}

const float CHALLENGE_REMINDER_BUFFER = 30.0


void function TryPlayAudioForPlayersEnteringMidChallenge( entity trigger, entity player )
{
	// if there's already an enemy inside, cancel
	foreach ( entity ent in trigger.GetTouchingEntities() )
	{
		if ( ent != player )
		{
			if ( ent.GetTeam() != player.GetTeam() )
				return
		}
	}

	if ( Flag( FLAG_CHALLENGE_INCOMPLETE_REMINDER_ACTIVE ) )
		return

	if ( file.teamIdxsRemindedMidChallenge.contains( player.GetTeam() ) )
		return

	if ( file.playersLeftArenaDoNotRemind.contains( player ) )
		return

	FlagSet( FLAG_CHALLENGE_INCOMPLETE_REMINDER_ACTIVE )

	file.teamIdxsRemindedMidChallenge.append( player.GetTeam() )
	//LoudSpeaker_PlaySingle( "Blood_Announcer_EnteredMidChallenge" )
	EmitSoundOnEntity( trigger, "diag_mp_bloodhound_btr_joinedprogress_01_3p" )

	wait CHALLENGE_REMINDER_BUFFER

	FlagClear( FLAG_CHALLENGE_INCOMPLETE_REMINDER_ACTIVE )
}


void function TryPlayAudioForPlayersEnteringPostChallenge( entity trigger, entity player )
{
	// if you are on the team that finished the final challenge...
	if ( file.teamIdxsThatCompletedChallenge.contains( player.GetTeam() ) )
		return

	// if the team that completed the final challenge is inside and alive...
	foreach ( entity ent in trigger.GetTouchingEntities() )
	{
		if ( !IsAlive( ent ) )
			continue

		if ( file.teamIdxsThatCompletedChallenge.contains( ent.GetTeam() ) )
			return
	}

	if ( Flag( FLAG_CHALLENGE_COMPLETE_REMINDER_ACTIVE ) )
		return

	if ( file.teamIdxsRemindedPostChallenge.contains( player.GetTeam() ) )
		return

	FlagSet( FLAG_CHALLENGE_COMPLETE_REMINDER_ACTIVE )

	file.teamIdxsRemindedPostChallenge.append( player.GetTeam() )
	//LoudSpeaker_PlaySingle( "Blood_Announcer_EnteredPostChallenge" )
	EmitSoundOnEntity( trigger, "diag_mp_bloodhound_btr_joinedcleared_01_3p" )

	wait CHALLENGE_REMINDER_BUFFER

	FlagClear( FLAG_CHALLENGE_COMPLETE_REMINDER_ACTIVE )
}


void function LoudSpeaker_PlaySingle( string dialogueAlias, float delay = 0.0 )
{
	int dialogueFlags = eDialogueFlags.USE_CUSTOM_QUEUE | eDialogueFlags.USE_CUSTOM_SPEAKERS

	foreach ( entity player in GetPlayerArray() )
	{
		thread PlayDialogueForPlayer_Retail( dialogueAlias, player, null, delay, dialogueFlags, "", null, file.customDialogueQueue )
	}
}
#endif


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//   ######  ########  #######  ########  ##    ##       ########  ########   #######  ########   ######
//  ##    ##    ##    ##     ## ##     ##  ##  ##        ##     ## ##     ## ##     ## ##     ## ##    ##
//  ##          ##    ##     ## ##     ##   ####         ##     ## ##     ## ##     ## ##     ## ##
//   ######     ##    ##     ## ########     ##          ########  ########  ##     ## ########   ######
//        ##    ##    ##     ## ##   ##      ##          ##        ##   ##   ##     ## ##              ##
//  ##    ##    ##    ##     ## ##    ##     ##          ##        ##    ##  ##     ## ##        ##    ##
//   ######     ##     #######  ##     ##    ##          ##        ##     ##  #######  ##         ######
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER
void function SpawnStoryProps_Server( entity storyProp )
{
	storyProp.SetUsable()
	storyProp.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS )
	storyProp.SetForceVisibleInPhaseShift( true )

	AddCallback_OnUseEntity_ClientServer( storyProp, StoryPropOnActivate )
	//SetCallback_CanUseEntityCallback( storyProp, StoryPropOnActivate )

	file.allStoryProps.append( storyProp )
}
#endif // SERVER


#if CLIENT
void function OnCreate_PropDynamic( entity prop )
{
	string scriptName = prop.GetScriptName()
	if ( scriptName == STORY_PROP_HUNT_SCRIPTNAME || scriptName == STORY_PROP_TECH_SCRIPTNAME || scriptName == STORY_PROP_SPIRITUAL_SCRIPTNAME )
	{
		AddEntityCallback_GetUseEntOverrideText( prop, GetStoryPropHintText )
		AddCallback_OnUseEntity_ClientServer( prop, StoryPropOnActivate )
		//SetCallback_CanUseEntityCallback( prop, StoryPropOnActivate )

		file.allStoryProps.append( prop )
	}

	if ( scriptName == BLOOD_TT_PANEL_TIER_0_SCRIPTNAME || scriptName == BLOOD_TT_PANEL_TIER_1_SCRIPTNAME || scriptName == BLOOD_TT_PANEL_TIER_2_SCRIPTNAME )
	{
		RewardPanelData panelData	// Not filling in challenge index, irrelevant for the client for now
		panelData.panel = prop

		entity mover = panelData.panel.GetLinkEnt()
		Point startPoint
		startPoint.origin = mover.GetOrigin()
		startPoint.angles = mover.GetAngles()
		panelData.doorStartPoint = startPoint

		file.panelDatas.append( panelData )
	}
}

void function OnDestroy_PropDynamic( entity ent )
{
	// ents do not have Script names anymore at the time of this call
	// string scriptName = ent.GetScriptName()
	//if ( scriptName == STORY_PROP_HUNT_SCRIPTNAME || scriptName == STORY_PROP_TECH_SCRIPTNAME || scriptName == STORY_PROP_SPIRITUAL_SCRIPTNAME )

	int idx = file.allStoryProps.find( ent )
	if ( idx != -1 )
	{
		file.allStoryProps.remove( idx )
	}

	RewardPanelData ornull panelToRemove = null
	foreach ( panelData in file.panelDatas )
	{
		if ( panelData.panel == ent )
		{
			panelToRemove = panelData
			break
		}
	}

	if ( panelToRemove != null )
	{
		expect RewardPanelData( panelToRemove )
		file.panelDatas.fastremovebyvalue( panelToRemove )
	}
}
#endif // CLIENT


#if SERVER
void function SpawnTechPropHologram( entity techProp )
{
	techProp = CreatePropDynamic( GetAssetFromString( HOLOGRAM_BASE ), GetEntByScriptName( STORY_PROP_TECH_TARGET_SCRIPTNAME ).GetOrigin(), <0, 0, 0> )
	techProp.SetScriptName( STORY_PROP_TECH_SCRIPTNAME )
	int fxid = GetParticleSystemIndex( GetAssetFromString( HOLOGRAM_FX ) )

	entity effect = StartParticleEffectOnEntity_ReturnEntity( techProp, fxid, FX_PATTACH_POINT_FOLLOW, techProp.LookupAttachment( "FX_CENTER" ) )

	SpawnStoryProps_Server( techProp )
}


void function SpawnArenaTrigger( entity arenaTrigger )
{
	file.arenaTrigger = GetEntByScriptName( ARENA_TRIGGER_SCRIPTNAME )
	file.arenaTrigger.SetEnterCallback( Arena_OnEnter )
	file.arenaTrigger.SetLeaveCallback( Arena_OnLeave )
}


void function SpawnTierPanel( entity panel )
{
	RewardPanelData panelData
	panelData.panel = panel

	panelData.panel.AllowMantle()
	panelData.panel.SetForceVisibleInPhaseShift( true )
	panelData.panel.SetUsable()
	panelData.panel.AddUsableValue( USABLE_CUSTOM_HINTS | USABLE_BY_OWNER | USABLE_BY_PILOTS | USABLE_BY_ENEMIES )
	panelData.panel.SetUsablePriority( USABLE_PRIORITY_LOW )

	GradeFlagsSet( panelData.panel, eGradeFlags.IS_LOCKED )

	// set up the doors
	entity mover = panelData.panel.GetLinkEnt()

	// store the doors original position for black market logic
	Point startPoint
	startPoint.origin = mover.GetOrigin()
	startPoint.angles = mover.GetAngles()
	panelData.doorStartPoint = startPoint

	file.panelDatas.resize( 3 )

	string usePrompt
	string panelScriptName = panel.GetScriptName()
	if ( panelScriptName == BLOOD_TT_PANEL_TIER_0_SCRIPTNAME )
	{
		panelData.challengeIdx = 0
		usePrompt = "#BLOOD_TT_PANEL_0_HINT"
		panelData.panel.SetSkin( 0 )
		file.panelDatas[0] = panelData
	}
	else if ( panelScriptName == BLOOD_TT_PANEL_TIER_1_SCRIPTNAME )
	{
		panelData.challengeIdx = 1
		usePrompt = "#BLOOD_TT_PANEL_1_DISABLED_HINT"
		panelData.panel.SetSkin( 1 )
		file.panelDatas[1] = panelData
	}
	else if ( panelScriptName == BLOOD_TT_PANEL_TIER_2_SCRIPTNAME )
	{
		panelData.challengeIdx = 2
		usePrompt = "#BLOOD_TT_PANEL_1_DISABLED_HINT"
		panelData.panel.SetSkin( 1 )
		file.panelDatas[2] = panelData
	}

	panelData.panel.SetUsePrompts( usePrompt, usePrompt )
	AddCallback_OnUseEntity_ServerOnly( panelData.panel, CreateProwlerPanelFunc( panelData.panel ) )

	entity door
	entity doorTarget
	// Assert if the mover is not connected to 2 entities (door and doorTarget)
	Assert( mover.GetLinkEntArray().len() == 2, "BloodhoundTT - mover is not linked to a door or doorTarget" )
	foreach ( entity linkEnt in mover.GetLinkEntArray() )
	{
		if ( linkEnt.GetClassName() == "info_target" )
		{
			doorTarget = linkEnt
		}
		else if ( linkEnt.GetClassName() == "func_brush" )
		{
			door = linkEnt
		}
	}
	Assert( door != null, "Bloodhound TT - mover is not linked to a door" )
	Assert( doorTarget != null, "Bloodhound TT - mover is not linked to a doorTarget" )

	mover.AllowNPCGroundEnt( false )

	door.SetOrigin( door.GetOrigin() + (mover.GetOrigin() - doorTarget.GetOrigin()) )
	door.SetParent( mover )
	doorTarget.Destroy()
}
#endif


#if CLIENT
string function GetStoryPropHintText( entity prop )
{
	if ( IsPlayerBloodhound( GetLocalClientPlayer() ) )
	{
		if ( IsChallengeActive() )
			return "#BLOOD_TT_STORY_PROP_UNUSABLE_TRIAL"

		switch ( prop.GetScriptName() )
		{
			case STORY_PROP_HUNT_SCRIPTNAME:
				return "#BLOOD_TT_STORY_PROP_HUNT"
				break

			case STORY_PROP_TECH_SCRIPTNAME:
				return "#BLOOD_TT_STORY_PROP_TECH"
				break

			case STORY_PROP_SPIRITUAL_SCRIPTNAME:
				return "#BLOOD_TT_STORY_PROP_SPIRIT"
				break
		}
	}

	return "#BLOOD_TT_STORY_PROP_UNUSABLE"
}
#endif // CLIENT


#if SERVER || CLIENT
bool function StoryProp_CanUse( entity playerUser, entity storyProp, int useFlags )
{
	if ( Bleedout_IsBleedingOut( playerUser ) )
		return false

	if ( !IsPlayerBloodhound( playerUser ) )
		return true

	// hide prompt if player already activated the prop
	StoryPropUsabilityData data
	#if SERVER
		Assert( playerUser in file.playerStoryPropDatas, "player did not have bloodhound tt story prop data initialized." )

		data = file.playerStoryPropDatas[ playerUser ]
	#elseif CLIENT
		data = file.clientStoryPropData
	#endif

	if ( !data.propsUsable )
		return false

	return true
}
#endif // SERVER || CLIENT


#if SERVER || CLIENT
bool function IsPlayerBloodhound( entity player )
{
	ItemFlavor character = LoadoutSlot_GetItemFlavor( ToEHI( player ), Loadout_CharacterClass() )
	string characterRef  = ItemFlavor_GetHumanReadableRef( character ).tolower()

	if ( characterRef != "character_bloodhound" )
		return true

	return true
}
#endif


#if SERVER || CLIENT
void function StoryPropOnActivate( entity prop, entity player, int useInputFlags )
{
	if ( !IsPlayerBloodhound( player ) )
		return

	if ( IsChallengeActive() )
		return

	StoryPropUsabilityData data
	array<string> dialogueLines

	#if SERVER
		Assert( player in file.playerStoryPropDatas, "player did not have bloodhound tt story prop data initialized." )

		data = file.playerStoryPropDatas[ player ]
	#elseif CLIENT
		data = file.clientStoryPropData
	#endif

	string scriptName = prop.GetScriptName()

	if ( scriptName == STORY_PROP_HUNT_SCRIPTNAME )
	{
		dialogueLines = DIALOGUE_LINES_STORY_PROP_HUNT
	}
	else if ( scriptName == STORY_PROP_TECH_SCRIPTNAME )
	{
		dialogueLines = DIALOGUE_LINES_STORY_PROP_TECH
	}
	else if ( scriptName == STORY_PROP_SPIRITUAL_SCRIPTNAME )
	{
		dialogueLines = DIALOGUE_LINES_STORY_PROP_SPIRITUAL
	}

	thread MakeStoryPropUnusableWaitAndReset( data, scriptName, player )

	#if SERVER
		foreach ( string refName in dialogueLines )
			PlayBattleChatterLineToSpeakerAndTeamThatBlocksLowerPriorityLines( player, refName )
	#endif
}


void function MakeStoryPropUnusableWaitAndReset( StoryPropUsabilityData data, string scriptName, entity player )
{
	EndSignal( player, SIGNAL_STORY_PROP_DIALOGUE_ABORTED )

	data.propsUsable = false
	float duration

	if ( scriptName == STORY_PROP_HUNT_SCRIPTNAME )
	{
		duration = 12.5
	}
	else if ( scriptName == STORY_PROP_TECH_SCRIPTNAME )
	{
		duration = 12.5
	}
	else if ( scriptName == STORY_PROP_SPIRITUAL_SCRIPTNAME )
	{
		duration = 19.0
	}

	OnThreadEnd(
		function() : ( data )
		{
			data.propsUsable = true
		}
	)

	wait duration
}


bool function IsChallengeActive()
{
	#if SERVER
		return Flag( FLAG_CHALLENGE_ACTIVE )
	#else
		// Linking is a quick server -> client shortcut to determine the state of the bloodhound arena if a challenge is active
		if ( IsValid( file.allStoryProps[0] ) )
			if ( file.allStoryProps[0].GetLinkEntArray().len() > 0 )
				return true

		return false
	#endif
}
#endif // SERVER || CLIENT


#if CLIENT
void function OnAbortDialogue( string dialogueRefName )
{
	if ( !IsBloodhoundTTEnabled() )
		return

	entity player = GetLocalClientPlayer()

	array<string> storyPropRefNames = clone(DIALOGUE_LINES_STORY_PROP_HUNT)
	storyPropRefNames.extend( DIALOGUE_LINES_STORY_PROP_TECH )
	storyPropRefNames.extend( DIALOGUE_LINES_STORY_PROP_SPIRITUAL )

	if ( storyPropRefNames.contains( dialogueRefName ) )
	{
		Signal( player, SIGNAL_STORY_PROP_DIALOGUE_ABORTED )
		//Remote_ServerCallFunction( "ClientCallback_BloodTT_StoryPropDialogueAborted" )
	}
}
#endif


#if SERVER
void function ClientCallback_BloodTT_StoryPropDialogueAborted( entity player )
{
	Signal( player, SIGNAL_STORY_PROP_DIALOGUE_ABORTED )
}

bool function GetBloodhoundTTAssetsToPrecache( array< string > models, array< string > particles )
{
	if ( IsBloodhoundTTEnabled() == false )
		return false

	models.append( HOLOGRAM_BASE )
	models.append( PROWLER_MDL )

	particles.append( HOLOGRAM_FX )
	particles.append( SPOTLIGHT_FX )
	particles.append( REWARD_DOOR_ALARM_FX )
	particles.append( REWARD_ROOM_ALARM_FX )

	return true
}
#endif


// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ########  ##          ###     ######  ##    ##          ##     ##    ###    ########  ##    ## ######## ########
//  ##     ## ##         ## ##   ##    ## ##   ##           ###   ###   ## ##   ##     ## ##   ##  ##          ##
//  ##     ## ##        ##   ##  ##       ##  ##            #### ####  ##   ##  ##     ## ##  ##   ##          ##
//  ########  ##       ##     ## ##       #####             ## ### ## ##     ## ########  #####    ######      ##
//  ##     ## ##       ######### ##       ##  ##            ##     ## ######### ##   ##   ##  ##   ##          ##
//  ##     ## ##       ##     ## ##    ## ##   ##           ##     ## ##     ## ##    ##  ##   ##  ##          ##
//  ########  ######## ##     ##  ######  ##    ##          ##     ## ##     ## ##     ## ##    ## ########    ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


const vector BLOOD_TT_CHAMBER_MINS = <-108, -48, -16>
const vector BLOOD_TT_CHAMBER_MAXS = <0, 48, 88>

#if SERVER || CLIENT
entity function GetBloodTTRewardPanelForLoot( entity lootEnt )
{
	foreach ( RewardPanelData data in file.panelDatas )
	{
		if ( !IsValid( data.panel ) )
			continue

		vector localPos = WorldPosToLocalPos_NoEnt( lootEnt.GetOrigin(), data.doorStartPoint.origin, data.doorStartPoint.angles )
		if ( localPos.x > BLOOD_TT_CHAMBER_MINS.x && localPos.x < BLOOD_TT_CHAMBER_MAXS.x
		&& localPos.y > BLOOD_TT_CHAMBER_MINS.y && localPos.y < BLOOD_TT_CHAMBER_MAXS.y
		&& localPos.z > BLOOD_TT_CHAMBER_MINS.z && localPos.z < BLOOD_TT_CHAMBER_MAXS.z )
			return data.panel
	}

	return null
}
#endif // SERVER || CLIENT


#if SERVER || CLIENT
bool function IsBloodTTRewardPanelLocked( entity panel )
{
	return GradeFlagsHas( panel, eGradeFlags.IS_LOCKED )
}
#endif // SERVER || CLIENT

const vector RAVEN_EYE_LOCAL_OFFSET = <18.0, 15.0, 173.0>
const int RAVEN_EYE_COUNT = 2
const float ALARM_LENGTH = 14.0

#if SERVER
void function MaybeActivateBloodTTDefense_Thread( entity pickup, entity device, entity player )
{
	// todo(dw): make this function better

	entity lootedRewardPanel = GetBloodTTRewardPanelForLoot( pickup )
	if ( !IsValid( lootedRewardPanel ) || !IsBloodTTRewardPanelLocked( lootedRewardPanel ) )
		return

	EndSignal( lootedRewardPanel, SIGNAL_REWARD_DOOR_OPENING )

	Signal( lootedRewardPanel, SIGNAL_MAYBE_ACTIVATE_LOBA_DEFENSE )
	EndSignal( lootedRewardPanel, SIGNAL_MAYBE_ACTIVATE_LOBA_DEFENSE )

	if ( IsValid( device ) )
		GradeFlagsSet( device, eGradeFlags.IS_BUSY )

	WaitFrame()

	if ( IsValid( device ) )
	{
		device.TakeDamage( 9999, null, null, {} )

		vector explosionCenter           = device.GetOrigin()
		float damage                     = 2
		float damageHeavyArmor           = damage
		float innerRadius                = 100
		float outerRadius                = 120
		int flags                        = DF_EXPLOSION
		vector projectileLaunchPos       = explosionCenter//vaultPanel.GetOrigin()
		float explosionForce             = 110
		int scriptDamageFlags            = damageTypes.explosive
		int scriptDamageSourceIdentifier = eDamageSourceId.vault_defense
		string impactEffectTableName     = "superSpectre_groundSlam_impact"
		Explosion( explosionCenter, lootedRewardPanel, lootedRewardPanel, damage, damageHeavyArmor, innerRadius, outerRadius, flags, projectileLaunchPos, explosionForce, scriptDamageFlags, scriptDamageSourceIdentifier, impactEffectTableName )
	}

	if ( IsValid( player ) && IsAlive( player ) && !Bleedout_IsBleedingOut( player ) )
		thread MakeBlackMarketPlayerHighPriorityThreatToNPCs( player )

	BloodTTBlackMarketAlarmSequence()
}
#endif // SERVER


#if SERVER
void function BloodTTBlackMarketAlarmSequence()
{
	array<entity> fxEnts
	OnThreadEnd( void function() : ( fxEnts ) {
		foreach ( entity fxEnt in fxEnts )
		{
			if ( IsValid( fxEnt ) )
				fxEnt.Destroy()
		}

		foreach ( RewardPanelData data in file.panelDatas )
			StopSoundAtPosition( data.doorStartPoint.origin, REWARD_DOOR_SOUND )
	} )

	wait 0.2

	float startTime = Time()
	while ( Time() < startTime + ALARM_LENGTH )
	{
		foreach ( RewardPanelData data in file.panelDatas )
		{
			EmitSoundAtPosition( TEAM_ANY, data.doorStartPoint.origin, REWARD_DOOR_SOUND, data.panel )

			for ( int idx = 0; idx < RAVEN_EYE_COUNT; idx ++ )
			{
				vector localPos    = idx < 1 ? RAVEN_EYE_LOCAL_OFFSET : <RAVEN_EYE_LOCAL_OFFSET.x, RAVEN_EYE_LOCAL_OFFSET.y * -1, RAVEN_EYE_LOCAL_OFFSET.z>
				vector localAngles = idx < 1 ? <0, -90, 0> : <0, 90, 0>

				entity fxEnt = StartParticleEffectInWorld_ReturnEntity(
					GetParticleSystemIndex( GetAssetFromString( REWARD_DOOR_ALARM_FX ) ),
					LocalPosToWorldPos_NoEnt( localPos, data.doorStartPoint.origin, data.doorStartPoint.angles ), LocalAngToWorldAng_NoEnt( localAngles, data.doorStartPoint.angles ) )

				fxEnt.SetStopType( "destroyImmediately" )
				fxEnts.append( fxEnt )
			}
		}

		vector centerRoomOrg = <-25623, 24409, -2568>
		entity roomFxEnt     = StartParticleEffectInWorld_ReturnEntity( GetParticleSystemIndex( GetAssetFromString( REWARD_ROOM_ALARM_FX ) ), centerRoomOrg, <0, 0, 0> )
		roomFxEnt.SetStopType( "destroyImmediately" )
		fxEnts.append( roomFxEnt )

		wait 1.5

		foreach ( entity fxEnt in fxEnts )
			fxEnt.Destroy()

		wait 1.5

		fxEnts.clear()
	}
}
#endif


#if SERVER
void function MakeBlackMarketPlayerHighPriorityThreatToNPCs( entity player )
{
	Signal( player, SIGNAL_MAKE_LOOTING_PLAYER_HIGH_THREAT )

	EndSignal( player, "OnDeath" )
	EndSignal( player, "BleedOut_OnStartDying" )
	EndSignal( player, SIGNAL_MAKE_LOOTING_PLAYER_HIGH_THREAT )

	player.SetNPCPriorityOverride( 30 )

	OnThreadEnd(
		function() : ( player )
		{
			if ( IsAlive( player ) )
				player.ClearNPCPriorityOverride()
		}
	)

	wait ALARM_LENGTH + 6.0
}
#endif


#if SERVER && DEV
void function TestBlackMarketBloodTTAlarm()
{
	thread BloodTTBlackMarketAlarmSequence()
}
#endif
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
//
//  ##     ## ######## #### ##       #### ######## ##    ##
//  ##     ##    ##     ##  ##        ##     ##     ##  ##
//  ##     ##    ##     ##  ##        ##     ##      ####
//  ##     ##    ##     ##  ##        ##     ##       ##
//  ##     ##    ##     ##  ##        ##     ##       ##
//  ##     ##    ##     ##  ##        ##     ##       ##
//   #######     ##    #### ######## ####    ##       ##
//
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================
// =================================================================================================================================


#if SERVER && DEV
void function Bloodhound_TT_SpawnProwlers( int numProwlers )
{
	for ( int idx = 0; idx < numProwlers; idx++ )
		thread SpawnProwlerAndAnimate( idx, 0 )

	foreach ( entity prowler in file.aliveProwlers )
	{
		if ( IsAlive( prowler ) )
		{
			RemoveEntityCallback_OnKilled( prowler, OnProwlerKilled )
			AddEntityCallback_OnKilled( prowler, OnProwlerKilled_Dev )
		}
	}
}


void function OnProwlerKilled_Dev( entity prowler, var DamageInfo )
{
	file.aliveProwlers.fastremovebyvalue( prowler )
}


void function Bloodhound_TT_KillProwlers()
{
	array<entity> aliveProwlers = clone(file.aliveProwlers)

	foreach ( entity prowler in aliveProwlers )
	{
		if ( IsAlive( prowler ) )
			prowler.TakeDamage( 200, null, null, null )
	}
}


void function Bloodhound_TT_TestSpotlight( int lightIdx, float duration = 3.0 )
{
	thread Bloodhound_TT_TestSpotlight_Thread( lightIdx, duration )
}


void function Bloodhound_TT_TestSpotlight_Thread( int lightIdx, float duration = 3.0 )
{
	thread LightShow_CreateSpotLightFX( lightIdx, false )

	wait duration

	thread LightShow_TurnOffSpotlight( lightIdx )
}
#endif // SERVER && DEV

#if SERVER || CLIENT
bool function IsBloodhoundTTEnabled()
{
	return true
}

bool function BloodHountTT_IsSmarLootEnabled()
{
	return GetCurrentPlaylistVarBool( "bloodhound_tt_smartloot_enabled", false )
}

int function BloodHountTT_GetGearChanceDropRate()
{
	return GetCurrentPlaylistVarInt( "bloodhound_tt_smartloot_gear_drop_rate", 70 )
}

bool function BloodHountTT_UseLootPositionOverrideHack()
{
	bool usePositionHack

	usePositionHack = GetCurrentPlaylistVarBool( "blood_tt_loot_override_hack", true )

	return usePositionHack
}
#endif // SERVER || CLIENT