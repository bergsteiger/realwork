unit VCMFormsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "VCMFormsProcessingPack" MUID: (54DCB28C0273)

{$Include w:\common\components\rtl\Garant\ScriptEngine\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityForm
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopFormIsFloatingStateAndParentNotVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingStateAndParentNotVisible }
  private
   function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopFormIsFloatingStateAndParentNotVisible

 TkwPopFormIsFloatingState = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingState }
  private
   function IsFloatingState(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* Реализация слова скрипта pop:Form:IsFloatingState }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopFormIsFloatingState

 TkwPopFormUserType = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:UserType }
  private
   function UserType(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Integer;
    {* Реализация слова скрипта pop:Form:UserType }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopFormUserType

 TkwPopFormFormID = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:FormID }
  private
   function FormID(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): AnsiString;
    {* Реализация слова скрипта pop:Form:FormID }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopFormFormID

function TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Boolean;
 {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
begin
 Result := aForm.IsFloatingStateAndParentNotVisible;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible

class function TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:IsFloatingStateAndParentNotVisible';
end;//TkwPopFormIsFloatingStateAndParentNotVisible.GetWordNameForRegister

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

procedure TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFloatingStateAndParentNotVisible', aCtx);
end;//TkwPopFormIsFloatingStateAndParentNotVisible.SetValuePrim

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

function TkwPopFormIsFloatingState.IsFloatingState(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Boolean;
 {* Реализация слова скрипта pop:Form:IsFloatingState }
begin
 Result := aForm.IsFloatingState;
end;//TkwPopFormIsFloatingState.IsFloatingState

class function TkwPopFormIsFloatingState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:IsFloatingState';
end;//TkwPopFormIsFloatingState.GetWordNameForRegister

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

procedure TkwPopFormIsFloatingState.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFloatingState', aCtx);
end;//TkwPopFormIsFloatingState.SetValuePrim

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

function TkwPopFormUserType.UserType(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): Integer;
 {* Реализация слова скрипта pop:Form:UserType }
begin
 Result := aForm.UserType;
end;//TkwPopFormUserType.UserType

class function TkwPopFormUserType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:UserType';
end;//TkwPopFormUserType.GetWordNameForRegister

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

procedure TkwPopFormUserType.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserType', aCtx);
end;//TkwPopFormUserType.SetValuePrim

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

function TkwPopFormFormID.FormID(const aCtx: TtfwContext;
 aForm: TvcmEntityForm): AnsiString;
 {* Реализация слова скрипта pop:Form:FormID }
//#UC START# *27D13BB1D318_27D13BB1D318_49525B34022A_Word_var*
//#UC END# *27D13BB1D318_27D13BB1D318_49525B34022A_Word_var*
begin
//#UC START# *27D13BB1D318_27D13BB1D318_49525B34022A_Word_impl*
 Result := aForm.FormID.rName;
//#UC END# *27D13BB1D318_27D13BB1D318_49525B34022A_Word_impl*
end;//TkwPopFormFormID.FormID

class function TkwPopFormFormID.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Form:FormID';
end;//TkwPopFormFormID.GetWordNameForRegister

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

procedure TkwPopFormFormID.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FormID', aCtx);
end;//TkwPopFormFormID.SetValuePrim

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

initialization
 TkwPopFormIsFloatingStateAndParentNotVisible.RegisterInEngine;
 {* Регистрация pop_Form_IsFloatingStateAndParentNotVisible }
 TkwPopFormIsFloatingState.RegisterInEngine;
 {* Регистрация pop_Form_IsFloatingState }
 TkwPopFormUserType.RegisterInEngine;
 {* Регистрация pop_Form_UserType }
 TkwPopFormFormID.RegisterInEngine;
 {* Регистрация pop_Form_FormID }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmEntityForm));
 {* Регистрация типа TvcmEntityForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
