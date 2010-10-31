#include once "windows.bi"
#Include Once "win/commctrl.bi"
#Include Once "win/commdlg.bi"
#Include Once "win/shellapi.bi"
#Include "QemuLoader.bi"
Function BrowseProg_Click(ByVal hWin As HWND) As Integer
	Dim txtBox As HWND
	Dim Text As String = "BrowseProg_Click"
	txtBox = GetDlgItem(hWin,txtProg)
	Return SendMessage(txtBox,WM_SETTEXT,0,StrPtr(Text))
End Function

Function BrowseWork_Click(ByVal hWin As HWND) As Integer
	Dim txtBox As HWND
	Dim Text As String = "BrowseWork_Click"
	txtBox = GetDlgItem(hWin,txtWork)
	Return SendMessage(txtBox,WM_SETTEXT,0,StrPtr(Text))
	
End Function

Function Go_Click(ByVal hWin As HWND) As Integer
	Dim Text As String = "Go_Click"
	Return SendMessage(hWin,WM_SETTEXT,0,StrPtr(Text))

End Function

Function WndProc(ByVal hWin As HWND,ByVal uMsg As UINT,ByVal wParam As WPARAM,ByVal lParam As LPARAM) As Integer

	Select Case uMsg
		Case WM_INITDIALOG
			hWnd=hWin
			'
		Case WM_COMMAND
			Select Case HiWord(wParam)
				Case BN_CLICKED,1
					Select Case LoWord(wParam)
						Case btnBrowseProg
							BrowseProg_Click(hWin)
						Case btnBrowseWork
							BrowseWork_Click(hWin)
						Case btnGo
							Go_Click(hWin)
					End Select
					'
			End Select
			'
		Case WM_SIZE
			'
		Case WM_CLOSE
			DestroyWindow(hWin)
			'
		Case WM_DESTROY
			PostQuitMessage(NULL)
			'
		Case Else
			Return DefWindowProc(hWin,uMsg,wParam,lParam)
			'
	End Select
	Return 0

End Function

Function WinMain(ByVal hInst As HINSTANCE,ByVal hPrevInst As HINSTANCE,ByVal CmdLine As ZString ptr,ByVal CmdShow As Integer) As Integer
	Dim wc As WNDCLASSEX
	Dim msg As MSG

	' Setup and register class for dialog
	wc.cbSize=SizeOf(WNDCLASSEX)
	wc.style=CS_HREDRAW or CS_VREDRAW
	wc.lpfnWndProc=@WndProc
	wc.cbClsExtra=0
	wc.cbWndExtra=DLGWINDOWEXTRA
	wc.hInstance=hInst
	wc.hbrBackground=Cast(HBRUSH,COLOR_BTNFACE+1)
	'wc.lpszMenuName=Cast(ZString Ptr,IDM_MENU)
	wc.lpszClassName=@ClassName
	wc.hIcon=LoadIcon(NULL,IDI_APPLICATION)
	wc.hIconSm=wc.hIcon
	wc.hCursor=LoadCursor(NULL,IDC_ARROW)
	RegisterClassEx(@wc)
	' Create and show the dialog
	CreateDialogParam(hInstance,Cast(ZString Ptr,IDD_DIALOG),NULL,@WndProc,NULL)
	ShowWindow(hWnd,SW_SHOWNORMAL)
	UpdateWindow(hWnd)
	' Message loop
	Do While GetMessage(@msg,NULL,0,0)
		TranslateMessage(@msg)
		DispatchMessage(@msg)
	Loop
	Return msg.wParam

End Function

' Program start
hInstance=GetModuleHandle(NULL)
CommandLine=GetCommandLine
InitCommonControls
WinMain(hInstance,NULL,CommandLine,SW_SHOWDEFAULT)
ExitProcess(0)

End
