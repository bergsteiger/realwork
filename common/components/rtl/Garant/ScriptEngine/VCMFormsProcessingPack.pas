unit VCMFormsProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\VCMFormsProcessingPack.pas"
// ���������: "ScriptKeywordsPack"

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
  {* ����� ������� pop:Form:IsFloatingStateAndParentNotVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingStateAndParentNotVisible >>> l_Boolean
[code]  }
  private
   function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* ���������� ����� ������� pop:Form:IsFloatingStateAndParentNotVisible }
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
  {* ����� ������� pop:Form:IsFloatingState
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingState >>> l_Boolean
[code]  }
  private
   function IsFloatingState(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Boolean;
    {* ���������� ����� ������� pop:Form:IsFloatingState }
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
  {* ����� ������� pop:Form:UserType
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aForm pop:Form:UserType >>> l_Integer
[code]  }
  private
   function UserType(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): Integer;
    {* ���������� ����� ������� pop:Form:UserType }
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
  {* ����� ������� pop:Form:FormID
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aForm pop:Form:FormID >>> l_String
[code]  }
  private
   function FormID(const aCtx: TtfwContext;
    aForm: TvcmEntityForm): AnsiString;
    {* ���������� ����� ������� pop:Form:FormID }
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
 {* ���������� ����� ������� pop:Form:IsFloatingStateAndParentNotVisible }
begin
 Result := aForm.IsFloatingStateAndParentNotVisible;
end;//TkwPopFormIsFloatingStateAndParentNotVisible.IsFloatingStateAndParentNotVisible

procedure TkwPopFormIsFloatingStateAndParentNotVisible.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TvcmEntityForm : ' + E.Message, aCtx);
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
begin
 RunnerError('������ ����������� �������� readonly �������� IsFloatingStateAndParentNotVisible', aCtx);
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
 {* ���������� ����� ������� pop:Form:IsFloatingState }
begin
 Result := aForm.IsFloatingState;
end;//TkwPopFormIsFloatingState.IsFloatingState

procedure TkwPopFormIsFloatingState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TvcmEntityForm : ' + E.Message, aCtx);
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
begin
 RunnerError('������ ����������� �������� readonly �������� IsFloatingState', aCtx);
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
 {* ���������� ����� ������� pop:Form:UserType }
begin
 Result := aForm.UserType;
end;//TkwPopFormUserType.UserType

procedure TkwPopFormUserType.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TvcmEntityForm;
begin
 try
  l_aForm := TvcmEntityForm(aCtx.rEngine.PopObjAs(TvcmEntityForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TvcmEntityForm : ' + E.Message, aCtx);
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
begin
 RunnerError('������ ����������� �������� readonly �������� UserType', aCtx);
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
 {* ���������� ����� ������� pop:Form:FormID }
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
   RunnerError('������ ��� ��������� ��������� aForm: TvcmEntityForm : ' + E.Message, aCtx);
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
begin
 RunnerError('������ ����������� �������� readonly �������� FormID', aCtx);
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
 {* ����������� pop_Form_IsFloatingStateAndParentNotVisible }
 TkwPopFormIsFloatingState.RegisterInEngine;
 {* ����������� pop_Form_IsFloatingState }
 TkwPopFormUserType.RegisterInEngine;
 {* ����������� pop_Form_UserType }
 TkwPopFormFormID.RegisterInEngine;
 {* ����������� pop_Form_FormID }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvcmEntityForm));
 {* ����������� ���� TvcmEntityForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
