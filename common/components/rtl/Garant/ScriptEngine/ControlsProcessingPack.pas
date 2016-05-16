unit ControlsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ControlsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ControlsProcessingPack" MUID: (4F69DF91037E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Graphics
 , Controls
 , l3Interfaces
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwClassLike
 , Types
 , tfwScriptingInterfaces
 , TypInfo
 , Menus
 , Forms
 , Windows
 , tfwPropertyLike
 , tfwTypeInfo
 , kwBynameControlPush
 , Messages
 , l3PopupMenuHelper
 , l3FormsService
 , l3ControlFontService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TControlFriend = {abstract} class(TControl)
  {* Друг к классу TControl }
 end;//TControlFriend

 TkwPopControlClientToScreen = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ClientToScreen }
  private
   function ClientToScreen(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
    {* Реализация слова скрипта pop:Control:ClientToScreen }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClientToScreen

 TkwPopControlScreenToClient = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ScreenToClient }
  private
   function ScreenToClient(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
    {* Реализация слова скрипта pop:Control:ScreenToClient }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlScreenToClient

 TkwPopControlInvalidate = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Invalidate }
  private
   procedure Invalidate(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Invalidate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlInvalidate

 TkwPopControlRepaint = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Repaint }
  private
   procedure Repaint(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Repaint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlRepaint

 TkwPopControlClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Click }
  private
   procedure Click(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Click }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClick

 TkwPopControlShow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Show }
  private
   procedure Show(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Show }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlShow

 TkwPopControlHide = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Hide }
  private
   procedure Hide(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Hide }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHide

 TkwPopControlUndock = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Undock }
  private
   procedure Undock(const aCtx: TtfwContext;
    aControl: TControl);
    {* Реализация слова скрипта pop:Control:Undock }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlUndock

 TkwPopControlGetPopupMenu = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetPopupMenu }
  private
   function GetPopupMenu(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TMenuItem;
    {* Реализация слова скрипта pop:Control:GetPopupMenu }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetPopupMenu

 TkwPopControlGetTopParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetTopParentForm }
  private
   function GetTopParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetTopParentForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetTopParentForm

 TkwPopControlGetMainForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetMainForm }
  private
   function GetMainForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetMainForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetMainForm

 TkwPopControlGetParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetParentForm }
  private
   function GetParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetParentForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetParentForm

 TkwPopControlGetAnotherParentForm = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetAnotherParentForm }
  private
   function GetAnotherParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
    {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetAnotherParentForm

 TkwControlByHandle = {final} class(TtfwClassLike)
  {* Слово скрипта Control:ByHandle }
  private
   function ByHandle(const aCtx: TtfwContext;
    aHandle: THandle): TControl;
    {* Реализация слова скрипта Control:ByHandle }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlByHandle

 TkwControlFocusedControlPush = {final} class(TtfwClassLike)
  {* Слово скрипта focused:control:push }
  private
   function focused_control_push(const aCtx: TtfwContext): TControl;
    {* Реализация слова скрипта focused:control:push }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlFocusedControlPush

 TkwPopControlColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Color }
  private
   function Color(const aCtx: TtfwContext;
    aControl: TControl): TColor;
    {* Реализация слова скрипта pop:Control:Color }
  protected
   class procedure DoSetValue(aControl: TControl;
    aValue: TColor);
    {* Метод установки значения свойства Color }
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlColor

 TkwPopControlEnabled = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Enabled }
  private
   function Enabled(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:Enabled }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlEnabled

 TkwPopControlVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Visible }
  private
   function Visible(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:Visible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlVisible

 TkwPopControlName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Name }
  private
   function Name(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlName

 TkwPopControlHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Hint }
  private
   function Hint(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Hint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlHint

 TkwPopControlShowHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ShowHint }
  private
   function ShowHint(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
    {* Реализация слова скрипта pop:Control:ShowHint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlShowHint

 TkwPopControlCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Caption }
  private
   function Caption(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
    {* Реализация слова скрипта pop:Control:Caption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlCaption

 TkwPopControlTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Top }
  private
   function Top(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Top }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlTop

 TkwPopControlLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Left }
  private
   function Left(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Left }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlLeft

 TkwPopControlHeight = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Height }
  private
   function Height(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlHeight

 TkwPopControlWidth = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Width }
  private
   function Width(const aCtx: TtfwContext;
    aControl: TControl): Integer;
    {* Реализация слова скрипта pop:Control:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlWidth

 TkwPopControlParent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Parent }
  private
   function Parent(const aCtx: TtfwContext;
    aControl: TControl): TControl;
    {* Реализация слова скрипта pop:Control:Parent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlParent

 TkwPopControlFont = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Font }
  private
   function Font(const aCtx: TtfwContext;
    aControl: TControl): Il3FontInfo;
    {* Реализация слова скрипта pop:Control:Font }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlFont

