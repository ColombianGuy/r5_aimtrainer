untyped

global function InitDevMenu
global function DEV_InitLoadoutDevSubMenu
global function SetupDevCommand // for dev
global function SetupDevFunc // for dev
global function SetupDevMenu
global function RepeatLastDevCommand
global function UpdatePrecachedSPWeapons
global function ServerCallback_OpenDevMenu
global function RunCodeDevCommandByAlias
global function DEV_ExecBoundDevMenuCommand
global function DEV_InitCodeDevMenu
global function UpdateCheatsState
global function AddLevelDevCommand

const string DEV_MENU_NAME = "[LEVEL]"

struct DevMenuPage
{
	void functionref()      devMenuFunc
	void functionref( var ) devMenuFuncWithOpParm
	var                     devMenuOpParm
}

struct DevCommand
{
	string                  label
	string                  command
	var                     opParm
	void functionref( var ) func
	bool                    isAMenuCommand = false
}


struct
{
	array<DevMenuPage> pageHistory = []
	DevMenuPage &      currentPage
	var                header
	array<var>         buttons
	array<table>       actionBlocks
	array<DevCommand>  devCommands
	DevCommand&        lastDevCommand
	bool               lastDevCommandAssigned
	string             lastDevCommandLabel
	string             lastDevCommandLabelInProgress
	bool               precachedWeapons

	DevCommand& focusedCmd
	bool        focusedCmdIsAssigned

	DevCommand boundCmd
	bool       boundCmdIsAssigned

	var footerHelpTxtLabel

	bool                      initializingCodeDevMenu = false
	string                    codeDevMenuPrefix = DEV_MENU_NAME + "/"
	table<string, DevCommand> codeDevMenuCommands

	array<DevCommand> levelSpecificCommands = []
	bool cheatsState
} file

function Dummy_Untyped( param )
{

}

void function UpdateCheatsState(bool cheatsState)
{
	file.cheatsState = cheatsState
}

bool function GetCheatsState()
{
	return file.cheatsState
}


void function InitDevMenu( var newMenuArg )
{
		var menu = GetMenu( "DevMenu" )

		AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, OnOpenDevMenu )

		file.header = Hud_GetChild( menu, "MenuTitle" )
		file.buttons = GetElementsByClassname( menu, "DevButtonClass" )
		foreach ( button in file.buttons )
		{
			Hud_AddEventHandler( button, UIE_CLICK, OnDevButton_Activate )
			Hud_AddEventHandler( button, UIE_GET_FOCUS, OnDevButton_GetFocus )
			Hud_AddEventHandler( button, UIE_GET_FOCUS, OnDevButton_LoseFocus )

			RuiSetString( Hud_GetRui( button ), "buttonText", "" )
			Hud_SetEnabled( button, false )
		}

		AddMenuFooterOption( menu, LEFT, BUTTON_B, true, "%[B_BUTTON|]% Back", "Back" )
		AddMenuEventHandler( menu, eUIEvent.MENU_NAVIGATE_BACK, BackOnePage_Activate )
		AddMenuFooterOption( menu, LEFT, BUTTON_Y, true, "%[Y_BUTTON|]% Repeat Last Dev Command:", "Repeat Last Dev Command:", RepeatLastCommand_Activate )
		AddMenuFooterOption( menu, LEFT, BUTTON_BACK, true, "%[BACK|]% Bind Selection to Gamepad", "", BindCommandToGamepad_Activate )
		file.footerHelpTxtLabel = GetElementsByClassname( menu, "FooterHelpTxt" )[0]

		RegisterSignal( "DEV_InitCodeDevMenu" )
		AddUICallback_LevelLoadingFinished( DEV_InitCodeDevMenu )
		AddUICallback_LevelShutdown( ClearCodeDevMenu )
		//OnOpenDevMenu()
}


void function AddLevelDevCommand( string label, string command )
{
		string codeDevMenuAlias = DEV_MENU_NAME + "/" + label
		DevMenu_Alias_DEV( codeDevMenuAlias, command )

		DevCommand cmd
		cmd.label = label
		cmd.command = command
		file.levelSpecificCommands.append( cmd )
}

void function OnOpenDevMenu()
{
	file.pageHistory.clear()
	file.currentPage.devMenuFunc = null
	file.currentPage.devMenuFuncWithOpParm = null
	file.currentPage.devMenuOpParm = null
	file.lastDevCommandLabelInProgress = ""

	SetDevMenu_MP()

	//DelayedFocusFirstButton()
}


//void function DelayedFocusFirstButton()
//{
//	//Hud_SetFocused( file.buttons[0] )
//	//Hud_SetSelected( file.buttons[0], true )
//	//vector screenSize = <GetScreenSize().width, GetScreenSize().height, 0>
//	vector buttonPos = <Hud_GetAbsX( file.buttons[0] ), Hud_GetAbsY( file.buttons[1] ), 0>
//	buttonPos += 0.5 * <Hud_GetWidth( file.buttons[0] ), -1 * Hud_GetHeight( file.buttons[0] ), 0>
//	WarpMouseCursorDEV( <buttonPos.x, buttonPos.y, 0> )
//}


void function ServerCallback_OpenDevMenu()
{
	AdvanceMenu( GetMenu( "DevMenu" ) )
}


void function DEV_InitCodeDevMenu()
{
	thread DEV_InitCodeDevMenu_Internal()
}


void function DEV_InitCodeDevMenu_Internal()
{
	Signal( uiGlobal.signalDummy, "DEV_InitCodeDevMenu" )
	EndSignal( uiGlobal.signalDummy, "DEV_InitCodeDevMenu" )

	while ( !IsFullyConnected() || !IsItemFlavorRegistrationFinished() )
	{
		WaitFrame()
	}

	file.initializingCodeDevMenu = true
	DevMenu_Alias_DEV( DEV_MENU_NAME, "" )
	DevMenu_Rm_DEV( DEV_MENU_NAME )
	OnOpenDevMenu()
	file.initializingCodeDevMenu = false
}


void function ClearCodeDevMenu()
{
	DevMenu_Alias_DEV( DEV_MENU_NAME, "" )
	DevMenu_Rm_DEV( DEV_MENU_NAME )
}


void function UpdateDevMenuButtons()
{
	file.devCommands.clear()

	if ( file.initializingCodeDevMenu )
		return

	// Title:
	{
		string titleText = file.lastDevCommandLabelInProgress
		if ( titleText == "" )
			titleText = ("Developer Menu    -    " + GetActiveLevel())
		Hud_SetText( file.header, titleText )
	}

	if ( file.currentPage.devMenuOpParm != null )
		file.currentPage.devMenuFuncWithOpParm( file.currentPage.devMenuOpParm )
	else
		file.currentPage.devMenuFunc()

	foreach ( index, button in file.buttons )
	{
		int buttonID = int( Hud_GetScriptID( button ) )

		if ( buttonID < file.devCommands.len() )
		{
			RuiSetString( Hud_GetRui( button ), "buttonText", file.devCommands[buttonID].label )
			Hud_SetEnabled( button, true )
		}
		else
		{
			RuiSetString( Hud_GetRui( button ), "buttonText", "" )
			Hud_SetEnabled( button, false )
		}

		if ( buttonID == 0 )
			Hud_SetFocused( button )
	}

	RefreshRepeatLastDevCommandPrompts()
}

