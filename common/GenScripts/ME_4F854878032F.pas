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
  {* Слово скрипта wnd:IsVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:IsVisible >>> l_Boolean
[code]  }
  function wnd_IsVisible(const aCtx: TtfwContext;
   aWnd: THandle): Boolean;
   {* Реализация слова скрипта wnd:IsVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndIsVisible
 
 TkwWndGetClassName = class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd wnd:GetClassName >>> l_String
[code]  }
  function wnd_GetClassName(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* Реализация слова скрипта wnd:GetClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndGetClassName
 
 TkwWndGetWindowText = class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetWindowText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd wnd:GetWindowText >>> l_String
[code]  }
  function wnd_GetWindowText(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* Реализация слова скрипта wnd:GetWindowText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndGetWindowText
 
 TkwWndCloseWindow = class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:CloseWindow
*Пример:*
[code]
 aWnd wnd:CloseWindow
[code]  }
  procedure wnd_CloseWindow(const aCtx: TtfwContext;
   aWnd: THandle);
   {* Реализация слова скрипта wnd:CloseWindow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndCloseWindow
 
 TkwWndWindowIsMine = class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:WindowIsMine
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:WindowIsMine >>> l_Boolean
[code]  }
  function wnd_WindowIsMine(const aCtx: TtfwContext;
   aWnd: THandle): Boolean;
   {* Реализация слова скрипта wnd:WindowIsMine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndWindowIsMine
 
 TkwWndSetForeground = class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:SetForeground
*Пример:*
[code]
 aWnd wnd:SetForeground
[code]  }
  procedure wnd_SetForeground(const aCtx: TtfwContext;
   aWnd: THandle);
   {* Реализация слова скрипта wnd:SetForeground }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWndSetForeground
 
 TkwWinTreeGetCurrentText = class(TtfwGlobalKeyWord)
  {* Слово скрипта WinTreeGetCurrentText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd WinTreeGetCurrentText >>> l_String
[code]  }
  function WinTreeGetCurrentText(const aCtx: TtfwContext;
   aWnd: THandle): AnsiString;
   {* Реализация слова скрипта WinTreeGetCurrentText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWinTreeGetCurrentText
 
 TkwIterateChildWindows = class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateChildWindows
*Пример:*
[code]
 aLambda aWnd IterateChildWindows
[code]  }
  procedure IterateChildWindows(const aCtx: TtfwContext;
   aWnd: THandle;
   aLambda: TtfwWord);
   {* Реализация слова скрипта IterateChildWindows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateChildWindows
 
 TkwIterateWindows = class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateWindows
*Пример:*
[code]
 aLambda IterateWindows
[code]  }
  procedure IterateWindows(const aCtx: TtfwContext;
   aLambda: TtfwWord);
   {* Реализация слова скрипта IterateWindows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIterateWindows
 
 TkwWindowFromPoint = class(TtfwGlobalKeyWord)
  {* Слово скрипта WindowFromPoint
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 aPoint WindowFromPoint >>> l_THandle
[code]  }
  function WindowFromPoint(const aCtx: TtfwContext;
   const aPoint: TPoint): THandle;
   {* Реализация слова скрипта WindowFromPoint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWindowFromPoint
 
 TkwGetForegroundWindow = class(TtfwGlobalKeyWord)
  {* Слово скрипта GetForegroundWindow
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 GetForegroundWindow >>> l_THandle
[code]  }
  function GetForegroundWindow(const aCtx: TtfwContext): THandle;
   {* Реализация слова скрипта GetForegroundWindow }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetForegroundWindow
 
 TkwFindWindowByCaption = class(TtfwGlobalKeyWord)
  {* Слово скрипта FindWindowByCaption
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 aCaption FindWindowByCaption >>> l_THandle
[code]  }
  function FindWindowByCaption(const aCtx: TtfwContext;
   const aCaption: AnsiString): THandle;
   {* Реализация слова скрипта FindWindowByCaption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFindWindowByCaption
 
 TkwSetFuzzInPercent = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetFuzzInPercent
*Пример:*
[code]
 aValue SetFuzzInPercent
[code]  }
  procedure SetFuzzInPercent(const aCtx: TtfwContext;
   aValue: Integer);
   {* Реализация слова скрипта SetFuzzInPercent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetFuzzInPercent
 
 TkwDesktopHeight = class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 desktop:Height >>> l_Integer
[code]  }
  function desktop_Height(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта desktop:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDesktopHeight
 
 TkwDesktopWidth = class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 desktop:Width >>> l_Integer
[code]  }
  function desktop_Width(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта desktop:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDesktopWidth
 
 TkwScreenWidth = class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Width >>> l_Integer
[code]  }
  function screen_Width(const aCtx: TtfwContext;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта screen:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenWidth
 
 TkwScreenHeight = class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Height >>> l_Integer
[code]  }
  function screen_Height(const aCtx: TtfwContext;
   anIndex: Integer): Integer;
   {* Реализация слова скрипта screen:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenHeight
 
 TkwMainScreenWidth = class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 MainScreen:Width >>> l_Integer
[code]  }
  function MainScreen_Width(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта MainScreen:Width }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainScreenWidth
 
 TkwMainScreenHeight = class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 MainScreen:Height >>> l_Integer
[code]  }
  function MainScreen_Height(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта MainScreen:Height }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainScreenHeight
 
 TkwScreenCount = class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 ScreenCount >>> l_Integer
[code]  }
  function ScreenCount(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта ScreenCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenCount
 
 TkwAskWindowToCloseItself = class(TtfwGlobalKeyWord)
  {* Слово скрипта AskWindowToCloseItself
*Пример:*
[code]
 aWnd AskWindowToCloseItself
[code]  }
  procedure AskWindowToCloseItself(const aCtx: TtfwContext;
   const aWnd: TtfwStackValue);
   {* Реализация слова скрипта AskWindowToCloseItself }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwAskWindowToCloseItself
 
 TkwScreenShot2File = class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenShot2File
[panel]Описание: снимает скриншот с передаваемого контрола и сохраняет его в файл bmp. Формат:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2File
[code]
где aFileName - имя файла с расширением bmp, в который сохранять скриншот
aHandle - хендл контрола, с которого снимаем скриншот (0 - для снятия скриншота с десктопа).
aLeft, aTop, aWidth, aHeight - начальные координаты и размеры прямоугольной области, с которой снимаем скриншот.
Пример:
[code]
  INTEGER VAR l_Handle
  "Контрол в фокусе" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2File
[code][panel]
*Пример:*
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
   {* Реализация слова скрипта ScreenShot2File }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenShot2File
 
 TkwScreenShot2FileWithCheck = class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenShot2FileWithCheck
[panel]Описание: снимает скриншот с передаваемого контрола и сохраняет его в файл bmp. После окончания теста производится сравнение с эталоном.
Формат:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2FileWithCheck
[code]
где aFileName - имя файла с расширением bmp, в который сохранять скриншот
aHandle - хендл контрола, с которого снимаем скриншот (0 - для снятия скриншота с десктопа).
aLeft, aTop, aWidth, aHeight - начальные координаты и размеры прямоугольной области, с которой снимаем скриншот.
Пример:
[code]
  INTEGER VAR l_Handle
  "Контрол в фокусе" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2FileWithCheck
[code][panel]
*Пример:*
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
   {* Реализация слова скрипта ScreenShot2FileWithCheck }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScreenShot2FileWithCheck
 
end.
