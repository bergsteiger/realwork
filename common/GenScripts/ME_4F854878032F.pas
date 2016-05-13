unit WinUtilsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WinUtilsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "WinUtilsPack" MUID: (4F854878032F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoWindows)}
uses
 l3IntfUses
 , Windows
 , tfwScriptingInterfaces
 , Types
;

function IterateWindowsMethod(hWindow: THandle;
 aData: PtfwWordCallContext): Boolean; stdcall;
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
 , tfwGlobalKeyWord
 , TypInfo
 , tfwTypeInfo
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
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwWndIsVisible = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:IsVisible }
  private
   function wnd_IsVisible(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
    {* Реализация слова скрипта wnd:IsVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndIsVisible

 TkwWndGetClassName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetClassName }
  private
   function wnd_GetClassName(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта wnd:GetClassName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetClassName

 TkwWndGetWindowText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:GetWindowText }
  private
   function wnd_GetWindowText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта wnd:GetWindowText }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetWindowText

 TkwWndCloseWindow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:CloseWindow }
  private
   procedure wnd_CloseWindow(const aCtx: TtfwContext;
    aWnd: THandle);
    {* Реализация слова скрипта wnd:CloseWindow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndCloseWindow

 TkwWndWindowIsMine = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:WindowIsMine }
  private
   function wnd_WindowIsMine(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
    {* Реализация слова скрипта wnd:WindowIsMine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndWindowIsMine

 TkwWndSetForeground = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта wnd:SetForeground }
  private
   procedure wnd_SetForeground(const aCtx: TtfwContext;
    aWnd: THandle);
    {* Реализация слова скрипта wnd:SetForeground }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndSetForeground

 TkwWinTreeGetCurrentText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WinTreeGetCurrentText }
  private
   function WinTreeGetCurrentText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
    {* Реализация слова скрипта WinTreeGetCurrentText }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWinTreeGetCurrentText

 TkwIterateChildWindows = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateChildWindows }
  private
   procedure IterateChildWindows(const aCtx: TtfwContext;
    aWnd: THandle;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateChildWindows }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateChildWindows

 TkwIterateWindows = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateWindows }
  private
   procedure IterateWindows(const aCtx: TtfwContext;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateWindows }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateWindows

 TkwWindowFromPoint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WindowFromPoint }
  private
   function WindowFromPoint(const aCtx: TtfwContext;
    const aPoint: TPoint): THandle;
    {* Реализация слова скрипта WindowFromPoint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWindowFromPoint

 TkwGetForegroundWindow = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetForegroundWindow }
  private
   function GetForegroundWindow(const aCtx: TtfwContext): THandle;
    {* Реализация слова скрипта GetForegroundWindow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetForegroundWindow

 TkwFindWindowByCaption = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта FindWindowByCaption }
  private
   function FindWindowByCaption(const aCtx: TtfwContext;
    const aCaption: AnsiString): THandle;
    {* Реализация слова скрипта FindWindowByCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFindWindowByCaption

 TkwSetFuzzInPercent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetFuzzInPercent }
  private
   procedure SetFuzzInPercent(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта SetFuzzInPercent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetFuzzInPercent

 TkwDesktopHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Height }
  private
   function desktop_Height(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта desktop:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopHeight

 TkwDesktopWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта desktop:Width }
  private
   function desktop_Width(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта desktop:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopWidth

 TkwScreenWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Width }
  private
   function screen_Width(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
    {* Реализация слова скрипта screen:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenWidth

 TkwScreenHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта screen:Height }
  private
   function screen_Height(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
    {* Реализация слова скрипта screen:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenHeight

 TkwMainScreenWidth = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Width }
  private
   function MainScreen_Width(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта MainScreen:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenWidth

 TkwMainScreenHeight = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MainScreen:Height }
  private
   function MainScreen_Height(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта MainScreen:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenHeight

 TkwScreenCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenCount }
  private
   function ScreenCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта ScreenCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenCount

 TkwAskWindowToCloseItself = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта AskWindowToCloseItself }
  private
   procedure AskWindowToCloseItself(const aCtx: TtfwContext;
    const aWnd: TtfwStackValue);
    {* Реализация слова скрипта AskWindowToCloseItself }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAskWindowToCloseItself

 TkwScreenShot2File = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenShot2File }
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenShot2File

 TkwScreenShot2FileWithCheck = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ScreenShot2FileWithCheck }
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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
//#UC START# *55192F7C0078_55192F7C0078_Word_var*
//#UC END# *55192F7C0078_55192F7C0078_Word_var*
begin
//#UC START# *55192F7C0078_55192F7C0078_Word_impl*
 Result := Windows.IsWindowVisible(aWnd);
