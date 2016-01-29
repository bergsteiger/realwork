unit ReminderWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "ReminderWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::ReminderWords::ReminderWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Interfaces,
  Types,
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  vtPopupFormModelPart,
  tfwScriptingInterfaces,
  vgRemindersLine,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  l3PopupMenuHelper
  {$IfEnd} //not NoVCL
  ,
  RemindersLineWordsPack
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  tfwScriptingTypes,
  TypInfo,
  tfwTypeRegistrator
  ;

type
 TkwPopReminderClick = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Click
*Пример:*
[code]
 aReminder pop:Reminder:Click
[code]  }
 private
 // private methods
   procedure Click(const aCtx: TtfwContext;
    aReminder: TvgReminder);
     {* Реализация слова скрипта pop:Reminder:Click }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderClick

// start class TkwPopReminderClick

procedure TkwPopReminderClick.Click(const aCtx: TtfwContext;
  aReminder: TvgReminder);
 {-}
begin
 aReminder.Click;
end;//TkwPopReminderClick.Click

procedure TkwPopReminderClick.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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

class function TkwPopReminderClick.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Click';
end;//TkwPopReminderClick.GetWordNameForRegister

function TkwPopReminderClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopReminderClick.GetResultTypeInfo

function TkwPopReminderClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderClick.GetAllParamsCount

function TkwPopReminderClick.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderClick.ParamsTypes

type
 TkwPopReminderMove = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:Move
*Пример:*
[code]
 aDelta aReminder pop:Reminder:Move
[code]  }
 private
 // private methods
   procedure Move(const aCtx: TtfwContext;
    aReminder: TvgReminder;
    const aDelta: TPoint);
     {* Реализация слова скрипта pop:Reminder:Move }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderMove

// start class TkwPopReminderMove

procedure TkwPopReminderMove.Move(const aCtx: TtfwContext;
  aReminder: TvgReminder;
  const aDelta: TPoint);
//#UC START# *2ABDE4AD9F20_0442CDEB32BC_var*
//#UC END# *2ABDE4AD9F20_0442CDEB32BC_var*
begin
//#UC START# *2ABDE4AD9F20_0442CDEB32BC_impl*
 RunnerAssert(aReminder.Owner is TvgRemindersLine, 'Не найдена линия медали', aCtx);
 (aReminder.Owner as TvgRemindersLine).OffSetLine(aDelta.X, aDelta.Y);
//#UC END# *2ABDE4AD9F20_0442CDEB32BC_impl*
end;//TkwPopReminderMove.Move

procedure TkwPopReminderMove.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
 l_aDelta : TPoint;
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

class function TkwPopReminderMove.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Move';
end;//TkwPopReminderMove.GetWordNameForRegister

function TkwPopReminderMove.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopReminderMove.GetResultTypeInfo

function TkwPopReminderMove.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopReminderMove.GetAllParamsCount

function TkwPopReminderMove.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder), @tfw_tiStruct]);
end;//TkwPopReminderMove.ParamsTypes

type
 TkwPopReminderFindEditor = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:FindEditor
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aReminder pop:Reminder:FindEditor >>> l_TComponent
[code]  }
 private
 // private methods
   function FindEditor(const aCtx: TtfwContext;
    aReminder: TvgReminder): TComponent;
     {* Реализация слова скрипта pop:Reminder:FindEditor }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderFindEditor

// start class TkwPopReminderFindEditor

function TkwPopReminderFindEditor.FindEditor(const aCtx: TtfwContext;
  aReminder: TvgReminder): TComponent;
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
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushObj((FindEditor(aCtx, l_aReminder)));
end;//TkwPopReminderFindEditor.DoDoIt

class function TkwPopReminderFindEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:FindEditor';
end;//TkwPopReminderFindEditor.GetWordNameForRegister

function TkwPopReminderFindEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TComponent);
end;//TkwPopReminderFindEditor.GetResultTypeInfo

function TkwPopReminderFindEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderFindEditor.GetAllParamsCount

function TkwPopReminderFindEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderFindEditor.ParamsTypes

type
 TkwPopReminderGetPopupMenu = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Reminder:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aReminder pop:Reminder:GetPopupMenu >>> l_TMenuItem
[code]  }
 private
 // private methods
   function GetPopupMenu(const aCtx: TtfwContext;
    aReminder: TvgReminder): TMenuItem;
     {* Реализация слова скрипта pop:Reminder:GetPopupMenu }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderGetPopupMenu

// start class TkwPopReminderGetPopupMenu

function TkwPopReminderGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
  aReminder: TvgReminder): TMenuItem;
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
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushObj((GetPopupMenu(aCtx, l_aReminder)));
end;//TkwPopReminderGetPopupMenu.DoDoIt

class function TkwPopReminderGetPopupMenu.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:GetPopupMenu';
end;//TkwPopReminderGetPopupMenu.GetWordNameForRegister

function TkwPopReminderGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopReminderGetPopupMenu.GetResultTypeInfo

function TkwPopReminderGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderGetPopupMenu.GetAllParamsCount

function TkwPopReminderGetPopupMenu.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderGetPopupMenu.ParamsTypes

type
 TkwPopReminderImageIndex = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ImageIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:ImageIndex >>> l_Integer
[code]  }
 private
 // private methods
   function ImageIndex(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
     {* Реализация слова скрипта pop:Reminder:ImageIndex }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderImageIndex

// start class TkwPopReminderImageIndex

function TkwPopReminderImageIndex.ImageIndex(const aCtx: TtfwContext;
  aReminder: TvgReminder): Integer;
 {-}
begin
 Result := aReminder.ImageIndex;
end;//TkwPopReminderImageIndex.ImageIndex

procedure TkwPopReminderImageIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushInt((ImageIndex(aCtx, l_aReminder)));
end;//TkwPopReminderImageIndex.DoDoIt

class function TkwPopReminderImageIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:ImageIndex';
end;//TkwPopReminderImageIndex.GetWordNameForRegister

procedure TkwPopReminderImageIndex.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ImageIndex', aCtx);
end;//TkwPopReminderImageIndex.SetValuePrim

function TkwPopReminderImageIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopReminderImageIndex.GetResultTypeInfo

function TkwPopReminderImageIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderImageIndex.GetAllParamsCount

function TkwPopReminderImageIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderImageIndex.ParamsTypes

type
 TkwPopReminderUserType = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aReminder pop:Reminder:UserType >>> l_Integer
[code]  }
 private
 // private methods
   function UserType(const aCtx: TtfwContext;
    aReminder: TvgReminder): Integer;
     {* Реализация слова скрипта pop:Reminder:UserType }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderUserType

// start class TkwPopReminderUserType

function TkwPopReminderUserType.UserType(const aCtx: TtfwContext;
  aReminder: TvgReminder): Integer;
 {-}
begin
 Result := aReminder.UserType;
end;//TkwPopReminderUserType.UserType

procedure TkwPopReminderUserType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushInt((UserType(aCtx, l_aReminder)));
end;//TkwPopReminderUserType.DoDoIt

class function TkwPopReminderUserType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:UserType';
end;//TkwPopReminderUserType.GetWordNameForRegister

procedure TkwPopReminderUserType.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserType', aCtx);
end;//TkwPopReminderUserType.SetValuePrim

function TkwPopReminderUserType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopReminderUserType.GetResultTypeInfo

function TkwPopReminderUserType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderUserType.GetAllParamsCount

function TkwPopReminderUserType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderUserType.ParamsTypes

