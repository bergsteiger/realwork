unit ReminderWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ReminderWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vgRemindersLine
 , l3Interfaces
 , vtPopupFormModelPart
 , Classes
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , l3PopupMenuHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , RemindersLineWordsPack
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopReminderClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Click
*Пример:*
[code]
 aReminder pop:Reminder:Click
[code]  }
  private
   procedure Click(const aCtx: TtfwContext;
    aReminder: TvgReminder);
    {* Реализация слова скрипта pop:Reminder:Click }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderClick

 TkwPopReminderMove = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Move
*Пример:*
[code]
 aDelta aReminder pop:Reminder:Move
[code]  }
  private
   procedure Move(const aCtx: TtfwContext;
    aReminder: TvgReminder;
    const aDelta: TPoint);
    {* Реализация слова скрипта pop:Reminder:Move }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderMove

 TkwPopReminderFindEditor = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:FindEditor
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aReminder pop:Reminder:FindEditor >>> l_TComponent
[code]  }
  private
   function FindEditor(const aCtx: TtfwContext;
    aReminder: TvgReminder): TComponent;
    {* Реализация слова скрипта pop:Reminder:FindEditor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderFindEditor

 TkwPopReminderGetPopupMenu = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aReminder pop:Reminder:GetPopupMenu >>> l_TMenuItem
[code]  }
  private
   function GetPopupMenu(const aCtx: TtfwContext;
    aReminder: TvgReminder): TMenuItem;
    {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderGetPopupMenu

 TkwPopReminderImageIndex = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ImageIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:ImageIndex >>> l_Integer
[code]  }
  private
   function ImageIndex(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
    {* Реализация слова скрипта pop:Reminder:ImageIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderImageIndex

 TkwPopReminderUserType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:UserType >>> l_Integer
[code]  }
  private
   function UserType(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
    {* Реализация слова скрипта pop:Reminder:UserType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderUserType

 TkwPopReminderIsBaloonVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:IsBaloonVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:IsBaloonVisible >>> l_Boolean
[code]  }
  private
   function IsBaloonVisible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderIsBaloonVisible

 TkwPopReminderVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Visible >>> l_Boolean
[code]  }
  private
   function Visible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:Visible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderVisible

 TkwPopReminderName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
    {* Реализация слова скрипта pop:Reminder:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderName

 TkwPopReminderFlash = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Flash
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Flash >>> l_Boolean
[code]  }
  private
   function Flash(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:Flash }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderFlash

 TkwPopReminderTextBackColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:TextBackColor
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:TextBackColor >>> l_String
[code]  }
  private
   function TextBackColor(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
    {* Реализация слова скрипта pop:Reminder:TextBackColor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderTextBackColor

 TkwPopReminderShowHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:ShowHint >>> l_Boolean
[code]  }
  private
   function ShowHint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
    {* Реализация слова скрипта pop:Reminder:ShowHint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderShowHint

 TkwPopReminderCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Caption
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Caption >>> l_Il3CString
[code]  }
  private
   function Caption(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
    {* Реализация слова скрипта pop:Reminder:Caption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderCaption

 TkwPopReminderHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Hint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Hint >>> l_Il3CString
[code]  }
  private
   function Hint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
    {* Реализация слова скрипта pop:Reminder:Hint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderHint

 TkwPopReminderPopupForm = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:PopupForm
*Тип результата:* TvtPopupFormModelPart
*Пример:*
[code]
OBJECT VAR l_TvtPopupFormModelPart
 aReminder pop:Reminder:PopupForm >>> l_TvtPopupFormModelPart
[code]  }
  private
   function PopupForm(const aCtx: TtfwContext;
    aReminder: TvgReminder): TvtPopupFormModelPart;
    {* Реализация слова скрипта pop:Reminder:PopupForm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderPopupForm

procedure TkwPopReminderClick.Click(const aCtx: TtfwContext;
 aReminder: TvgReminder);
 {* Реализация слова скрипта pop:Reminder:Click }
//#UC START# *F2A8E1383778_1C5F9BBE1179_var*
//#UC END# *F2A8E1383778_1C5F9BBE1179_var*
begin
//#UC START# *F2A8E1383778_1C5F9BBE1179_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2A8E1383778_1C5F9BBE1179_impl*
end;//TkwPopReminderClick.Click

procedure TkwPopReminderClick.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C5F9BBE1179_var*
//#UC END# *4DAEEDE10285_1C5F9BBE1179_var*
begin
//#UC START# *4DAEEDE10285_1C5F9BBE1179_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C5F9BBE1179_impl*
end;//TkwPopReminderClick.DoDoIt

class function TkwPopReminderClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Click';
end;//TkwPopReminderClick.GetWordNameForRegister

function TkwPopReminderClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1C5F9BBE1179_var*
//#UC END# *551544E2001A_1C5F9BBE1179_var*
begin
//#UC START# *551544E2001A_1C5F9BBE1179_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1C5F9BBE1179_impl*
end;//TkwPopReminderClick.GetResultTypeInfo

function TkwPopReminderClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1C5F9BBE1179_var*
//#UC END# *559687E6025A_1C5F9BBE1179_var*
begin
//#UC START# *559687E6025A_1C5F9BBE1179_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1C5F9BBE1179_impl*
end;//TkwPopReminderClick.GetAllParamsCount

function TkwPopReminderClick.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C5F9BBE1179_var*
//#UC END# *5617F4D00243_1C5F9BBE1179_var*
begin
//#UC START# *5617F4D00243_1C5F9BBE1179_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C5F9BBE1179_impl*
end;//TkwPopReminderClick.ParamsTypes

procedure TkwPopReminderMove.Move(const aCtx: TtfwContext;
 aReminder: TvgReminder;
 const aDelta: TPoint);
 {* Реализация слова скрипта pop:Reminder:Move }
//#UC START# *2ABDE4AD9F20_0442CDEB32BC_var*
//#UC END# *2ABDE4AD9F20_0442CDEB32BC_var*
begin
//#UC START# *2ABDE4AD9F20_0442CDEB32BC_impl*
 RunnerAssert(aReminder.Owner is TvgRemindersLine, 'Не найдена линия медали', aCtx);
 (aReminder.Owner as TvgRemindersLine).OffSetLine(aDelta.X, aDelta.Y);
//#UC END# *2ABDE4AD9F20_0442CDEB32BC_impl*
end;//TkwPopReminderMove.Move

procedure TkwPopReminderMove.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0442CDEB32BC_var*
//#UC END# *4DAEEDE10285_0442CDEB32BC_var*
begin
//#UC START# *4DAEEDE10285_0442CDEB32BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0442CDEB32BC_impl*
end;//TkwPopReminderMove.DoDoIt

class function TkwPopReminderMove.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Move';
end;//TkwPopReminderMove.GetWordNameForRegister

function TkwPopReminderMove.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0442CDEB32BC_var*
//#UC END# *551544E2001A_0442CDEB32BC_var*
begin
//#UC START# *551544E2001A_0442CDEB32BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0442CDEB32BC_impl*
end;//TkwPopReminderMove.GetResultTypeInfo

function TkwPopReminderMove.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0442CDEB32BC_var*
//#UC END# *559687E6025A_0442CDEB32BC_var*
begin
//#UC START# *559687E6025A_0442CDEB32BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0442CDEB32BC_impl*
end;//TkwPopReminderMove.GetAllParamsCount

function TkwPopReminderMove.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0442CDEB32BC_var*
//#UC END# *5617F4D00243_0442CDEB32BC_var*
begin
//#UC START# *5617F4D00243_0442CDEB32BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0442CDEB32BC_impl*
end;//TkwPopReminderMove.ParamsTypes

function TkwPopReminderFindEditor.FindEditor(const aCtx: TtfwContext;
 aReminder: TvgReminder): TComponent;
 {* Реализация слова скрипта pop:Reminder:FindEditor }
//#UC START# *963C245EE80F_649B596A6C75_var*
var
 l_F : TForm;
 l_E : TComponent;
//#UC END# *963C245EE80F_649B596A6C75_var*
begin
//#UC START# *963C245EE80F_649B596A6C75_impl*
 with aReminder do
 begin
  RunnerAssert(Assigned(PopupForm) and PopupForm.Visible, 'Баллон не существует или невидим.', aCtx);
  l_F := PopupForm.Panel.Controls[0] as TForm;
  l_E := l_F.FindComponent('Viewer');
  RunnerAssert(Assigned(l_E), 'Не найден редактор в баллоне.', aCtx);
  Result := l_E;
 end;//with aReminder
//#UC END# *963C245EE80F_649B596A6C75_impl*
end;//TkwPopReminderFindEditor.FindEditor

procedure TkwPopReminderFindEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_649B596A6C75_var*
//#UC END# *4DAEEDE10285_649B596A6C75_var*
begin
//#UC START# *4DAEEDE10285_649B596A6C75_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_649B596A6C75_impl*
end;//TkwPopReminderFindEditor.DoDoIt

class function TkwPopReminderFindEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:FindEditor';
end;//TkwPopReminderFindEditor.GetWordNameForRegister

function TkwPopReminderFindEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_649B596A6C75_var*
//#UC END# *551544E2001A_649B596A6C75_var*
begin
//#UC START# *551544E2001A_649B596A6C75_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_649B596A6C75_impl*
end;//TkwPopReminderFindEditor.GetResultTypeInfo

function TkwPopReminderFindEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_649B596A6C75_var*
//#UC END# *559687E6025A_649B596A6C75_var*
begin
//#UC START# *559687E6025A_649B596A6C75_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_649B596A6C75_impl*
end;//TkwPopReminderFindEditor.GetAllParamsCount

function TkwPopReminderFindEditor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_649B596A6C75_var*
//#UC END# *5617F4D00243_649B596A6C75_var*
begin
//#UC START# *5617F4D00243_649B596A6C75_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_649B596A6C75_impl*
end;//TkwPopReminderFindEditor.ParamsTypes

function TkwPopReminderGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
 aReminder: TvgReminder): TMenuItem;
 {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
//#UC START# *BC5BE2E8AB9C_C1FAEFF176B2_var*
var
 l_Pt: TPoint;
//#UC END# *BC5BE2E8AB9C_C1FAEFF176B2_var*
begin
//#UC START# *BC5BE2E8AB9C_C1FAEFF176B2_impl*
 l_Pt.X := 0;
 l_Pt.Y := 0;
 Result := Tl3PopupMenuHelper.Instance.GetPopupMenu(aReminder, l_Pt);
//#UC END# *BC5BE2E8AB9C_C1FAEFF176B2_impl*
end;//TkwPopReminderGetPopupMenu.GetPopupMenu

procedure TkwPopReminderGetPopupMenu.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C1FAEFF176B2_var*
//#UC END# *4DAEEDE10285_C1FAEFF176B2_var*
begin
//#UC START# *4DAEEDE10285_C1FAEFF176B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C1FAEFF176B2_impl*
end;//TkwPopReminderGetPopupMenu.DoDoIt

class function TkwPopReminderGetPopupMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:GetPopupMenu';
end;//TkwPopReminderGetPopupMenu.GetWordNameForRegister

function TkwPopReminderGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C1FAEFF176B2_var*
//#UC END# *551544E2001A_C1FAEFF176B2_var*
begin
//#UC START# *551544E2001A_C1FAEFF176B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C1FAEFF176B2_impl*
end;//TkwPopReminderGetPopupMenu.GetResultTypeInfo

function TkwPopReminderGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C1FAEFF176B2_var*
//#UC END# *559687E6025A_C1FAEFF176B2_var*
begin
//#UC START# *559687E6025A_C1FAEFF176B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C1FAEFF176B2_impl*
end;//TkwPopReminderGetPopupMenu.GetAllParamsCount

function TkwPopReminderGetPopupMenu.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C1FAEFF176B2_var*
//#UC END# *5617F4D00243_C1FAEFF176B2_var*
begin
//#UC START# *5617F4D00243_C1FAEFF176B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C1FAEFF176B2_impl*
end;//TkwPopReminderGetPopupMenu.ParamsTypes

function TkwPopReminderImageIndex.ImageIndex(const aCtx: TtfwContext;
 aReminder: TvgReminder): Integer;
 {* Реализация слова скрипта pop:Reminder:ImageIndex }
//#UC START# *5CFFEF151E73_A580AA2892B6_var*
//#UC END# *5CFFEF151E73_A580AA2892B6_var*
begin
//#UC START# *5CFFEF151E73_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5CFFEF151E73_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.ImageIndex

procedure TkwPopReminderImageIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A580AA2892B6_var*
//#UC END# *4DAEEDE10285_A580AA2892B6_var*
begin
//#UC START# *4DAEEDE10285_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.DoDoIt

class function TkwPopReminderImageIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:ImageIndex';
end;//TkwPopReminderImageIndex.GetWordNameForRegister

procedure TkwPopReminderImageIndex.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A580AA2892B6_var*
//#UC END# *52D00B00031A_A580AA2892B6_var*
begin
//#UC START# *52D00B00031A_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.SetValuePrim

function TkwPopReminderImageIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A580AA2892B6_var*
//#UC END# *551544E2001A_A580AA2892B6_var*
begin
//#UC START# *551544E2001A_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.GetResultTypeInfo

function TkwPopReminderImageIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A580AA2892B6_var*
//#UC END# *559687E6025A_A580AA2892B6_var*
begin
//#UC START# *559687E6025A_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.GetAllParamsCount

function TkwPopReminderImageIndex.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A580AA2892B6_var*
//#UC END# *5617F4D00243_A580AA2892B6_var*
begin
//#UC START# *5617F4D00243_A580AA2892B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A580AA2892B6_impl*
end;//TkwPopReminderImageIndex.ParamsTypes

function TkwPopReminderUserType.UserType(const aCtx: TtfwContext;
 aReminder: TvgReminder): Integer;
 {* Реализация слова скрипта pop:Reminder:UserType }
//#UC START# *2AADE74ECABD_03823097F08B_var*
//#UC END# *2AADE74ECABD_03823097F08B_var*
begin
//#UC START# *2AADE74ECABD_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *2AADE74ECABD_03823097F08B_impl*
end;//TkwPopReminderUserType.UserType

procedure TkwPopReminderUserType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_03823097F08B_var*
//#UC END# *4DAEEDE10285_03823097F08B_var*
begin
//#UC START# *4DAEEDE10285_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_03823097F08B_impl*
end;//TkwPopReminderUserType.DoDoIt

class function TkwPopReminderUserType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:UserType';
end;//TkwPopReminderUserType.GetWordNameForRegister

procedure TkwPopReminderUserType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_03823097F08B_var*
//#UC END# *52D00B00031A_03823097F08B_var*
begin
//#UC START# *52D00B00031A_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_03823097F08B_impl*
end;//TkwPopReminderUserType.SetValuePrim

function TkwPopReminderUserType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_03823097F08B_var*
//#UC END# *551544E2001A_03823097F08B_var*
begin
//#UC START# *551544E2001A_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_03823097F08B_impl*
end;//TkwPopReminderUserType.GetResultTypeInfo

function TkwPopReminderUserType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_03823097F08B_var*
//#UC END# *559687E6025A_03823097F08B_var*
begin
//#UC START# *559687E6025A_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_03823097F08B_impl*
end;//TkwPopReminderUserType.GetAllParamsCount

function TkwPopReminderUserType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_03823097F08B_var*
//#UC END# *5617F4D00243_03823097F08B_var*
begin
//#UC START# *5617F4D00243_03823097F08B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_03823097F08B_impl*
end;//TkwPopReminderUserType.ParamsTypes

function TkwPopReminderIsBaloonVisible.IsBaloonVisible(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
//#UC START# *17481393F146_B5B73476616C_var*
//#UC END# *17481393F146_B5B73476616C_var*
begin
//#UC START# *17481393F146_B5B73476616C_impl*
 Result := ((aReminder.PopupForm <> nil) and aReminder.PopupForm.Visible);
//#UC END# *17481393F146_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.IsBaloonVisible

procedure TkwPopReminderIsBaloonVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B5B73476616C_var*
//#UC END# *4DAEEDE10285_B5B73476616C_var*
begin
//#UC START# *4DAEEDE10285_B5B73476616C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.DoDoIt

class function TkwPopReminderIsBaloonVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:IsBaloonVisible';
end;//TkwPopReminderIsBaloonVisible.GetWordNameForRegister

procedure TkwPopReminderIsBaloonVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B5B73476616C_var*
//#UC END# *52D00B00031A_B5B73476616C_var*
begin
//#UC START# *52D00B00031A_B5B73476616C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.SetValuePrim

function TkwPopReminderIsBaloonVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B5B73476616C_var*
//#UC END# *551544E2001A_B5B73476616C_var*
begin
//#UC START# *551544E2001A_B5B73476616C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.GetResultTypeInfo

function TkwPopReminderIsBaloonVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B5B73476616C_var*
//#UC END# *559687E6025A_B5B73476616C_var*
begin
//#UC START# *559687E6025A_B5B73476616C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.GetAllParamsCount

function TkwPopReminderIsBaloonVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B5B73476616C_var*
//#UC END# *5617F4D00243_B5B73476616C_var*
begin
//#UC START# *5617F4D00243_B5B73476616C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.ParamsTypes

function TkwPopReminderVisible.Visible(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:Visible }
//#UC START# *51D228A026B4_86556B367D77_var*
//#UC END# *51D228A026B4_86556B367D77_var*
begin
//#UC START# *51D228A026B4_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D228A026B4_86556B367D77_impl*
end;//TkwPopReminderVisible.Visible

procedure TkwPopReminderVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86556B367D77_var*
//#UC END# *4DAEEDE10285_86556B367D77_var*
begin
//#UC START# *4DAEEDE10285_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86556B367D77_impl*
end;//TkwPopReminderVisible.DoDoIt

class function TkwPopReminderVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Visible';
end;//TkwPopReminderVisible.GetWordNameForRegister

procedure TkwPopReminderVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_86556B367D77_var*
//#UC END# *52D00B00031A_86556B367D77_var*
begin
//#UC START# *52D00B00031A_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_86556B367D77_impl*
end;//TkwPopReminderVisible.SetValuePrim

function TkwPopReminderVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_86556B367D77_var*
//#UC END# *551544E2001A_86556B367D77_var*
begin
//#UC START# *551544E2001A_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_86556B367D77_impl*
end;//TkwPopReminderVisible.GetResultTypeInfo

function TkwPopReminderVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_86556B367D77_var*
//#UC END# *559687E6025A_86556B367D77_var*
begin
//#UC START# *559687E6025A_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_86556B367D77_impl*
end;//TkwPopReminderVisible.GetAllParamsCount

function TkwPopReminderVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_86556B367D77_var*
//#UC END# *5617F4D00243_86556B367D77_var*
begin
//#UC START# *5617F4D00243_86556B367D77_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_86556B367D77_impl*
end;//TkwPopReminderVisible.ParamsTypes

function TkwPopReminderName.Name(const aCtx: TtfwContext;
 aReminder: TvgReminder): AnsiString;
 {* Реализация слова скрипта pop:Reminder:Name }
//#UC START# *EEDF43F40E05_53BA7E6BD35A_var*
//#UC END# *EEDF43F40E05_53BA7E6BD35A_var*
begin
//#UC START# *EEDF43F40E05_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEDF43F40E05_53BA7E6BD35A_impl*
end;//TkwPopReminderName.Name

procedure TkwPopReminderName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53BA7E6BD35A_var*
//#UC END# *4DAEEDE10285_53BA7E6BD35A_var*
begin
//#UC START# *4DAEEDE10285_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_53BA7E6BD35A_impl*
end;//TkwPopReminderName.DoDoIt

class function TkwPopReminderName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Name';
end;//TkwPopReminderName.GetWordNameForRegister

procedure TkwPopReminderName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_53BA7E6BD35A_var*
//#UC END# *52D00B00031A_53BA7E6BD35A_var*
begin
//#UC START# *52D00B00031A_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_53BA7E6BD35A_impl*
end;//TkwPopReminderName.SetValuePrim

function TkwPopReminderName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_53BA7E6BD35A_var*
//#UC END# *551544E2001A_53BA7E6BD35A_var*
begin
//#UC START# *551544E2001A_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_53BA7E6BD35A_impl*
end;//TkwPopReminderName.GetResultTypeInfo

function TkwPopReminderName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_53BA7E6BD35A_var*
//#UC END# *559687E6025A_53BA7E6BD35A_var*
begin
//#UC START# *559687E6025A_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_53BA7E6BD35A_impl*
end;//TkwPopReminderName.GetAllParamsCount

function TkwPopReminderName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_53BA7E6BD35A_var*
//#UC END# *5617F4D00243_53BA7E6BD35A_var*
begin
//#UC START# *5617F4D00243_53BA7E6BD35A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_53BA7E6BD35A_impl*
end;//TkwPopReminderName.ParamsTypes

function TkwPopReminderFlash.Flash(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:Flash }
//#UC START# *5223957A2E07_41F02D480F88_var*
//#UC END# *5223957A2E07_41F02D480F88_var*
begin
//#UC START# *5223957A2E07_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *5223957A2E07_41F02D480F88_impl*
end;//TkwPopReminderFlash.Flash

procedure TkwPopReminderFlash.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_41F02D480F88_var*
//#UC END# *4DAEEDE10285_41F02D480F88_var*
begin
//#UC START# *4DAEEDE10285_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_41F02D480F88_impl*
end;//TkwPopReminderFlash.DoDoIt

class function TkwPopReminderFlash.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Flash';
end;//TkwPopReminderFlash.GetWordNameForRegister

procedure TkwPopReminderFlash.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_41F02D480F88_var*
//#UC END# *52D00B00031A_41F02D480F88_var*
begin
//#UC START# *52D00B00031A_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_41F02D480F88_impl*
end;//TkwPopReminderFlash.SetValuePrim

function TkwPopReminderFlash.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_41F02D480F88_var*
//#UC END# *551544E2001A_41F02D480F88_var*
begin
//#UC START# *551544E2001A_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_41F02D480F88_impl*
end;//TkwPopReminderFlash.GetResultTypeInfo

function TkwPopReminderFlash.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_41F02D480F88_var*
//#UC END# *559687E6025A_41F02D480F88_var*
begin
//#UC START# *559687E6025A_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_41F02D480F88_impl*
end;//TkwPopReminderFlash.GetAllParamsCount

function TkwPopReminderFlash.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_41F02D480F88_var*
//#UC END# *5617F4D00243_41F02D480F88_var*
begin
//#UC START# *5617F4D00243_41F02D480F88_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_41F02D480F88_impl*
end;//TkwPopReminderFlash.ParamsTypes

function TkwPopReminderTextBackColor.TextBackColor(const aCtx: TtfwContext;
 aReminder: TvgReminder): AnsiString;
 {* Реализация слова скрипта pop:Reminder:TextBackColor }
//#UC START# *C4047A8567A8_4910B3AB2F0F_var*
//#UC END# *C4047A8567A8_4910B3AB2F0F_var*
begin
//#UC START# *C4047A8567A8_4910B3AB2F0F_impl*
 Result := aReminder.vgTextRect.Fill.Color;
//#UC END# *C4047A8567A8_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.TextBackColor

procedure TkwPopReminderTextBackColor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4910B3AB2F0F_var*
//#UC END# *4DAEEDE10285_4910B3AB2F0F_var*
begin
//#UC START# *4DAEEDE10285_4910B3AB2F0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.DoDoIt

class function TkwPopReminderTextBackColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:TextBackColor';
end;//TkwPopReminderTextBackColor.GetWordNameForRegister

procedure TkwPopReminderTextBackColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4910B3AB2F0F_var*
//#UC END# *52D00B00031A_4910B3AB2F0F_var*
begin
//#UC START# *52D00B00031A_4910B3AB2F0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.SetValuePrim

function TkwPopReminderTextBackColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4910B3AB2F0F_var*
//#UC END# *551544E2001A_4910B3AB2F0F_var*
begin
//#UC START# *551544E2001A_4910B3AB2F0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.GetResultTypeInfo

function TkwPopReminderTextBackColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4910B3AB2F0F_var*
//#UC END# *559687E6025A_4910B3AB2F0F_var*
begin
//#UC START# *559687E6025A_4910B3AB2F0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.GetAllParamsCount

function TkwPopReminderTextBackColor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4910B3AB2F0F_var*
//#UC END# *5617F4D00243_4910B3AB2F0F_var*
begin
//#UC START# *5617F4D00243_4910B3AB2F0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.ParamsTypes

function TkwPopReminderShowHint.ShowHint(const aCtx: TtfwContext;
 aReminder: TvgReminder): Boolean;
 {* Реализация слова скрипта pop:Reminder:ShowHint }
//#UC START# *5FAB78F3A8B1_01DFD9EDE9C7_var*
//#UC END# *5FAB78F3A8B1_01DFD9EDE9C7_var*
begin
//#UC START# *5FAB78F3A8B1_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5FAB78F3A8B1_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.ShowHint

procedure TkwPopReminderShowHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_01DFD9EDE9C7_var*
//#UC END# *4DAEEDE10285_01DFD9EDE9C7_var*
begin
//#UC START# *4DAEEDE10285_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.DoDoIt

class function TkwPopReminderShowHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:ShowHint';
end;//TkwPopReminderShowHint.GetWordNameForRegister

procedure TkwPopReminderShowHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_01DFD9EDE9C7_var*
//#UC END# *52D00B00031A_01DFD9EDE9C7_var*
begin
//#UC START# *52D00B00031A_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.SetValuePrim

function TkwPopReminderShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_01DFD9EDE9C7_var*
//#UC END# *551544E2001A_01DFD9EDE9C7_var*
begin
//#UC START# *551544E2001A_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.GetResultTypeInfo

function TkwPopReminderShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_01DFD9EDE9C7_var*
//#UC END# *559687E6025A_01DFD9EDE9C7_var*
begin
//#UC START# *559687E6025A_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.GetAllParamsCount

function TkwPopReminderShowHint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_01DFD9EDE9C7_var*
//#UC END# *5617F4D00243_01DFD9EDE9C7_var*
begin
//#UC START# *5617F4D00243_01DFD9EDE9C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_01DFD9EDE9C7_impl*
end;//TkwPopReminderShowHint.ParamsTypes

function TkwPopReminderCaption.Caption(const aCtx: TtfwContext;
 aReminder: TvgReminder): Il3CString;
 {* Реализация слова скрипта pop:Reminder:Caption }
//#UC START# *87E221BFC87E_D817B4A59BC2_var*
//#UC END# *87E221BFC87E_D817B4A59BC2_var*
begin
//#UC START# *87E221BFC87E_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *87E221BFC87E_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.Caption

procedure TkwPopReminderCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D817B4A59BC2_var*
//#UC END# *4DAEEDE10285_D817B4A59BC2_var*
begin
//#UC START# *4DAEEDE10285_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.DoDoIt

class function TkwPopReminderCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Caption';
end;//TkwPopReminderCaption.GetWordNameForRegister

procedure TkwPopReminderCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D817B4A59BC2_var*
//#UC END# *52D00B00031A_D817B4A59BC2_var*
begin
//#UC START# *52D00B00031A_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.SetValuePrim

function TkwPopReminderCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D817B4A59BC2_var*
//#UC END# *551544E2001A_D817B4A59BC2_var*
begin
//#UC START# *551544E2001A_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.GetResultTypeInfo

function TkwPopReminderCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D817B4A59BC2_var*
//#UC END# *559687E6025A_D817B4A59BC2_var*
begin
//#UC START# *559687E6025A_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.GetAllParamsCount

function TkwPopReminderCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D817B4A59BC2_var*
//#UC END# *5617F4D00243_D817B4A59BC2_var*
begin
//#UC START# *5617F4D00243_D817B4A59BC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D817B4A59BC2_impl*
end;//TkwPopReminderCaption.ParamsTypes

function TkwPopReminderHint.Hint(const aCtx: TtfwContext;
 aReminder: TvgReminder): Il3CString;
 {* Реализация слова скрипта pop:Reminder:Hint }
//#UC START# *34D2B1DAA1D5_3D456BE889E3_var*
//#UC END# *34D2B1DAA1D5_3D456BE889E3_var*
begin
//#UC START# *34D2B1DAA1D5_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *34D2B1DAA1D5_3D456BE889E3_impl*
end;//TkwPopReminderHint.Hint

procedure TkwPopReminderHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3D456BE889E3_var*
//#UC END# *4DAEEDE10285_3D456BE889E3_var*
begin
//#UC START# *4DAEEDE10285_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3D456BE889E3_impl*
end;//TkwPopReminderHint.DoDoIt

class function TkwPopReminderHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:Hint';
end;//TkwPopReminderHint.GetWordNameForRegister

procedure TkwPopReminderHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3D456BE889E3_var*
//#UC END# *52D00B00031A_3D456BE889E3_var*
begin
//#UC START# *52D00B00031A_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3D456BE889E3_impl*
end;//TkwPopReminderHint.SetValuePrim

function TkwPopReminderHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3D456BE889E3_var*
//#UC END# *551544E2001A_3D456BE889E3_var*
begin
//#UC START# *551544E2001A_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3D456BE889E3_impl*
end;//TkwPopReminderHint.GetResultTypeInfo

function TkwPopReminderHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3D456BE889E3_var*
//#UC END# *559687E6025A_3D456BE889E3_var*
begin
//#UC START# *559687E6025A_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3D456BE889E3_impl*
end;//TkwPopReminderHint.GetAllParamsCount

function TkwPopReminderHint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3D456BE889E3_var*
//#UC END# *5617F4D00243_3D456BE889E3_var*
begin
//#UC START# *5617F4D00243_3D456BE889E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3D456BE889E3_impl*
end;//TkwPopReminderHint.ParamsTypes

function TkwPopReminderPopupForm.PopupForm(const aCtx: TtfwContext;
 aReminder: TvgReminder): TvtPopupFormModelPart;
 {* Реализация слова скрипта pop:Reminder:PopupForm }
//#UC START# *59E14B85260B_27F1AE8E8012_var*
//#UC END# *59E14B85260B_27F1AE8E8012_var*
begin
//#UC START# *59E14B85260B_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *59E14B85260B_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.PopupForm

procedure TkwPopReminderPopupForm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_27F1AE8E8012_var*
//#UC END# *4DAEEDE10285_27F1AE8E8012_var*
begin
//#UC START# *4DAEEDE10285_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.DoDoIt

class function TkwPopReminderPopupForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Reminder:PopupForm';
end;//TkwPopReminderPopupForm.GetWordNameForRegister

procedure TkwPopReminderPopupForm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_27F1AE8E8012_var*
//#UC END# *52D00B00031A_27F1AE8E8012_var*
begin
//#UC START# *52D00B00031A_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.SetValuePrim

function TkwPopReminderPopupForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_27F1AE8E8012_var*
//#UC END# *551544E2001A_27F1AE8E8012_var*
begin
//#UC START# *551544E2001A_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.GetResultTypeInfo

function TkwPopReminderPopupForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_27F1AE8E8012_var*
//#UC END# *559687E6025A_27F1AE8E8012_var*
begin
//#UC START# *559687E6025A_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.GetAllParamsCount

function TkwPopReminderPopupForm.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_27F1AE8E8012_var*
//#UC END# *5617F4D00243_27F1AE8E8012_var*
begin
//#UC START# *5617F4D00243_27F1AE8E8012_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_27F1AE8E8012_impl*
end;//TkwPopReminderPopupForm.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
 {* Регистрация типа TvgReminder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* Регистрация типа TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPopupFormModelPart));
 {* Регистрация типа TvtPopupFormModelPart }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

end.