//#UC END# *55192F7C0078_55192F7C0078_Word_impl*
end;//TkwWndIsVisible.wnd_IsVisible

class function TkwWndIsVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:IsVisible';
end;//TkwWndIsVisible.GetWordNameForRegister

function TkwWndIsVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwWndIsVisible.GetResultTypeInfo

function TkwWndIsVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndIsVisible.GetAllParamsCount

function TkwWndIsVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndIsVisible.ParamsTypes

procedure TkwWndIsVisible.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(wnd_IsVisible(aCtx, l_aWnd));
end;//TkwWndIsVisible.DoDoIt

function TkwWndGetClassName.wnd_GetClassName(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта wnd:GetClassName }
//#UC START# *55192F980349_55192F980349_Word_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *55192F980349_55192F980349_Word_var*
begin
//#UC START# *55192F980349_55192F980349_Word_impl*
 GetClassName(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *55192F980349_55192F980349_Word_impl*
end;//TkwWndGetClassName.wnd_GetClassName

class function TkwWndGetClassName.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:GetClassName';
end;//TkwWndGetClassName.GetWordNameForRegister

function TkwWndGetClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwWndGetClassName.GetResultTypeInfo

function TkwWndGetClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndGetClassName.GetAllParamsCount

function TkwWndGetClassName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndGetClassName.ParamsTypes

procedure TkwWndGetClassName.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(wnd_GetClassName(aCtx, l_aWnd));
end;//TkwWndGetClassName.DoDoIt

function TkwWndGetWindowText.wnd_GetWindowText(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта wnd:GetWindowText }
//#UC START# *55192FAF01D3_55192FAF01D3_Word_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *55192FAF01D3_55192FAF01D3_Word_var*
begin
//#UC START# *55192FAF01D3_55192FAF01D3_Word_impl*
 GetWindowText(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *55192FAF01D3_55192FAF01D3_Word_impl*
end;//TkwWndGetWindowText.wnd_GetWindowText

class function TkwWndGetWindowText.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:GetWindowText';
end;//TkwWndGetWindowText.GetWordNameForRegister

function TkwWndGetWindowText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwWndGetWindowText.GetResultTypeInfo

function TkwWndGetWindowText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndGetWindowText.GetAllParamsCount

function TkwWndGetWindowText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndGetWindowText.ParamsTypes

procedure TkwWndGetWindowText.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(wnd_GetWindowText(aCtx, l_aWnd));
end;//TkwWndGetWindowText.DoDoIt

procedure TkwWndCloseWindow.wnd_CloseWindow(const aCtx: TtfwContext;
 aWnd: THandle);
 {* Реализация слова скрипта wnd:CloseWindow }
//#UC START# *5519300102ED_5519300102ED_Word_var*
//#UC END# *5519300102ED_5519300102ED_Word_var*
begin
//#UC START# *5519300102ED_5519300102ED_Word_impl*
 SendMessage(aWnd, WM_CLOSE, 0, 0);
//#UC END# *5519300102ED_5519300102ED_Word_impl*
end;//TkwWndCloseWindow.wnd_CloseWindow

class function TkwWndCloseWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:CloseWindow';
end;//TkwWndCloseWindow.GetWordNameForRegister

function TkwWndCloseWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwWndCloseWindow.GetResultTypeInfo

function TkwWndCloseWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndCloseWindow.GetAllParamsCount

function TkwWndCloseWindow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndCloseWindow.ParamsTypes

procedure TkwWndCloseWindow.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 wnd_CloseWindow(aCtx, l_aWnd);
end;//TkwWndCloseWindow.DoDoIt

function TkwWndWindowIsMine.wnd_WindowIsMine(const aCtx: TtfwContext;
 aWnd: THandle): Boolean;
 {* Реализация слова скрипта wnd:WindowIsMine }
//#UC START# *55193045008D_55193045008D_Word_var*
var
 l_Process: DWORD;
//#UC END# *55193045008D_55193045008D_Word_var*
begin
//#UC START# *55193045008D_55193045008D_Word_impl*
 GetWindowThreadProcessId(aWnd, l_Process);
 Result := (l_Process = GetCurrentProcessId);
//#UC END# *55193045008D_55193045008D_Word_impl*
end;//TkwWndWindowIsMine.wnd_WindowIsMine

class function TkwWndWindowIsMine.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:WindowIsMine';
end;//TkwWndWindowIsMine.GetWordNameForRegister

function TkwWndWindowIsMine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwWndWindowIsMine.GetResultTypeInfo

function TkwWndWindowIsMine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndWindowIsMine.GetAllParamsCount

function TkwWndWindowIsMine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndWindowIsMine.ParamsTypes

procedure TkwWndWindowIsMine.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(wnd_WindowIsMine(aCtx, l_aWnd));
end;//TkwWndWindowIsMine.DoDoIt

procedure TkwWndSetForeground.wnd_SetForeground(const aCtx: TtfwContext;
 aWnd: THandle);
 {* Реализация слова скрипта wnd:SetForeground }
//#UC START# *5519307103E4_5519307103E4_Word_var*
//#UC END# *5519307103E4_5519307103E4_Word_var*
begin
//#UC START# *5519307103E4_5519307103E4_Word_impl*
 Windows.SetForegroundWindow(aWnd);
//#UC END# *5519307103E4_5519307103E4_Word_impl*
end;//TkwWndSetForeground.wnd_SetForeground

class function TkwWndSetForeground.GetWordNameForRegister: AnsiString;
begin
 Result := 'wnd:SetForeground';
end;//TkwWndSetForeground.GetWordNameForRegister

function TkwWndSetForeground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwWndSetForeground.GetResultTypeInfo

function TkwWndSetForeground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWndSetForeground.GetAllParamsCount

function TkwWndSetForeground.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndSetForeground.ParamsTypes

procedure TkwWndSetForeground.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 wnd_SetForeground(aCtx, l_aWnd);
end;//TkwWndSetForeground.DoDoIt

function TkwWinTreeGetCurrentText.WinTreeGetCurrentText(const aCtx: TtfwContext;
 aWnd: THandle): AnsiString;
 {* Реализация слова скрипта WinTreeGetCurrentText }
//#UC START# *551930A001DF_551930A001DF_Word_var*
var
 l_Current: TTVItemA;
 l_Res: Boolean;
 l_Text: array[1..255] of AnsiChar;
//#UC END# *551930A001DF_551930A001DF_Word_var*
begin
//#UC START# *551930A001DF_551930A001DF_Word_impl*
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
//#UC END# *551930A001DF_551930A001DF_Word_impl*
end;//TkwWinTreeGetCurrentText.WinTreeGetCurrentText

class function TkwWinTreeGetCurrentText.GetWordNameForRegister: AnsiString;
begin
 Result := 'WinTreeGetCurrentText';
end;//TkwWinTreeGetCurrentText.GetWordNameForRegister

function TkwWinTreeGetCurrentText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwWinTreeGetCurrentText.GetResultTypeInfo

function TkwWinTreeGetCurrentText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWinTreeGetCurrentText.GetAllParamsCount

function TkwWinTreeGetCurrentText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWinTreeGetCurrentText.ParamsTypes

procedure TkwWinTreeGetCurrentText.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(WinTreeGetCurrentText(aCtx, l_aWnd));
end;//TkwWinTreeGetCurrentText.DoDoIt

procedure TkwIterateChildWindows.IterateChildWindows(const aCtx: TtfwContext;
 aWnd: THandle;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateChildWindows }
//#UC START# *551941E30047_551941E30047_Word_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *551941E30047_551941E30047_Word_var*
begin
//#UC START# *551941E30047_551941E30047_Word_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumChildWindows(aWnd, @IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *551941E30047_551941E30047_Word_impl*
end;//TkwIterateChildWindows.IterateChildWindows

class function TkwIterateChildWindows.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateChildWindows';
end;//TkwIterateChildWindows.GetWordNameForRegister

function TkwIterateChildWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwIterateChildWindows.GetResultTypeInfo

function TkwIterateChildWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwIterateChildWindows.GetAllParamsCount

function TkwIterateChildWindows.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(TtfwWord)]);
end;//TkwIterateChildWindows.ParamsTypes