void function SetDevMenu_MP()
{
	if ( file.initializingCodeDevMenu )
	{
		SetupDefaultDevCommandsMP()
		return
	}
	PushPageHistory()
	file.currentPage.devMenuFunc = SetupDefaultDevCommandsMP
	UpdateDevMenuButtons()
}


void function ChangeToThisMenu( void functionref() menuFunc )
{
	if ( file.initializingCodeDevMenu )
	{
		menuFunc()
		return
	}
	PushPageHistory()
	file.currentPage.devMenuFunc = menuFunc
	file.currentPage.devMenuFuncWithOpParm = null
	file.currentPage.devMenuOpParm = null
	UpdateDevMenuButtons()
}


void function ChangeToThisMenu_WithOpParm( void functionref( var ) menuFuncWithOpParm, opParm = null )
{
	if ( file.initializingCodeDevMenu )
	{
		menuFuncWithOpParm( opParm )
		return
	}

	PushPageHistory()
	file.currentPage.devMenuFunc = null
	file.currentPage.devMenuFuncWithOpParm = menuFuncWithOpParm
	file.currentPage.devMenuOpParm = opParm
	UpdateDevMenuButtons()
}

const array<int> allowedWeaponChangeModes = [
	
	ePlaylists.fs_dm,
	ePlaylists.fs_1v1,
	ePlaylists.fs_lgduels_1v1,
	ePlaylists.fs_realistic_ttv
]

void function SetupDefaultDevCommandsMP()
{
	//Player is fully connected at this point, a check was made before
	RunClientScript("DEV_SendCheatsStateToUI")
	
	if( allowedWeaponChangeModes.contains( Playlist() ) )
	{
		SetupDevMenu( "FSDM: Change Primary weapon", SetDevMenu_TDMPrimaryWeapons )
		SetupDevMenu( "FSDM: Change Secondary weapon", SetDevMenu_TDMSecondaryWeapons )
		SetupDevCommand( "FSDM: Save Current Weapons", "saveguns" )
		SetupDevCommand( "FSDM: Reset Saved Weapons", "resetguns" )
	}

	if(GetCheatsState()){

		SetupDevMenu( "Equip Legend Abilities", SetDevMenu_Abilities )
		SetupDevMenu( "Equip Weapons", SetDevMenu_Weapons )
		SetupDevMenu( "Equip Titanfall Weapons", SetDevMenu_R2Weapons )
		SetupDevMenu( "Equip Throwables", SetDevMenu_Throwables )

		SetupDevMenu( "Custom: Weapons (All)", SetDevMenu_SurvivalLoot, "weapon_custom" )
		SetupDevMenu( "Custom: Attachments", SetDevMenu_SurvivalLoot, "attachment_custom" )
		SetupDevMenu( "Custom: Player Models", SetDevMenu_CustomPRModel )
		
		if ( IsSurvivalMenuEnabled() )
		{
			SetupDevMenu( "Change Character", SetDevMenu_SurvivalCharacter )
			SetupDevMenu( "Survival", SetDevMenu_Survival )
			SetupDevMenu( "Survival: Weapons", SetDevMenu_SurvivalLoot, "main_weapon" )
			SetupDevMenu( "Survival: Attachments", SetDevMenu_SurvivalLoot, "attachment" )
			SetupDevMenu( "Survival: Helmets", SetDevMenu_SurvivalLoot, "helmet" )
			SetupDevMenu( "Survival: Armors", SetDevMenu_SurvivalLoot, "armor" )
			SetupDevMenu( "Survival: Backpacks", SetDevMenu_SurvivalLoot, "backpack" )
			SetupDevMenu( "Survival: Incap Shields", SetDevMenu_SurvivalLoot, "incapshield" )
			string itemsString = "ordnance ammo health custom_pickup data_knife"
			SetupDevMenu( "Survival: Consumables", SetDevMenu_SurvivalLoot, itemsString )
		}

		SetupDevMenu( "Respawn Player(s)", SetDevMenu_RespawnPlayers )
		SetupDevCommand( "Recharge Abilities", "recharge" )
		
		SetupDevMenu( "Spawn NPC at Crosshair [Friendly]", SetDevMenu_AISpawnFriendly )
		SetupDevMenu( "Spawn NPC at Crosshair [Enemy]", SetDevMenu_AISpawnEnemy )
		
		SetupDevCommand( "Toggle NoClip", "noclip" )
		SetupDevCommand( "Toggle Skybox View", "script thread ToggleSkyboxView()" )
		SetupDevCommand( "Toggle HUD", "ToggleHUD" )
		SetupDevCommand( "Start Skydive", "script thread SkydiveTest()" )
		SetupDevCommand( "Spawn Deathbox", "SpawnDeathboxAtCrosshair" )

		SetupDevCommand( "Summon Players to player 0", "script summonplayers()" )

		SetupDevCommand( "Enable God Mode", "script EnableDemigod( gp()[0] )" )
		SetupDevCommand( "Disable God Mode", "script DisableDemigod( gp()[0] )" )
		SetupDevCommand( "Toggle Third Person Mode", "ToggleThirdPerson" )

		SetupDevMenu( "Prototypes", SetDevMenu_Prototypes )
	}
	else
	{
		SetupDevCommand( "Cheats are disabled! Type 'sv_cheats 1' in console to enable dev menu if you're the server admin.", "empty" )
	}
}


void function SetDevMenu_LevelCommands( var _ )
{
	ChangeToThisMenu( SetupLevelDevCommands )
}


void function SetupLevelDevCommands()
{
	string activeLevel = GetActiveLevel()
	if ( activeLevel == "" )
		return

	switch ( activeLevel )
	{
		case "model_viewer":
			SetupDevCommand( "Toggle Rebreather Masks", "script ToggleRebreatherMasks()" )
			break
	}
}

void function SetDevMenu_Abilities( var _ )
{
	thread ChangeToThisMenu( SetupAbilities )
}

void function SetDevMenu_Weapons( var _ )
{
	thread ChangeToThisMenu( SetupWeapons )
}
void function SetDevMenu_R2Weapons( var _ )
{
	thread ChangeToThisMenu( SetupTitanfallWeapons )
}
void function SetDevMenu_Throwables( var _ )
{
	thread ChangeToThisMenu( SetupThrowables )
}
void function SetDevMenu_TDMPrimaryWeapons( var _ )
{
	thread ChangeToThisMenu( SetupTDMPrimaryWeapons )
}
void function SetDevMenu_TDMSecondaryWeapons( var _ )
{
	thread ChangeToThisMenu( SetupTDMSecondaryWeapons )
}
void function SetDevMenu_SurvivalCharacter( var _ )
{
	thread ChangeToThisMenu( SetupChangeSurvivalCharacterClass )
}
void function SetDevMenu_AISpawnFriendly( var _ )
{
	thread ChangeToThisMenu( SetupFriendlyNPC )
}
void function SetDevMenu_AISpawnEnemy( var _ )
{
	thread ChangeToThisMenu( SetupEnemyNPC )
}
void function SetDevMenu_Editor( var _ )
{
	thread ChangeToThisMenu( SetupEditor )
}
void function SetDevMenu_CustomPRModel( var _ )
{
	thread ChangeToThisMenu( SetupChangeCharacterModel )
}
void function DEV_InitLoadoutDevSubMenu()
{
	file.initializingCodeDevMenu = true
	string codeDevMenuPrefix = file.codeDevMenuPrefix
	//file.codeDevMenuPrefix = "Alter Loadout"
	//DevMenu_Alias_DEV( file.codeDevMenuPrefix, "" )
	//DevMenu_Rm_DEV( file.codeDevMenuPrefix )
	//file.codeDevMenuPrefix += "/"
	file.codeDevMenuPrefix += "Alter Loadout/"
	DevMenu_Rm_DEV( file.codeDevMenuPrefix + "(Click to load this menu..)" )
	thread ChangeToThisMenu( SetupAlterLoadout )
	file.codeDevMenuPrefix = codeDevMenuPrefix
	file.initializingCodeDevMenu = false
}


