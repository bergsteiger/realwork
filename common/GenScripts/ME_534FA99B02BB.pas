unit ReminderWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ReminderWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ReminderWordsPack" MUID: (534FA99B02BB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Interfaces
 , vtPopupFormModelPart
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vgRemindersLine
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , Types
 , Classes
 , Menus
 , tfwPropertyLike
 , tfwTypeInfo
 , l3PopupMenuHelper
 , RemindersLineWordsPack
 , Forms
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopReminderClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Click }
  private
   procedure Click(const aCtx: TtfwContext;
    aReminder: TvgReminder);
    {* Реализация слова скрипта pop:Reminder:Click }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderClick

 TkwPopReminderMove = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Move }
  private
   procedure Move(const aCtx: TtfwContext;
    aReminder: TvgReminder;
    const aDelta: TPoint);
    {* Реализация слова скрипта pop:Reminder:Move }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderMove

 TkwPopReminderFindEditor = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:FindEditor }
  private
   function FindEditor(const aCtx: TtfwContext;
    aReminder: TvgReminder): TComponent;
    {* Реализация слова скрипта pop:Reminder:FindEditor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderFindEditor

 TkwPopReminderGetPopupMenu = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:GetPopupMenu }
  private
   function GetPopupMenu(const aCtx: TtfwContext;
    aReminder: TvgReminder): TMenuItem;
    {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderGetPopupMenu

 TkwPopReminderImageIndex = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ImageIndex }
  private
   function ImageIndex(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
    {* Реализация слова скрипта pop:Reminder:ImageIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderImageIndex

 TkwPopReminderUserType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:UserType }
  private
   function UserType(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
    {* Реализация слова скрипта pop:Reminder:UserType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderUserType

 TkwPopReminderIsBaloonVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:IsBaloonVisible }
  private
   function IsBaloonVisible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderIsBaloonVisible

 TkwPopReminderVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Visible }
  private
   function Visible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:Visible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderVisible

 TkwPopReminderName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Name }
  private
   function Name(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
    {* Реализация слова скрипта pop:Reminder:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderName

 TkwPopReminderFlash = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Flash }
  private
   function Flash(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:Flash }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderFlash

 TkwPopReminderTextBackColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:TextBackColor }
  private
   function TextBackColor(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
    {* Реализация слова скрипта pop:Reminder:TextBackColor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderTextBackColor

 TkwPopReminderShowHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ShowHint }
  private
   function ShowHint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:ShowHint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderShowHint

 TkwPopReminderCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Caption }
  private
   function Caption(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
    {* Реализация слова скрипта pop:Reminder:Caption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderCaption

 TkwPopReminderHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Hint }
  private
   function Hint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
    {* Реализация слова скрипта pop:Reminder:Hint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderHint

 TkwPopReminderPopupForm = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:PopupForm }
  private
   function PopupForm(const aCtx: TtfwContext;
    aReminder: TvgReminder): TvtPopupFormModelPart;
    {* Реализация слова скрипта pop:Reminder:PopupForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopReminderPopupForm

procedure TkwPopReminderClick.Click(const aCtx: TtfwContext;
 aReminder: TvgReminder);
 {* Реализация слова скрипта pop:Reminder:Click }
begin
 aReminder.Click;
end;//TkwPopReminderClick.Click

class function TkwPopReminderClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Click';
end;//TkwPopReminderClick.GetWordNameForRegister

function TkwPopReminderClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopReminderClick.GetResultTypeInfo

function TkwPopReminderClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderClick.GetAllParamsCount

function TkwPopReminderClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderClick.ParamsTypes

procedure TkwPopReminderClick.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Click(aCtx, l_aReminder);
end;//TkwPopReminderClick.DoDoIt

procedure TkwPopReminderMove.Move(const aCtx: TtfwContext;
 aReminder: TvgReminder;
 const aDelta: TPoint);
 {* Реализация слова скрипта pop:Reminder:Move }
//#UC START# *55004A3A0131_55004A3A0131_532973740186_Word_var*
//#UC END# *55004A3A0131_55004A3A0131_532973740186_Word_var*
begin
//#UC START# *55004A3A0131_55004A3A0131_532973740186_Word_impl*
 RunnerAssert(aReminder.Owner is TvgRemindersLine, 'Не найдена линия медали', aCtx);
 (aReminder.Owner as TvgRemindersLine).OffSetLine(aDelta.X, aDelta.Y);
//#UC END# *55004A3A0131_55004A3A0131_532973740186_Word_impl*
end;//TkwPopReminderMove.Move

class function TkwPopReminderMove.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Move';
end;//TkwPopReminderMove.GetWordNameForRegister

function TkwPopReminderMove.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopReminderMove.GetResultTypeInfo

function TkwPopReminderMove.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopReminderMove.GetAllParamsCount

function TkwPopReminderMove.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder), @tfw_tiStruct]);
end;//TkwPopReminderMove.ParamsTypes

