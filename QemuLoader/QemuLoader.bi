Dim Shared hInstance As HMODULE
Dim Shared CommandLine As ZString Ptr
Dim Shared hWnd As HWND

Const ClassName="DLGCLASS"
Const AppName="Dialog as main"
Const AboutMsg=!"FbEdit Dialog as main\13\10Copyright © FbEdit 2007"

#define IDD_DIALOG              1000
#define IDC_STC1                1001
#define txtProg                 1002
#define btnBrowseProg           1003
#define IDC_STC2                1004
#define btnBrowseWork           1005
#define txtWork                 1006
#define txtDefault              1008
#define IDC_STC3                1009
#define txtAdditional           1007
#define IDC_STC4                1010
#define btnGo                   1011