void function SetDevMenu_AlterLoadout( var _ )
{
	if ( file.initializingCodeDevMenu )
	{
		//return
		DevMenu_Alias_DEV( file.codeDevMenuPrefix + "(Click to load this menu..)", "script_ui DEV_InitLoadoutDevSubMenu()" )
	}
	else
	{
		thread ChangeToThisMenu( SetupAlterLoadout )
	}
}


void function SetupAlterLoadout()
{
	array<string> categories = []
	foreach( LoadoutEntry entry in GetAllLoadoutSlots() )
	{
		if ( !categories.contains( entry.DEV_category ) )
			categories.append( entry.DEV_category )
	}
	categories.sort()
	foreach( string category in categories )
	{
		SetupDevMenu( category, void function( var unused ) : ( category ) {
			thread ChangeToThisMenu( void function() : ( category ) {
				SetupAlterLoadout_CategoryScreen( category )
			} )
		} )
	}
}


void function SetupAlterLoadout_CategoryScreen( string category )
{
	array<LoadoutEntry> entries = clone GetAllLoadoutSlots()
	entries.sort( int function( LoadoutEntry a, LoadoutEntry b ) {
		if ( a.DEV_name < b.DEV_name )
			return -1
		if ( a.DEV_name > b.DEV_name )
			return 1
		return 0
	} )

	array<string> charactersUsed = []

	foreach( LoadoutEntry entry in  entries)
	{
		if ( entry.DEV_category != category )
			continue

		string prefix = "character_"

		if ( entry.DEV_name.find( prefix ) == 0 )
		{
			string character = GetCharacterNameFromDEV_name( entry.DEV_name )

			if ( !charactersUsed.contains( character ) )
			{
				charactersUsed.append( character )
				SetupDevMenu( character, void function( var unused ) : ( category, character ) {
					thread ChangeToThisMenu( void function() : ( category, character ) {
						SetupAlterLoadout_CategoryScreenForCharacter( category, character )
					} )
				} )
			}
		}
		else
		{
			SetupDevMenu( entry.DEV_name, void function( var unused ) : ( entry ) {
				thread ChangeToThisMenu( void function() : ( entry ) {
					SetupAlterLoadout_SlotScreen( entry )
				} )
			} )
		}
	}
}

void function SetupAlterLoadout_CategoryScreenForCharacter( string category, string character )
{
	array<LoadoutEntry> entries = clone GetAllLoadoutSlots()
	entries.sort( int function( LoadoutEntry a, LoadoutEntry b ) {
		if ( a.DEV_name < b.DEV_name )
			return -1
		if ( a.DEV_name > b.DEV_name )
			return 1
		return 0
	} )

	array< LoadoutEntry > entriesToUse

	foreach( LoadoutEntry entry in entries )
	{
		if ( entry.DEV_category != category )
			continue

		string entryCharacter = GetCharacterNameFromDEV_name( entry.DEV_name )

		if ( entryCharacter != character )
			continue

		entriesToUse.append( entry )
	}


	if ( entriesToUse.len() > 1 )
	{
		foreach ( LoadoutEntry entry in entriesToUse )
		{
			SetupDevMenu( entry.DEV_name, void function( var unused ) : ( entry ) {
				thread ChangeToThisMenu( void function() : ( entry ) {
					SetupAlterLoadout_SlotScreen( entry )
				} )
			} )
		}
	}
	else if ( entriesToUse.len() == 1 )
	{
		LoadoutEntry entry = entriesToUse[ 0 ]
		SetupAlterLoadout_SlotScreen( entry )
	}
}

string function GetCharacterNameFromDEV_name( string DEV_name )
{
	string prefix = "character_"
	return split( DEV_name.slice( prefix.len() ), " " )[ 0 ]
}

void function SetupAlterLoadout_SlotScreen( LoadoutEntry entry )
{
	// todo(dw): 368482
	//if ( entry.canBeEmpty )
	//{
	//	SetupDevFunc( "(empty)", void function( var unused ) : ( entry ) {
	//		DEV_RequestSetItemFlavorLoadoutSlot( LocalClientEHI(), entry, null )
	//	} )
	//}

	array<ItemFlavor> flavors = clone DEV_GetValidItemFlavorsForLoadoutSlotForDev( LocalClientEHI(), entry )
	flavors.sort( int function( ItemFlavor a, ItemFlavor b ) {
		if ( Localize( ItemFlavor_GetLongName( a ) ) < Localize( ItemFlavor_GetLongName( b ) ) )
			return -1
		if ( Localize( ItemFlavor_GetLongName( a ) ) > Localize( ItemFlavor_GetLongName( b ) ) )
			return 1
		return 0
	} )

	foreach( ItemFlavor flav in flavors )
	{
		SetupDevFunc( Localize( ItemFlavor_GetLongName( flav ) ), void function( var unused ) : ( entry, flav ) {
			DEV_RequestSetItemFlavorLoadoutSlot( LocalClientEHI(), entry, flav )
		} )
	}
}


void function SetDevMenu_OverrideSpawnSurvivalCharacter( var _ )
{
	thread ChangeToThisMenu( SetupOverrideSpawnSurvivalCharacter )
}


void function SetDevMenu_Survival( var _ )
{
	thread ChangeToThisMenu( SetupSurvival )
}


void function SetDevMenu_SurvivalLoot( var categories )
{
	thread ChangeToThisMenu_WithOpParm( SetupSurvivalLoot, categories )
}


void function SetDevMenu_SurvivalIncapShieldBots( var _ )
{
	thread ChangeToThisMenu( SetupSurvivalIncapShieldBot )
}



void function ChangeToThisMenu_PrecacheWeapons( void functionref() menuFunc )
{
	if ( file.initializingCodeDevMenu )
	{
		menuFunc()
		return
	}

	waitthread PrecacheWeaponsIfNecessary()

	PushPageHistory()
	file.currentPage.devMenuFunc = menuFunc
	file.currentPage.devMenuFuncWithOpParm = null
	file.currentPage.devMenuOpParm = null
	UpdateDevMenuButtons()
}


void function ChangeToThisMenu_PrecacheWeapons_WithOpParm( void functionref( var ) menuFuncWithOpParm, opParm = null )
{
	if ( file.initializingCodeDevMenu )
	{
		menuFuncWithOpParm( opParm )
		return
	}

	waitthread PrecacheWeaponsIfNecessary()

	PushPageHistory()
	file.currentPage.devMenuFunc = null
	file.currentPage.devMenuFuncWithOpParm = menuFuncWithOpParm
	file.currentPage.devMenuOpParm = opParm
	UpdateDevMenuButtons()
}