function TkwPopControlClientToScreen.ClientToScreen(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TPoint;
 {* Реализация слова скрипта pop:Control:ClientToScreen }
begin
 Result := aControl.ClientToScreen(aPoint);
end;//TkwPopControlClientToScreen.ClientToScreen

class function TkwPopControlClientToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ClientToScreen';
end;//TkwPopControlClientToScreen.GetWordNameForRegister

function TkwPopControlClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlClientToScreen.GetResultTypeInfo

function TkwPopControlClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlClientToScreen.GetAllParamsCount

function TkwPopControlClientToScreen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlClientToScreen.ParamsTypes

procedure TkwPopControlClientToScreen.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint(ClientToScreen(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlClientToScreen.DoDoIt

function TkwPopControlScreenToClient.ScreenToClient(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TPoint;
 {* Реализация слова скрипта pop:Control:ScreenToClient }
begin
 Result := aControl.ScreenToClient(aPoint);
end;//TkwPopControlScreenToClient.ScreenToClient

class function TkwPopControlScreenToClient.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ScreenToClient';
end;//TkwPopControlScreenToClient.GetWordNameForRegister

function TkwPopControlScreenToClient.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlScreenToClient.GetResultTypeInfo

function TkwPopControlScreenToClient.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlScreenToClient.GetAllParamsCount

function TkwPopControlScreenToClient.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlScreenToClient.ParamsTypes

procedure TkwPopControlScreenToClient.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint(ScreenToClient(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlScreenToClient.DoDoIt

procedure TkwPopControlInvalidate.Invalidate(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Invalidate }
begin
 aControl.Invalidate;
end;//TkwPopControlInvalidate.Invalidate

class function TkwPopControlInvalidate.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Invalidate';
end;//TkwPopControlInvalidate.GetWordNameForRegister

function TkwPopControlInvalidate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlInvalidate.GetResultTypeInfo

function TkwPopControlInvalidate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlInvalidate.GetAllParamsCount

function TkwPopControlInvalidate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlInvalidate.ParamsTypes

procedure TkwPopControlInvalidate.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Invalidate(aCtx, l_aControl);
end;//TkwPopControlInvalidate.DoDoIt

procedure TkwPopControlRepaint.Repaint(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Repaint }
begin
 aControl.Repaint;
end;//TkwPopControlRepaint.Repaint

class function TkwPopControlRepaint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Repaint';
end;//TkwPopControlRepaint.GetWordNameForRegister

function TkwPopControlRepaint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlRepaint.GetResultTypeInfo

function TkwPopControlRepaint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlRepaint.GetAllParamsCount

function TkwPopControlRepaint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlRepaint.ParamsTypes

procedure TkwPopControlRepaint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Repaint(aCtx, l_aControl);
end;//TkwPopControlRepaint.DoDoIt

procedure TkwPopControlClick.Click(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Click }
//#UC START# *54FED487024E_54FED487024E_47E1201703C3_Word_var*
//#UC END# *54FED487024E_54FED487024E_47E1201703C3_Word_var*
begin
//#UC START# *54FED487024E_54FED487024E_47E1201703C3_Word_impl*
 TControlFriend(aControl).Click;
//#UC END# *54FED487024E_54FED487024E_47E1201703C3_Word_impl*
end;//TkwPopControlClick.Click

class function TkwPopControlClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Click';
end;//TkwPopControlClick.GetWordNameForRegister

function TkwPopControlClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlClick.GetResultTypeInfo

function TkwPopControlClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlClick.GetAllParamsCount

function TkwPopControlClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlClick.ParamsTypes

procedure TkwPopControlClick.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Click(aCtx, l_aControl);
end;//TkwPopControlClick.DoDoIt

procedure TkwPopControlShow.Show(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Show }
begin
 aControl.Show;
end;//TkwPopControlShow.Show

class function TkwPopControlShow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Show';
end;//TkwPopControlShow.GetWordNameForRegister

function TkwPopControlShow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlShow.GetResultTypeInfo

function TkwPopControlShow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlShow.GetAllParamsCount

function TkwPopControlShow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShow.ParamsTypes

procedure TkwPopControlShow.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Show(aCtx, l_aControl);
end;//TkwPopControlShow.DoDoIt

procedure TkwPopControlHide.Hide(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Hide }
begin
 aControl.Hide;
end;//TkwPopControlHide.Hide

class function TkwPopControlHide.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Hide';
end;//TkwPopControlHide.GetWordNameForRegister

function TkwPopControlHide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlHide.GetResultTypeInfo

function TkwPopControlHide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHide.GetAllParamsCount

function TkwPopControlHide.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHide.ParamsTypes

procedure TkwPopControlHide.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Hide(aCtx, l_aControl);
end;//TkwPopControlHide.DoDoIt

procedure TkwPopControlUndock.Undock(const aCtx: TtfwContext;
 aControl: TControl);
 {* Реализация слова скрипта pop:Control:Undock }
//#UC START# *54FEE29D03A3_54FEE29D03A3_47E1201703C3_Word_var*
//#UC END# *54FEE29D03A3_54FEE29D03A3_47E1201703C3_Word_var*
begin
//#UC START# *54FEE29D03A3_54FEE29D03A3_47E1201703C3_Word_impl*
 aControl.ManualDock(nil, nil, alNone);
//#UC END# *54FEE29D03A3_54FEE29D03A3_47E1201703C3_Word_impl*
end;//TkwPopControlUndock.Undock

class function TkwPopControlUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Undock';
end;//TkwPopControlUndock.GetWordNameForRegister

function TkwPopControlUndock.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlUndock.GetResultTypeInfo

function TkwPopControlUndock.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlUndock.GetAllParamsCount

function TkwPopControlUndock.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlUndock.ParamsTypes

procedure TkwPopControlUndock.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Undock(aCtx, l_aControl);
end;//TkwPopControlUndock.DoDoIt

function TkwPopControlGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
 aControl: TControl;
 const aPoint: TPoint): TMenuItem;
 {* Реализация слова скрипта pop:Control:GetPopupMenu }
//#UC START# *550015610205_550015610205_47E1201703C3_Word_var*
//#UC END# *550015610205_550015610205_47E1201703C3_Word_var*
begin
//#UC START# *550015610205_550015610205_47E1201703C3_Word_impl*
 Result := Tl3PopupMenuHelper.Instance.GetPopupMenu(aControl, aPoint);
//#UC END# *550015610205_550015610205_47E1201703C3_Word_impl*
end;//TkwPopControlGetPopupMenu.GetPopupMenu

class function TkwPopControlGetPopupMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetPopupMenu';
end;//TkwPopControlGetPopupMenu.GetWordNameForRegister

function TkwPopControlGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopControlGetPopupMenu.GetResultTypeInfo

function TkwPopControlGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlGetPopupMenu.GetAllParamsCount

function TkwPopControlGetPopupMenu.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlGetPopupMenu.ParamsTypes

procedure TkwPopControlGetPopupMenu.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPopupMenu(aCtx, l_aControl, l_aPoint));
end;//TkwPopControlGetPopupMenu.DoDoIt

function TkwPopControlGetTopParentForm.GetTopParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetTopParentForm }
//#UC START# *5506E91A011F_5506E91A011F_47E1201703C3_Word_var*
//#UC END# *5506E91A011F_5506E91A011F_47E1201703C3_Word_var*
begin
//#UC START# *5506E91A011F_5506E91A011F_47E1201703C3_Word_impl*
 Result := Tl3FormsService.Instance.GetTopParentForm(aControl);
//#UC END# *5506E91A011F_5506E91A011F_47E1201703C3_Word_impl*
end;//TkwPopControlGetTopParentForm.GetTopParentForm

class function TkwPopControlGetTopParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetTopParentForm';
end;//TkwPopControlGetTopParentForm.GetWordNameForRegister

function TkwPopControlGetTopParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetTopParentForm.GetResultTypeInfo

function TkwPopControlGetTopParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetTopParentForm.GetAllParamsCount

function TkwPopControlGetTopParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetTopParentForm.ParamsTypes

procedure TkwPopControlGetTopParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetTopParentForm(aCtx, l_aControl));
end;//TkwPopControlGetTopParentForm.DoDoIt

function TkwPopControlGetMainForm.GetMainForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetMainForm }
//#UC START# *5506E93200C2_5506E93200C2_47E1201703C3_Word_var*
//#UC END# *5506E93200C2_5506E93200C2_47E1201703C3_Word_var*
begin
//#UC START# *5506E93200C2_5506E93200C2_47E1201703C3_Word_impl*
 Result := Tl3FormsService.Instance.GetMainForm(aControl);
//#UC END# *5506E93200C2_5506E93200C2_47E1201703C3_Word_impl*
end;//TkwPopControlGetMainForm.GetMainForm

class function TkwPopControlGetMainForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetMainForm';
end;//TkwPopControlGetMainForm.GetWordNameForRegister

function TkwPopControlGetMainForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetMainForm.GetResultTypeInfo

function TkwPopControlGetMainForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetMainForm.GetAllParamsCount

function TkwPopControlGetMainForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetMainForm.ParamsTypes

procedure TkwPopControlGetMainForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetMainForm(aCtx, l_aControl));
end;//TkwPopControlGetMainForm.DoDoIt

