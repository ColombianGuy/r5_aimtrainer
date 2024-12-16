//Made by @CafeFPS

untyped

#if SERVER

#endif

#if CLIENT
global function CC_ReplayFight
global function CC_StartNewGame

global function Flowstate_OpenCoachingMenu
global function Flowstate_CloseCoachingMenu
global function Flowstate_AddRecordingIdentifierToClient
#endif

struct recordingInfo_Identifier
{
	int index //yea who cares
	float duration
	float dateTime
	int winnerHandle
}

struct
{
	#if SERVER

	#endif
	
	array< recordingInfo_Identifier > recordingsIdentifiers //len should be the same as recordingAnims and recordingAnimsInfo
} file

const int MAX_SLOT = 50

#if SERVER

#endif

#if CLIENT
void function CC_StartNewGame()
{
	entity player = GetLocalClientPlayer()
	
	if( !player.GetPlayerNetBool("IsAdmin") )
		return
	
	player.ClientCommand( "coaching_startnew" )
}

void function CC_ReplayFight( int index )
{
	entity player = GetLocalClientPlayer()
	
	if( !player.GetPlayerNetBool("IsAdmin") )
		return
	
	player.ClientCommand( "coaching_playselected " + index )
}

void function Flowstate_OpenCoachingMenu()
{
	RunUIScript( "UI_Open1v1CoachingMenu" )
}

void function Flowstate_CloseCoachingMenu()
{
	RunUIScript( "UI_Close1v1CoachingMenu" )
}

void function Flowstate_AddRecordingIdentifierToClient( int index, float duration, float dateTime, int winnerHandle )
{
	recordingInfo_Identifier newRecording
	newRecording.index = index
	newRecording.duration = duration
	newRecording.dateTime = dateTime
	newRecording.winnerHandle = winnerHandle
	
	file.recordingsIdentifiers.append( newRecording )
	
	RunUIScript( "UI_Flowstate_AddRecordingIdentifierToClient", index, duration, dateTime, winnerHandle )
}
#endif