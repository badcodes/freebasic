#Ifndef RString_Header
#Define RString_Header


Namespace RString
	Const chDQuote As String = Chr$(34)
	Const chCRLF As String = Chr$(10) & Chr$(13) 
	Public Enum QuotingStyle
		DoubleQuote
		SingleQuote
		BracketQuote
		BraceQuote
		ArrowQuote
	End Enum
	Declare Function Quote(ByRef sNaked As String,ByVal qs As QuotingStyle) As String 
	Declare Function GetLine OverLoad (fAcceptEmpty As Integer) As String 
	Declare Function GetLine Overload(ByRef sResult As String) As Integer 
End Namespace

#EndIf

