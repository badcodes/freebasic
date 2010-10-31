#Define IDD_DIALOG			1000

#Define IDM_MENU				10000
#Define IDM_FILE_EXIT		10001
#Define IDM_HELP_ABOUT		10101

Dim Shared hInstance As HMODULE
Dim Shared CommandLine As ZString Ptr
Dim Shared hWnd As HWND

Const ClassName="DLGCLASS"
Const AppName="Dialog as main"
Const AboutMsg=!"FbEdit Dialog as main\13\10Copyright © FbEdit 2007"
