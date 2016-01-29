unit WinUtilsPack;

interface

uses
 l3IntfUses
 , Windows
 , tfwScriptingInterfaces
 , Types
 , tfwTypeInfo
 , tfwGlobalKeyWord
 , TypInfo
;

implementation

uses
 l3ImplUses
 , SysUtils
 , Messages
 , CommCtrl
 , l3ImageUtils
 , Forms
 , Controls
 , l3CloseFormHelper
 , Graphics
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TkwWndIsVisible = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:IsVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:IsVisible >>> l_Boolean
[code]  }
  function wnd_IsVisible(const aCtx: TtfwContext;
   aWnd: THandle): Boolean;
   {* ���������� ����� ������� wnd:IsVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndIsVisible
 
 TkwWndGetClassName = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:GetClassName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd wnd:GetClassName >>> l_String
[code]  }
  function wnd_GetClassName(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* ���������� ����� ������� wnd:GetClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndGetClassName
 
 TkwWndGetWindowText = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:GetWindowText
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd wnd:GetWindowText >>> l_String
[code]  }
  function wnd_GetWindowText(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* ���������� ����� ������� wnd:GetWindowText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndGetWindowText
 
 TkwWndCloseWindow = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:CloseWindow
*������:*
[code]
 aWnd wnd:CloseWindow
[code]  }
  procedure wnd_CloseWindow(const aCtx: TtfwContext;
   aWnd: THandle);
   {* ���������� ����� ������� wnd:CloseWindow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndCloseWindow
 
 TkwWndWindowIsMine = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:WindowIsMine
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:WindowIsMine >>> l_Boolean
[code]  }
  function wnd_WindowIsMine(const aCtx: TtfwContext;
   aWnd: THandle): Boolean;
   {* ���������� ����� ������� wnd:WindowIsMine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndWindowIsMine
 
 TkwWndSetForeground = class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:SetForeground
*������:*
[code]
 aWnd wnd:SetForeground
[code]  }
  procedure wnd_SetForeground(const aCtx: TtfwContext;
   aWnd: THandle);
   {* ���������� ����� ������� wnd:SetForeground }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndSetForeground
 
 TkwWinTreeGetCurrentText = class(TtfwGlobalKeyWord)
  {* ����� ������� WinTreeGetCurrentText
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd WinTreeGetCurrentText >>> l_String
[code]  }
  function WinTreeGetCurrentText(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* ���������� ����� ������� WinTreeGetCurrentText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWinTreeGetCurrentText
 
 TkwIterateChildWindows = class(TtfwGlobalKeyWord)
  {* ����� ������� IterateChildWindows
*������:*
[code]
 aLambda aWnd IterateChildWindows
[code]  }
  procedure IterateChildWindows(const aCtx: TtfwContext;
   aWnd: THandle;
   aLambda: TtfwWord);
   {* ���������� ����� ������� IterateChildWindows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateChildWindows
 
 TkwIterateWindows = class(TtfwGlobalKeyWord)
  {* ����� ������� IterateWindows
*������:*
[code]
 aLambda IterateWindows
[code]  }
  procedure IterateWindows(const aCtx: TtfwContext;
   aLambda: TtfwWord);
   {* ���������� ����� ������� IterateWindows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateWindows
 
 TkwWindowFromPoint = class(TtfwGlobalKeyWord)
  {* ����� ������� WindowFromPoint
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 aPoint WindowFromPoint >>> l_THandle
[code]  }
  function WindowFromPoint(const aCtx: TtfwContext;
   const aPoint: TPoint): THandle;
   {* ���������� ����� ������� WindowFromPoint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWindowFromPoint
 
 TkwGetForegroundWindow = class(TtfwGlobalKeyWord)
  {* ����� ������� GetForegroundWindow
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 GetForegroundWindow >>> l_THandle
[code]  }
  function GetForegroundWindow(const aCtx: TtfwContext): THandle;
   {* ���������� ����� ������� GetForegroundWindow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetForegroundWindow
 
 TkwFindWindowByCaption = class(TtfwGlobalKeyWord)
  {* ����� ������� FindWindowByCaption
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 aCaption FindWindowByCaption >>> l_THandle
[code]  }
  function FindWindowByCaption(const aCtx: TtfwContext;
   const aCaption: AnsiString): THandle;
   {* ���������� ����� ������� FindWindowByCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFindWindowByCaption
 
 TkwSetFuzzInPercent = class(TtfwGlobalKeyWord)
  {* ����� ������� SetFuzzInPercent
*������:*
[code]
 aValue SetFuzzInPercent
[code]  }
  procedure SetFuzzInPercent(const aCtx: TtfwContext;
   aValue: Integer);
   {* ���������� ����� ������� SetFuzzInPercent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetFuzzInPercent
 
 TkwDesktopHeight = class(TtfwGlobalKeyWord)
  {* ����� ������� desktop:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 desktop:Height >>> l_Integer
[code]  }
  function desktop_Height(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� desktop:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDesktopHeight
 
 TkwDesktopWidth = class(TtfwGlobalKeyWord)
  {* ����� ������� desktop:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 desktop:Width >>> l_Integer
[code]  }
  function desktop_Width(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� desktop:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDesktopWidth
 
 TkwScreenWidth = class(TtfwGlobalKeyWord)
  {* ����� ������� screen:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Width >>> l_Integer
[code]  }
  function screen_Width(const aCtx: TtfwContext;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� screen:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenWidth
 
 TkwScreenHeight = class(TtfwGlobalKeyWord)
  {* ����� ������� screen:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Height >>> l_Integer
[code]  }
  function screen_Height(const aCtx: TtfwContext;
   anIndex: Integer): Integer;
   {* ���������� ����� ������� screen:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenHeight
 
 TkwMainScreenWidth = class(TtfwGlobalKeyWord)
  {* ����� ������� MainScreen:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 MainScreen:Width >>> l_Integer
[code]  }
  function MainScreen_Width(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� MainScreen:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainScreenWidth
 
 TkwMainScreenHeight = class(TtfwGlobalKeyWord)
  {* ����� ������� MainScreen:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 MainScreen:Height >>> l_Integer
[code]  }
  function MainScreen_Height(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� MainScreen:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainScreenHeight
 
 TkwScreenCount = class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 ScreenCount >>> l_Integer
[code]  }
  function ScreenCount(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� ScreenCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenCount
 
 TkwAskWindowToCloseItself = class(TtfwGlobalKeyWord)
  {* ����� ������� AskWindowToCloseItself
*������:*
[code]
 aWnd AskWindowToCloseItself
[code]  }
  procedure AskWindowToCloseItself(const aCtx: TtfwContext;
   const aWnd: TtfwStackValue);
   {* ���������� ����� ������� AskWindowToCloseItself }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwAskWindowToCloseItself
 
 TkwScreenShot2File = class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenShot2File
[panel]��������: ������� �������� � ������������� �������� � ��������� ��� � ���� bmp. ������:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2File
[code]
��� aFileName - ��� ����� � ����������� bmp, � ������� ��������� ��������
aHandle - ����� ��������, � �������� ������� �������� (0 - ��� ������ ��������� � ��������).
aLeft, aTop, aWidth, aHeight - ��������� ���������� � ������� ������������� �������, � ������� ������� ��������.
������:
[code]
  INTEGER VAR l_Handle
  "������� � ������" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2File
[code][panel]
*������:*
[code]
 aFileName aHeight aWidth aTop aLeft aWnd ScreenShot2File
[code]  }
  procedure ScreenShot2File(const aCtx: TtfwContext;
   aWnd: THandle;
   aLeft: Integer;
   aTop: Integer;
   aWidth: Integer;
   aHeight: Integer;
   const aFileName: AnsiString);
   {* ���������� ����� ������� ScreenShot2File }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenShot2File
 
 TkwScreenShot2FileWithCheck = class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenShot2FileWithCheck
[panel]��������: ������� �������� � ������������� �������� � ��������� ��� � ���� bmp. ����� ��������� ����� ������������ ��������� � ��������.
������:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2FileWithCheck
[code]
��� aFileName - ��� ����� � ����������� bmp, � ������� ��������� ��������
aHandle - ����� ��������, � �������� ������� �������� (0 - ��� ������ ��������� � ��������).
aLeft, aTop, aWidth, aHeight - ��������� ���������� � ������� ������������� �������, � ������� ������� ��������.
������:
[code]
  INTEGER VAR l_Handle
  "������� � ������" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2FileWithCheck
[code][panel]
*������:*
[code]
 aFileName aHeight aWidth aTop aLeft aWnd ScreenShot2FileWithCheck
[code]  }
  procedure ScreenShot2FileWithCheck(const aCtx: TtfwContext;
   aWnd: THandle;
   aLeft: Integer;
   aTop: Integer;
   aWidth: Integer;
   aHeight: Integer;
   const aFileName: AnsiString);
   {* ���������� ����� ������� ScreenShot2FileWithCheck }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenShot2FileWithCheck
 
end.