procedure TkwPopReminderMove.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
var l_aDelta: TPoint;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelta := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelta: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Move(aCtx, l_aReminder, l_aDelta);
end;//TkwPopReminderMove.DoDoIt

function TkwPopReminderFindEditor.FindEditor(const aCtx: TtfwContext;
 aReminder: TvgReminder): TComponent;
 {* Реализация слова скрипта pop:Reminder:FindEditor }
//#UC START# *55004A7901B4_55004A7901B4_532973740186_Word_var*
var
 l_F : TForm;
 l_E : TComponent;
//#UC END# *55004A7901B4_55004A7901B4_532973740186_Word_var*
begin
//#UC START# *55004A7901B4_55004A7901B4_532973740186_Word_impl*
 with aReminder do
 begin
  RunnerAssert(Assigned(PopupForm) and PopupForm.Visible, 'Баллон не существует или невидим.', aCtx);
  l_F := PopupForm.Panel.Controls[0] as TForm;
  l_E := l_F.FindComponent('Viewer');
  RunnerAssert(Assigned(l_E), 'Не найден редактор в баллоне.', aCtx);
  Result := l_E;
 end;//with aReminder
//#UC END# *55004A7901B4_55004A7901B4_532973740186_Word_impl*
end;//TkwPopReminderFindEditor.FindEditor

class function TkwPopReminderFindEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:FindEditor';
end;//TkwPopReminderFindEditor.GetWordNameForRegister

function TkwPopReminderFindEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComponent);
end;//TkwPopReminderFindEditor.GetResultTypeInfo

function TkwPopReminderFindEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderFindEditor.GetAllParamsCount

function TkwPopReminderFindEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderFindEditor.ParamsTypes

procedure TkwPopReminderFindEditor.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindEditor(aCtx, l_aReminder));
end;//TkwPopReminderFindEditor.DoDoIt

function TkwPopReminderGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
 aReminder: TvgReminder): TMenuItem;
 {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
//#UC START# *55004A9B02E5_55004A9B02E5_532973740186_Word_var*
var
 l_Pt: TPoint;
//#UC END# *55004A9B02E5_55004A9B02E5_532973740186_Word_var*
begin
//#UC START# *55004A9B02E5_55004A9B02E5_532973740186_Word_impl*
 l_Pt.X := 0;
 l_Pt.Y := 0;
 Result := Tl3PopupMenuHelper.Instance.GetPopupMenu(aReminder, l_Pt);
//#UC END# *55004A9B02E5_55004A9B02E5_532973740186_Word_impl*
end;//TkwPopReminderGetPopupMenu.GetPopupMenu

class function TkwPopReminderGetPopupMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:GetPopupMenu';
end;//TkwPopReminderGetPopupMenu.GetWordNameForRegister

function TkwPopReminderGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopReminderGetPopupMenu.GetResultTypeInfo

function TkwPopReminderGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderGetPopupMenu.GetAllParamsCount

function TkwPopReminderGetPopupMenu.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderGetPopupMenu.ParamsTypes

procedure TkwPopReminderGetPopupMenu.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetPopupMenu(aCtx, l_aReminder));
end;//TkwPopReminderGetPopupMenu.DoDoIt

