global function InitTeamSelectorMenu

global function UI_OpenTeamSelectorMenu
global function UI_CloseTeamSelectorMenu

struct
{
	var panel
	var startButton
	var dragIcon
	var dragTarget
	var chatTarget
	var chatInputLine
	var chatFrame

	bool setTeamNameIsOpen = false

	bool chatEnabled	= false
	bool isReady		= false
	bool isMatchmaking 	= false
	bool canAction		= false
	bool selfAssign		= false
	int teamIndex		= TEAM_UNASSIGNED
	bool isAutoClosing  = false
	int autoCloseRemainingTime = 0
	array<TeamSelector_LobbyPlayer> lobbyPlayers

	array<TeamSelector_LobbyPlayer> assignedPlayers
	bool hasRemainingPlayers = true
	bool hasRemainingAllianceOrTeam = true
	int remainingPlayers
	string gamemode

	TeamSelector_LobbyState& customMatchData
	bool customMatchDataSet = false

	array<var> teamButtons
	array<var> teamPlayers

} file

const int AUTO_CLOSE_LOBBY_TIMER = 60

void function InitTeamSelectorMenu( var panel )
{
	file.panel = panel
	
	file.startButton = Hud_GetChild( panel, "StartButton" )
	file.chatTarget = Hud_GetChild( panel, "ChatPanel" )
	file.chatInputLine = Hud_GetChild( file.chatTarget, "ChatInputLine" )
	file.chatFrame = Hud_GetChild( panel, "ChatFrame" )
	AddButtonEventHandler( file.startButton, UIE_CLICK, StartMatch_OnClick )
	AddButtonEventHandler(file.chatFrame, UIE_CLICK, ChatBox_OnClick )
}

void function UI_OpenTeamSelectorMenu()
{
	CloseAllMenus()

	AdvanceMenu( file.panel )
	CustomMatchLobby_OnShow( file.panel )
}

void function UI_CloseTeamSelectorMenu()
{
	CloseAllMenus()
	CustomMatchLobby_OnHide( file.panel )
}

void function CustomMatchLobby_OnShow( var panel )
{
	Hud_Show( Hud_GetChild( panel, "LobbyRosterPanel" ) )
	
	Hud_SetEnabled( file.startButton, true )
	SetMenuNavigationDisabled( false )

	ShowPanel( Hud_GetChild( file.panel, "LobbyTeamsPanel" ) )

	RegisterButtonPressedCallback( BUTTON_Y, StartMatch_OnClick )

}

void function CustomMatchLobby_OnHide( var panel )
{
	DeregisterButtonPressedCallback( BUTTON_Y, StartMatch_OnClick )
}

void function StartMatch_OnClick( var button )

}

void function ChatBox_OnClick( var button )
{
	if ( file.chatEnabled )
	{
		Hud_SetFocused( file.chatInputLine )
	}
}