type
 TkwPopReminderIsBaloonVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:IsBaloonVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:IsBaloonVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function IsBaloonVisible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
     {* Реализация слова скрипта pop:Reminder:IsBaloonVisible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderIsBaloonVisible

// start class TkwPopReminderIsBaloonVisible

function TkwPopReminderIsBaloonVisible.IsBaloonVisible(const aCtx: TtfwContext;
  aReminder: TvgReminder): Boolean;
//#UC START# *17481393F146_B5B73476616C_var*
//#UC END# *17481393F146_B5B73476616C_var*
begin
//#UC START# *17481393F146_B5B73476616C_impl*
 Result := ((aReminder.PopupForm <> nil) and aReminder.PopupForm.Visible);
//#UC END# *17481393F146_B5B73476616C_impl*
end;//TkwPopReminderIsBaloonVisible.IsBaloonVisible

procedure TkwPopReminderIsBaloonVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushBool((IsBaloonVisible(aCtx, l_aReminder)));
end;//TkwPopReminderIsBaloonVisible.DoDoIt

class function TkwPopReminderIsBaloonVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:IsBaloonVisible';
end;//TkwPopReminderIsBaloonVisible.GetWordNameForRegister

procedure TkwPopReminderIsBaloonVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsBaloonVisible', aCtx);
end;//TkwPopReminderIsBaloonVisible.SetValuePrim

function TkwPopReminderIsBaloonVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderIsBaloonVisible.GetResultTypeInfo

function TkwPopReminderIsBaloonVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderIsBaloonVisible.GetAllParamsCount

function TkwPopReminderIsBaloonVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderIsBaloonVisible.ParamsTypes

type
 TkwPopReminderVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Visible >>> l_Boolean
[code]  }
 private
 // private methods
   function Visible(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
     {* Реализация слова скрипта pop:Reminder:Visible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderVisible

// start class TkwPopReminderVisible

function TkwPopReminderVisible.Visible(const aCtx: TtfwContext;
  aReminder: TvgReminder): Boolean;
 {-}
begin
 Result := aReminder.Visible;
end;//TkwPopReminderVisible.Visible

procedure TkwPopReminderVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushBool((Visible(aCtx, l_aReminder)));
end;//TkwPopReminderVisible.DoDoIt

class function TkwPopReminderVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Visible';
end;//TkwPopReminderVisible.GetWordNameForRegister

procedure TkwPopReminderVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopReminderVisible.SetValuePrim

function TkwPopReminderVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderVisible.GetResultTypeInfo

function TkwPopReminderVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderVisible.GetAllParamsCount

function TkwPopReminderVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderVisible.ParamsTypes

type
 TkwPopReminderName = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:Name >>> l_String
[code]  }
 private
 // private methods
   function Name(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
     {* Реализация слова скрипта pop:Reminder:Name }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderName

// start class TkwPopReminderName

function TkwPopReminderName.Name(const aCtx: TtfwContext;
  aReminder: TvgReminder): AnsiString;
 {-}
begin
 Result := aReminder.Name;
end;//TkwPopReminderName.Name

procedure TkwPopReminderName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushString((Name(aCtx, l_aReminder)));
end;//TkwPopReminderName.DoDoIt

class function TkwPopReminderName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Name';
end;//TkwPopReminderName.GetWordNameForRegister

procedure TkwPopReminderName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopReminderName.SetValuePrim

function TkwPopReminderName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopReminderName.GetResultTypeInfo

function TkwPopReminderName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderName.GetAllParamsCount

function TkwPopReminderName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderName.ParamsTypes

type
 TkwPopReminderFlash = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Flash
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:Flash >>> l_Boolean
[code]  }
 private
 // private methods
   function Flash(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
     {* Реализация слова скрипта pop:Reminder:Flash }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderFlash

// start class TkwPopReminderFlash

function TkwPopReminderFlash.Flash(const aCtx: TtfwContext;
  aReminder: TvgReminder): Boolean;
 {-}
begin
 Result := aReminder.Flash;
end;//TkwPopReminderFlash.Flash

procedure TkwPopReminderFlash.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushBool((Flash(aCtx, l_aReminder)));
end;//TkwPopReminderFlash.DoDoIt

class function TkwPopReminderFlash.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Flash';
end;//TkwPopReminderFlash.GetWordNameForRegister

procedure TkwPopReminderFlash.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Flash', aCtx);
end;//TkwPopReminderFlash.SetValuePrim

function TkwPopReminderFlash.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderFlash.GetResultTypeInfo

function TkwPopReminderFlash.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderFlash.GetAllParamsCount

function TkwPopReminderFlash.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderFlash.ParamsTypes

type
 TkwPopReminderTextBackColor = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:TextBackColor
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aReminder pop:Reminder:TextBackColor >>> l_String
[code]  }
 private
 // private methods
   function TextBackColor(const aCtx: TtfwContext;
    aReminder: TvgReminder): AnsiString;
     {* Реализация слова скрипта pop:Reminder:TextBackColor }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderTextBackColor

// start class TkwPopReminderTextBackColor

function TkwPopReminderTextBackColor.TextBackColor(const aCtx: TtfwContext;
  aReminder: TvgReminder): AnsiString;
//#UC START# *C4047A8567A8_4910B3AB2F0F_var*
//#UC END# *C4047A8567A8_4910B3AB2F0F_var*
begin
//#UC START# *C4047A8567A8_4910B3AB2F0F_impl*
 Result := aReminder.vgTextRect.Fill.Color;
//#UC END# *C4047A8567A8_4910B3AB2F0F_impl*
end;//TkwPopReminderTextBackColor.TextBackColor

procedure TkwPopReminderTextBackColor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushString((TextBackColor(aCtx, l_aReminder)));
end;//TkwPopReminderTextBackColor.DoDoIt

class function TkwPopReminderTextBackColor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:TextBackColor';
end;//TkwPopReminderTextBackColor.GetWordNameForRegister

procedure TkwPopReminderTextBackColor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TextBackColor', aCtx);
end;//TkwPopReminderTextBackColor.SetValuePrim

function TkwPopReminderTextBackColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopReminderTextBackColor.GetResultTypeInfo

function TkwPopReminderTextBackColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderTextBackColor.GetAllParamsCount

function TkwPopReminderTextBackColor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderTextBackColor.ParamsTypes

type
 TkwPopReminderShowHint = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aReminder pop:Reminder:ShowHint >>> l_Boolean
[code]  }
 private
 // private methods
   function ShowHint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Boolean;
     {* Реализация слова скрипта pop:Reminder:ShowHint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderShowHint

// start class TkwPopReminderShowHint

function TkwPopReminderShowHint.ShowHint(const aCtx: TtfwContext;
  aReminder: TvgReminder): Boolean;
 {-}
begin
 Result := aReminder.ShowHint;
end;//TkwPopReminderShowHint.ShowHint

procedure TkwPopReminderShowHint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushBool((ShowHint(aCtx, l_aReminder)));
end;//TkwPopReminderShowHint.DoDoIt

class function TkwPopReminderShowHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:ShowHint';
end;//TkwPopReminderShowHint.GetWordNameForRegister

procedure TkwPopReminderShowHint.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowHint', aCtx);
end;//TkwPopReminderShowHint.SetValuePrim

function TkwPopReminderShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopReminderShowHint.GetResultTypeInfo

function TkwPopReminderShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderShowHint.GetAllParamsCount

function TkwPopReminderShowHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderShowHint.ParamsTypes

type
 TkwPopReminderCaption = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Caption
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Caption >>> l_Il3CString
[code]  }
 private
 // private methods
   function Caption(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
     {* Реализация слова скрипта pop:Reminder:Caption }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderCaption

// start class TkwPopReminderCaption

function TkwPopReminderCaption.Caption(const aCtx: TtfwContext;
  aReminder: TvgReminder): Il3CString;
 {-}
begin
 Result := aReminder.Caption;
end;//TkwPopReminderCaption.Caption

procedure TkwPopReminderCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushString((Caption(aCtx, l_aReminder)));
end;//TkwPopReminderCaption.DoDoIt

class function TkwPopReminderCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Caption';
end;//TkwPopReminderCaption.GetWordNameForRegister

procedure TkwPopReminderCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwPopReminderCaption.SetValuePrim

function TkwPopReminderCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopReminderCaption.GetResultTypeInfo

function TkwPopReminderCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderCaption.GetAllParamsCount

function TkwPopReminderCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderCaption.ParamsTypes

type
 TkwPopReminderHint = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:Hint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aReminder pop:Reminder:Hint >>> l_Il3CString
[code]  }
 private
 // private methods
   function Hint(const aCtx: TtfwContext;
    aReminder: TvgReminder): Il3CString;
     {* Реализация слова скрипта pop:Reminder:Hint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderHint

// start class TkwPopReminderHint

function TkwPopReminderHint.Hint(const aCtx: TtfwContext;
  aReminder: TvgReminder): Il3CString;
 {-}
begin
 Result := aReminder.Hint;
end;//TkwPopReminderHint.Hint

procedure TkwPopReminderHint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushString((Hint(aCtx, l_aReminder)));
end;//TkwPopReminderHint.DoDoIt

class function TkwPopReminderHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:Hint';
end;//TkwPopReminderHint.GetWordNameForRegister

procedure TkwPopReminderHint.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Hint', aCtx);
end;//TkwPopReminderHint.SetValuePrim

function TkwPopReminderHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopReminderHint.GetResultTypeInfo

function TkwPopReminderHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderHint.GetAllParamsCount

function TkwPopReminderHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderHint.ParamsTypes

type
 TkwPopReminderPopupForm = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Reminder:PopupForm
*Тип результата:* TvtPopupFormModelPart
*Пример:*
[code]
OBJECT VAR l_TvtPopupFormModelPart
 aReminder pop:Reminder:PopupForm >>> l_TvtPopupFormModelPart
[code]  }
 private
 // private methods
   function PopupForm(const aCtx: TtfwContext;
    aReminder: TvgReminder): TvtPopupFormModelPart;
     {* Реализация слова скрипта pop:Reminder:PopupForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopReminderPopupForm

// start class TkwPopReminderPopupForm

function TkwPopReminderPopupForm.PopupForm(const aCtx: TtfwContext;
  aReminder: TvgReminder): TvtPopupFormModelPart;
 {-}
begin
 Result := aReminder.PopupForm;
end;//TkwPopReminderPopupForm.PopupForm

procedure TkwPopReminderPopupForm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aReminder : TvgReminder;
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
 aCtx.rEngine.PushObj((PopupForm(aCtx, l_aReminder)));
end;//TkwPopReminderPopupForm.DoDoIt

class function TkwPopReminderPopupForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Reminder:PopupForm';
end;//TkwPopReminderPopupForm.GetWordNameForRegister

procedure TkwPopReminderPopupForm.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству PopupForm', aCtx);
end;//TkwPopReminderPopupForm.SetValuePrim

function TkwPopReminderPopupForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPopupFormModelPart);
end;//TkwPopReminderPopupForm.GetResultTypeInfo

function TkwPopReminderPopupForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopReminderPopupForm.GetAllParamsCount

function TkwPopReminderPopupForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgReminder)]);
end;//TkwPopReminderPopupForm.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Click
 TkwPopReminderClick.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Move
 TkwPopReminderMove.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_FindEditor
 TkwPopReminderFindEditor.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_GetPopupMenu
 TkwPopReminderGetPopupMenu.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_ImageIndex
 TkwPopReminderImageIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_UserType
 TkwPopReminderUserType.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_IsBaloonVisible
 TkwPopReminderIsBaloonVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Visible
 TkwPopReminderVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Name
 TkwPopReminderName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Flash
 TkwPopReminderFlash.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_TextBackColor
 TkwPopReminderTextBackColor.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_ShowHint
 TkwPopReminderShowHint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Caption
 TkwPopReminderCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_Hint
 TkwPopReminderHint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_Reminder_PopupForm
 TkwPopReminderPopupForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TvgReminder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TPoint
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TComponent
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TMenuItem
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TvtPopupFormModelPart
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPopupFormModelPart));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

end.