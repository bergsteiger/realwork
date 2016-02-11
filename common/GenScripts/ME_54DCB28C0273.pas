unit VCMFormsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopFormIsFloatingStateAndParentNotVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingStateAndParentNotVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingStateAndParentNotVisible >>> l_Boolean
[code]  }
  private
   function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormIsFloatingStateAndParentNotVisible

 TkwPopFormIsFloatingState = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingState
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingState >>> l_Boolean
[code]  }
  private
   function IsFloatingState(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* Реализация слова скрипта pop:Form:IsFloatingState }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormIsFloatingState

 TkwPopFormUserType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:Form:UserType >>> l_Integer
[code]  }
  private
   function UserType(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Integer;
    {* Реализация слова скрипта pop:Form:UserType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormUserType

 TkwPopFormFormID = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:FormID
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aForm pop:Form:FormID >>> l_String
[code]  }
  private
   function FormID(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): AnsiString;
    {* Реализация слова скрипта pop:Form:FormID }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFormID

function TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Boolean;
 {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
//#UC START# *4A1ADA6890A6_B6E9E8EFCE95_var*
//#UC END# *4A1ADA6890A6_B6E9E8EFCE95_var*
begin
//#UC START# *4A1ADA6890A6_B6E9E8EFCE95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A1ADA6890A6_B6E9E8EFCE95_impl*
end;//TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible

procedure TkwPopFormIsFloatingStateAndParentNotVisible.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
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
 aCtx.rEngine.PushBool(IsFloatingStateAndParentNotVisible(aCtx, l_aForm));
end;//TkwPopFormIsFloatingStateAndParentNotVisible.DoDoIt

class function TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:IsFloatingStateAndParentNotVisible';
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister

procedure TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Form: TvcmEntityForm;
begin
 try
  l_Form := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Form: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Form. := aValue.AsBoolean;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim

function TkwPopFormIsFloatingStateAndParentNotVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetResultTypeInfo

function TkwPopFormIsFloatingStateAndParentNotVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetAllParamsCount

function TkwPopFormIsFloatingStateAndParentNotVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.ParamsTypes

function TkwPopFormIsFloatingState.IsFloatingState(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Boolean;
 {* Реализация слова скрипта pop:Form:IsFloatingState }
//#UC START# *1605D41D08A0_E5D04ADC6C87_var*
//#UC END# *1605D41D08A0_E5D04ADC6C87_var*
begin
//#UC START# *1605D41D08A0_E5D04ADC6C87_impl*
 !!! Needs to be implemented !!!
//#UC END# *1605D41D08A0_E5D04ADC6C87_impl*
end;//TkwPopFormIsFloatingState.IsFloatingState

procedure TkwPopFormIsFloatingState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
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
 aCtx.rEngine.PushBool(IsFloatingState(aCtx, l_aForm));
end;//TkwPopFormIsFloatingState.DoDoIt

class function TkwPopFormIsFloatingState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:IsFloatingState';
end;//TkwPopFormIsFloatingState.GetWordNameForRegister

procedure TkwPopFormIsFloatingState.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Form: TvcmEntityForm;
begin
 try
  l_Form := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Form: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Form. := aValue.AsBoolean;
end;//TkwPopFormIsFloatingState.SetValuePrim

function TkwPopFormIsFloatingState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormIsFloatingState.GetResultTypeInfo

function TkwPopFormIsFloatingState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormIsFloatingState.GetAllParamsCount

function TkwPopFormIsFloatingState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormIsFloatingState.ParamsTypes

function TkwPopFormUserType.UserType(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Integer;
 {* Реализация слова скрипта pop:Form:UserType }
//#UC START# *6E48299F798F_F96A7A339D27_var*
//#UC END# *6E48299F798F_F96A7A339D27_var*
begin
//#UC START# *6E48299F798F_F96A7A339D27_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E48299F798F_F96A7A339D27_impl*
end;//TkwPopFormUserType.UserType

procedure TkwPopFormUserType.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
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
 aCtx.rEngine.PushInt(UserType(aCtx, l_aForm));
end;//TkwPopFormUserType.DoDoIt

class function TkwPopFormUserType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:UserType';
end;//TkwPopFormUserType.GetWordNameForRegister

procedure TkwPopFormUserType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Form: TvcmEntityForm;
begin
 try
  l_Form := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Form: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Form. := aValue.AsInt;
end;//TkwPopFormUserType.SetValuePrim

function TkwPopFormUserType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormUserType.GetResultTypeInfo

function TkwPopFormUserType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormUserType.GetAllParamsCount

function TkwPopFormUserType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormUserType.ParamsTypes

function TkwPopFormFormID.FormID(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): AnsiString;
 {* Реализация слова скрипта pop:Form:FormID }
//#UC START# *C723C4FA73E4_B0B047C68F92_var*
//#UC END# *C723C4FA73E4_B0B047C68F92_var*
begin
//#UC START# *C723C4FA73E4_B0B047C68F92_impl*
 Result := aForm.FormID.rName;
//#UC END# *C723C4FA73E4_B0B047C68F92_impl*
end;//TkwPopFormFormID.FormID

procedure TkwPopFormFormID.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
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
 aCtx.rEngine.PushString(FormID(aCtx, l_aForm));
end;//TkwPopFormFormID.DoDoIt

class function TkwPopFormFormID.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:FormID';
end;//TkwPopFormFormID.GetWordNameForRegister

procedure TkwPopFormFormID.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Form: TvcmEntityForm;
begin
 try
  l_Form := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Form: TvcmEntityForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(Form, aValue.AsDelphiString);
end;//TkwPopFormFormID.SetValuePrim

function TkwPopFormFormID.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopFormFormID.GetResultTypeInfo

function TkwPopFormFormID.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormFormID.GetAllParamsCount

function TkwPopFormFormID.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvcmEntityForm)]);
end;//TkwPopFormFormID.ParamsTypes

initialization
 TkwPopFormIsFloatingStateAndParentNotVisible.RegisterInEngine;
 {* Регистрация pop_Form_IsFloatingStateAndParentNotVisible }
 TkwPopFormIsFloatingState.RegisterInEngine;
 {* Регистрация pop_Form_IsFloatingState }
 TkwPopFormUserType.RegisterInEngine;
 {* Регистрация pop_Form_UserType }
 TkwPopFormFormID.RegisterInEngine;
 {* Регистрация pop_Form_FormID }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmEntityForm));
 {* Регистрация типа TvcmEntityForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