procedure TkwIterateChildWindows.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
var l_aLambda: TtfwWord;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateChildWindows(aCtx, l_aWnd, l_aLambda);
end;//TkwIterateChildWindows.DoDoIt

procedure TkwIterateWindows.IterateWindows(const aCtx: TtfwContext;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateWindows }
//#UC START# *5519427E00F3_5519427E00F3_Word_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *5519427E00F3_5519427E00F3_Word_var*
begin
//#UC START# *5519427E00F3_5519427E00F3_Word_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumWindows(@IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *5519427E00F3_5519427E00F3_Word_impl*
end;//TkwIterateWindows.IterateWindows

class function TkwIterateWindows.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateWindows';
end;//TkwIterateWindows.GetWordNameForRegister

function TkwIterateWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwIterateWindows.GetResultTypeInfo

function TkwIterateWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIterateWindows.GetAllParamsCount

function TkwIterateWindows.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwIterateWindows.ParamsTypes

procedure TkwIterateWindows.DoDoIt(const aCtx: TtfwContext);
var l_aLambda: TtfwWord;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateWindows(aCtx, l_aLambda);
end;//TkwIterateWindows.DoDoIt

function TkwWindowFromPoint.WindowFromPoint(const aCtx: TtfwContext;
 const aPoint: TPoint): THandle;
 {* Реализация слова скрипта WindowFromPoint }
