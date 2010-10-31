#Include "Commands.bi"

Using XRL

Dim Cmd As CCommands
Dim sCmd As String = Cmd.Program + " " + Cmd.Argument


Print "Ready to execute ";sCmd
Print "Press any key to start...";
GetKey()
Print ""
Print String(40,"=")

'Dim result As Integer = shell(sCmd)
Dim result As Integer = EXEC(cmd.program,cmd.argument)
'Dim result As Integer = Run(cmd.program,cmd.argument)


Print String(40,"=")

If result = -1 Then
    Print "Error running "; sCmd
Else
    Print "Exit code:"; result
End If

Print "Press any Key to exit...";
GetKey()
Print ""
