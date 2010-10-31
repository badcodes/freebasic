Public Function Main() As Integer
	Print "Hello,World!"
	Return 0
End Function

Public Sub OPrint OverLoad (ByVal N As Integer)
	Print "NUM:";N
End Sub

Public Sub OPrint OverLoad (ByVal S As String)
	Print "STR:";S
End Sub

Public Sub OPrint OverLoad (ByVal D As Double)
	Print "DBL:";D
End Sub