//#UC START# *551943280118_551943280118_Word_var*
//#UC END# *551943280118_551943280118_Word_var*
begin
//#UC START# *551943280118_551943280118_Word_impl*
 Result := Windows.WindowFromPoint(aPoint);
//#UC END# *551943280118_551943280118_Word_impl*
end;//TkwWindowFromPoint.WindowFromPoint

class function TkwWindowFromPoint.GetWordNameForRegister: AnsiString;
begin
 Result := 'WindowFromPoint';
end;//TkwWindowFromPoint.GetWordNameForRegister

function TkwWindowFromPoint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(THandle);
end;//TkwWindowFromPoint.GetResultTypeInfo

function TkwWindowFromPoint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWindowFromPoint.GetAllParamsCount

function TkwWindowFromPoint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwWindowFromPoint.ParamsTypes

procedure TkwWindowFromPoint.DoDoIt(const aCtx: TtfwContext);
var l_aPoint: TPoint;
begin
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(WindowFromPoint(aCtx, l_aPoint)));
end;//TkwWindowFromPoint.DoDoIt

function TkwGetForegroundWindow.GetForegroundWindow(const aCtx: TtfwContext): THandle;
 {* Реализация слова скрипта GetForegroundWindow }
//#UC START# *5519434F0000_5519434F0000_Word_var*
//#UC END# *5519434F0000_5519434F0000_Word_var*
begin
//#UC START# *5519434F0000_5519434F0000_Word_impl*
 Result := Windows.GetForegroundWindow;
//#UC END# *5519434F0000_5519434F0000_Word_impl*
end;//TkwGetForegroundWindow.GetForegroundWindow

class function TkwGetForegroundWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetForegroundWindow';
end;//TkwGetForegroundWindow.GetWordNameForRegister

function TkwGetForegroundWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(THandle);
end;//TkwGetForegroundWindow.GetResultTypeInfo

function TkwGetForegroundWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetForegroundWindow.GetAllParamsCount

function TkwGetForegroundWindow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetForegroundWindow.ParamsTypes

procedure TkwGetForegroundWindow.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(Integer(GetForegroundWindow(aCtx)));
end;//TkwGetForegroundWindow.DoDoIt

function TkwFindWindowByCaption.FindWindowByCaption(const aCtx: TtfwContext;
 const aCaption: AnsiString): THandle;
 {* Реализация слова скрипта FindWindowByCaption }
//#UC START# *551943860248_551943860248_Word_var*
//#UC END# *551943860248_551943860248_Word_var*
begin
//#UC START# *551943860248_551943860248_Word_impl*
 Result := FindWindowA(nil, PAnsiChar(aCaption));
//#UC END# *551943860248_551943860248_Word_impl*
end;//TkwFindWindowByCaption.FindWindowByCaption

class function TkwFindWindowByCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'FindWindowByCaption';
end;//TkwFindWindowByCaption.GetWordNameForRegister

function TkwFindWindowByCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(THandle);
end;//TkwFindWindowByCaption.GetResultTypeInfo

function TkwFindWindowByCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFindWindowByCaption.GetAllParamsCount

function TkwFindWindowByCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwFindWindowByCaption.ParamsTypes

procedure TkwFindWindowByCaption.DoDoIt(const aCtx: TtfwContext);
var l_aCaption: AnsiString;
begin
 try
  l_aCaption := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCaption: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(FindWindowByCaption(aCtx, l_aCaption)));
end;//TkwFindWindowByCaption.DoDoIt

procedure TkwSetFuzzInPercent.SetFuzzInPercent(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта SetFuzzInPercent }
//#UC START# *551943FD0148_551943FD0148_Word_var*
//#UC END# *551943FD0148_551943FD0148_Word_var*
begin
//#UC START# *551943FD0148_551943FD0148_Word_impl*
 l3SetFuzzValueInPercent(aValue);
//#UC END# *551943FD0148_551943FD0148_Word_impl*
end;//TkwSetFuzzInPercent.SetFuzzInPercent

class function TkwSetFuzzInPercent.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetFuzzInPercent';
end;//TkwSetFuzzInPercent.GetWordNameForRegister

function TkwSetFuzzInPercent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetFuzzInPercent.GetResultTypeInfo

function TkwSetFuzzInPercent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSetFuzzInPercent.GetAllParamsCount

function TkwSetFuzzInPercent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSetFuzzInPercent.ParamsTypes

procedure TkwSetFuzzInPercent.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetFuzzInPercent(aCtx, l_aValue);
end;//TkwSetFuzzInPercent.DoDoIt

function TkwDesktopHeight.desktop_Height(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта desktop:Height }
//#UC START# *551D5FE00397_551D5FE00397_Word_var*
//#UC END# *551D5FE00397_551D5FE00397_Word_var*
begin
//#UC START# *551D5FE00397_551D5FE00397_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopHeight;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *551D5FE00397_551D5FE00397_Word_impl*
end;//TkwDesktopHeight.desktop_Height

class function TkwDesktopHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'desktop:Height';
end;//TkwDesktopHeight.GetWordNameForRegister

function TkwDesktopHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDesktopHeight.GetResultTypeInfo

function TkwDesktopHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDesktopHeight.GetAllParamsCount

function TkwDesktopHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDesktopHeight.ParamsTypes

procedure TkwDesktopHeight.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(desktop_Height(aCtx));
end;//TkwDesktopHeight.DoDoIt

function TkwDesktopWidth.desktop_Width(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта desktop:Width }
//#UC START# *551D5FF00393_551D5FF00393_Word_var*
//#UC END# *551D5FF00393_551D5FF00393_Word_var*
begin
//#UC START# *551D5FF00393_551D5FF00393_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopWidth
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *551D5FF00393_551D5FF00393_Word_impl*
end;//TkwDesktopWidth.desktop_Width

class function TkwDesktopWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'desktop:Width';
end;//TkwDesktopWidth.GetWordNameForRegister

function TkwDesktopWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDesktopWidth.GetResultTypeInfo

function TkwDesktopWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDesktopWidth.GetAllParamsCount

function TkwDesktopWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDesktopWidth.ParamsTypes

procedure TkwDesktopWidth.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(desktop_Width(aCtx));
end;//TkwDesktopWidth.DoDoIt

function TkwScreenWidth.screen_Width(const aCtx: TtfwContext;
 anIndex: Integer): Integer;
 {* Реализация слова скрипта screen:Width }
//#UC START# *551D5FFF03A1_551D5FFF03A1_Word_var*
//#UC END# *551D5FFF03A1_551D5FFF03A1_Word_var*
begin
//#UC START# *551D5FFF03A1_551D5FFF03A1_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Width;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *551D5FFF03A1_551D5FFF03A1_Word_impl*
end;//TkwScreenWidth.screen_Width

class function TkwScreenWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'screen:Width';
end;//TkwScreenWidth.GetWordNameForRegister

function TkwScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwScreenWidth.GetResultTypeInfo

function TkwScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwScreenWidth.GetAllParamsCount

function TkwScreenWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwScreenWidth.ParamsTypes

procedure TkwScreenWidth.DoDoIt(const aCtx: TtfwContext);
var l_anIndex: Integer;
begin
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(screen_Width(aCtx, l_anIndex));
end;//TkwScreenWidth.DoDoIt