function TkwPopReminderImageIndex.ImageIndex(const aCtx: TtfwContext;
 aReminder: TvgReminder): Integer;
 {* Реализация слова скрипта pop:Reminder:ImageIndex }
begin
 Result := aReminder.ImageIndex;
end;//TkwPopReminderImageIndex.ImageIndex

class function TkwPopReminderImageIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:ImageIndex';
end;//TkwPopReminderImageIndex.GetWordNameForRegister

function TkwPopReminderImageIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopReminderImageIndex.GetResultTypeInfo

function TkwPopReminderImageIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderImageIndex.GetAllParamsCount

function TkwPopReminderImageIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderImageIndex.ParamsTypes

procedure TkwPopReminderImageIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ImageIndex', aCtx);
end;//TkwPopReminderImageIndex.SetValuePrim

procedure TkwPopReminderImageIndex.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ImageIndex(aCtx, l_aReminder));
end;//TkwPopReminderImageIndex.DoDoIt

function TkwPopReminderUserType.UserType(const aCtx: TtfwContext;
 aReminder: TvgReminder): Integer;
 {* Реализация слова скрипта pop:Reminder:UserType }
begin
 Result := aReminder.UserType;
end;//TkwPopReminderUserType.UserType

class function TkwPopReminderUserType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:UserType';
end;//TkwPopReminderUserType.GetWordNameForRegister

function TkwPopReminderUserType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopReminderUserType.GetResultTypeInfo

function TkwPopReminderUserType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderUserType.GetAllParamsCount

function TkwPopReminderUserType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderUserType.ParamsTypes

procedure TkwPopReminderUserType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserType', aCtx);
end;//TkwPopReminderUserType.SetValuePrim

procedure TkwPopReminderUserType.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(UserType(aCtx, l_aReminder));
end;//TkwPopReminderUserType.DoDoIt

function TkwPopReminderIsBaloonVisible.IsBaloonVisible(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
//#UC START# *550047F201E5_550047F201E5_532973740186_Word_var*
//#UC END# *550047F201E5_550047F201E5_532973740186_Word_var*
begin
//#UC START# *550047F201E5_550047F201E5_532973740186_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550047F201E5_550047F201E5_532973740186_Word_impl*
end;//TkwPopReminderIsBaloonVisible.IsBaloonVisible

class function TkwPopReminderIsBaloonVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:IsBaloonVisible';
end;//TkwPopReminderIsBaloonVisible.GetWordNameForRegister

function TkwPopReminderIsBaloonVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderIsBaloonVisible.GetResultTypeInfo

function TkwPopReminderIsBaloonVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderIsBaloonVisible.GetAllParamsCount

function TkwPopReminderIsBaloonVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderIsBaloonVisible.ParamsTypes

procedure TkwPopReminderIsBaloonVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsBaloonVisible', aCtx);
end;//TkwPopReminderIsBaloonVisible.SetValuePrim

procedure TkwPopReminderIsBaloonVisible.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsBaloonVisible(aCtx, l_aReminder));
end;//TkwPopReminderIsBaloonVisible.DoDoIt

function TkwPopReminderVisible.Visible(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:Visible }
begin
 Result := aReminder.Visible;
end;//TkwPopReminderVisible.Visible

class function TkwPopReminderVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Visible';
end;//TkwPopReminderVisible.GetWordNameForRegister

function TkwPopReminderVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderVisible.GetResultTypeInfo

function TkwPopReminderVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderVisible.GetAllParamsCount

function TkwPopReminderVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderVisible.ParamsTypes

procedure TkwPopReminderVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopReminderVisible.SetValuePrim

procedure TkwPopReminderVisible.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Visible(aCtx, l_aReminder));
end;//TkwPopReminderVisible.DoDoIt

function TkwPopReminderName.Name(const aCtx: TtfwContext;
 aReminder: TvgReminder): AnsiString;
 {* Реализация слова скрипта pop:Reminder:Name }
begin
 Result := aReminder.Name;
end;//TkwPopReminderName.Name

