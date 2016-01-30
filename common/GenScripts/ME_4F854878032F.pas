unit WinUtilsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoWindows)}
uses
 l3IntfUses
 , Windows
 , tfwScriptingInterfaces
 , Types
 , tfwTypeInfo
 , tfwGlobalKeyWord
 , TypInfo
;

function IterateWindowsMethod(hWindow: THandle;
 aData: PtfwWordCallContext): Boolean;
procedure MakeScreenshot(aWnd: THandle;
 const aRect: TRect;
 const aFileName: AnsiString;
 aWithCheck: Boolean;
 const aCtx: TtfwContext;
 aCaller: TtfwWord);
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoWindows)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoWindows)}
uses
 l3ImplUses
 , SysUtils
 , Messages
 , CommCtrl
 , l3ImageUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3CloseFormHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TkwWndIsVisible = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:IsVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:IsVisible >>> l_Boolean
[code]  }
  private
   function wnd_IsVisible(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
    {* Реализация слова скрипта wnd:IsVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndIsVisible

 TkwWndGetClassName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd wnd:GetClassName >>> l_String
[code]  }
  private
   function wnd_GetClassName(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта wnd:GetClassName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetClassName

 TkwWndGetWindowText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetWindowText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd wnd:GetWindowText >>> l_String
[code]  }
  private
   function wnd_GetWindowText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта wnd:GetWindowText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetWindowText

 TkwWndCloseWindow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:CloseWindow
*Пример:*
[code]
 aWnd wnd:CloseWindow
[code]  }
  private
   procedure wnd_CloseWindow(const aCtx: TtfwContext;
    aWnd: THandle);
    {* Реализация слова скрипта wnd:CloseWindow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndCloseWindow

 TkwWndWindowIsMine = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:WindowIsMine
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:WindowIsMine >>> l_Boolean
[code]  }
  private
   function wnd_WindowIsMine(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
    {* Реализация слова скрипта wnd:WindowIsMine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndWindowIsMine

 TkwWndSetForeground = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:SetForeground
*Пример:*
[code]
 aWnd wnd:SetForeground
[code]  }
  private
   procedure wnd_SetForeground(const aCtx: TtfwContext;
    aWnd: THandle);
    {* Реализация слова скрипта wnd:SetForeground }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndSetForeground

 TkwWinTreeGetCurrentText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WinTreeGetCurrentText
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aWnd WinTreeGetCurrentText >>> l_String
[code]  }
  private
   function WinTreeGetCurrentText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта WinTreeGetCurrentText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWinTreeGetCurrentText

 TkwIterateChildWindows = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateChildWindows
*Пример:*
[code]
 aLambda aWnd IterateChildWindows
[code]  }
  private
   procedure IterateChildWindows(const aCtx: TtfwContext;
    aWnd: THandle;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateChildWindows }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateChildWindows

 TkwIterateWindows = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateWindows
*Пример:*
[code]
 aLambda IterateWindows
