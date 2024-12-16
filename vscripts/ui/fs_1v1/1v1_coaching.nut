//Made by @CafeFPS

global function InitCoachingMenu

global function Init_CoachingRecordingsList

global function UI_Open1v1CoachingMenu
global function UI_Close1v1CoachingMenu

global function UI_Flowstate_AddRecordingIdentifierToClient

global function ClearRecordings

struct recordingInfo_Identifier
{
	int index
	float duration
	float dateTime
	int winnerHandle
}

struct
{
	var menu

	var panel
	var contentPanel
	
	var buttonStartNew
	var buttonClose

	var buttonStartNewText
	var buttonCloseText
	
	array< recordingInfo_Identifier > coachingRecordingList //Ask client vm to repopulate on resolution changed
} file

void function InitCoachingMenu( var menu )
{	
	file.menu = menu
	
	file.buttonStartNew = Hud_GetChild( menu, "StartNewButton" )
	file.buttonStartNewText = Hud_GetChild( menu, "StartNewText" )
	
	file.buttonClose = Hud_GetChild( menu, "CloseButton" )
	file.buttonCloseText = Hud_GetChild( menu, "CloseText" )
	
	AddButtonEventHandler( file.buttonStartNew, UIE_CLICK, UI_StartNewButton )
	AddButtonEventHandler( file.buttonClose, UIE_CLICK, UI_Close1v1CoachingMenuButton )
	
	SetMenuReceivesCommands( menu, false )
	SetGamepadCursorEnabled( menu, true )

	AddMenuEventHandler( menu, eUIEvent.MENU_OPEN, CoachingMenuOnOpen )
	AddMenuEventHandler( menu, eUIEvent.MENU_CLOSE, CoachingMenuOnClose )
	AddMenuEventHandler( menu, eUIEvent.MENU_NAVIGATE_BACK, CoachingMenuOnNavBack )
}

void function Init_CoachingRecordingsList( var panel ) 
{
	file.panel = panel
	var contentPanel = Hud_GetChild( panel, "ContentPanel" )
	file.contentPanel = contentPanel

	ScrollPanel_InitPanel( panel )
	ScrollPanel_InitScrollBar( panel, Hud_GetChild( panel, "ScrollBar" ) )
	
	AddPanelEventHandler( panel, eUIEvent.PANEL_SHOW, OnCoachingRecordingsListPanel_Show )
	AddPanelEventHandler( panel, eUIEvent.PANEL_HIDE, OnCoachingRecordingsListPanel_Hide )

	//Setup buttons
	for( int i = 0; i <= 50 ; i++ )
	{
		AddButtonEventHandler( Hud_GetChild( file.contentPanel, "Button" + i ), UIE_CLICK, RequestFightToPlay )
	}
}

void function OnCoachingRecordingsListPanel_Show( var panel )
{
	ScrollPanel_SetActive( panel, true )
	ScrollPanel_Refresh( panel )
}

void function OnCoachingRecordingsListPanel_Hide( var panel )
{
	ScrollPanel_SetActive( panel, false )
}

void function UI_Open1v1CoachingMenu()
{
	CloseAllMenus()

	AdvanceMenu( file.menu )
	
	entity player = GetUIPlayer()
	
	if( !uiGlobal.bIsServerAdmin )
	{
		Hud_SetVisible( file.buttonStartNew, false )
		Hud_SetVisible( file.buttonClose, false )

		Hud_SetVisible( file.buttonStartNewText, false )
		Hud_SetVisible( file.buttonCloseText, false )
	}
	
	if( file.coachingRecordingList.len() == 0 )
	{
		Hud_SetVisible( Hud_GetChild( file.contentPanel, "NoRecordingsText" ), true )
		Hud_SetVisible( Hud_GetChild( file.contentPanel, "HeaderText" ), false )
	} else
	{
		Hud_SetVisible( Hud_GetChild( file.contentPanel, "NoRecordingsText" ), false )
		Hud_SetVisible( Hud_GetChild( file.contentPanel, "HeaderText" ), true )
	}
	
	PopulateRecordingsList()
}

void function PopulateRecordingsList()
{
	for( int i = 0; i < file.coachingRecordingList.len() ; i++ )
	{
		Assert( file.coachingRecordingList[i].index == i )
		
		SetButtonAndTextVisible( i, true )
		
		DisplayTime dt = SecondsToDHMS( int( file.coachingRecordingList[i].duration ) )
		Hud_SetText( Hud_GetChild( file.contentPanel, "Text" + i ), ( i + 1 ).tostring() + ". " + EHI_GetName( file.coachingRecordingList[i].winnerHandle ) + " Win - Duration: " + format( "%.2d:%.2d", dt.minutes, dt.seconds ) )
	}

	for( int i = file.coachingRecordingList.len(); i < 50 ; i++ )
	{
		SetButtonAndTextVisible( i, false )
	}
}

void function SetButtonAndTextVisible( int index, bool visible )
{
	Hud_SetVisible( Hud_GetChild( file.contentPanel, "Button" + index ), visible )
	Hud_SetVisible( Hud_GetChild( file.contentPanel, "Text" + index ), visible )
}

void function RequestFightToPlay( var button )
{
	int scriptID = int( Hud_GetScriptID( button ) )
	
	printt( "try to play fight with id ", scriptID )
	CloseAllMenus()
	RunClientScript( "CC_ReplayFight", scriptID )
}

void function UI_Close1v1CoachingMenu()
{
	CloseAllMenus()
}

void function UI_StartNewButton( var button )
{
	printt( "start new game" )
	CloseAllMenus()
	RunClientScript( "CC_StartNewGame" )
}

void function UI_Close1v1CoachingMenuButton( var button )
{
	CloseAllMenus()
}

void function CoachingMenuOnOpen()
{
	SetBlurEnabled( true )

	ShowPanel( Hud_GetChild( file.menu, "CoachingRecordingsList" ) )
}

void function CoachingMenuOnClose()
{
}

void function CoachingMenuOnNavBack()
{
	UI_CloseScenariosStandingsMenu()
}

void function ClearRecordings()
{
	file.coachingRecordingList.clear()
}

void function UI_Flowstate_AddRecordingIdentifierToClient( int index, float duration, float dateTime, int winnerHandle )
{
	recordingInfo_Identifier newRecording
	newRecording.index = index
	newRecording.duration = duration
	newRecording.dateTime = dateTime
	newRecording.winnerHandle = winnerHandle
	
	printt( "Recording info sent to UI" )
	file.coachingRecordingList.append( newRecording )
}