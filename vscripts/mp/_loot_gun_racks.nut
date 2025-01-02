global function GunRacks_Init
global function GunRacks_AddGunLootItem
global function GunRacks_AddLootItemToRack
global function GunRacks_SetRackOff
global function GunRacks_CreateAndSetupUpWeapon
#if DEVELOPER
global function DumpGunRackContent
#endif

global const string GUN_RACK_CLASS_NAME = "script_gun_rack"

const asset GUNRACK_MODEL = $"mdl/industrial/gun_rack_arm_down.rmdl"
const asset GUNRACK_MODEL_OFF = $"mdl/industrial/gun_rack_arm_down_new_off.rmdl"

struct
{
	array<entity> allGunRacks
	table<entity,entity> lootToRackTable

	string gunRackLootOverride
	bool onMovingGeo
} file

void function GunRacks_Init()
{
	if (MapName() != eMaps.mp_rr_desertlands_mu2 && MapName() != eMaps.mp_rr_desertlands_mu1_tt)
		return

	PrecacheModel( GUNRACK_MODEL )
	PrecacheModel( GUNRACK_MODEL_OFF )

	file.gunRackLootOverride = GetCurrentPlaylistVarString( "standard_rack_loot_group_override", "" )

	//AddSpawnCallbackEditorClass( "prop_dynamic", GUN_RACK_CLASS_NAME, OnGunRackSpawned )
	AddSpawnCallbackEditorClass( "prop_dynamic_lightweight", GUN_RACK_CLASS_NAME, OnGunRackSpawned )
	AddCallback_EntitiesDidLoad( OnEntitiesDidLoad )
	Loot_AddCallback_OnPlayerLootPickupRetail( GunRack_OnPlayerLootPickedUp )
}

void function OnEntitiesDidLoad()
{
	// Spawn Weapons on racks
	array<entity> gunRackArray = GetAllGunRacks()
	foreach( gunRack in gunRackArray )
	{
		file.onMovingGeo = false
		if ( gunRack.HasKey( "onMovingGeo" ) )
		{
			if ( gunRack.GetValueForKey( "onMovingGeo" ) == "1" )
				file.onMovingGeo = true
		}

		if ( !gunRack.HasKey( "loot_is_custom" ) || gunRack.GetValueForKey( "loot_is_custom" ) == "0" )
		{ // if loot_is_custom, you are responsible for spawning the gun racks loot and setting its model state
			string lootRef = ""
			if ( file.gunRackLootOverride != "" )
			{
				lootRef = SURVIVAL_GetWeightedItemFromGroup( file.gunRackLootOverride )
			}
			else if ( gunRack.HasKey( "loot_weapon" ) && gunRack.kv.loot_weapon != "" )
			{
				lootRef = string( gunRack.kv.loot_weapon ).tolower()
				Assert( SURVIVAL_Loot_IsRefValid( lootRef ), "loot_weapon points to a invalid loot ref (" + lootRef + ")" )
			}
			else if ( gunRack.HasKey( "loot_group" ) && gunRack.kv.loot_group != "" )
			{
				string lootGroup = string( gunRack.kv.loot_group ).tolower()
				//if ( !SURVIVAL_IsValidLootGroup( lootGroup ) )
					//continue
				lootRef = SURVIVAL_GetWeightedItemFromGroup( lootGroup )
				Assert( SURVIVAL_Loot_IsRefValid( lootRef ), "loot_group (" + lootGroup + ") generated an invalid loot ref (" + lootRef + ")" )
			}
			else
			{
				gunRack.SetModel( GUNRACK_MODEL_OFF )
				continue
			}

			if ( lootRef != "" )
			{
				if ( !SURVIVAL_Loot_IsRefValid( lootRef ) || SURVIVAL_Loot_GetLootDataByRef( lootRef ).lootType != eLootType.MAINWEAPON )
				{
					gunRack.SetModel( GUNRACK_MODEL_OFF )
					continue
				}

				entity lootEnt = GunRacks_CreateAndSetupUpWeapon( gunRack, lootRef )
				file.lootToRackTable[ lootEnt ] <- gunRack
			}
		}
	}
}

void function OnGunRackSpawned( entity gunRack )
{
	file.allGunRacks.append( gunRack )
}

void function GunRacks_SetRackOff( entity gunRack )
{
	gunRack.SetModel( GUNRACK_MODEL_OFF )
}

void function GunRacks_AddGunLootItem( entity gunRack, string lootRef )
{
	// note: no protection from weapons being spawned on top of each other!
	gunRack.SetModel( GUNRACK_MODEL )
	entity lootEnt = GunRacks_CreateAndSetupUpWeapon( gunRack, lootRef )
	file.lootToRackTable[ lootEnt ] <- gunRack
}

void function GunRacks_AddLootItemToRack( entity gunRack, entity lootEnt )
{
	gunRack.SetModel( GUNRACK_MODEL )
	file.lootToRackTable[ lootEnt ] <- gunRack
}

entity function GunRacks_CreateAndSetupUpWeapon( entity gunRack, string lootRef )
{
	vector rackAngles = gunRack.GetAngles()
	vector lootAngles = AnglesCompose( rackAngles, <-85, 180, 0> )
	if ( lootRef == "mp_weapon_bow" )
		lootAngles = AnglesCompose( lootAngles, <85, 0, 0> )

	vector lootOrigin = PositionOffsetFromEnt( gunRack, 2, 0, 47 )

	entity lootEnt = SpawnGenericLoot( lootRef, lootOrigin , lootAngles, 500 )

	if ( file.onMovingGeo )
	{
		TraceResults trace = TraceLineHighDetail( lootEnt.GetOrigin(), lootEnt.GetOrigin() - <0, 0, 88>, lootEnt, LOOT_TRACE, LOOT_COLLISION_GROUP )
		if ( IsValid( trace.hitEnt ) && trace.hitEnt.HasPusherAncestor() )
			lootEnt.SetParent( trace.hitEnt, "", true, 0 )
	}

	return lootEnt
}

array<entity> function GetAllGunRacks()
{
	return file.allGunRacks
}

void function GunRack_OnPlayerLootPickedUp( entity player, entity lootEnt, string ref, int unitsPickedUp, bool willDestroy, entity deathBox, int pickupFlags )
{
	//if ( lootEnt in file.lootToRackTable )
	{
		entity gunRack = file.lootToRackTable[ lootEnt ]
		gunRack.SetModel( GUNRACK_MODEL_OFF )
		delete file.lootToRackTable[ lootEnt ]
	}
}

#if DEVELOPER
void function DumpGunRackContent()
{
	foreach( loot, rack in file.lootToRackTable )
	{
		printt( loot.GetModelName(), rack.GetOrigin() )
	}
}

#endif