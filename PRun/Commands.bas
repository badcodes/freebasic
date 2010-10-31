#Include "Commands.bi"

Namespace XRL

Constructor CCommands()
	Dim argc As Integer
	Dim argv As String
	argc = 1
	mProgram = Command(argc)
	argc = argc + 1
	argv = Command(argc)
	Do Until argv = ""
		mArgument = mArgument + Chr$(34) + argv + Chr$(34) + " "
		argc = argc + 1
		argv = Command(argc)
	Loop
	mArgument=RTrim(mArgument)
End Constructor

Property CCommands.Program() As String 
	Return this.mProgram
End Property

Property CCommands.Argument() As String
	Return this.mArgument
End Property

End Namespace
