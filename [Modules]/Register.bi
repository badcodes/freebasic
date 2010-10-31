#Ifndef RRegister_Header
#Define RRegister_Header


#Include Once "windows.bi"
#Include Once "win/winreg.bi"

Namespace RRegister
	Const MAX_REG_SZ As Integer = 512
	DECLARE Function OpenKey(ByVal PKEY As HKEY,ByRef SubKey As String,ByVal samDesired As REGSAM=KEY_ALL_ACCESS) As HKEY
   Declare Function CloseKey(ByVal PKEY As HKEY) As Long
   Declare Function CreateKey(ByVal PKEY As HKEY,ByRef SubKey As String,ByVal fdwOptions As Dword = REG_OPTION_NON_VOLATILE,ByVal samDesired As REGSAM=KEY_ALL_ACCESS) As HKEY
   Declare Function GetValueSZ(ByVal Key As HKEY,ByRef ValueName As String) As String
	Declare Function SetValueSZ(ByVal Key As HKEY,ByRef ValueName As String,ByRef VauleData As String) As Long 
	Declare Function DeleteKey(ByVal PKey As HKEY,ByRef KeyName As String) As Long 
	
End Namespace

#EndIf
