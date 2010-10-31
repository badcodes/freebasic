#Include Once "windows.bi"
#Include Once "win/winreg.bi"
#Include Once "String.bi"
#Include Once "Register.bi"

#Include Once "ShellReg.bi"


Using RString
Using RRegister

Declare Sub Help()
Declare Sub ExitPrompt()
Declare Sub Register(ByRef As String,ByRef As String,ByRef As String,ByRef As String)
Declare Sub UnRegister(ByRef As String,ByRef As String)

Dim argc As Integer = 1
Dim fHelp As Integer = 0
Dim fUnReg As Integer = 0
Dim fGraph As Integer = 0


Select Case Command(argc) 
	Case "-h"
		fHelp = 1
		argc = argc +1
	Case "-u"
		fUnReg = 1
		argc = argc + 1
	Case "-r"
		fUnReg = 0
		argc = argc + 1
'	Case "-g"
'		fGraph = 1
'		argc = argc + 1
End Select

#Ifdef GRAPH_MODE
Screen 12
#endif

If fHelp Then
	Help()
	ExitPrompt()
	End 0
EndIf


Dim sFileType As String
Dim sShellCommand As String
Dim sShellMenuName As String
Dim sShellName As String

If Command(argc)="" Then
	Print "Enter the FileType(such as ";chDQuote;".txt";chDQuote;" or ";chDQuote;"txtfile";chDQuote;"):";	
	If Not RString.GetLine(sFileType) then 
		Print "Empty string not acceptable,aborting..."
		ExitPrompt()
		End 0
	EndIf
Else
	sFileType = Command(argc)
	Print "Read FileType from command line as :";sFileType	
End If
argc = argc + 1

If Command(argc)="" Then
	Print "Enter the ShellName:";
	If Not RString.GetLine(sShellName) then 
		Print "Empty string not acceptable,aborting..."
		ExitPrompt()
		End 0
	EndIf
Else
	sShellName = Command(argc)
	Print "Read ShellName from command line as :";sShellName
End If
argc = argc + 1

If fUnReg = 0 Then	
	If Command(argc)="" Then
		Print "Enter the ShellCommand:";
		If Not RString.GetLine(sShellCommand) then 
			Print "Empty string not acceptable,aborting..."
			ExitPrompt()
			End 0
		EndIf
	Else
		sShellCommand = Command(argc)
		Print "Read ShellCommand from command line as :";sShellCommand
	End If
	argc = argc + 1
	If Command(argc)="" Then
		Print "Enter the ShellMenuName:";
		If Not RString.GetLine(sShellMenuName) then 
			Print "Empty string not acceptable,aborting..."
			ExitPrompt()
			End 0
		EndIf
	Else
		sShellMenuName = Command(argc)
		Print "Read ShellMenuName from command line as :";sShellMenuName
	End If
	argc = argc + 1
End If

If fUnreg Then
	UnRegister sFileType,sShellName
Else
	Register sFiletype,sShellName,sShellCommand,sShellMenuName
EndIf

ExitPrompt()


Public Sub Register( _
	ByRef sFileType As String, _ 
	ByRef sShellName As String, _
	ByRef sShellCommand As String, _
	ByRef sShellMenuName As String)

	Print "Register shell command for ";Quote("HKEY_CLASSES_ROOT\" & sFileType & "\",QuotingStyle.BracketQuote)
	'Print Quote("HKEY_CLASSES_ROOT\" & sFileType & "\",QuotingStyle.BracketQuote)
	
	Dim hkBase As HKEY
	
	If Left$(sFileType,1)="." Then
		hkBase = OpenKey(HKEY_CLASSES_ROOT,sFileType)
		If hkBase = 0 Then hkBase = CreateKey(HKEY_CLASSES_ROOT,sFileType)
		If hkBase = 0 Then
				Print "Can't not open or create register key:";Quote("HKEY_CLASSES_ROOT\" & sFileType,QuotingStyle.BracketQuote)
				End -1 
		EndIf
		
		Dim sValue As String 
		sValue = GetValueSZ(hkBase,"")
		CloseKey(hkBase)
		If sValue <> "" Then
			sFileType = sValue
			Print "Redirect key to ";sFileType			
		EndIf
	EndIf
	
	hkBase = OpenKey(HKEY_CLASSES_ROOT,sFileType)
	If hkBase = 0 Then hkBase = CreateKey(HKEY_CLASSES_ROOT,sFileType)
	If hkBase = 0 then
			Print "Can't not open or create register key:";Quote("HKEY_CLASSES_ROOT\" + sFileType,QuotingStyle.BracketQuote)
			End -1 		
	EndIf

	Dim hkCurrent As HKEY
	   
	Print Quote("HKEY_CLASSES_ROOT\" + sFileType + "\Shell\",QuotingStyle.BracketQuote)
	hkCurrent = CreateKey(hkBase,"Shell")
	CloseKey(hkBase)
	hkBase=hkCurrent
	
	Print Quote("HKEY_CLASSES_ROOT\" + sFileType + "\Shell\" + sShellName + "\",QuotingStyle.BracketQuote)
	hkCurrent = CreateKey(hkBase,sShellName)
	CloseKey(hkBase)
	hkBase=hkCurrent

	Print "@=";sShellMenuName
	SetValueSZ(hkBase,"",sShellMenuName)
	
	Print Quote("HKEY_CLASSES_ROOT\" + sFileType + "\Shell\" + sShellName + "\Command",QuotingStyle.BracketQuote)
	hkCurrent = CreateKey(hkBase,"Command")
	CloseKey(hkBase)
	hkBase=hkCurrent
	
	Print "@=";sShellCommand
	setValueSZ(hkBase,"",sShellCommand)

	closeKey(hkBase)

End Sub


Public Sub UnRegister(ByRef sFileType As String,ByRef sShellName As String)
	Print "UnRegister shell command [";sShellName ; "] for ";chDQuote;"HKEY_CLASSES_ROOT\";sFileType;"\";chDquote	
	Dim sKey As String
	skey = sFileType & "\Shell\" & sShellName & "\Command"
	Print "Deleting ";Quote("HKEY_CLASSES_ROOT\" & sKey,QuotingStyle.BracketQuote);"..."
	If DeleteKey(HKEY_CLASSES_ROOT,sKey)=ERROR_SUCcESS Then
		Print "Successed."
		skey = sFileType & "\Shell\" & sShellName
		Print "Deleting ";Quote("HKEY_CLASSES_ROOT\" & sKey,QuotingStyle.BracketQuote);"..."
		If DeleteKey(HKEY_CLASSES_ROOT,sKey)=ERROR_SUCCESS Then
			Print "Successed."
		Else
			Print "Failed."
		End If
	Else
		Print "Failed."
	EndIf 
End Sub

Public Sub Help()
	Print APPNAME;" V";APPVER;chCRLF;"    - ";APPDESC
	Print "Usage:";chCRLF;"    ";Command(0);" [Options] FileType ShellName ShellCommand ShellMenuName"
	Print "Options:";chCRLF;_
			"    -h    ";APPOPT_H;chCRLF;_
			"    -u    ";APPOPT_U;chCRLF;_
			"    -r    ";APPOPT_R;chCRLF;
			'"	-g	Graph Mode"
End Sub

Public Sub ExitPrompt()
	#Ifdef GRAPH_MODE
		Print "Any key to exit..."
		GetKey()
	#endif
End Sub