[code]  }
  private
   procedure IterateWindows(const aCtx: TtfwContext;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateWindows }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateWindows

 TkwWindowFromPoint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WindowFromPoint
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 aPoint WindowFromPoint >>> l_THandle
[code]  }
  private
   function WindowFromPoint(const aCtx: TtfwContext;
    const aPoint: TPoint): THandle;
    {* Реализация слова скрипта WindowFromPoint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWindowFromPoint

 TkwGetForegroundWindow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetForegroundWindow
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 GetForegroundWindow >>> l_THandle
[code]  }
  private
   function GetForegroundWindow(const aCtx: TtfwContext): THandle;
    {* Реализация слова скрипта GetForegroundWindow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetForegroundWindow

 TkwFindWindowByCaption = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта FindWindowByCaption
*Тип результата:* THandle
*Пример:*
[code]
CARDINAL VAR l_THandle
 aCaption FindWindowByCaption >>> l_THandle
[code]  }
  private
   function FindWindowByCaption(const aCtx: TtfwContext;
    const aCaption: AnsiString): THandle;
    {* Реализация слова скрипта FindWindowByCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFindWindowByCaption

 TkwSetFuzzInPercent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetFuzzInPercent
*Пример:*
[code]
 aValue SetFuzzInPercent
[code]  }
  private
   procedure SetFuzzInPercent(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта SetFuzzInPercent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetFuzzInPercent

 TkwDesktopHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 desktop:Height >>> l_Integer
[code]  }
  private
   function desktop_Height(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта desktop:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopHeight

 TkwDesktopWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 desktop:Width >>> l_Integer
[code]  }
  private
   function desktop_Width(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта desktop:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopWidth

 TkwScreenWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Width >>> l_Integer
[code]  }
  private
   function screen_Width(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
    {* Реализация слова скрипта screen:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenWidth

 TkwScreenHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Height >>> l_Integer
[code]  }
  private
   function screen_Height(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
    {* Реализация слова скрипта screen:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenHeight

 TkwMainScreenWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 MainScreen:Width >>> l_Integer
[code]  }
  private
   function MainScreen_Width(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта MainScreen:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenWidth

 TkwMainScreenHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 MainScreen:Height >>> l_Integer
[code]  }
  private
   function MainScreen_Height(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта MainScreen:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenHeight

 TkwScreenCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 ScreenCount >>> l_Integer
[code]  }
  private
   function ScreenCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта ScreenCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenCount

 TkwAskWindowToCloseItself = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта AskWindowToCloseItself
*Пример:*
[code]
 aWnd AskWindowToCloseItself
[code]  }
  private
   procedure AskWindowToCloseItself(const aCtx: TtfwContext;
    const aWnd: TtfwStackValue);
    {* Реализация слова скрипта AskWindowToCloseItself }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAskWindowToCloseItself

 TkwScreenShot2File = {final} class(TtfwGlobalKeyWord)
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
  private
   procedure ScreenShot2File(const aCtx: TtfwContext;
    aWnd: THandle;
    aLeft: Integer;
    aTop: Integer;
    aWidth: Integer;
    aHeight: Integer;
    const aFileName: AnsiString);
    {* Реализация слова скрипта ScreenShot2File }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenShot2File

 TkwScreenShot2FileWithCheck = {final} class(TtfwGlobalKeyWord)
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
  private
   procedure ScreenShot2FileWithCheck(const aCtx: TtfwContext;
    aWnd: THandle;
    aLeft: Integer;
    aTop: Integer;
    aWidth: Integer;
    aHeight: Integer;
    const aFileName: AnsiString);
    {* Реализация слова скрипта ScreenShot2FileWithCheck }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenShot2FileWithCheck

function IterateWindowsMethod(hWindow: THandle;
 aData: PtfwWordCallContext): Boolean;
//#UC START# *510AB608018E_4F854878032F_var*
//#UC END# *510AB608018E_4F854878032F_var*
begin
//#UC START# *510AB608018E_4F854878032F_impl*
 Result := True;
 try
  aData.rCtx.rEngine.PushInt(Integer(hWindow));
  aData.rWord.DoIt(aData.rCtx^);
 except
  on EtfwBreakIterator do
   Result := False;
 end;//try..except
//#UC END# *510AB608018E_4F854878032F_impl*
end;//IterateWindowsMethod

procedure MakeScreenshot(aWnd: THandle;
 const aRect: TRect;
 const aFileName: AnsiString;
 aWithCheck: Boolean;
 const aCtx: TtfwContext;
 aCaller: TtfwWord);
//#UC START# *551D697C0023_4F854878032F_var*
var
 l_Top     : Integer;
 l_Left    : Integer;
 l_Width   : Integer;
 l_Height  : Integer;
 l_Bitmap  : TBitmap;
 l_FileName: AnsiString;
//#UC END# *551D697C0023_4F854878032F_var*
begin
//#UC START# *551D697C0023_4F854878032F_impl*
 l_Bitmap := TBitmap.Create;
 try
  l_Left := aRect.Left;
  l_Top := aRect.Top;
  l_Width := aRect.Right - aRect.Left;
  l_Height := aRect.Bottom - aRect.Top;
  aCaller.RunnerAssert(l_Height > 0, 'Высота скриншота меньше или равна 0.', aCtx);
  aCaller.RunnerAssert(l_Width > 0, 'Ширина скриншота меньше или равна 0.', aCtx);
  l3MakeScreenShot(l_Bitmap, l_Left, l_Top, l_Width, l_Height, aWnd);
  l_FileName := aCtx.rCaller.ResolveOutputFilePath(aFileName);
  l_Bitmap.SaveToFile(l_FileName);
  if aWithCheck then
  begin
   with Tl3PicturePathService.Instance do
   begin
    AddPicturePath(l_FileName);
    SetTestName('');
   end; // with Tl3PicturePathService.Instance do
   aCtx.rCaller.CheckPictureOnly;
  end;//aWithCheck
 finally
  FreeAndNil(l_Bitmap);
 end;
//#UC END# *551D697C0023_4F854878032F_impl*
end;//MakeScreenshot

function TkwWndIsVisible.wnd_IsVisible(const aCtx: TtfwContext;
 aWnd: THandle): Boolean;
 {* Реализация слова скрипта wnd:IsVisible }
//#UC START# *51F7DBC755B8_CB65D7FF1E6C_var*
//#UC END# *51F7DBC755B8_CB65D7FF1E6C_var*
begin
//#UC START# *51F7DBC755B8_CB65D7FF1E6C_impl*
 Result := Windows.IsWindowVisible(aWnd);
//#UC END# *51F7DBC755B8_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.wnd_IsVisible

procedure TkwWndIsVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB65D7FF1E6C_var*
//#UC END# *4DAEEDE10285_CB65D7FF1E6C_var*
begin
//#UC START# *4DAEEDE10285_CB65D7FF1E6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.DoDoIt

class function TkwWndIsVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:IsVisible';
end;//TkwWndIsVisible.GetWordNameForRegister

function TkwWndIsVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CB65D7FF1E6C_var*
//#UC END# *551544E2001A_CB65D7FF1E6C_var*
begin
//#UC START# *551544E2001A_CB65D7FF1E6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.GetResultTypeInfo

function TkwWndIsVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_CB65D7FF1E6C_var*
//#UC END# *559687E6025A_CB65D7FF1E6C_var*
begin
//#UC START# *559687E6025A_CB65D7FF1E6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.GetAllParamsCount

function TkwWndIsVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CB65D7FF1E6C_var*
//#UC END# *5617F4D00243_CB65D7FF1E6C_var*
begin
//#UC START# *5617F4D00243_CB65D7FF1E6C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.ParamsTypes

function TkwWndGetClassName.wnd_GetClassName(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта wnd:GetClassName }
//#UC START# *E554A2B1DE10_455E9214E4B7_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *E554A2B1DE10_455E9214E4B7_var*
begin
//#UC START# *E554A2B1DE10_455E9214E4B7_impl*
 GetClassName(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *E554A2B1DE10_455E9214E4B7_impl*
end;//TkwWndGetClassName.wnd_GetClassName

procedure TkwWndGetClassName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_455E9214E4B7_var*
//#UC END# *4DAEEDE10285_455E9214E4B7_var*
begin
//#UC START# *4DAEEDE10285_455E9214E4B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_455E9214E4B7_impl*
end;//TkwWndGetClassName.DoDoIt

class function TkwWndGetClassName.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:GetClassName';
end;//TkwWndGetClassName.GetWordNameForRegister

function TkwWndGetClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_455E9214E4B7_var*
//#UC END# *551544E2001A_455E9214E4B7_var*
begin
//#UC START# *551544E2001A_455E9214E4B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_455E9214E4B7_impl*
end;//TkwWndGetClassName.GetResultTypeInfo

function TkwWndGetClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_455E9214E4B7_var*
//#UC END# *559687E6025A_455E9214E4B7_var*
begin
//#UC START# *559687E6025A_455E9214E4B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_455E9214E4B7_impl*
end;//TkwWndGetClassName.GetAllParamsCount

function TkwWndGetClassName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_455E9214E4B7_var*
//#UC END# *5617F4D00243_455E9214E4B7_var*
begin
//#UC START# *5617F4D00243_455E9214E4B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_455E9214E4B7_impl*
end;//TkwWndGetClassName.ParamsTypes

function TkwWndGetWindowText.wnd_GetWindowText(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта wnd:GetWindowText }
//#UC START# *38FB07665775_6ECBEE6894B8_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *38FB07665775_6ECBEE6894B8_var*
begin
//#UC START# *38FB07665775_6ECBEE6894B8_impl*
 GetWindowText(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *38FB07665775_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.wnd_GetWindowText

procedure TkwWndGetWindowText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6ECBEE6894B8_var*
//#UC END# *4DAEEDE10285_6ECBEE6894B8_var*
begin
//#UC START# *4DAEEDE10285_6ECBEE6894B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.DoDoIt

class function TkwWndGetWindowText.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:GetWindowText';
end;//TkwWndGetWindowText.GetWordNameForRegister

function TkwWndGetWindowText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6ECBEE6894B8_var*
//#UC END# *551544E2001A_6ECBEE6894B8_var*
begin
//#UC START# *551544E2001A_6ECBEE6894B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.GetResultTypeInfo

function TkwWndGetWindowText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6ECBEE6894B8_var*
//#UC END# *559687E6025A_6ECBEE6894B8_var*
begin
//#UC START# *559687E6025A_6ECBEE6894B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.GetAllParamsCount

function TkwWndGetWindowText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6ECBEE6894B8_var*
//#UC END# *5617F4D00243_6ECBEE6894B8_var*
begin
//#UC START# *5617F4D00243_6ECBEE6894B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.ParamsTypes

procedure TkwWndCloseWindow.wnd_CloseWindow(const aCtx: TtfwContext;
 aWnd: THandle);
 {* Реализация слова скрипта wnd:CloseWindow }
//#UC START# *EF73ED47DC1E_B3B5EA3F1514_var*
//#UC END# *EF73ED47DC1E_B3B5EA3F1514_var*
begin
//#UC START# *EF73ED47DC1E_B3B5EA3F1514_impl*
 SendMessage(aWnd, WM_CLOSE, 0, 0);
//#UC END# *EF73ED47DC1E_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.wnd_CloseWindow

procedure TkwWndCloseWindow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B3B5EA3F1514_var*
//#UC END# *4DAEEDE10285_B3B5EA3F1514_var*
begin
//#UC START# *4DAEEDE10285_B3B5EA3F1514_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.DoDoIt

class function TkwWndCloseWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:CloseWindow';
end;//TkwWndCloseWindow.GetWordNameForRegister

function TkwWndCloseWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B3B5EA3F1514_var*
//#UC END# *551544E2001A_B3B5EA3F1514_var*
begin
//#UC START# *551544E2001A_B3B5EA3F1514_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.GetResultTypeInfo

function TkwWndCloseWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B3B5EA3F1514_var*
//#UC END# *559687E6025A_B3B5EA3F1514_var*
begin
//#UC START# *559687E6025A_B3B5EA3F1514_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.GetAllParamsCount

function TkwWndCloseWindow.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B3B5EA3F1514_var*
//#UC END# *5617F4D00243_B3B5EA3F1514_var*
begin
//#UC START# *5617F4D00243_B3B5EA3F1514_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.ParamsTypes

function TkwWndWindowIsMine.wnd_WindowIsMine(const aCtx: TtfwContext;
 aWnd: THandle): Boolean;
 {* Реализация слова скрипта wnd:WindowIsMine }
//#UC START# *7F8BF12C6C7F_C09FEECC1053_var*
var
 l_Process: DWORD;
//#UC END# *7F8BF12C6C7F_C09FEECC1053_var*
begin
//#UC START# *7F8BF12C6C7F_C09FEECC1053_impl*
 GetWindowThreadProcessId(aWnd, l_Process);
 Result := (l_Process = GetCurrentProcessId);
//#UC END# *7F8BF12C6C7F_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.wnd_WindowIsMine

procedure TkwWndWindowIsMine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C09FEECC1053_var*
//#UC END# *4DAEEDE10285_C09FEECC1053_var*
begin
//#UC START# *4DAEEDE10285_C09FEECC1053_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.DoDoIt

class function TkwWndWindowIsMine.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:WindowIsMine';
end;//TkwWndWindowIsMine.GetWordNameForRegister

function TkwWndWindowIsMine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C09FEECC1053_var*
//#UC END# *551544E2001A_C09FEECC1053_var*
begin
//#UC START# *551544E2001A_C09FEECC1053_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.GetResultTypeInfo

function TkwWndWindowIsMine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C09FEECC1053_var*
//#UC END# *559687E6025A_C09FEECC1053_var*
begin
//#UC START# *559687E6025A_C09FEECC1053_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.GetAllParamsCount

function TkwWndWindowIsMine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C09FEECC1053_var*
//#UC END# *5617F4D00243_C09FEECC1053_var*
begin
//#UC START# *5617F4D00243_C09FEECC1053_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.ParamsTypes

procedure TkwWndSetForeground.wnd_SetForeground(const aCtx: TtfwContext;
 aWnd: THandle);
 {* Реализация слова скрипта wnd:SetForeground }
//#UC START# *D113CC850E0F_1C5511E4225D_var*
//#UC END# *D113CC850E0F_1C5511E4225D_var*
begin
//#UC START# *D113CC850E0F_1C5511E4225D_impl*
 Windows.SetForegroundWindow(aWnd);
//#UC END# *D113CC850E0F_1C5511E4225D_impl*
end;//TkwWndSetForeground.wnd_SetForeground

procedure TkwWndSetForeground.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C5511E4225D_var*
//#UC END# *4DAEEDE10285_1C5511E4225D_var*
begin
//#UC START# *4DAEEDE10285_1C5511E4225D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C5511E4225D_impl*
end;//TkwWndSetForeground.DoDoIt

class function TkwWndSetForeground.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:SetForeground';
end;//TkwWndSetForeground.GetWordNameForRegister

function TkwWndSetForeground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1C5511E4225D_var*
//#UC END# *551544E2001A_1C5511E4225D_var*
begin
//#UC START# *551544E2001A_1C5511E4225D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1C5511E4225D_impl*
end;//TkwWndSetForeground.GetResultTypeInfo

function TkwWndSetForeground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1C5511E4225D_var*
//#UC END# *559687E6025A_1C5511E4225D_var*
begin
//#UC START# *559687E6025A_1C5511E4225D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1C5511E4225D_impl*
end;//TkwWndSetForeground.GetAllParamsCount

function TkwWndSetForeground.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C5511E4225D_var*
//#UC END# *5617F4D00243_1C5511E4225D_var*
begin
//#UC START# *5617F4D00243_1C5511E4225D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C5511E4225D_impl*
end;//TkwWndSetForeground.ParamsTypes

function TkwWinTreeGetCurrentText.WinTreeGetCurrentText(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта WinTreeGetCurrentText }
//#UC START# *38530DA9DB57_A893626FB9A5_var*
var
 l_Current: TTVItemA;
 l_Res: Boolean;
 l_Text: array[1..255] of AnsiChar;
//#UC END# *38530DA9DB57_A893626FB9A5_var*
begin
//#UC START# *38530DA9DB57_A893626FB9A5_impl*
 System.FillChar(l_Current, SizeOf(l_Current), 0);
 l_Current.hItem := TreeView_GetSelection(aWnd);
 l_Current.mask := TVIF_TEXT;
 l_Current.cchTextMax := 255;
 l_Current.pszText := @l_Text;

 l_Res := TreeView_GetItemA(aWnd, l_Current);
 if l_Res then
  Result := l_Current.pszText
 else
  Result := '';
//#UC END# *38530DA9DB57_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.WinTreeGetCurrentText

procedure TkwWinTreeGetCurrentText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A893626FB9A5_var*
//#UC END# *4DAEEDE10285_A893626FB9A5_var*
begin
//#UC START# *4DAEEDE10285_A893626FB9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.DoDoIt

class function TkwWinTreeGetCurrentText.GetWordNameForRegister: AnsiString;
begin
 Result := 'WinTreeGetCurrentText';
end;//TkwWinTreeGetCurrentText.GetWordNameForRegister

function TkwWinTreeGetCurrentText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A893626FB9A5_var*
//#UC END# *551544E2001A_A893626FB9A5_var*
begin
//#UC START# *551544E2001A_A893626FB9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.GetResultTypeInfo

function TkwWinTreeGetCurrentText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A893626FB9A5_var*
//#UC END# *559687E6025A_A893626FB9A5_var*
begin
//#UC START# *559687E6025A_A893626FB9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.GetAllParamsCount

function TkwWinTreeGetCurrentText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A893626FB9A5_var*
//#UC END# *5617F4D00243_A893626FB9A5_var*
begin
//#UC START# *5617F4D00243_A893626FB9A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.ParamsTypes

procedure TkwIterateChildWindows.IterateChildWindows(const aCtx: TtfwContext;
 aWnd: THandle;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateChildWindows }
//#UC START# *885E0A0E618E_BB2233135443_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *885E0A0E618E_BB2233135443_var*
begin
//#UC START# *885E0A0E618E_BB2233135443_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumChildWindows(aWnd, @IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *885E0A0E618E_BB2233135443_impl*
end;//TkwIterateChildWindows.IterateChildWindows

procedure TkwIterateChildWindows.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB2233135443_var*
//#UC END# *4DAEEDE10285_BB2233135443_var*
begin
//#UC START# *4DAEEDE10285_BB2233135443_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB2233135443_impl*
end;//TkwIterateChildWindows.DoDoIt

class function TkwIterateChildWindows.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateChildWindows';
end;//TkwIterateChildWindows.GetWordNameForRegister

function TkwIterateChildWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BB2233135443_var*
//#UC END# *551544E2001A_BB2233135443_var*
begin
//#UC START# *551544E2001A_BB2233135443_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BB2233135443_impl*
end;//TkwIterateChildWindows.GetResultTypeInfo

function TkwIterateChildWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BB2233135443_var*
//#UC END# *559687E6025A_BB2233135443_var*
begin
//#UC START# *559687E6025A_BB2233135443_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BB2233135443_impl*
end;//TkwIterateChildWindows.GetAllParamsCount

function TkwIterateChildWindows.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BB2233135443_var*
//#UC END# *5617F4D00243_BB2233135443_var*
begin
//#UC START# *5617F4D00243_BB2233135443_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BB2233135443_impl*
end;//TkwIterateChildWindows.ParamsTypes

procedure TkwIterateWindows.IterateWindows(const aCtx: TtfwContext;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateWindows }
//#UC START# *0BC1915B6BEB_2EB6B5E4913F_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *0BC1915B6BEB_2EB6B5E4913F_var*
begin
//#UC START# *0BC1915B6BEB_2EB6B5E4913F_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumWindows(@IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *0BC1915B6BEB_2EB6B5E4913F_impl*
end;//TkwIterateWindows.IterateWindows

procedure TkwIterateWindows.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2EB6B5E4913F_var*
//#UC END# *4DAEEDE10285_2EB6B5E4913F_var*
begin
//#UC START# *4DAEEDE10285_2EB6B5E4913F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2EB6B5E4913F_impl*
end;//TkwIterateWindows.DoDoIt

class function TkwIterateWindows.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateWindows';
end;//TkwIterateWindows.GetWordNameForRegister

function TkwIterateWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2EB6B5E4913F_var*
//#UC END# *551544E2001A_2EB6B5E4913F_var*
begin
//#UC START# *551544E2001A_2EB6B5E4913F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2EB6B5E4913F_impl*
end;//TkwIterateWindows.GetResultTypeInfo

function TkwIterateWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2EB6B5E4913F_var*
//#UC END# *559687E6025A_2EB6B5E4913F_var*
begin
//#UC START# *559687E6025A_2EB6B5E4913F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2EB6B5E4913F_impl*
end;//TkwIterateWindows.GetAllParamsCount

function TkwIterateWindows.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2EB6B5E4913F_var*
//#UC END# *5617F4D00243_2EB6B5E4913F_var*
begin
//#UC START# *5617F4D00243_2EB6B5E4913F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2EB6B5E4913F_impl*
end;//TkwIterateWindows.ParamsTypes

function TkwWindowFromPoint.WindowFromPoint(const aCtx: TtfwContext;
 const aPoint: TPoint): THandle;
 {* Реализация слова скрипта WindowFromPoint }
//#UC START# *6FFCD3ADC6FE_2D01DE64792B_var*
//#UC END# *6FFCD3ADC6FE_2D01DE64792B_var*
begin
//#UC START# *6FFCD3ADC6FE_2D01DE64792B_impl*
 Result := Windows.WindowFromPoint(aPoint);
//#UC END# *6FFCD3ADC6FE_2D01DE64792B_impl*
end;//TkwWindowFromPoint.WindowFromPoint

procedure TkwWindowFromPoint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D01DE64792B_var*
//#UC END# *4DAEEDE10285_2D01DE64792B_var*
begin
//#UC START# *4DAEEDE10285_2D01DE64792B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D01DE64792B_impl*
end;//TkwWindowFromPoint.DoDoIt

class function TkwWindowFromPoint.GetWordNameForRegister: AnsiString;
begin
 Result := 'WindowFromPoint';
end;//TkwWindowFromPoint.GetWordNameForRegister

function TkwWindowFromPoint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2D01DE64792B_var*
//#UC END# *551544E2001A_2D01DE64792B_var*
begin
//#UC START# *551544E2001A_2D01DE64792B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2D01DE64792B_impl*
end;//TkwWindowFromPoint.GetResultTypeInfo

function TkwWindowFromPoint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2D01DE64792B_var*
//#UC END# *559687E6025A_2D01DE64792B_var*
begin
//#UC START# *559687E6025A_2D01DE64792B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2D01DE64792B_impl*
end;//TkwWindowFromPoint.GetAllParamsCount

function TkwWindowFromPoint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2D01DE64792B_var*
//#UC END# *5617F4D00243_2D01DE64792B_var*
begin
//#UC START# *5617F4D00243_2D01DE64792B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2D01DE64792B_impl*
end;//TkwWindowFromPoint.ParamsTypes

function TkwGetForegroundWindow.GetForegroundWindow(const aCtx: TtfwContext): THandle;
 {* Реализация слова скрипта GetForegroundWindow }
//#UC START# *5CBACAD0EDFA_CB29543BBB60_var*
//#UC END# *5CBACAD0EDFA_CB29543BBB60_var*
begin
//#UC START# *5CBACAD0EDFA_CB29543BBB60_impl*
 Result := Windows.GetForegroundWindow;
//#UC END# *5CBACAD0EDFA_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.GetForegroundWindow

procedure TkwGetForegroundWindow.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB29543BBB60_var*
//#UC END# *4DAEEDE10285_CB29543BBB60_var*
begin
//#UC START# *4DAEEDE10285_CB29543BBB60_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.DoDoIt

class function TkwGetForegroundWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetForegroundWindow';
end;//TkwGetForegroundWindow.GetWordNameForRegister

function TkwGetForegroundWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CB29543BBB60_var*
//#UC END# *551544E2001A_CB29543BBB60_var*
begin
//#UC START# *551544E2001A_CB29543BBB60_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.GetResultTypeInfo

function TkwGetForegroundWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_CB29543BBB60_var*
//#UC END# *559687E6025A_CB29543BBB60_var*
begin
//#UC START# *559687E6025A_CB29543BBB60_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.GetAllParamsCount

function TkwGetForegroundWindow.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CB29543BBB60_var*
//#UC END# *5617F4D00243_CB29543BBB60_var*
begin
//#UC START# *5617F4D00243_CB29543BBB60_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.ParamsTypes

function TkwFindWindowByCaption.FindWindowByCaption(const aCtx: TtfwContext;
 const aCaption: AnsiString): THandle;
 {* Реализация слова скрипта FindWindowByCaption }
//#UC START# *84D6BB2A5250_0FB930B944B8_var*
//#UC END# *84D6BB2A5250_0FB930B944B8_var*
begin
//#UC START# *84D6BB2A5250_0FB930B944B8_impl*
 Result := FindWindowA(nil, PAnsiChar(aCaption));
//#UC END# *84D6BB2A5250_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.FindWindowByCaption

procedure TkwFindWindowByCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0FB930B944B8_var*
//#UC END# *4DAEEDE10285_0FB930B944B8_var*
begin
//#UC START# *4DAEEDE10285_0FB930B944B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.DoDoIt

class function TkwFindWindowByCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'FindWindowByCaption';
end;//TkwFindWindowByCaption.GetWordNameForRegister

function TkwFindWindowByCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0FB930B944B8_var*
//#UC END# *551544E2001A_0FB930B944B8_var*
begin
//#UC START# *551544E2001A_0FB930B944B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.GetResultTypeInfo

function TkwFindWindowByCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0FB930B944B8_var*
//#UC END# *559687E6025A_0FB930B944B8_var*
begin
//#UC START# *559687E6025A_0FB930B944B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.GetAllParamsCount

function TkwFindWindowByCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0FB930B944B8_var*
//#UC END# *5617F4D00243_0FB930B944B8_var*
begin
//#UC START# *5617F4D00243_0FB930B944B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.ParamsTypes

procedure TkwSetFuzzInPercent.SetFuzzInPercent(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта SetFuzzInPercent }
//#UC START# *FFB533EE4DD1_DDDEEE94C045_var*
//#UC END# *FFB533EE4DD1_DDDEEE94C045_var*
begin
//#UC START# *FFB533EE4DD1_DDDEEE94C045_impl*
 l3SetFuzzValueInPercent(aValue);
//#UC END# *FFB533EE4DD1_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.SetFuzzInPercent

procedure TkwSetFuzzInPercent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DDDEEE94C045_var*
//#UC END# *4DAEEDE10285_DDDEEE94C045_var*
begin
//#UC START# *4DAEEDE10285_DDDEEE94C045_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.DoDoIt

class function TkwSetFuzzInPercent.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetFuzzInPercent';
end;//TkwSetFuzzInPercent.GetWordNameForRegister

function TkwSetFuzzInPercent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DDDEEE94C045_var*
//#UC END# *551544E2001A_DDDEEE94C045_var*
begin
//#UC START# *551544E2001A_DDDEEE94C045_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.GetResultTypeInfo

function TkwSetFuzzInPercent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_DDDEEE94C045_var*
//#UC END# *559687E6025A_DDDEEE94C045_var*
begin
//#UC START# *559687E6025A_DDDEEE94C045_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.GetAllParamsCount

function TkwSetFuzzInPercent.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DDDEEE94C045_var*
//#UC END# *5617F4D00243_DDDEEE94C045_var*
begin
//#UC START# *5617F4D00243_DDDEEE94C045_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.ParamsTypes

function TkwDesktopHeight.desktop_Height(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта desktop:Height }
//#UC START# *4EDF1B6456EE_F5071C676120_var*
//#UC END# *4EDF1B6456EE_F5071C676120_var*
begin
//#UC START# *4EDF1B6456EE_F5071C676120_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopHeight;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *4EDF1B6456EE_F5071C676120_impl*
end;//TkwDesktopHeight.desktop_Height

procedure TkwDesktopHeight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F5071C676120_var*
//#UC END# *4DAEEDE10285_F5071C676120_var*
begin
//#UC START# *4DAEEDE10285_F5071C676120_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F5071C676120_impl*
end;//TkwDesktopHeight.DoDoIt

class function TkwDesktopHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'desktop:Height';
end;//TkwDesktopHeight.GetWordNameForRegister

function TkwDesktopHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F5071C676120_var*
//#UC END# *551544E2001A_F5071C676120_var*
begin
//#UC START# *551544E2001A_F5071C676120_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F5071C676120_impl*
end;//TkwDesktopHeight.GetResultTypeInfo

function TkwDesktopHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F5071C676120_var*
//#UC END# *559687E6025A_F5071C676120_var*
begin
//#UC START# *559687E6025A_F5071C676120_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F5071C676120_impl*
end;//TkwDesktopHeight.GetAllParamsCount

function TkwDesktopHeight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F5071C676120_var*
//#UC END# *5617F4D00243_F5071C676120_var*
begin
//#UC START# *5617F4D00243_F5071C676120_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F5071C676120_impl*
end;//TkwDesktopHeight.ParamsTypes

function TkwDesktopWidth.desktop_Width(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта desktop:Width }
//#UC START# *EC4EA52ACE49_F2D32D266DD0_var*
//#UC END# *EC4EA52ACE49_F2D32D266DD0_var*
begin
//#UC START# *EC4EA52ACE49_F2D32D266DD0_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopWidth
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *EC4EA52ACE49_F2D32D266DD0_impl*
end;//TkwDesktopWidth.desktop_Width

procedure TkwDesktopWidth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F2D32D266DD0_var*
//#UC END# *4DAEEDE10285_F2D32D266DD0_var*
begin
//#UC START# *4DAEEDE10285_F2D32D266DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F2D32D266DD0_impl*
end;//TkwDesktopWidth.DoDoIt

class function TkwDesktopWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'desktop:Width';
end;//TkwDesktopWidth.GetWordNameForRegister

function TkwDesktopWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F2D32D266DD0_var*
//#UC END# *551544E2001A_F2D32D266DD0_var*
begin
//#UC START# *551544E2001A_F2D32D266DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F2D32D266DD0_impl*
end;//TkwDesktopWidth.GetResultTypeInfo

function TkwDesktopWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F2D32D266DD0_var*
//#UC END# *559687E6025A_F2D32D266DD0_var*
begin
//#UC START# *559687E6025A_F2D32D266DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F2D32D266DD0_impl*
end;//TkwDesktopWidth.GetAllParamsCount

function TkwDesktopWidth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F2D32D266DD0_var*
//#UC END# *5617F4D00243_F2D32D266DD0_var*
begin
//#UC START# *5617F4D00243_F2D32D266DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F2D32D266DD0_impl*
end;//TkwDesktopWidth.ParamsTypes

function TkwScreenWidth.screen_Width(const aCtx: TtfwContext;
 anIndex: Integer): Integer;
 {* Реализация слова скрипта screen:Width }
//#UC START# *FF7BA1B0E345_44BBDAE720F0_var*
//#UC END# *FF7BA1B0E345_44BBDAE720F0_var*
begin
//#UC START# *FF7BA1B0E345_44BBDAE720F0_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Width;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *FF7BA1B0E345_44BBDAE720F0_impl*
end;//TkwScreenWidth.screen_Width

procedure TkwScreenWidth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44BBDAE720F0_var*
//#UC END# *4DAEEDE10285_44BBDAE720F0_var*
begin
//#UC START# *4DAEEDE10285_44BBDAE720F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44BBDAE720F0_impl*
end;//TkwScreenWidth.DoDoIt

class function TkwScreenWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'screen:Width';
end;//TkwScreenWidth.GetWordNameForRegister

function TkwScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_44BBDAE720F0_var*
//#UC END# *551544E2001A_44BBDAE720F0_var*
begin
//#UC START# *551544E2001A_44BBDAE720F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_44BBDAE720F0_impl*
end;//TkwScreenWidth.GetResultTypeInfo

function TkwScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_44BBDAE720F0_var*
//#UC END# *559687E6025A_44BBDAE720F0_var*
begin
//#UC START# *559687E6025A_44BBDAE720F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_44BBDAE720F0_impl*
end;//TkwScreenWidth.GetAllParamsCount

function TkwScreenWidth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_44BBDAE720F0_var*
//#UC END# *5617F4D00243_44BBDAE720F0_var*
begin
//#UC START# *5617F4D00243_44BBDAE720F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_44BBDAE720F0_impl*
end;//TkwScreenWidth.ParamsTypes

function TkwScreenHeight.screen_Height(const aCtx: TtfwContext;
 anIndex: Integer): Integer;
 {* Реализация слова скрипта screen:Height }
//#UC START# *726789FBF9F7_91E516864416_var*
//#UC END# *726789FBF9F7_91E516864416_var*
begin
//#UC START# *726789FBF9F7_91E516864416_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *726789FBF9F7_91E516864416_impl*
end;//TkwScreenHeight.screen_Height

procedure TkwScreenHeight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_91E516864416_var*
//#UC END# *4DAEEDE10285_91E516864416_var*
begin
//#UC START# *4DAEEDE10285_91E516864416_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_91E516864416_impl*
end;//TkwScreenHeight.DoDoIt

class function TkwScreenHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'screen:Height';
end;//TkwScreenHeight.GetWordNameForRegister

function TkwScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_91E516864416_var*
//#UC END# *551544E2001A_91E516864416_var*
begin
//#UC START# *551544E2001A_91E516864416_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_91E516864416_impl*
end;//TkwScreenHeight.GetResultTypeInfo

function TkwScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_91E516864416_var*
//#UC END# *559687E6025A_91E516864416_var*
begin
//#UC START# *559687E6025A_91E516864416_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_91E516864416_impl*
end;//TkwScreenHeight.GetAllParamsCount

function TkwScreenHeight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_91E516864416_var*
//#UC END# *5617F4D00243_91E516864416_var*
begin
//#UC START# *5617F4D00243_91E516864416_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_91E516864416_impl*
end;//TkwScreenHeight.ParamsTypes

function TkwMainScreenWidth.MainScreen_Width(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта MainScreen:Width }
//#UC START# *91F8A1F3931B_3832249557A1_var*
//#UC END# *91F8A1F3931B_3832249557A1_var*
begin
//#UC START# *91F8A1F3931B_3832249557A1_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Width;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *91F8A1F3931B_3832249557A1_impl*
end;//TkwMainScreenWidth.MainScreen_Width

procedure TkwMainScreenWidth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3832249557A1_var*
//#UC END# *4DAEEDE10285_3832249557A1_var*
begin
//#UC START# *4DAEEDE10285_3832249557A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3832249557A1_impl*
end;//TkwMainScreenWidth.DoDoIt

class function TkwMainScreenWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainScreen:Width';
end;//TkwMainScreenWidth.GetWordNameForRegister

function TkwMainScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3832249557A1_var*
//#UC END# *551544E2001A_3832249557A1_var*
begin
//#UC START# *551544E2001A_3832249557A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3832249557A1_impl*
end;//TkwMainScreenWidth.GetResultTypeInfo

function TkwMainScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3832249557A1_var*
//#UC END# *559687E6025A_3832249557A1_var*
begin
//#UC START# *559687E6025A_3832249557A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3832249557A1_impl*
end;//TkwMainScreenWidth.GetAllParamsCount

function TkwMainScreenWidth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3832249557A1_var*
//#UC END# *5617F4D00243_3832249557A1_var*
begin
//#UC START# *5617F4D00243_3832249557A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3832249557A1_impl*
end;//TkwMainScreenWidth.ParamsTypes

function TkwMainScreenHeight.MainScreen_Height(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта MainScreen:Height }
//#UC START# *8218EB203DB0_8022C1F2B088_var*
//#UC END# *8218EB203DB0_8022C1F2B088_var*
begin
//#UC START# *8218EB203DB0_8022C1F2B088_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *8218EB203DB0_8022C1F2B088_impl*
end;//TkwMainScreenHeight.MainScreen_Height

procedure TkwMainScreenHeight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8022C1F2B088_var*
//#UC END# *4DAEEDE10285_8022C1F2B088_var*
begin
//#UC START# *4DAEEDE10285_8022C1F2B088_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8022C1F2B088_impl*
end;//TkwMainScreenHeight.DoDoIt

class function TkwMainScreenHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainScreen:Height';
end;//TkwMainScreenHeight.GetWordNameForRegister

function TkwMainScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8022C1F2B088_var*
//#UC END# *551544E2001A_8022C1F2B088_var*
begin
//#UC START# *551544E2001A_8022C1F2B088_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8022C1F2B088_impl*
end;//TkwMainScreenHeight.GetResultTypeInfo

function TkwMainScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8022C1F2B088_var*
//#UC END# *559687E6025A_8022C1F2B088_var*
begin
//#UC START# *559687E6025A_8022C1F2B088_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8022C1F2B088_impl*
end;//TkwMainScreenHeight.GetAllParamsCount

function TkwMainScreenHeight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8022C1F2B088_var*
//#UC END# *5617F4D00243_8022C1F2B088_var*
begin
//#UC START# *5617F4D00243_8022C1F2B088_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8022C1F2B088_impl*
end;//TkwMainScreenHeight.ParamsTypes

function TkwScreenCount.ScreenCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта ScreenCount }
//#UC START# *D8F53100D31F_4C862EA2F8C6_var*
//#UC END# *D8F53100D31F_4C862EA2F8C6_var*
begin
//#UC START# *D8F53100D31F_4C862EA2F8C6_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.MonitorCount;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *D8F53100D31F_4C862EA2F8C6_impl*
end;//TkwScreenCount.ScreenCount

procedure TkwScreenCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C862EA2F8C6_var*
//#UC END# *4DAEEDE10285_4C862EA2F8C6_var*
begin
//#UC START# *4DAEEDE10285_4C862EA2F8C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C862EA2F8C6_impl*
end;//TkwScreenCount.DoDoIt

class function TkwScreenCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenCount';
end;//TkwScreenCount.GetWordNameForRegister

function TkwScreenCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4C862EA2F8C6_var*
//#UC END# *551544E2001A_4C862EA2F8C6_var*
begin
//#UC START# *551544E2001A_4C862EA2F8C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4C862EA2F8C6_impl*
end;//TkwScreenCount.GetResultTypeInfo

function TkwScreenCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4C862EA2F8C6_var*
//#UC END# *559687E6025A_4C862EA2F8C6_var*
begin
//#UC START# *559687E6025A_4C862EA2F8C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4C862EA2F8C6_impl*
end;//TkwScreenCount.GetAllParamsCount

function TkwScreenCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4C862EA2F8C6_var*
//#UC END# *5617F4D00243_4C862EA2F8C6_var*
begin
//#UC START# *5617F4D00243_4C862EA2F8C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4C862EA2F8C6_impl*
end;//TkwScreenCount.ParamsTypes

procedure TkwAskWindowToCloseItself.AskWindowToCloseItself(const aCtx: TtfwContext;
 const aWnd: TtfwStackValue);
 {* Реализация слова скрипта AskWindowToCloseItself }
//#UC START# *7734C551216C_22E2D41E5FCD_var*
{$IfNDef NoVCL}
var
 l_Window: TWinControl;
 l_Handle: THandle;
{$EndIf  NoVCL}
//#UC END# *7734C551216C_22E2D41E5FCD_var*
begin
//#UC START# *7734C551216C_22E2D41E5FCD_impl*
 {$IfNDef NoVCL}
 l_Window := nil;
 if (aWnd.rType = tfw_vtInt) then
 begin
  l_Handle := THandle(aWnd.AsInt);
  l_Window := FindControl(l_Handle);
 end//aWnd.rType = tfw_vtInt
 else
  l_Handle := 0;

 if Assigned(l_Window) or
    (aWnd.rType = tfw_vtObj) then
 begin
  if not Assigned(l_Window) then
   l_Window := aWnd.AsObject As TWinControl;
  RunnerAssert(l_Window is TWinControl, 'Где окно?!', aCtx);
  if Tl3CloseFormHelper.Instance.Close(l_Window) then
   Exit;
  if (l_Handle <> 0) then
   l_Handle := l_Window.Handle;
 end;//Assigned(l_Window) or
 RunnerAssert(l_Handle <> 0, 'Где окно?!', aCtx);
 PostMessage(l_Handle, WM_CLOSE, 0, 0);
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *7734C551216C_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.AskWindowToCloseItself

procedure TkwAskWindowToCloseItself.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_22E2D41E5FCD_var*
//#UC END# *4DAEEDE10285_22E2D41E5FCD_var*
begin
//#UC START# *4DAEEDE10285_22E2D41E5FCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.DoDoIt

class function TkwAskWindowToCloseItself.GetWordNameForRegister: AnsiString;
begin
 Result := 'AskWindowToCloseItself';
end;//TkwAskWindowToCloseItself.GetWordNameForRegister

function TkwAskWindowToCloseItself.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_22E2D41E5FCD_var*
//#UC END# *551544E2001A_22E2D41E5FCD_var*
begin
//#UC START# *551544E2001A_22E2D41E5FCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.GetResultTypeInfo

function TkwAskWindowToCloseItself.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_22E2D41E5FCD_var*
//#UC END# *559687E6025A_22E2D41E5FCD_var*
begin
//#UC START# *559687E6025A_22E2D41E5FCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.GetAllParamsCount

function TkwAskWindowToCloseItself.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_22E2D41E5FCD_var*
//#UC END# *5617F4D00243_22E2D41E5FCD_var*
begin
//#UC START# *5617F4D00243_22E2D41E5FCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.ParamsTypes

procedure TkwScreenShot2File.ScreenShot2File(const aCtx: TtfwContext;
 aWnd: THandle;
 aLeft: Integer;
 aTop: Integer;
 aWidth: Integer;
 aHeight: Integer;
 const aFileName: AnsiString);
 {* Реализация слова скрипта ScreenShot2File }
//#UC START# *E3689417D97C_D7673935EC18_var*
//#UC END# *E3689417D97C_D7673935EC18_var*
begin
//#UC START# *E3689417D97C_D7673935EC18_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, false, aCtx, Self);
//#UC END# *E3689417D97C_D7673935EC18_impl*
end;//TkwScreenShot2File.ScreenShot2File

procedure TkwScreenShot2File.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D7673935EC18_var*
//#UC END# *4DAEEDE10285_D7673935EC18_var*
begin
//#UC START# *4DAEEDE10285_D7673935EC18_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D7673935EC18_impl*
end;//TkwScreenShot2File.DoDoIt

class function TkwScreenShot2File.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenShot2File';
end;//TkwScreenShot2File.GetWordNameForRegister

function TkwScreenShot2File.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D7673935EC18_var*
//#UC END# *551544E2001A_D7673935EC18_var*
begin
//#UC START# *551544E2001A_D7673935EC18_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D7673935EC18_impl*
end;//TkwScreenShot2File.GetResultTypeInfo

function TkwScreenShot2File.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D7673935EC18_var*
//#UC END# *559687E6025A_D7673935EC18_var*
begin
//#UC START# *559687E6025A_D7673935EC18_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D7673935EC18_impl*
end;//TkwScreenShot2File.GetAllParamsCount

function TkwScreenShot2File.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D7673935EC18_var*
//#UC END# *5617F4D00243_D7673935EC18_var*
begin
//#UC START# *5617F4D00243_D7673935EC18_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D7673935EC18_impl*
end;//TkwScreenShot2File.ParamsTypes

procedure TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck(const aCtx: TtfwContext;
 aWnd: THandle;
 aLeft: Integer;
 aTop: Integer;
 aWidth: Integer;
 aHeight: Integer;
 const aFileName: AnsiString);
 {* Реализация слова скрипта ScreenShot2FileWithCheck }
//#UC START# *8B949444F0A6_13CADBEDE41C_var*
//#UC END# *8B949444F0A6_13CADBEDE41C_var*
begin
//#UC START# *8B949444F0A6_13CADBEDE41C_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, true, aCtx, Self);
//#UC END# *8B949444F0A6_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck

procedure TkwScreenShot2FileWithCheck.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_13CADBEDE41C_var*
//#UC END# *4DAEEDE10285_13CADBEDE41C_var*
begin
//#UC START# *4DAEEDE10285_13CADBEDE41C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.DoDoIt

class function TkwScreenShot2FileWithCheck.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenShot2FileWithCheck';
end;//TkwScreenShot2FileWithCheck.GetWordNameForRegister

function TkwScreenShot2FileWithCheck.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_13CADBEDE41C_var*
//#UC END# *551544E2001A_13CADBEDE41C_var*
begin
//#UC START# *551544E2001A_13CADBEDE41C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.GetResultTypeInfo

function TkwScreenShot2FileWithCheck.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_13CADBEDE41C_var*
//#UC END# *559687E6025A_13CADBEDE41C_var*
begin
//#UC START# *559687E6025A_13CADBEDE41C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.GetAllParamsCount

function TkwScreenShot2FileWithCheck.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_13CADBEDE41C_var*
//#UC END# *5617F4D00243_13CADBEDE41C_var*
begin
//#UC START# *5617F4D00243_13CADBEDE41C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.ParamsTypes

initialization
 TkwWndIsVisible.RegisterInEngine;
 {* Регистрация wnd_IsVisible }
 TkwWndGetClassName.RegisterInEngine;
 {* Регистрация wnd_GetClassName }
 TkwWndGetWindowText.RegisterInEngine;
 {* Регистрация wnd_GetWindowText }
 TkwWndCloseWindow.RegisterInEngine;
 {* Регистрация wnd_CloseWindow }
 TkwWndWindowIsMine.RegisterInEngine;
 {* Регистрация wnd_WindowIsMine }
 TkwWndSetForeground.RegisterInEngine;
 {* Регистрация wnd_SetForeground }
 TkwWinTreeGetCurrentText.RegisterInEngine;
 {* Регистрация WinTreeGetCurrentText }
 TkwIterateChildWindows.RegisterInEngine;
 {* Регистрация IterateChildWindows }
 TkwIterateWindows.RegisterInEngine;
 {* Регистрация IterateWindows }
 TkwWindowFromPoint.RegisterInEngine;
 {* Регистрация WindowFromPoint }
 TkwGetForegroundWindow.RegisterInEngine;
 {* Регистрация GetForegroundWindow }
 TkwFindWindowByCaption.RegisterInEngine;
 {* Регистрация FindWindowByCaption }
 TkwSetFuzzInPercent.RegisterInEngine;
 {* Регистрация SetFuzzInPercent }
 TkwDesktopHeight.RegisterInEngine;
 {* Регистрация desktop_Height }
 TkwDesktopWidth.RegisterInEngine;
 {* Регистрация desktop_Width }
 TkwScreenWidth.RegisterInEngine;
 {* Регистрация screen_Width }
 TkwScreenHeight.RegisterInEngine;
 {* Регистрация screen_Height }
 TkwMainScreenWidth.RegisterInEngine;
 {* Регистрация MainScreen_Width }
 TkwMainScreenHeight.RegisterInEngine;
 {* Регистрация MainScreen_Height }
 TkwScreenCount.RegisterInEngine;
 {* Регистрация ScreenCount }
 TkwAskWindowToCloseItself.RegisterInEngine;
 {* Регистрация AskWindowToCloseItself }
 TkwScreenShot2File.RegisterInEngine;
 {* Регистрация ScreenShot2File }
 TkwScreenShot2FileWithCheck.RegisterInEngine;
 {* Регистрация ScreenShot2FileWithCheck }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
 {* Регистрация типа THandle }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoWindows)

end.
