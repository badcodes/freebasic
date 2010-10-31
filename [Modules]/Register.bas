#Include Once "Register.bi"
Namespace RRegister

	Public Function OpenKey(ByVal PKEY As HKEY,ByRef SubKey As String,ByVal samDesired As REGSAM=KEY_ALL_ACCESS) As HKEY
		Dim hkRet As HKEY
		If RegOpenKeyEx(PKEY,StrPtr(SubKey),0,samDesired,@hkRet) = ERROR_SUCCESS Then
			Return hkRet
		Else
			Return 0
		EndIf
	End Function
	
   Public Function CreateKey(ByVal PKEY As HKEY,ByRef SubKey As String,ByVal fdwOptions As Dword = REG_OPTION_NON_VOLATILE,ByVal samDesired As REGSAM=KEY_ALL_ACCESS) As HKEY
   	Dim hkRet As HKEY
   	Dim dRet As Dword
   	If RegCreateKeyEx(PKEY,StrPtr(SubKey),0,NULL,fdwOptions,samDesired,NULL,@hkRet,@dRet)= ERROR_SUCCESS Then
   		Return hkRet
   	Else
   		Return 0
   	EndIf
   End function
   
   Public Function CloseKey(ByVal PKEY As HKEY) As Long
   	Return RegCloseKey(PKEY)
   End Function
   
   Public Function GetValueSZ(ByVal Key As HKEY,ByRef ValueName As String) As String
   	Dim sData As ZString*MAX_REG_SZ
   	Dim cData As Dword=MAX_REG_SZ
   	Dim iData As Dword
   	If RegQueryValueEx(Key,StrPtr(ValueName),0,@iData,@sData,@cData) = ERROR_SUCCESS Then
   		Return Left$(sData,cData)
   	Else
   		Return ""
   	EndIf
   End Function

	Public Function SetValueSZ(ByVal Key As HKEY,ByRef ValueName As String,ByRef ValueData As String) As Long 
		Return RegSetValueEx(Key,StrPtr(ValueName),NULL,REG_SZ,StrPtr(ValueData),Len(ValueData))
	End Function
	
	Public Function DeleteKey(ByVal PKey As HKEY,ByRef KeyName As String) As Long 
		Return RegDeleteKey(PKEY,StrPtr(KeyName))
	End Function
	
End Namespace