function TkwScreenHeight.screen_Height(const aCtx: TtfwContext;
 anIndex: Integer): Integer;
 {* Реализация слова скрипта screen:Height }
//#UC START# *551D60220051_551D60220051_Word_var*
//#UC END# *551D60220051_551D60220051_Word_var*
begin
//#UC START# *551D60220051_551D60220051_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *551D60220051_551D60220051_Word_impl*
end;//TkwScreenHeight.screen_Height

class function TkwScreenHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'screen:Height';
end;//TkwScreenHeight.GetWordNameForRegister

function TkwScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwScreenHeight.GetResultTypeInfo

function TkwScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwScreenHeight.GetAllParamsCount

function TkwScreenHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwScreenHeight.ParamsTypes

procedure TkwScreenHeight.DoDoIt(const aCtx: TtfwContext);
var l_anIndex: Integer;
begin
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(screen_Height(aCtx, l_anIndex));
end;//TkwScreenHeight.DoDoIt

function TkwMainScreenWidth.MainScreen_Width(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта MainScreen:Width }
//#UC START# *551D605302AE_551D605302AE_Word_var*
//#UC END# *551D605302AE_551D605302AE_Word_var*
begin
//#UC START# *551D605302AE_551D605302AE_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Width;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *551D605302AE_551D605302AE_Word_impl*
end;//TkwMainScreenWidth.MainScreen_Width

class function TkwMainScreenWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainScreen:Width';
end;//TkwMainScreenWidth.GetWordNameForRegister

function TkwMainScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMainScreenWidth.GetResultTypeInfo

function TkwMainScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwMainScreenWidth.GetAllParamsCount

function TkwMainScreenWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMainScreenWidth.ParamsTypes

procedure TkwMainScreenWidth.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(MainScreen_Width(aCtx));
end;//TkwMainScreenWidth.DoDoIt

function TkwMainScreenHeight.MainScreen_Height(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта MainScreen:Height }
//#UC START# *551D606401C1_551D606401C1_Word_var*
//#UC END# *551D606401C1_551D606401C1_Word_var*
begin
//#UC START# *551D606401C1_551D606401C1_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *551D606401C1_551D606401C1_Word_impl*
end;//TkwMainScreenHeight.MainScreen_Height

class function TkwMainScreenHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'MainScreen:Height';
end;//TkwMainScreenHeight.GetWordNameForRegister

function TkwMainScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMainScreenHeight.GetResultTypeInfo

function TkwMainScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwMainScreenHeight.GetAllParamsCount

function TkwMainScreenHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwMainScreenHeight.ParamsTypes

procedure TkwMainScreenHeight.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(MainScreen_Height(aCtx));
end;//TkwMainScreenHeight.DoDoIt

function TkwScreenCount.ScreenCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта ScreenCount }
//#UC START# *551D607202D0_551D607202D0_Word_var*
//#UC END# *551D607202D0_551D607202D0_Word_var*
begin
//#UC START# *551D607202D0_551D607202D0_Word_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.MonitorCount;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *551D607202D0_551D607202D0_Word_impl*
end;//TkwScreenCount.ScreenCount

class function TkwScreenCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenCount';
end;//TkwScreenCount.GetWordNameForRegister

function TkwScreenCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwScreenCount.GetResultTypeInfo

function TkwScreenCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwScreenCount.GetAllParamsCount

function TkwScreenCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwScreenCount.ParamsTypes

procedure TkwScreenCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(ScreenCount(aCtx));
end;//TkwScreenCount.DoDoIt

procedure TkwAskWindowToCloseItself.AskWindowToCloseItself(const aCtx: TtfwContext;
 const aWnd: TtfwStackValue);
 {* Реализация слова скрипта AskWindowToCloseItself }
//#UC START# *551D60A60370_551D60A60370_Word_var*
{$IfNDef NoVCL}
var
 l_Window: TWinControl;
 l_Handle: THandle;
{$EndIf  NoVCL}
//#UC END# *551D60A60370_551D60A60370_Word_var*
begin
//#UC START# *551D60A60370_551D60A60370_Word_impl*
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
//#UC END# *551D60A60370_551D60A60370_Word_impl*
end;//TkwAskWindowToCloseItself.AskWindowToCloseItself

