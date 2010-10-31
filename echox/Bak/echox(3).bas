
Dim SLASH As Const UByte = Asc("-")
Dim ext_mark As Const ZString*3  => "-e"
DIM CONVTABLE As Const String = !"n\nr\ne\e\\\\t\t"
Dim arg As String = Command() 
Dim pct As ZString Ptr = StrPtr(CONVTABLE)
Dim lct As Integer = Len(CONVTABLE)
Dim parg As ZString Ptr = StrPtr(arg)
Dim larg As Integer = Len(arg)
Dim oarg As String  = String(larg,0)
Dim poarg As ZString Ptr = StrPtr(oarg)

Dim i As Integer = 0
If ((*parg)[0] = ext_mark[0]) And ((*parg)[1] = ext_mark[1]) Then
	If((*parg)[0] = SLASH) Then
		For i = 0 To lct -1 Step 2
			If((*parg)[1] = (*pct)[i]) Then
				(*oarg)++ = (*pct)[i+1]
				parg++
			EndIf
		Next
						
	Else
		(*oarg)++ = (*parg)++ 
	EndIf
	Print "aaa",*(parg + 3)
Else
	Print *parg
EndIf


'Const SLASH As UByte = "-"
'Dim ext As UByte
'ext = 0

'If Command(1) = "-e" Then
'		ext = 1
'EndIf

'If ext = 1 Then
'	Dim c As UByte
'	Dim nc As UByte
'	Dim args As String 
'	args = Mid(Command,3)
'	Dim i As Integer = 0
'	Dim L As Integer = Len(arg)
'	Do While i<l
'		i++
'		c = Mid(args,i,1)
'		If c="-" Then
'			
'		EndIf 
'	Loop
'	
'Else
'	Print Command
'EndIf

'Public Function compaire_two_byte(ByRef b1 As UByte,ByRef b2 As UByte,ByRef b3 As UByte,ByRef b4 As UByte) As UByte
'	If(b1 = b3 And b2 = b4) Return 1
'	Return 0
'End Function