void function PrecacheWeaponsIfNecessary()
{
	if ( file.precachedWeapons )
		return

	file.precachedWeapons = true
	CloseAllMenus()

	DisablePrecacheErrors()
	wait 0.1
	ClientCommand( "script PrecacheSPWeapons()" )
	wait 0.1
	ClientCommand( "script_client PrecacheSPWeapons()" )
	wait 0.1
	RestorePrecacheErrors()

	AdvanceMenu( GetMenu( "DevMenu" ) )
}


void function UpdatePrecachedSPWeapons()
{
	file.precachedWeapons = true
}

void function SetDevMenu_RespawnPlayers( var _ )
{
	ChangeToThisMenu( SetupRespawnPlayersDevMenu )
}


void function SetupRespawnPlayersDevMenu()
{
	SetupDevCommand( "Respawn me", "respawn" )
	SetupDevCommand( "Respawn all players", "respawn all" )
	SetupDevCommand( "Respawn all dead players", "respawn alldead" )
	SetupDevCommand( "Respawn random player", "respawn random" )
	SetupDevCommand( "Respawn random dead player", "respawn randomdead" )
	SetupDevCommand( "Respawn bots", "respawn bots" )
	SetupDevCommand( "Respawn dead bots", "respawn deadbots" )
	SetupDevCommand( "Respawn my teammates", "respawn allies" )
	SetupDevCommand( "Respawn my enemies", "respawn enemies" )
}