function TkwPopControlGetParentForm.GetParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetParentForm }
//#UC START# *5506E9460154_5506E9460154_47E1201703C3_Word_var*
//#UC END# *5506E9460154_5506E9460154_47E1201703C3_Word_var*
begin
//#UC START# *5506E9460154_5506E9460154_47E1201703C3_Word_impl*
 Result := Tl3FormsService.Instance.GetParentForm(aControl);
//#UC END# *5506E9460154_5506E9460154_47E1201703C3_Word_impl*
end;//TkwPopControlGetParentForm.GetParentForm

class function TkwPopControlGetParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetParentForm';
end;//TkwPopControlGetParentForm.GetWordNameForRegister

function TkwPopControlGetParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetParentForm.GetResultTypeInfo

function TkwPopControlGetParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetParentForm.GetAllParamsCount

function TkwPopControlGetParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetParentForm.ParamsTypes

procedure TkwPopControlGetParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetParentForm(aCtx, l_aControl));
end;//TkwPopControlGetParentForm.DoDoIt

function TkwPopControlGetAnotherParentForm.GetAnotherParentForm(const aCtx: TtfwContext;
 aControl: TControl): TCustomForm;
 {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
//#UC START# *5506E95C015D_5506E95C015D_47E1201703C3_Word_var*
//#UC END# *5506E95C015D_5506E95C015D_47E1201703C3_Word_var*
begin
//#UC START# *5506E95C015D_5506E95C015D_47E1201703C3_Word_impl*
 Result := Tl3FormsService.Instance.GetAnotherParentForm(aControl);
//#UC END# *5506E95C015D_5506E95C015D_47E1201703C3_Word_impl*
end;//TkwPopControlGetAnotherParentForm.GetAnotherParentForm

class function TkwPopControlGetAnotherParentForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetAnotherParentForm';
end;//TkwPopControlGetAnotherParentForm.GetWordNameForRegister

function TkwPopControlGetAnotherParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetAnotherParentForm.GetResultTypeInfo

function TkwPopControlGetAnotherParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlGetAnotherParentForm.GetAllParamsCount

function TkwPopControlGetAnotherParentForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetAnotherParentForm.ParamsTypes

procedure TkwPopControlGetAnotherParentForm.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetAnotherParentForm(aCtx, l_aControl));
end;//TkwPopControlGetAnotherParentForm.DoDoIt

