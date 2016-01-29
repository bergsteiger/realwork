unit VCMFormsProcessingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VCM"
// Модуль: "VCMFormsProcessingPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VCM::VCMFormsProcessing::VCMFormsProcessingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmEntityForm,
  tfwScriptingInterfaces,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopFormIsFloatingStateAndParentNotVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingStateAndParentNotVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingStateAndParentNotVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
     {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
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
 end;//TkwPopFormIsFloatingStateAndParentNotVisible

// start class TkwPopFormIsFloatingStateAndParentNotVisible

function TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
  aForm: TvcmEntityForm): Boolean;
 {-}
begin
 Result := aForm.IsFloatingStateAndParentNotVisible;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible

procedure TkwPopFormIsFloatingStateAndParentNotVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aForm : TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsFloatingStateAndParentNotVisible(aCtx, l_aForm)));
end;//TkwPopFormIsFloatingStateAndParentNotVisible.DoDoIt

class function TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Form:IsFloatingStateAndParentNotVisible';
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister

procedure TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFloatingStateAndParentNotVisible', aCtx);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim

function TkwPopFormIsFloatingStateAndParentNotVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetResultTypeInfo

function TkwPopFormIsFloatingStateAndParentNotVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetAllParamsCount

function TkwPopFormIsFloatingStateAndParentNotVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.ParamsTypes

type
 TkwPopFormIsFloatingState = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingState
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingState >>> l_Boolean
[code]  }
 private
 // private methods
   function IsFloatingState(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
     {* Реализация слова скрипта pop:Form:IsFloatingState }
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
 end;//TkwPopFormIsFloatingState

// start class TkwPopFormIsFloatingState

function TkwPopFormIsFloatingState.IsFloatingState(const aCtx: TtfwContext;
  aForm: TvcmEntityForm): Boolean;
 {-}
begin
 Result := aForm.IsFloatingState;
end;//TkwPopFormIsFloatingState.IsFloatingState

procedure TkwPopFormIsFloatingState.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aForm : TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsFloatingState(aCtx, l_aForm)));
end;//TkwPopFormIsFloatingState.DoDoIt

class function TkwPopFormIsFloatingState.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Form:IsFloatingState';
end;//TkwPopFormIsFloatingState.GetWordNameForRegister

procedure TkwPopFormIsFloatingState.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFloatingState', aCtx);
end;//TkwPopFormIsFloatingState.SetValuePrim

function TkwPopFormIsFloatingState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormIsFloatingState.GetResultTypeInfo

function TkwPopFormIsFloatingState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFormIsFloatingState.GetAllParamsCount

function TkwPopFormIsFloatingState.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormIsFloatingState.ParamsTypes

type
 TkwPopFormUserType = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:Form:UserType >>> l_Integer
[code]  }
 private
 // private methods
   function UserType(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Integer;
     {* Реализация слова скрипта pop:Form:UserType }
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
 end;//TkwPopFormUserType

// start class TkwPopFormUserType

function TkwPopFormUserType.UserType(const aCtx: TtfwContext;
  aForm: TvcmEntityForm): Integer;
 {-}
begin
 Result := aForm.UserType;
end;//TkwPopFormUserType.UserType

procedure TkwPopFormUserType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aForm : TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((UserType(aCtx, l_aForm)));
end;//TkwPopFormUserType.DoDoIt

class function TkwPopFormUserType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Form:UserType';
end;//TkwPopFormUserType.GetWordNameForRegister

procedure TkwPopFormUserType.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserType', aCtx);
end;//TkwPopFormUserType.SetValuePrim

function TkwPopFormUserType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormUserType.GetResultTypeInfo

function TkwPopFormUserType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFormUserType.GetAllParamsCount

function TkwPopFormUserType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormUserType.ParamsTypes

type
 TkwPopFormFormID = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:FormID
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aForm pop:Form:FormID >>> l_String
[code]  }
 private
 // private methods
   function FormID(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): AnsiString;
     {* Реализация слова скрипта pop:Form:FormID }
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
 end;//TkwPopFormFormID

// start class TkwPopFormFormID

function TkwPopFormFormID.FormID(const aCtx: TtfwContext;
  aForm: TvcmEntityForm): AnsiString;
//#UC START# *C723C4FA73E4_B0B047C68F92_var*
//#UC END# *C723C4FA73E4_B0B047C68F92_var*
begin
//#UC START# *C723C4FA73E4_B0B047C68F92_impl*
 Result := aForm.FormID.rName;
//#UC END# *C723C4FA73E4_B0B047C68F92_impl*
end;//TkwPopFormFormID.FormID

procedure TkwPopFormFormID.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aForm : TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((FormID(aCtx, l_aForm)));
end;//TkwPopFormFormID.DoDoIt

class function TkwPopFormFormID.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Form:FormID';
end;//TkwPopFormFormID.GetWordNameForRegister

procedure TkwPopFormFormID.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FormID', aCtx);
end;//TkwPopFormFormID.SetValuePrim

function TkwPopFormFormID.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopFormFormID.GetResultTypeInfo

function TkwPopFormFormID.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopFormFormID.GetAllParamsCount

function TkwPopFormFormID.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormFormID.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация pop_Form_IsFloatingStateAndParentNotVisible
 TkwPopFormIsFloatingStateAndParentNotVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация pop_Form_IsFloatingState
 TkwPopFormIsFloatingState.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация pop_Form_UserType
 TkwPopFormUserType.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация pop_Form_FormID
 TkwPopFormFormID.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TvcmEntityForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmEntityForm));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVCM

end.