void function SetupTDMPrimaryWeapons()
{
	//Assault Rifles
	SetupDevCommand( "R-301", "tgive p mp_weapon_rspn101 optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Flatline", "tgive p mp_weapon_vinson optic_cq_hcog_bruiser stock_tactical_l3 highcal_mag_l3")
	SetupDevCommand( "Hemlok", "tgive p mp_weapon_hemlok optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 highcal_mag_l3" )
	SetupDevCommand( "Havoc", "tgive p mp_weapon_energy_ar optic_cq_hcog_bruiser stock_tactical_l3 energy_mag_l1 hopup_turbocharger" )
	//LMGs
	SetupDevCommand( "Spitfire", "tgive p mp_weapon_lmg optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 highcal_mag_l2" )
	SetupDevCommand( "Devotion", "tgive p mp_weapon_esaw optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 energy_mag_l1 hopup_turbocharger" )
	SetupDevCommand( "L-STAR EMG", "tgive p mp_weapon_lstar energy_mag_l3 optic_cq_hcog_bruiser" )
	//SMGs
	SetupDevCommand( "R-99 SMG", "tgive p mp_weapon_r97 optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Alternator SMG", "tgive p mp_weapon_alternator_smg optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Prowler Burst SMG", "tgive p mp_weapon_pdw optic_cq_hcog_classic stock_tactical_l3 highcal_mag_l3" )
	SetupDevCommand( "Volt SMG", "tgive p mp_weapon_volt_smg optic_cq_hcog_classic barrel_stabilizer_l3 stock_tactical_l3 energy_mag_l3" )
	// SetupDevCommand( "CAR SMG", "tgive p mp_weapon_car optic_cq_hcog_classic barrel_stabilizer_l3 stock_tactical_l3 bullets_mag_l3" )
	//Marksman Weapons
	SetupDevCommand( "G7 Scout", "tgive p mp_weapon_g2 optic_ranged_hcog stock_sniper_l3 barrel_stabilizer_l3 bullets_mag_l3 hopup_double_tap" )
	SetupDevCommand( "Triple Take", "tgive p mp_weapon_doubletake energy_mag_l3 optic_ranged_hcog stock_sniper_l3 hopup_energy_choke" )
	//Pistols
	SetupDevCommand( "RE-45", "tgive p mp_weapon_autopistol optic_cq_hcog_classic barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "P2020", "tgive p mp_weapon_semipistol optic_cq_hcog_classic bullets_mag_l3 hopup_unshielded_dmg" )
	SetupDevCommand( "Wingman", "tgive p mp_weapon_wingman optic_cq_hcog_classic sniper_mag_l3" )
	//Shotguns
	SetupDevCommand( "EVA-8", "tgive p mp_weapon_shotgun shotgun_bolt_l3 optic_cq_threat hopup_double_tap" )
	SetupDevCommand( "Mozambique", "tgive p mp_weapon_shotgun_pistol shotgun_bolt_l3 optic_cq_threat hopup_unshielded_dmg" )
	SetupDevCommand( "Peacekeeper", "tgive p mp_weapon_energy_shotgun shotgun_bolt_l3 optic_cq_threat hopup_energy_choke" )
	SetupDevCommand( "Mastiff","tgive p mp_weapon_mastiff shotgun_bolt_l3")
	//Sniper Rifles
	SetupDevCommand( "Longbow", "tgive p mp_weapon_dmr optic_sniper_variable barrel_stabilizer_l3 stock_sniper_l3 sniper_mag_l3" )
	SetupDevCommand( "Charge Rifle", "tgive p mp_weapon_defender optic_sniper_threat stock_sniper_l3" )
	//SetupDevCommand( "Kraber", "tgive p mp_weapon_sniper" )
}

void function SetupTDMSecondaryWeapons()
{
	//Assault Rifles
	SetupDevCommand( "R-301", "tgive s mp_weapon_rspn101 optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Flatline", "tgive s mp_weapon_vinson optic_cq_hcog_bruiser stock_tactical_l3 highcal_mag_l3")
	SetupDevCommand( "Hemlok", "tgive s mp_weapon_hemlok optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 highcal_mag_l3" )
	SetupDevCommand( "Havoc", "tgive s mp_weapon_energy_ar optic_cq_hcog_bruiser stock_tactical_l3 energy_mag_l1 hopup_turbocharger" )
	//LMGs
	SetupDevCommand( "Spitfire", "tgive s mp_weapon_lmg optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 highcal_mag_l2" )
	SetupDevCommand( "Devotion", "tgive s mp_weapon_esaw optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 energy_mag_l1 hopup_turbocharger" )
	SetupDevCommand( "L-STAR EMG", "tgive s mp_weapon_lstar energy_mag_l3 optic_cq_hcog_bruiser" )
	//SMGs
	SetupDevCommand( "R-99 SMG", "tgive s mp_weapon_r97 optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Alternator SMG", "tgive s mp_weapon_alternator_smg optic_cq_hcog_bruiser stock_tactical_l3 barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "Prowler Burst SMG", "tgive s mp_weapon_pdw optic_cq_hcog_classic stock_tactical_l3 highcal_mag_l3" )
	SetupDevCommand( "Volt SMG", "tgive s mp_weapon_volt_smg optic_cq_hcog_classic barrel_stabilizer_l3 stock_tactical_l3 energy_mag_l3" )
	// SetupDevCommand( "CAR SMG", "tgive s mp_weapon_car optic_cq_hcog_classic barrel_stabilizer_l3 stock_tactical_l3 bullets_mag_l3" )
	//Marksman Weapons
	SetupDevCommand( "G7 Scout", "tgive s mp_weapon_g2 optic_ranged_hcog stock_sniper_l3 barrel_stabilizer_l3 bullets_mag_l3 hopup_double_tap" )
	SetupDevCommand( "Triple Take", "tgive s mp_weapon_doubletake energy_mag_l3 optic_ranged_hcog stock_sniper_l3 hopup_energy_choke" )
	//Pistols
	SetupDevCommand( "RE-45", "tgive s mp_weapon_autopistol optic_cq_hcog_classic barrel_stabilizer_l3 bullets_mag_l3" )
	SetupDevCommand( "P2020", "tgive s mp_weapon_semipistol optic_cq_hcog_classic bullets_mag_l3 hopup_unshielded_dmg" )
	SetupDevCommand( "Wingman", "tgive s mp_weapon_wingman optic_cq_hcog_classic sniper_mag_l3" )
	//Shotguns
	SetupDevCommand( "EVA-8", "tgive s mp_weapon_shotgun shotgun_bolt_l3 optic_cq_threat hopup_double_tap" )
	SetupDevCommand( "Mozambique", "tgive s mp_weapon_shotgun_pistol shotgun_bolt_l3 optic_cq_threat hopup_unshielded_dmg" )
	SetupDevCommand( "Peacekeeper", "tgive s mp_weapon_energy_shotgun shotgun_bolt_l3 optic_cq_threat hopup_energy_choke" )
	SetupDevCommand( "Mastiff","tgive s mp_weapon_mastiff shotgun_bolt_l3")
	//Sniper Rifles
	SetupDevCommand( "Longbow", "tgive s mp_weapon_dmr optic_sniper_variable barrel_stabilizer_l3 stock_sniper_l3 highcal_mag_l3" )
	SetupDevCommand( "Charge Rifle", "tgive s mp_weapon_defender optic_sniper_threat stock_sniper_l3" )
	//SetupDevCommand( "Kraber", "tgive s mp_weapon_sniper" )
}

void function SetDevMenu_RespawnOverride( var _ )
{
	ChangeToThisMenu( SetupRespawnOverrideDevMenu )
}


void function SetupRespawnOverrideDevMenu()
{
	SetupDevCommand( "Use gamemode behaviour", "set_respawn_override off" )
	SetupDevCommand( "Override: Allow all respawning", "set_respawn_override allow" )
	SetupDevCommand( "Override: Deny all respawning", "set_respawn_override deny" )
	SetupDevCommand( "Override: Allow bot respawning", "set_respawn_override allowbots" )
}


void function SetDevMenu_ThreatTracker( var _ )
{
	ChangeToThisMenu( SetupThreatTrackerDevMenu )
}


void function SetupThreatTrackerDevMenu()
{
	SetupDevCommand( "Reload Threat Data", "fs_report_sync_opens 0; script ReloadScripts(); script ThreatTracker_ReloadThreatData()" )
	SetupDevCommand( "Threat Tracking ON", "script ThreatTracker_SetActive( true )" )
	SetupDevCommand( "Threat Tracking OFF", "script ThreatTracker_SetActive( false )" )
	SetupDevCommand( "Overhead Debug ON", "script ThreatTracker_DrawDebugOverheadText( true )" )
	SetupDevCommand( "Overhead Debug OFF", "script ThreatTracker_DrawDebugOverheadText( false )" )
	SetupDevCommand( "Console Debug Level 0", "script ThreatTracker_SetDebugLevel( 0 )" )
	SetupDevCommand( "Console Debug Level 1", "script ThreatTracker_SetDebugLevel( 1 )" )
	SetupDevCommand( "Console Debug Level 2", "script ThreatTracker_SetDebugLevel( 2 )" )
	SetupDevCommand( "Console Debug Level 3", "script ThreatTracker_SetDebugLevel( 3 )" )
}


void function SetDevMenu_HighVisNPCTest( var _ )
{
	ChangeToThisMenu( SetupHighVisNPCTest )
}


void function SetupHighVisNPCTest()
{
	SetupDevCommand( "Spawn at Crosshair", "script PROTO_SpawnHighVisNPCs()" )
	SetupDevCommand( "Delete Test NPCs", "script PROTO_DeleteHighVisNPCs()" )
	SetupDevCommand( "Use R5 Art Settings", "script PROTO_HighVisNPCs_SetTestEnv( \"r5\" )" )
	SetupDevCommand( "Use R2 Art Settings", "script PROTO_HighVisNPCs_SetTestEnv( \"r2\" )" )
}

void function SetDevMenu_Prototypes( var _ )
{
	thread ChangeToThisMenu( SetupPrototypesDevMenu )
}

void function SetupPrototypesDevMenu()
{
	SetupDevCommand( "Toggle Akimbo With Current Weapon", "script DEV_ToggleAkimboWeapon(gp()[0])" )
	SetupDevCommand( "Toggle Akimbo With Holstered Weapon", "script DEV_ToggleAkimboWeaponAlt(gp()[0])" )
	// SetupDevCommand( "Change to Shadow Squad", "script Dev_ShadowFormEnable( GP() )" )
}


void function RunCodeDevCommandByAlias( string alias )
{
	RunDevCommand( file.codeDevMenuCommands[alias], false )
}


void function SetupDevCommand( string label, string command )
{
	if ( command.slice( 0, 5 ) == "give " )
		command = "give_server " + command.slice( 5 )

	DevCommand cmd
	cmd.label = label
	cmd.command = command

	file.devCommands.append( cmd )
	if ( file.initializingCodeDevMenu )
	{
		string codeDevMenuAlias = file.codeDevMenuPrefix + label
		//string codeDevMenuCommand = format( "script_ui RunCodeDevCommandByAlias( \"%s\" )", codeDevMenuAlias )
		//file.codeDevMenuCommands[codeDevMenuAlias] <- cmd
		DevMenu_Alias_DEV( codeDevMenuAlias, command )
	}
}


void function SetupDevFunc( string label, void functionref( var ) func, var opParm = null )
{
	DevCommand cmd
	cmd.label = label
	cmd.func = func
	cmd.opParm = opParm

	file.devCommands.append( cmd )
	if ( file.initializingCodeDevMenu )
	{
		string codeDevMenuAlias   = file.codeDevMenuPrefix + label
		string codeDevMenuCommand = format( "script_ui RunCodeDevCommandByAlias( \"%s\" )", codeDevMenuAlias )
		file.codeDevMenuCommands[codeDevMenuAlias] <- cmd
		DevMenu_Alias_DEV( codeDevMenuAlias, codeDevMenuCommand )
	}
}


void function SetupDevMenu( string label, void functionref( var ) func, var opParm = null )
{
	DevCommand cmd
	cmd.label = (label + "  ->")
	cmd.func = func
	cmd.opParm = opParm
	cmd.isAMenuCommand = true

	file.devCommands.append( cmd )

	if ( file.initializingCodeDevMenu )
	{
		string codeDevMenuPrefix = file.codeDevMenuPrefix
		file.codeDevMenuPrefix += label + "/"
		cmd.func( cmd.opParm )
		file.codeDevMenuPrefix = codeDevMenuPrefix
	}
}


void function OnDevButton_Activate( var button )
{
	if ( level.ui.disableDev )
	{
		Warning( "Dev commands disabled on matchmaking servers." )
		return
	}

	int buttonID   = int( Hud_GetScriptID( button ) )
	DevCommand cmd = file.devCommands[buttonID]

	RunDevCommand( cmd, false )
}


void function OnDevButton_GetFocus( var button )
{
	file.focusedCmdIsAssigned = false

	int buttonID = int( Hud_GetScriptID( button ) )
	if ( buttonID >= file.devCommands.len() )
		return

	if ( file.devCommands[buttonID].isAMenuCommand )
		return

	file.focusedCmd = file.devCommands[buttonID]
	file.focusedCmdIsAssigned = true
}


void function OnDevButton_LoseFocus( var button )
{
}


void function RunDevCommand( DevCommand cmd, bool isARepeat )
{
	if ( !isARepeat )
	{
		if ( file.lastDevCommandLabelInProgress.len() > 0 )
			file.lastDevCommandLabelInProgress += "  "
		file.lastDevCommandLabelInProgress += cmd.label

		if ( !cmd.isAMenuCommand )
		{
			file.lastDevCommand = cmd
			file.lastDevCommandAssigned = true
			file.lastDevCommandLabel = file.lastDevCommandLabelInProgress
		}
	}

	if ( cmd.command != "" )
	{
		ClientCommand( cmd.command )
		if ( IsLobby() )
		{
			CloseAllMenus()
			AdvanceMenu( GetMenu( "R5RLobbyMenu" ) )
		}
		else
		{
			CloseAllMenus()
		}
	}
	else
	{
		cmd.func( cmd.opParm )
	}
}


void function RepeatLastDevCommand( var _ )
{
	if ( !file.lastDevCommandAssigned )
		return

	RunDevCommand( file.lastDevCommand, true )
}


void function RepeatLastCommand_Activate( var button )
{
	RepeatLastDevCommand( null )
}


void function PushPageHistory()
{
	DevMenuPage page = file.currentPage
	if ( page.devMenuFunc != null || page.devMenuFuncWithOpParm != null )
		file.pageHistory.push( clone page )
}


void function BackOnePage_Activate()
{
	if ( file.pageHistory.len() == 0 )
	{
		CloseActiveMenu( true )
		return
	}

	file.currentPage = file.pageHistory.pop()
	UpdateDevMenuButtons()
}


void function RefreshRepeatLastDevCommandPrompts()
{
	string newText = ""
	//if ( AreOnDefaultDevCommandMenu() )
	{
		if ( file.lastDevCommandAssigned )
			newText = file.lastDevCommandLabel    // file.lastDevCommand.label
		else
			newText = "<none>"
	}

	if ( AreOnDefaultDevCommandMenu() )
		file.lastDevCommandLabelInProgress = ""

	Hud_SetText( file.footerHelpTxtLabel, newText )
}


bool function AreOnDefaultDevCommandMenu()
{
	if ( file.currentPage.devMenuFunc == SetupDefaultDevCommandsMP )
		return true

	return false
}


void function BindCommandToGamepad_Activate( var button )
{
	if ( !BindCommandToGamepad_ShouldShow() )
		return

	// Binding:
	{
		string cmdText = "bind back \"script_ui DEV_ExecBoundDevMenuCommand()\""
		ClientCommand( cmdText )
	}

	file.boundCmd.command = file.focusedCmd.command
	file.boundCmd.isAMenuCommand = file.focusedCmd.isAMenuCommand
	file.boundCmd.label = file.focusedCmd.label
	file.boundCmd.func = file.focusedCmd.func
	file.boundCmd.opParm = file.focusedCmd.opParm
	file.boundCmdIsAssigned = true

	// Feedback:
	{
		string fullName = ""
		if ( file.lastDevCommandLabelInProgress.len() > 0 )
			fullName = file.lastDevCommandLabelInProgress + " -> "
		fullName += file.focusedCmd.label

		string prompt = "Bound to gamepad BACK: " + fullName
		printt( prompt )
		//string cmdText = "script Dev_PrintMessage( gp()[0], \"" + prompt + "\" )"
		//ClientCommand( cmdText )
		EmitUISound( "wpn_pickup_titanweapon_1p" )
	}

	CloseAllMenus()
}


bool function BindCommandToGamepad_ShouldShow()
{
	if ( !file.focusedCmdIsAssigned )
		return false
	if ( file.focusedCmd.command.len() == 0 )
		return false
	return true
}


void function DEV_ExecBoundDevMenuCommand()
{
	if ( !file.boundCmdIsAssigned )
		return

	RunDevCommand( file.boundCmd, true )
}

void function SetupChangeSurvivalCharacterClass()
{
// TODO: FIX [Undefined variable "SetupDevFunc"] //done?
	#if UI
		array<ItemFlavor> characters = clone GetAllCharacters()
		characters.sort( int function( ItemFlavor a, ItemFlavor b ) {
			if ( Localize( ItemFlavor_GetLongName( a ) ) < Localize( ItemFlavor_GetLongName( b ) ) )
				return -1
			if ( Localize( ItemFlavor_GetLongName( a ) ) > Localize( ItemFlavor_GetLongName( b ) ) )
				return 1
			return 0
		} )
		foreach( ItemFlavor character in characters )
		{
			SetupDevFunc( Localize( ItemFlavor_GetLongName( character ) ), void function( var unused ) : ( character ) {
				DEV_RequestSetItemFlavorLoadoutSlot( LocalClientEHI(), Loadout_CharacterClass(), character )
			} )
		}
	#endif
}

void function SetupChangeCharacterModel()
{
	#if UI
		SetupDevCommand( "TF2 Ash (by @LorryLeKral)", "Flowstate_AssignCustomCharacterFromMenu 6")
		SetupDevCommand( "TF2 Blisk (by @LorryLeKral)", "Flowstate_AssignCustomCharacterFromMenu 1")
		SetupDevCommand( "TF2 Jack Cooper (by @LorryLeKral)", "Flowstate_AssignCustomCharacterFromMenu 8")
		SetupDevCommand( "Ballistic (by @CafeFPS)", "Flowstate_AssignCustomCharacterFromMenu 12")
		SetupDevCommand( "Fade (by @CafeFPS)", "Flowstate_AssignCustomCharacterFromMenu 2")
		SetupDevCommand( "Rhapsody (by @CafeFPS)", "Flowstate_AssignCustomCharacterFromMenu 5")
		SetupDevCommand( "Crewmate [3p only] (by bobblet)", "Flowstate_AssignCustomCharacterFromMenu 3")
		SetupDevCommand( "MRVN [3p only] (by @CafeFPS)", "Flowstate_AssignCustomCharacterFromMenu 13")
		SetupDevCommand( "Pete (by @CafeFPS)", "Flowstate_AssignCustomCharacterFromMenu 16" )
	#endif
}


void function SetupOverrideSpawnSurvivalCharacter()
{
	#if(UI)
		SetupDevCommand( "Random (default)", "dev_sur_force_spawn_character random" )
		SetupDevCommand( "Shipping only", "dev_sur_force_spawn_character special" )
		array<ItemFlavor> characters = clone GetAllCharacters()
		characters.sort( int function( ItemFlavor a, ItemFlavor b ) {
			if ( Localize( ItemFlavor_GetLongName( a ) ) < Localize( ItemFlavor_GetLongName( b ) ) )
				return -1
			if ( Localize( ItemFlavor_GetLongName( a ) ) > Localize( ItemFlavor_GetLongName( b ) ) )
				return 1
			return 0
		} )
		foreach( ItemFlavor characterClass in characters )
		{
			SetupDevCommand( Localize( ItemFlavor_GetLongName( characterClass ) ), "dev_sur_force_spawn_character " + ItemFlavor_GetHumanReadableRef( characterClass ) )
		}
	#endif
}

void function SetupWeapons()
{
	#if UI
	// Rifles
	SetupDevCommand( "Rifle: Flatline", "give mp_weapon_vinson" )
	SetupDevCommand( "Rifle: G7 Scout", "give mp_weapon_g2" )
	SetupDevCommand( "Rifle: Havoc", "give mp_weapon_energy_ar" )
	SetupDevCommand( "Rifle: Hemlok", "give mp_weapon_hemlok" )
	SetupDevCommand( "Rifle: R-301", "give mp_weapon_rspn101" )
	

	// SMGs
	SetupDevCommand( "SMG: Alternator", "give mp_weapon_alternator_smg" )
	SetupDevCommand( "SMG: Prowler", "give mp_weapon_pdw" )
	SetupDevCommand( "SMG: R-99", "give mp_weapon_r97" )
	SetupDevCommand( "SMG: Volt SMG", "give mp_weapon_volt_smg" )

	// LMGs
	SetupDevCommand( "LMG: Devotion", "give mp_weapon_esaw" )
	SetupDevCommand( "LMG: L-Star", "give mp_weapon_lstar" )
	SetupDevCommand( "LMG: Spitfire", "give mp_weapon_lmg" )

	// Snipers
	SetupDevCommand( "Sniper: Charge Rifle", "give mp_weapon_defender" )
	SetupDevCommand( "Sniper: Kraber", "give mp_weapon_sniper" )
	SetupDevCommand( "Sniper: Longbow", "give mp_weapon_dmr" )
	SetupDevCommand( "Sniper: Triple Take", "give mp_weapon_doubletake" )
	SetupDevCommand( "Sniper: Sentinel", "give mp_weapon_sentinel" )

	// Shotguns
	SetupDevCommand( "Shotgun: EVA-8 Auto", "give mp_weapon_shotgun" )
	SetupDevCommand( "Shotgun: Mastiff", "give mp_weapon_mastiff" )
	SetupDevCommand( "Shotgun: Mozambique", "give mp_weapon_shotgun_pistol" )
	SetupDevCommand( "Shotgun: Peacekeeper", "give mp_weapon_energy_shotgun" )

	// Pistols
	SetupDevCommand( "Pistol: P2020", "give mp_weapon_semipistol" )
	SetupDevCommand( "Pistol: RE-45", "give mp_weapon_autopistol" )
	SetupDevCommand( "Pistol: Wingman", "give mp_weapon_wingman" )

	// Dev
	SetupDevCommand( "Dev: Dev Cubemap ", "give weapon_cubemap" )
	
	// Custom
	SetupDevCommand( "-> Custom weapons, created by @CafeFPS", "give mp" )
	SetupDevCommand( "Custom: Flame Thrower (Model by @LorryLeKral)", "give mp_weapon_flamethrower" )
	SetupDevCommand( "Custom: Raygun ", "give mp_weapon_raygun" )
	SetupDevCommand( "Custom: Flowstate Sword", "playerRequestsSword")
	#endif
}

void function SetupTitanfallWeapons()
{
	#if UI
	// Titanfall guns, ported by @LorryLeKral with the help from @AmosModz
	SetupDevCommand( "Titanfall weapons, ported by LorryLeKral with the help from @AmosModz", "give mp" )
	SetupDevCommand( "Please credit us properly if you are going to create content using them!", "give mp" )
	SetupDevCommand( "Titanfall 2: EPG", "give mp_weapon_epg" )
	SetupDevCommand( "Titanfall 2: Sidewinder", "give mp_weapon_smr" )
	SetupDevCommand( "Titanfall 2: Archer", "give mp_weapon_rocket_launcher" )
	SetupDevCommand( "Titanfall 2: Softball", "give mp_weapon_softball" )
	SetupDevCommand( "Titanfall 2: Car", "give mp_weapon_car_r2" )
	SetupDevCommand( "Titanfall 2: MGL", "give mp_weapon_mgl" )
	SetupDevCommand( "Titanfall 2: ColdWar", "give mp_weapon_pulse_lmg" )
	SetupDevCommand( "Titanfall 2: Thunderbolt", "give mp_weapon_arc_launcher" )
	SetupDevCommand( "Titanfall 2: Smart Pistol", "give mp_weapon_smart_pistol" )
	SetupDevCommand( "Titanfall 2: Arc Tool", "give sp_weapon_arc_tool" )
	SetupDevCommand( "Titanfall 2: Wingman Elite", "give mp_weapon_wingman_n" )
	SetupDevCommand( "Titanfall 2: R101 Assault Rifle", "give mp_weapon_rspn101_og iron_sights" )
	SetupDevCommand( "Titanfall 2: Proximity Mine", "give mp_weapon_proximity_mine" )
	SetupDevCommand( " ", "give mp" )
	SetupDevCommand( " ", "give mp" )

	// Dev
	SetupDevCommand( "Dev: Softball Apex Version", "give mp_weapon_softball apex_model" )
	SetupDevCommand( "Dev: Flight Core", "give mp_titanweapon_flightcore_rockets")
	SetupDevCommand( "Dev: Satchel", "give mp_weapon_satchel")
	#endif
}

void function SetupThrowables()
{
	#if UI
	// Grenades
	SetupDevCommand( "Grenade: Arc Star", "give mp_weapon_grenade_emp" )
	SetupDevCommand( "Grenade: Frag", "give mp_weapon_frag_grenade" )
	SetupDevCommand( "Grenade: Thermite", "give mp_weapon_thermite_grenade" )
	
	// Custom Grenades
	if( GetCurrentPlaylistVarBool( "is_halo_gamemode", false ) )
	{
		SetupDevCommand( "Grenade: Halo Frag", "give mp_weapon_frag_grenade_halomod" )
		SetupDevCommand( "Grenade: Halo Plasma  Frag", "give mp_weapon_plasma_grenade_halomod" )
	}
	#endif
}

void function SetupSurvival()
{
	#if UI
		SetupDevCommand( "Toggle Training Completed", "script GP().SetPersistentVar( \"trainingCompleted\", (GP().GetPersistentVarAsInt( \"trainingCompleted\" ) == 0 ? 1 : 0) )" )
		SetupDevCommand( "Enable Survival Dev Mode", "playlist survival_dev" )
		SetupDevCommand( "Disable Match Ending", "mp_enablematchending 0" )
		SetupDevCommand( "Drop Care Package R1", "script thread AirdropForRound( gp()[0].GetOrigin(), gp()[0].GetAngles(), 0, null )" )
		SetupDevCommand( "Drop Care Package R2", "script thread AirdropForRound( gp()[0].GetOrigin(), gp()[0].GetAngles(), 1, null )" )
		SetupDevCommand( "Drop Care Package R3", "script thread AirdropForRound( gp()[0].GetOrigin(), gp()[0].GetAngles(), 2, null )" )
		SetupDevCommand( "Force Circle Movement", "script thread FlagWait( \"DeathCircleActive\" );script svGlobal.levelEnt.Signal( \"DeathField_ShrinkNow\" );script FlagClear( \"DeathFieldPaused\" )" )
		SetupDevCommand( "Pause Circle Movement", "script FlagSet( \"DeathFieldPaused\" )" )
		SetupDevCommand( "Unpause Circle Movement", "script FlagClear( \"DeathFieldPaused\" )" )
		SetupDevCommand( "Gladiator Intro Sequence", "script thread DEV_StartGladiatorIntroSequence()" )
		SetupDevCommand( "Bleedout Debug Mode", "script FlagSet( \"BleedoutDebug\" )" )
		SetupDevCommand( "Disable Loot Drops on Death", "script FlagSet( \"DisableLootDrops\" )" )
		SetupDevCommand( "Drop My Death Box", "script thread SURVIVAL_Death_DropLoot_Internal( gp(), null, 100 )" )
	#endif
}


void function SetupSurvivalLoot( var categories )
{
	#if UI
		RunClientScript( "SetupSurvivalLoot", categories )
	#endif
}

void function SetupAbilities()
{
	#if UI
	SetupDevCommand( "Bangalore Tactical", "give mp_weapon_grenade_bangalore" )
	SetupDevCommand( "Bangalore Ultimate", "give mp_weapon_grenade_creeping_bombardment" )
	SetupDevCommand( "Bloodhound Tactical", "give mp_ability_area_sonar_scan" )
	SetupDevCommand( "Bloodhound Ultimate", "give mp_ability_hunt_mode" )
	SetupDevCommand( "Caustic Tactical", "give mp_weapon_dirty_bomb" )
	SetupDevCommand( "Caustic Ultimate", "give mp_weapon_grenade_gas" )
	SetupDevCommand( "Crypto Tactical", "give mp_ability_crypto_drone" )
	SetupDevCommand( "Crypto Ultimate", "give mp_ability_crypto_drone_emp" )
	SetupDevCommand( "Gibraltar Tactical", "give mp_weapon_bubble_bunker" )
	SetupDevCommand( "Gibraltar Ultimate", "give mp_weapon_grenade_defensive_bombardment" )
	SetupDevCommand( "Lifeline Tactical", "give mp_weapon_deployable_medic" )
	SetupDevCommand( "Lifeline Ultimate", "give mp_ability_care_package" )
	SetupDevCommand( "Mirage Tactical", "give mp_ability_holopilot" )
	SetupDevCommand( "Mirage Ultimate", "give mp_ability_mirage_ultimate" )
	SetupDevCommand( " ", "give dontgiveanything" ) // blank line so Octance is in the same column
	SetupDevCommand( "Octane Tactical", "give mp_ability_heal" )
	SetupDevCommand( "Octane Ultimate", "give mp_weapon_jump_pad" )
	SetupDevCommand( "Pathfinder Tactical", "give mp_ability_grapple" )
	SetupDevCommand( "Pathfinder Ultimate", "give mp_weapon_zipline" )
	SetupDevCommand( "Wattson Tactical", "give mp_weapon_tesla_trap" )
	SetupDevCommand( "Wattson Ultimate", "give mp_weapon_trophy_defense_system"  )
	SetupDevCommand( "Wraith Tactical", "give mp_ability_phase_walk" )
	SetupDevCommand( "Wraith Ultimate", "give mp_weapon_phase_tunnel" )
	
	SetupDevCommand( "Tf2: Pulse Blade", "give mp_weapon_grenade_sonar" )
	SetupDevCommand( "Tf2: Amped Wall", "give mp_weapon_deployable_cover" )
	SetupDevCommand( "Tf2: Electric Smoke", "give mp_weapon_grenade_electric_smoke" )
	
	SetupDevCommand( "Dev: 3Dash", "give mp_ability_3dash" )
	SetupDevCommand( "Dev: Cloak", "give mp_ability_cloak" )
	
	//SetupDevCommand( "Gravity Star", "give mp_weapon_grenade_gravity" )
	
	SetupDevCommand( "-> Custom abilities, created by @CafeFPS", "give mp" )
	SetupDevCommand( "Custom: Gravity Lift", "give mp_ability_space_elevator_tac" )
	SetupDevCommand( "Custom: Phase Rewind", "give mp_ability_phase_rewind" )
	SetupDevCommand( "Custom: Suppressor Turret ( ft. @Julefox )", "give mp_weapon_turret")
	SetupDevCommand( "Custom: Phase Chamber", "give mp_ability_phase_chamber")
	SetupDevCommand( "Custom: Ring Flare", "give mp_weapon_ringflare")
	#endif
}

void function SetupSurvivalIncapShieldBot()
{
	#if UI
	SetupDevCommand( "Spawn Bot with Lv 1 Incap Shield", "script Dev_SpawnBotWithIncapShieldToView( 1 )" )
	SetupDevCommand( "Spawn Bot with Lv 2 Incap Shield", "script Dev_SpawnBotWithIncapShieldToView( 2 )" )
	SetupDevCommand( "Spawn Bot with Lv 3 Incap Shield", "script Dev_SpawnBotWithIncapShieldToView( 3 )" )
	SetupDevCommand( "Spawn Bot with Lv 4 Incap Shield", "script Dev_SpawnBotWithIncapShieldToView( 4 )" )
	SetupDevCommand( "Spawn Bot with a Random Incap Shield", "script Dev_SpawnBotWithIncapShieldToView( -1 )" )
	#endif
}

void function SetupFriendlyNPC()
{
	#if UI
	//Friendly NPCs
	SetupDevCommand( "Friendly NPC: Stalker", "script DEV_SpawnStalkerAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Spectre", "script DEV_SpawnSpectreAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Dummie",  "script DEV_SpawnDummyAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Plasma Drone", "script DEV_SpawnPlasmaDroneAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Rocket Drone", "script DEV_SpawnRocketDroneAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Legend", "script DEV_SpawnLegendAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Prowler", "script DEV_SpawnProwlerAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Marvin", "script DEV_SpawnMarvinAtCrosshair(gp()[0].GetTeam())" )
	//SetupDevCommand( "Friendly NPC: Soldier", "script DEV_SpawnSoldierAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Spider", "script DEV_SpawnSpiderAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Infected", "script DEV_SpawnInfectedSoldierAtCrosshair(gp()[0].GetTeam())" )
	SetupDevCommand( "Friendly NPC: Tick", "script DEV_SpawnExplosiveTickAtCrosshair(gp()[0].GetTeam())" )
	#endif
}

void function SetupEnemyNPC()
{
	#if UI
	//Enemy NPCs
	SetupDevCommand( "Enemy NPC: Stalker", "script DEV_SpawnStalkerAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Spectre", "script DEV_SpawnSpectreAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Dummie", "script DEV_SpawnDummyAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Plasma Drone", "script DEV_SpawnPlasmaDroneAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Rocket Drone", "script DEV_SpawnRocketDroneAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Legend", "script DEV_SpawnLegendAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Prowler", "script DEV_SpawnProwlerAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Marvin", "script DEV_SpawnMarvinAtCrosshair()" )
	//SetupDevCommand( "Enemy NPC: Soldier", "script DEV_SpawnSoldierAtCrosshair()" )//Come back to this NPC later, we have animations and models but they are unstable -kral
	SetupDevCommand( "Enemy NPC: Spider", "script DEV_SpawnSpiderAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Infected", "script DEV_SpawnInfectedSoldierAtCrosshair()" )
	SetupDevCommand( "Enemy NPC: Tick", "script DEV_SpawnExplosiveTickAtCrosshair()" )
	#endif
}

void function SetupEditor()
{
	#if UI
	SetupDevCommand( "Start Editing", "give mp_weapon_editor" )
	SetupDevCommand( "Zipline", "give mp_weapon_zipline" )
	#endif
}