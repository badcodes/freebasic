
#Define R_NODebug 0
#define NULL 0

#Include Once "iniFile.bi"
'#undef MOUSE_MOVED
'#include once "curses.bi"



Using RiniFile

Enum ActionsNumber
	An_UnKnown = -1
	AN_Read = 1
	AN_Write = 2
	AN_ReadSection = 3
	AN_WriteSection = 4
	AN_Help = 5
	AN_Count = 6
End Enum

Declare Function Main() As Integer
Declare Function PerformAction(ID As ActionsNumber,cmdStart As Integer) As Integer
Declare Sub InitAction()
Declare Function Do_Help(cmdStart As Integer) As Integer
Declare Function Do_Read(cmdStart As Integer) As Integer
Declare Function Do_Write(cmdStart As Integer) As Integer
Declare Function Do_ReadSection(cmdStart As Integer) As Integer
Declare Function Do_WriteSection(cmdStart As Integer) As Integer
Declare Function Do_Unknown(cmdStart As Integer) As Integer
Declare Sub InitScreen()

Dim Shared ActionCount As Long = AN_Count -1
Dim shared Actions(1 To 5) As String

End Main()

Function Main() As Integer
	
	InitScreen()
	
	InitAction()
	
	Dim argc As Integer
	Dim action As ActionsNumber 
	Dim actionArg() As String
	Dim actionArgCount As Long = 0
	
	argc = 1
	Select Case LCase(Command$(argc))
		Case "","-h","--help","/h","usage",Actions(An_Help)
			action = AN_Help
		Case Actions(An_Read)
			action = An_Read
		Case Actions(AN_Write)
			action = AN_Write
		Case Actions(AN_ReadSection)
			action = AN_ReadSection
		Case Actions(AN_WriteSection)
			action = AN_WriteSection
		Case Else
			action = AN_Unknown
	End Select
	'If Command$() = "" Then action = AN_Help
	
	Return PerformAction(action,argc + 1)
	
End function

Sub InitScreen()



'    Dim As Short f, b
'
'    initscr( )
'    cbreak( )
'    noecho( )
'
'    If (has_colors( )) Then
'                start_color( )
'                pair_content( 0, @f, @b )
'                init_pair( 1, COLOR_WHITE, COLOR_BLUE )
'                attrset( COLOR_PAIR(1))
'
'    Else
'    End If
'   
'    endwin( )
    
End Sub

Function PerformAction(ID As ActionsNumber,cmdStart As Integer) As Integer
	Select Case ID
		Case AN_Help
			Return Do_Help(cmdStart)
		Case An_Read
			Return Do_Read(cmdStart)
		Case An_Write
			Return Do_Write(cmdStart)
		Case An_ReadSection
			Return Do_ReadSection(cmdStart)
		Case An_WriteSection
			Return Do_WriteSection(cmdStart)
		Case Else
			Return Do_Unknown(cmdStart)
	End Select
End Function

Sub InitAction()
	Actions(An_Read) = "read"
	Actions(An_Write) = "write"
	Actions(An_ReadSection) = "readsection"
	Actions(An_WriteSection) = "writesection"
	Actions(An_Help) = "help"
End Sub

Function Do_Help(cmdStart As Integer) As Integer
	Print Command(0);" V1.0"
	Print "  - iniHandler for reading and writting ini file"
	Print "Usage:"
	Print "  (Action) [Arguments...]"
	Print "Actions:"
	Print "  1.Help"
	Print "  2.Read inifile section keyname"
	Print "  3.Write inifile section keyname value"
	Print "  4.ReadSection inifile section"
	Print "  5.WriteSection inifile section text"
	Return 0
End Function

Function Do_Read(cmdStart As Integer) As Integer
	Print ReadSetting(Command$(cmdStart),Command$(cmdStart+1),Command$(cmdStart+2))
	Return 0
End Function

Function Do_Write(cmdStart As Integer) As Integer
	If WriteSetting(Command$(cmdStart),Command$(cmdStart+1),Command$(cmdStart+2),Command$(cmdStart+3)) Then
		Return 0
	Else
		Return -1
	EndIf
End Function

Function Do_ReadSection(cmdStart As Integer) As Integer
	Print ReadSection(Command$(cmdStart),Command$(cmdStart+1))
	Return 0
End Function

Function Do_WriteSection(cmdStart As Integer) As Integer
	If WriteSection(Command$(cmdStart),Command$(cmdStart+1),Command$(cmdStart+2)) Then
		Return 0
	Else
		Return -1
	EndIf
End Function

Function Do_Unknown(cmdStart As Integer) As Integer
	Print "Unknown action"
	Return -1
End Function
