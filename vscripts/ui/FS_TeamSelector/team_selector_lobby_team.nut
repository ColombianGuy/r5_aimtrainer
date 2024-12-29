//Made by @CafeFPS

global function InitTeamSelectorLobbyTeamPanel

global const string TEAM_SELECTOR_BUTTON = "TeamSelectButton"
global const string TEAM_SELECTOR_PLAYER = "TeamPlayerMember"
global const string TEAM_SELECTOR_FRAME = "TeamFrame"

int MAX_TEAMS = 20 //can change
int TEAM_SIZE = 3 //can change

global struct TeamStruct
{
	var teamButton
	var teamFrame
	table< var, entity > playersButtonMap
	
	array<entity> players
}

struct
{
	var panel

	array< TeamStruct > allTeams
} file

void function InitTeamSelectorLobbyTeamPanel( var panel )
{
	file.panel = panel

	//Build teams
	for(int i = 0+2; i < MAX_TEAMS+2; i++ )
	{
		string num = i < 10 ? "0" + i : i.tostring()
		var button = Hud_GetChild( panel, TEAM_SELECTOR_BUTTON + num )
		AddButtonEventHandler( button, UIE_CLICK, OnTeamSelected )
		
		var frame = Hud_GetChild( panel, TEAM_SELECTOR_FRAME + num )
		
		TeamStruct team
		team.teamButton = button
		team.teamFrame = frame
		
		for(int j = 1; j <= TEAM_SIZE; j++ )//for(int j = TEAM_SIZE; j > 0; j-- )
		{
			var playerButton = Hud_GetChild( panel, TEAM_SELECTOR_PLAYER + num + "_" + j )
			team.playersButtonMap[playerButton] <- null
		}
		
		file.allTeams.append( team )
	}
	
	//Ocultar los frames de los teams que no se van a usar
	
	//Deshabilitar los players button que no se van a usar
}

void function OnTeamSelected( var button )
{
	int teamInt = -1
	foreach( int i, TeamStruct team in file.allTeams )
	{
		if( button == team.teamButton )
			teamInt = i
	}
	
	if( teamInt == -1 )
		return
	
	//Can select? Quedan puestos para este equipo?
	
	//Solicitar team al servidor -> Transmitir a todos los clientes
	
	//Seleccionar team después de la respuesta del servidor
	
	HudElem_SetRuiArg( button, "isSelected", true )
	
	OnTeamSelected_DisableTheOthers( button )
	
	//DEV TEST
	GetAvailablePlayerButtonForTeamAndAssign( teamInt, GetUIPlayer() )
}

void function OnTeamSelected_DisableTheOthers( var button )
{
	foreach( team in file.allTeams )
	{
		if( button == team.teamButton )
			continue
		
		HudElem_SetRuiArg( team.teamButton, "isSelected", false )
	}
}

void function GetAvailablePlayerButtonForTeamAndAssign( int teamInt, entity player )
{
	//desasignar
	foreach( team in file.allTeams )
	{
		foreach( var playerButton, entity playerMap in team.playersButtonMap )
		{
			if( playerMap == player )
			{
				team.playersButtonMap[playerButton] = null
				Hud_SetText( playerButton, "" )
			}
		}
	}

	//asignar
	foreach( var playerButton, entity playerMap in file.allTeams[teamInt].playersButtonMap )
	{
		if( playerMap == null )
		{
			file.allTeams[teamInt].playersButtonMap[playerButton] = player
			Hud_SetText( playerButton, "r5r_CafeFPS" ) //EHI_GetName( ToEHI( player ) )
			break
		}
	}
}