class function TkwPopReminderName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Name';
end;//TkwPopReminderName.GetWordNameForRegister

function TkwPopReminderName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopReminderName.GetResultTypeInfo

function TkwPopReminderName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderName.GetAllParamsCount

function TkwPopReminderName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderName.ParamsTypes

procedure TkwPopReminderName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopReminderName.SetValuePrim

procedure TkwPopReminderName.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aReminder));
end;//TkwPopReminderName.DoDoIt

function TkwPopReminderFlash.Flash(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:Flash }
begin
 Result := aReminder.Flash;
end;//TkwPopReminderFlash.Flash

class function TkwPopReminderFlash.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Flash';
end;//TkwPopReminderFlash.GetWordNameForRegister

function TkwPopReminderFlash.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderFlash.GetResultTypeInfo

function TkwPopReminderFlash.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderFlash.GetAllParamsCount

function TkwPopReminderFlash.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderFlash.ParamsTypes

procedure TkwPopReminderFlash.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Flash', aCtx);
end;//TkwPopReminderFlash.SetValuePrim

procedure TkwPopReminderFlash.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Flash(aCtx, l_aReminder));
end;//TkwPopReminderFlash.DoDoIt

function TkwPopReminderTextBackColor.TextBackColor(const aCtx: TtfwContext;
 aReminder: TvgReminder): AnsiString;
 {* Реализация слова скрипта pop:Reminder:TextBackColor }
//#UC START# *550048F80073_550048F80073_532973740186_Word_var*
//#UC END# *550048F80073_550048F80073_532973740186_Word_var*
begin
//#UC START# *550048F80073_550048F80073_532973740186_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *550048F80073_550048F80073_532973740186_Word_impl*
end;//TkwPopReminderTextBackColor.TextBackColor

class function TkwPopReminderTextBackColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:TextBackColor';
end;//TkwPopReminderTextBackColor.GetWordNameForRegister

function TkwPopReminderTextBackColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopReminderTextBackColor.GetResultTypeInfo

function TkwPopReminderTextBackColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderTextBackColor.GetAllParamsCount

function TkwPopReminderTextBackColor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderTextBackColor.ParamsTypes

procedure TkwPopReminderTextBackColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextBackColor', aCtx);
end;//TkwPopReminderTextBackColor.SetValuePrim

procedure TkwPopReminderTextBackColor.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(TextBackColor(aCtx, l_aReminder));
end;//TkwPopReminderTextBackColor.DoDoIt

function TkwPopReminderShowHint.ShowHint(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:ShowHint }
begin
 Result := aReminder.ShowHint;
end;//TkwPopReminderShowHint.ShowHint

class function TkwPopReminderShowHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:ShowHint';
end;//TkwPopReminderShowHint.GetWordNameForRegister

function TkwPopReminderShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderShowHint.GetResultTypeInfo

function TkwPopReminderShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderShowHint.GetAllParamsCount

function TkwPopReminderShowHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderShowHint.ParamsTypes

procedure TkwPopReminderShowHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowHint', aCtx);
end;//TkwPopReminderShowHint.SetValuePrim

procedure TkwPopReminderShowHint.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(ShowHint(aCtx, l_aReminder));
end;//TkwPopReminderShowHint.DoDoIt

function TkwPopReminderCaption.Caption(const aCtx: TtfwContext;
 aReminder: TvgReminder): Il3CString;
 {* Реализация слова скрипта pop:Reminder:Caption }
begin
 Result := aReminder.Caption;
end;//TkwPopReminderCaption.Caption

class function TkwPopReminderCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Caption';
end;//TkwPopReminderCaption.GetWordNameForRegister

function TkwPopReminderCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopReminderCaption.GetResultTypeInfo

function TkwPopReminderCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderCaption.GetAllParamsCount

function TkwPopReminderCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderCaption.ParamsTypes

procedure TkwPopReminderCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwPopReminderCaption.SetValuePrim

procedure TkwPopReminderCaption.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Caption(aCtx, l_aReminder));
end;//TkwPopReminderCaption.DoDoIt

