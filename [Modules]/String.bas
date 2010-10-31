
#Include Once "string.bi"
Namespace RString
	
	Public Function DQuote(ByVal sNaked As String) As String 
		Return chDQuote & sNaked & chDquote  
	End Function
	Public Function Quote(ByRef sNaked As String,ByVal qs As QuotingStyle = DoubleQuote) As String 
		Select Case qs
			Case SingleQuote
				Return "'" & sNaked & "'"
			Case BracketQuote
				Return "[" & sNaked & "]"
			Case BraceQuote
				Return "{" & sNaked & "}"
			Case Else
				Return chDQuote & sNaked & chDQuote
		End Select
	End Function
	Public Function GetLine overload(fAcceptEmpty As Integer = 1) As String 
		Dim sResult As String
		Input "",sResult
		If fAcceptEmpty Then Return sResult
		Do Until sResult<>""
			Input "",sResult
		Loop
		Return sResult
	End Function
	Public Function GetLine overload(ByRef sResult As String) As Integer
		Input "",sResult
		If sResult="" Then Return 0 Else Return -1	
	End Function
End Namespace