function TkwControlByHandle.ByHandle(const aCtx: TtfwContext;
 aHandle: THandle): TControl;
 {* Реализация слова скрипта Control:ByHandle }
//#UC START# *5511831402B5_5511831402B5_47E1201703C3_Word_var*
//#UC END# *5511831402B5_5511831402B5_47E1201703C3_Word_var*
begin
//#UC START# *5511831402B5_5511831402B5_47E1201703C3_Word_impl*
 Result := FindControl(aHandle);
 RunnerAssert(Assigned(Result), 'Не найден контрол.', aCtx);
//#UC END# *5511831402B5_5511831402B5_47E1201703C3_Word_impl*
end;//TkwControlByHandle.ByHandle

class function TkwControlByHandle.GetWordNameForRegister: AnsiString;
begin
 Result := 'Control:ByHandle';
end;//TkwControlByHandle.GetWordNameForRegister

function TkwControlByHandle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwControlByHandle.GetResultTypeInfo

function TkwControlByHandle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwControlByHandle.GetAllParamsCount

function TkwControlByHandle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), TypeInfo(THandle)]);
end;//TkwControlByHandle.ParamsTypes

procedure TkwControlByHandle.DoDoIt(const aCtx: TtfwContext);
var l_aHandle: THandle;
begin
 try
  l_aHandle := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHandle: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ByHandle(aCtx, l_aHandle));