function TkwPopReminderHint.Hint(const aCtx: TtfwContext;
 aReminder: TvgReminder): Il3CString;
 {* Реализация слова скрипта pop:Reminder:Hint }
begin
 Result := aReminder.Hint;
end;//TkwPopReminderHint.Hint

class function TkwPopReminderHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Hint';
end;//TkwPopReminderHint.GetWordNameForRegister

function TkwPopReminderHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopReminderHint.GetResultTypeInfo

function TkwPopReminderHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderHint.GetAllParamsCount

function TkwPopReminderHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderHint.ParamsTypes

procedure TkwPopReminderHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Hint', aCtx);
end;//TkwPopReminderHint.SetValuePrim

procedure TkwPopReminderHint.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Hint(aCtx, l_aReminder));
end;//TkwPopReminderHint.DoDoIt

function TkwPopReminderPopupForm.PopupForm(const aCtx: TtfwContext;
 aReminder: TvgReminder): TvtPopupFormModelPart;
 {* Реализация слова скрипта pop:Reminder:PopupForm }
begin
 Result := aReminder.PopupForm;
end;//TkwPopReminderPopupForm.PopupForm

class function TkwPopReminderPopupForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:PopupForm';
end;//TkwPopReminderPopupForm.GetWordNameForRegister

function TkwPopReminderPopupForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPopupFormModelPart);
end;//TkwPopReminderPopupForm.GetResultTypeInfo

function TkwPopReminderPopupForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopReminderPopupForm.GetAllParamsCount

function TkwPopReminderPopupForm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderPopupForm.ParamsTypes

procedure TkwPopReminderPopupForm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PopupForm', aCtx);
end;//TkwPopReminderPopupForm.SetValuePrim

procedure TkwPopReminderPopupForm.DoDoIt(const aCtx: TtfwContext);
var l_aReminder: TvgReminder;
begin
 try
  l_aReminder := TvgReminder(aCtx.rEngine.PopObjAs(TvgReminder));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aReminder: TvgReminder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PopupForm(aCtx, l_aReminder));
end;//TkwPopReminderPopupForm.DoDoIt

initialization
 TkwPopReminderClick.RegisterInEngine;
 {* Регистрация pop_Reminder_Click }
 TkwPopReminderMove.RegisterInEngine;
 {* Регистрация pop_Reminder_Move }
 TkwPopReminderFindEditor.RegisterInEngine;
 {* Регистрация pop_Reminder_FindEditor }
 TkwPopReminderGetPopupMenu.RegisterInEngine;
 {* Регистрация pop_Reminder_GetPopupMenu }
 TkwPopReminderImageIndex.RegisterInEngine;
 {* Регистрация pop_Reminder_ImageIndex }
 TkwPopReminderUserType.RegisterInEngine;
 {* Регистрация pop_Reminder_UserType }
 TkwPopReminderIsBaloonVisible.RegisterInEngine;
 {* Регистрация pop_Reminder_IsBaloonVisible }
 TkwPopReminderVisible.RegisterInEngine;
 {* Регистрация pop_Reminder_Visible }
 TkwPopReminderName.RegisterInEngine;
 {* Регистрация pop_Reminder_Name }
 TkwPopReminderFlash.RegisterInEngine;
 {* Регистрация pop_Reminder_Flash }
 TkwPopReminderTextBackColor.RegisterInEngine;
 {* Регистрация pop_Reminder_TextBackColor }
 TkwPopReminderShowHint.RegisterInEngine;
 {* Регистрация pop_Reminder_ShowHint }
 TkwPopReminderCaption.RegisterInEngine;
 {* Регистрация pop_Reminder_Caption }
 TkwPopReminderHint.RegisterInEngine;
 {* Регистрация pop_Reminder_Hint }
 TkwPopReminderPopupForm.RegisterInEngine;
 {* Регистрация pop_Reminder_PopupForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
 {* Регистрация типа TvgReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* Регистрация типа TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPopupFormModelPart));
 {* Регистрация типа TvtPopupFormModelPart }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

end.
