#Ifndef RIniFile_Header
#Define RIniFile_Header

#Include Once "win/winbase.bi"

Namespace RIniFile
  
	Declare Function ReadSetting overload(ByRef Filename As String,ByRef Section As String,ByRef Keyname As String) As String
	Declare Function ReadSection OverLoad (ByRef Filename As String,ByRef Section As String) As String
	Declare Function WriteSetting OverLoad (ByRef Filename As String,ByRef Section As String,ByRef Keyname As String,ByRef Value As String) As boolean
	Declare Function WriteSection OverLoad (ByRef Filename As String,ByRef Section As String,ByRef Value As String) As Boolean
	
End Namespace


#endif