end;//TkwControlByHandle.DoDoIt

function TkwControlFocusedControlPush.focused_control_push(const aCtx: TtfwContext): TControl;
 {* Реализация слова скрипта focused:control:push }
//#UC START# *551EA6DD0274_551EA6DD0274_47E1201703C3_Word_var*
var
 l_C : TControl;
//#UC END# *551EA6DD0274_551EA6DD0274_47E1201703C3_Word_var*
begin
//#UC START# *551EA6DD0274_551EA6DD0274_47E1201703C3_Word_impl*
 l_C := FindControl(GetFocus);
 if (l_C = nil) then
 // - наверное мы под отладчиком или из под нас выдернули фокус
 begin
  RunnerAssert(Screen.ActiveForm <> nil, 'Нет активной формы', aCtx);
  l_C := Screen.ActiveForm.ActiveControl;
 end;//l_C = nil
 RunnerAssert(l_C <> nil, 'Не нашли контрол в фокусе', aCtx);
 Result := l_C;
//#UC END# *551EA6DD0274_551EA6DD0274_47E1201703C3_Word_impl*
end;//TkwControlFocusedControlPush.focused_control_push

class function TkwControlFocusedControlPush.GetWordNameForRegister: AnsiString;
begin
 Result := 'focused:control:push';
end;//TkwControlFocusedControlPush.GetWordNameForRegister

function TkwControlFocusedControlPush.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwControlFocusedControlPush.GetResultTypeInfo

function TkwControlFocusedControlPush.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwControlFocusedControlPush.GetAllParamsCount

function TkwControlFocusedControlPush.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwControlFocusedControlPush.ParamsTypes

procedure TkwControlFocusedControlPush.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(focused_control_push(aCtx));
end;//TkwControlFocusedControlPush.DoDoIt

class procedure TkwPopControlColor.DoSetValue(aControl: TControl;
 aValue: TColor);
 {* Метод установки значения свойства Color }
//#UC START# *54FED42200C0_47E1201703C3_Word_DoSetValue_54FED42200C0_47E1201703C3_Word_var*
//#UC END# *54FED42200C0_47E1201703C3_Word_DoSetValue_54FED42200C0_47E1201703C3_Word_var*
begin
//#UC START# *54FED42200C0_47E1201703C3_Word_DoSetValue_54FED42200C0_47E1201703C3_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *54FED42200C0_47E1201703C3_Word_DoSetValue_54FED42200C0_47E1201703C3_Word_impl*
end;//TkwPopControlColor.DoSetValue

function TkwPopControlColor.Color(const aCtx: TtfwContext;
 aControl: TControl): TColor;
 {* Реализация слова скрипта pop:Control:Color }
//#UC START# *54FED42200C0_54FED42200C0_47E1201703C3_Word_var*
//#UC END# *54FED42200C0_54FED42200C0_47E1201703C3_Word_var*
begin
//#UC START# *54FED42200C0_54FED42200C0_47E1201703C3_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *54FED42200C0_54FED42200C0_47E1201703C3_Word_impl*
end;//TkwPopControlColor.Color

class function TkwPopControlColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Color';
end;//TkwPopControlColor.GetWordNameForRegister

function TkwPopControlColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TColor);
end;//TkwPopControlColor.GetResultTypeInfo

function TkwPopControlColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlColor.GetAllParamsCount

function TkwPopControlColor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlColor.ParamsTypes

procedure TkwPopControlColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_Control, TColor(aValue.AsInt));
end;//TkwPopControlColor.SetValuePrim

procedure TkwPopControlColor.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Color(aCtx, l_aControl)));
end;//TkwPopControlColor.DoDoIt

function TkwPopControlEnabled.Enabled(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:Enabled }
begin
 Result := aControl.Enabled;
end;//TkwPopControlEnabled.Enabled

class function TkwPopControlEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Enabled';
end;//TkwPopControlEnabled.GetWordNameForRegister

function TkwPopControlEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlEnabled.GetResultTypeInfo

function TkwPopControlEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlEnabled.GetAllParamsCount

function TkwPopControlEnabled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlEnabled.ParamsTypes

procedure TkwPopControlEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopControlEnabled.SetValuePrim

procedure TkwPopControlEnabled.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Enabled(aCtx, l_aControl));
end;//TkwPopControlEnabled.DoDoIt

function TkwPopControlVisible.Visible(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:Visible }
begin
 Result := aControl.Visible;
end;//TkwPopControlVisible.Visible

class function TkwPopControlVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Visible';
end;//TkwPopControlVisible.GetWordNameForRegister

function TkwPopControlVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlVisible.GetResultTypeInfo

function TkwPopControlVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlVisible.GetAllParamsCount

function TkwPopControlVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlVisible.ParamsTypes

procedure TkwPopControlVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopControlVisible.SetValuePrim

procedure TkwPopControlVisible.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Visible(aCtx, l_aControl));
end;//TkwPopControlVisible.DoDoIt

function TkwPopControlName.Name(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Name }
begin
 Result := aControl.Name;
end;//TkwPopControlName.Name

class function TkwPopControlName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Name';
end;//TkwPopControlName.GetWordNameForRegister

function TkwPopControlName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlName.GetResultTypeInfo

function TkwPopControlName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlName.GetAllParamsCount

function TkwPopControlName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlName.ParamsTypes

procedure TkwPopControlName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopControlName.SetValuePrim

procedure TkwPopControlName.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aControl));
end;//TkwPopControlName.DoDoIt

function TkwPopControlHint.Hint(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Hint }
begin
 Result := aControl.Hint;
end;//TkwPopControlHint.Hint

class function TkwPopControlHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Hint';
end;//TkwPopControlHint.GetWordNameForRegister

function TkwPopControlHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlHint.GetResultTypeInfo

function TkwPopControlHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHint.GetAllParamsCount

function TkwPopControlHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHint.ParamsTypes

procedure TkwPopControlHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Hint', aCtx);
end;//TkwPopControlHint.SetValuePrim

procedure TkwPopControlHint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Hint(aCtx, l_aControl));
end;//TkwPopControlHint.DoDoIt

function TkwPopControlShowHint.ShowHint(const aCtx: TtfwContext;
 aControl: TControl): Boolean;
 {* Реализация слова скрипта pop:Control:ShowHint }
begin
 Result := aControl.ShowHint;
end;//TkwPopControlShowHint.ShowHint

class function TkwPopControlShowHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ShowHint';
end;//TkwPopControlShowHint.GetWordNameForRegister

function TkwPopControlShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlShowHint.GetResultTypeInfo

function TkwPopControlShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlShowHint.GetAllParamsCount

function TkwPopControlShowHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShowHint.ParamsTypes

procedure TkwPopControlShowHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowHint', aCtx);
end;//TkwPopControlShowHint.SetValuePrim

procedure TkwPopControlShowHint.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(ShowHint(aCtx, l_aControl));
end;//TkwPopControlShowHint.DoDoIt

function TkwPopControlCaption.Caption(const aCtx: TtfwContext;
 aControl: TControl): AnsiString;
 {* Реализация слова скрипта pop:Control:Caption }
