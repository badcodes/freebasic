#include Once "iniFile.bi"

Namespace RIniFile
	Private Const cst_MAX_Setting_Size As Integer = 512
	Private Const cst_MAX_Section_Size As Integer = 4096
	Public Function ReadSetting overload(ByRef Filename As String,ByRef Section As String,ByRef Keyname As String) As String
		Dim r As Long
		Dim size As Long
		Dim result As String 
		size = cst_MAX_Setting_Size
		result = String(size,0)
		r = GetPrivateProfileString(StrPtr(Section),StrPtr(Keyname),0,StrPtr(result),Len(result),StrPtr(filename))
		If r>0 Then result = Left$(result,r) Else result = ""
		#IfNdef R_NoDebug
			Print "ReadSetting Called"
			Print "	Filename:" & Filename
			Print "	Section:" & Section
			Print "	Key:" & Keyname
			Print "ReadSetting return " & """" & result & """"
		#EndIf
		Return result
	End Function
	
	Public Function ReadSection OverLoad (ByRef Filename As String,ByRef Section As String) As String
		Dim r As Long
		Dim size As Long
		Dim result As String 
		size = cst_MAX_Section_Size
		result = String(size,0)
		r = GetPrivateProfileSection(StrPtr(Section),StrPtr(result),size,StrPtr(Filename))
		If r>0 Then result = Left$(result,r) Else result = ""
				#IfNdef R_NoDebug
			Print "ReadSection Called"
			Print "	Filename:" & Filename
			Print "	Section:" & Section
			Print "ReadSection return " & """" & result & """"
		#EndIf
		Return result
	End function
	
	Public Function WriteSetting OverLoad (ByRef Filename As String,ByRef Section As String,ByRef Keyname As String,ByRef Value As String) As Boolean
		Dim result As Boolean
		result=WritePrivateProfileString(StrPtr(Section),StrPtr(Keyname),StrPtr(Value),StrPtr(Filename))		
		#IfNdef R_NoDebug
			Print "WriteSetting Called"
			Print "	Filename:" & Filename
			Print "	Section:" & Section
			Print "	Key:" & Keyname
			Print "	Value:" & Value
			Print "ReadSetting return " & """" & result & """"
		#EndIf
		Return result
	End Function
	
	public Function WriteSection OverLoad (ByRef Filename As String,ByRef Section As String,ByRef Value As String) As Boolean
		Dim result As Boolean
		result=WritePrivateProfileSection(StrPtr(Section),StrPtr(Value),StrPtr(Filename))		
		#IfNdef R_NoDebug
			Print "WriteSection Called"
			Print "	Filename:" & Filename
			Print "	Section:" & Section
			Print "	Value:" & Value
			Print "ReadSection return " & """" & result & """"
		#EndIf
		Return result
	End sub

End Namespace