class function TkwAskWindowToCloseItself.GetWordNameForRegister: AnsiString;
begin
 Result := 'AskWindowToCloseItself';
end;//TkwAskWindowToCloseItself.GetWordNameForRegister

function TkwAskWindowToCloseItself.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwAskWindowToCloseItself.GetResultTypeInfo

function TkwAskWindowToCloseItself.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAskWindowToCloseItself.GetAllParamsCount

function TkwAskWindowToCloseItself.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwAskWindowToCloseItself.ParamsTypes

procedure TkwAskWindowToCloseItself.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: TtfwStackValue;
begin
 try
  l_aWnd := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AskWindowToCloseItself(aCtx, l_aWnd);
end;//TkwAskWindowToCloseItself.DoDoIt

procedure TkwScreenShot2File.ScreenShot2File(const aCtx: TtfwContext;
 aWnd: THandle;
 aLeft: Integer;
 aTop: Integer;
 aWidth: Integer;
 aHeight: Integer;
 const aFileName: AnsiString);
 {* Реализация слова скрипта ScreenShot2File }
//#UC START# *551D6A28026C_551D6A28026C_Word_var*
//#UC END# *551D6A28026C_551D6A28026C_Word_var*
begin
//#UC START# *551D6A28026C_551D6A28026C_Word_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, false, aCtx, Self);
//#UC END# *551D6A28026C_551D6A28026C_Word_impl*
end;//TkwScreenShot2File.ScreenShot2File

class function TkwScreenShot2File.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenShot2File';
end;//TkwScreenShot2File.GetWordNameForRegister

function TkwScreenShot2File.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwScreenShot2File.GetResultTypeInfo

function TkwScreenShot2File.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 6;
end;//TkwScreenShot2File.GetAllParamsCount

function TkwScreenShot2File.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), @tfw_tiString]);
end;//TkwScreenShot2File.ParamsTypes

procedure TkwScreenShot2File.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
var l_aLeft: Integer;
var l_aTop: Integer;
var l_aWidth: Integer;
var l_aHeight: Integer;
var l_aFileName: AnsiString;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLeft := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeft: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTop := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTop: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWidth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWidth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aHeight := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHeight: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScreenShot2File(aCtx, l_aWnd, l_aLeft, l_aTop, l_aWidth, l_aHeight, l_aFileName);
end;//TkwScreenShot2File.DoDoIt

procedure TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck(const aCtx: TtfwContext;
 aWnd: THandle;
 aLeft: Integer;
 aTop: Integer;
 aWidth: Integer;
 aHeight: Integer;
 const aFileName: AnsiString);
 {* Реализация слова скрипта ScreenShot2FileWithCheck }
//#UC START# *551D6A850205_551D6A850205_Word_var*
//#UC END# *551D6A850205_551D6A850205_Word_var*
begin
//#UC START# *551D6A850205_551D6A850205_Word_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, true, aCtx, Self);
//#UC END# *551D6A850205_551D6A850205_Word_impl*
end;//TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck

class function TkwScreenShot2FileWithCheck.GetWordNameForRegister: AnsiString;
begin
 Result := 'ScreenShot2FileWithCheck';
end;//TkwScreenShot2FileWithCheck.GetWordNameForRegister

function TkwScreenShot2FileWithCheck.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwScreenShot2FileWithCheck.GetResultTypeInfo

function TkwScreenShot2FileWithCheck.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 6;
end;//TkwScreenShot2FileWithCheck.GetAllParamsCount

function TkwScreenShot2FileWithCheck.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), @tfw_tiString]);
end;//TkwScreenShot2FileWithCheck.ParamsTypes

procedure TkwScreenShot2FileWithCheck.DoDoIt(const aCtx: TtfwContext);
var l_aWnd: THandle;
var l_aLeft: Integer;
var l_aTop: Integer;
var l_aWidth: Integer;
var l_aHeight: Integer;
var l_aFileName: AnsiString;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLeft := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeft: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTop := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTop: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWidth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWidth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aHeight := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHeight: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScreenShot2FileWithCheck(aCtx, l_aWnd, l_aLeft, l_aTop, l_aWidth, l_aHeight, l_aFileName);
end;//TkwScreenShot2FileWithCheck.DoDoIt

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
 {* Регистрация типа THandle }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoWindows)

end.