//#UC START# *54FED5F90129_54FED5F90129_47E1201703C3_Word_var*
//#UC END# *54FED5F90129_54FED5F90129_47E1201703C3_Word_var*
begin
//#UC START# *54FED5F90129_54FED5F90129_47E1201703C3_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *54FED5F90129_54FED5F90129_47E1201703C3_Word_impl*
end;//TkwPopControlCaption.Caption

class function TkwPopControlCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Caption';
end;//TkwPopControlCaption.GetWordNameForRegister

function TkwPopControlCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopControlCaption.GetResultTypeInfo

function TkwPopControlCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlCaption.GetAllParamsCount

function TkwPopControlCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlCaption.ParamsTypes

procedure TkwPopControlCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwPopControlCaption.SetValuePrim

procedure TkwPopControlCaption.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Caption(aCtx, l_aControl));
end;//TkwPopControlCaption.DoDoIt

function TkwPopControlTop.Top(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Top }
begin
 Result := aControl.Top;
end;//TkwPopControlTop.Top

class function TkwPopControlTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Top';
end;//TkwPopControlTop.GetWordNameForRegister

function TkwPopControlTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlTop.GetResultTypeInfo

function TkwPopControlTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlTop.GetAllParamsCount

function TkwPopControlTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlTop.ParamsTypes

procedure TkwPopControlTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Top := aValue.AsInt;
end;//TkwPopControlTop.SetValuePrim

procedure TkwPopControlTop.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Top(aCtx, l_aControl));
end;//TkwPopControlTop.DoDoIt

function TkwPopControlLeft.Left(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Left }
begin
 Result := aControl.Left;
end;//TkwPopControlLeft.Left

class function TkwPopControlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Left';
end;//TkwPopControlLeft.GetWordNameForRegister

function TkwPopControlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlLeft.GetResultTypeInfo

function TkwPopControlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlLeft.GetAllParamsCount

function TkwPopControlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlLeft.ParamsTypes

procedure TkwPopControlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Left := aValue.AsInt;
end;//TkwPopControlLeft.SetValuePrim

procedure TkwPopControlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Left(aCtx, l_aControl));
end;//TkwPopControlLeft.DoDoIt

function TkwPopControlHeight.Height(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Height }
begin
 Result := aControl.Height;
end;//TkwPopControlHeight.Height

class function TkwPopControlHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Height';
end;//TkwPopControlHeight.GetWordNameForRegister

function TkwPopControlHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlHeight.GetResultTypeInfo

function TkwPopControlHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHeight.GetAllParamsCount

function TkwPopControlHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHeight.ParamsTypes

procedure TkwPopControlHeight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Height := aValue.AsInt;
end;//TkwPopControlHeight.SetValuePrim

procedure TkwPopControlHeight.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Height(aCtx, l_aControl));
end;//TkwPopControlHeight.DoDoIt

function TkwPopControlWidth.Width(const aCtx: TtfwContext;
 aControl: TControl): Integer;
 {* Реализация слова скрипта pop:Control:Width }
begin
 Result := aControl.Width;
end;//TkwPopControlWidth.Width

class function TkwPopControlWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Width';
end;//TkwPopControlWidth.GetWordNameForRegister

function TkwPopControlWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlWidth.GetResultTypeInfo

function TkwPopControlWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlWidth.GetAllParamsCount

function TkwPopControlWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlWidth.ParamsTypes

procedure TkwPopControlWidth.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Width := aValue.AsInt;
end;//TkwPopControlWidth.SetValuePrim

procedure TkwPopControlWidth.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Width(aCtx, l_aControl));
end;//TkwPopControlWidth.DoDoIt

function TkwPopControlParent.Parent(const aCtx: TtfwContext;
 aControl: TControl): TControl;
 {* Реализация слова скрипта pop:Control:Parent }
begin
 Result := aControl.Parent;
end;//TkwPopControlParent.Parent

class function TkwPopControlParent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Parent';
end;//TkwPopControlParent.GetWordNameForRegister

function TkwPopControlParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwPopControlParent.GetResultTypeInfo

function TkwPopControlParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlParent.GetAllParamsCount

function TkwPopControlParent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlParent.ParamsTypes

procedure TkwPopControlParent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Parent', aCtx);
end;//TkwPopControlParent.SetValuePrim

procedure TkwPopControlParent.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Parent(aCtx, l_aControl));
end;//TkwPopControlParent.DoDoIt

