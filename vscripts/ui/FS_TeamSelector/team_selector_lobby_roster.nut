global function InitTeamSelectorLobbyRosterPanel

struct RosterDisplay
{
	string name
	var button
	var grid
}

struct
{
	var panel
	array<RosterDisplay> rosterDisplays

	int team
} file

const int MIN_ROSTER_SIZE = 6

void function InitTeamSelectorLobbyRosterPanel( var panel )
{
	file.panel = panel

	file.rosterDisplays.clear()
	AddRosterPanel( "TEAM UNASSIGNED" )
}

void function AddRosterPanel( string name )
{
	int index = file.rosterDisplays.len()
	string buttonName = format( "LobbyRosterButton%02u", index )
	string gridName = format( "LobbyRoster%02u", index )

	RosterDisplay display
	display.name = name
	display.button = Hud_GetChild( file.panel, buttonName )
	display.grid = Hud_GetChild( file.panel, gridName )
	file.rosterDisplays.append( display )

	HudElem_SetRuiArg( display.button, "isSelected", true )
	HudElem_SetRuiArg( display.button, "buttonText", Localize( display.name ) )
	AddButtonEventHandler( display.button, UIE_CLICK, CustomMatchLobbyRoster_OnLeftClick )
}

void function CustomMatchLobbyRoster_OnLeftClick( var button )
{
	int roster = Hud_GetScriptID( button ).tointeger()
	EnableRosterPanel( roster )
}

var function EnableRosterPanel( int index )
{
	Assert( index < file.rosterDisplays.len() )
	foreach ( int i, RosterDisplay display in file.rosterDisplays )
	{
		Hud_SetVisible( display.grid, i == index )
		HudElem_SetRuiArg( display.button, "isSelected", i == index )
	}
}