function TkwPopControlFont.Font(const aCtx: TtfwContext;
 aControl: TControl): Il3FontInfo;
 {* Реализация слова скрипта pop:Control:Font }
//#UC START# *556F26B303CB_556F26B303CB_47E1201703C3_Word_var*
//#UC END# *556F26B303CB_556F26B303CB_47E1201703C3_Word_var*
begin
//#UC START# *556F26B303CB_556F26B303CB_47E1201703C3_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *556F26B303CB_556F26B303CB_47E1201703C3_Word_impl*
end;//TkwPopControlFont.Font

class function TkwPopControlFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Font';
end;//TkwPopControlFont.GetWordNameForRegister

function TkwPopControlFont.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Il3FontInfo);
end;//TkwPopControlFont.GetResultTypeInfo

function TkwPopControlFont.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlFont.GetAllParamsCount

function TkwPopControlFont.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlFont.ParamsTypes

procedure TkwPopControlFont.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Font', aCtx);
end;//TkwPopControlFont.SetValuePrim

procedure TkwPopControlFont.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Font(aCtx, l_aControl), TypeInfo(Il3FontInfo));
end;//TkwPopControlFont.DoDoIt

initialization
 TkwPopControlClientToScreen.RegisterInEngine;
 {* Регистрация pop_Control_ClientToScreen }
 TkwPopControlScreenToClient.RegisterInEngine;
 {* Регистрация pop_Control_ScreenToClient }
 TkwPopControlInvalidate.RegisterInEngine;
 {* Регистрация pop_Control_Invalidate }
 TkwPopControlRepaint.RegisterInEngine;
 {* Регистрация pop_Control_Repaint }
 TkwPopControlClick.RegisterInEngine;
 {* Регистрация pop_Control_Click }
 TkwPopControlShow.RegisterInEngine;
 {* Регистрация pop_Control_Show }
 TkwPopControlHide.RegisterInEngine;
 {* Регистрация pop_Control_Hide }
 TkwPopControlUndock.RegisterInEngine;
 {* Регистрация pop_Control_Undock }
 TkwPopControlGetPopupMenu.RegisterInEngine;
 {* Регистрация pop_Control_GetPopupMenu }
 TkwPopControlGetTopParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetTopParentForm }
 TkwPopControlGetMainForm.RegisterInEngine;
 {* Регистрация pop_Control_GetMainForm }
 TkwPopControlGetParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetParentForm }
 TkwPopControlGetAnotherParentForm.RegisterInEngine;
 {* Регистрация pop_Control_GetAnotherParentForm }
 TkwControlByHandle.RegisterInEngine;
 {* Регистрация Control_ByHandle }
 TkwControlFocusedControlPush.RegisterInEngine;
 {* Регистрация Control_focused_control_push }
 TkwPopControlColor.RegisterInEngine;
 {* Регистрация pop_Control_Color }
 TkwPopControlEnabled.RegisterInEngine;
 {* Регистрация pop_Control_Enabled }
 TkwPopControlVisible.RegisterInEngine;
 {* Регистрация pop_Control_Visible }
 TkwPopControlName.RegisterInEngine;
 {* Регистрация pop_Control_Name }
 TkwPopControlHint.RegisterInEngine;
 {* Регистрация pop_Control_Hint }
 TkwPopControlShowHint.RegisterInEngine;
 {* Регистрация pop_Control_ShowHint }
 TkwPopControlCaption.RegisterInEngine;
 {* Регистрация pop_Control_Caption }
 TkwPopControlTop.RegisterInEngine;
 {* Регистрация pop_Control_Top }
 TkwPopControlLeft.RegisterInEngine;
 {* Регистрация pop_Control_Left }
 TkwPopControlHeight.RegisterInEngine;
 {* Регистрация pop_Control_Height }
 TkwPopControlWidth.RegisterInEngine;
 {* Регистрация pop_Control_Width }
 TkwPopControlParent.RegisterInEngine;
 {* Регистрация pop_Control_Parent }
 TkwPopControlFont.RegisterInEngine;
 {* Регистрация pop_Control_Font }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* Регистрация типа TCustomForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TColor));
 {* Регистрация типа TColor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
 {* Регистрация типа Il3FontInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
 {* Регистрация типа THandle }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
