unit CustomFormProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\CustomFormProcessingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "CustomFormProcessingPack" MUID: (553252BF022D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Forms
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwPopFormFormStyle = {final} class(TtfwClassLike)
  {* ����� ������� pop:form:FormStyle
*��� ����������:* TFormStyle
*������:*
[code]
TFormStyle VAR l_TFormStyle
 aForm pop:form:FormStyle >>> l_TFormStyle
[code]  }
  private
   function pop_form_FormStyle(const aCtx: TtfwContext;
    aForm: TCustomForm): TFormStyle;
    {* ���������� ����� ������� pop:form:FormStyle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFormStyle

 TCustomFormProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TCustomFormProcessingPackResNameGetter

function TkwPopFormFormStyle.pop_form_FormStyle(const aCtx: TtfwContext;
 aForm: TCustomForm): TFormStyle;
 {* ���������� ����� ������� pop:form:FormStyle }
//#UC START# *BCF4960E4290_3ADE91F9FA16_var*
//#UC END# *BCF4960E4290_3ADE91F9FA16_var*
begin
//#UC START# *BCF4960E4290_3ADE91F9FA16_impl*
 Result := TForm(aForm).FormStyle;
//#UC END# *BCF4960E4290_3ADE91F9FA16_impl*
end;//TkwPopFormFormStyle.pop_form_FormStyle

procedure TkwPopFormFormStyle.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TCustomForm;
begin
 try
  l_aForm := TCustomForm(aCtx.rEngine.PopObjAs(TCustomForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aForm: TCustomForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(pop_form_FormStyle(aCtx, l_aForm)));
end;//TkwPopFormFormStyle.DoDoIt

function TkwPopFormFormStyle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TFormStyle);
end;//TkwPopFormFormStyle.GetResultTypeInfo

function TkwPopFormFormStyle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormFormStyle.GetAllParamsCount

function TkwPopFormFormStyle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomForm)]);
end;//TkwPopFormFormStyle.ParamsTypes

class function TkwPopFormFormStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FormStyle';
end;//TkwPopFormFormStyle.GetWordNameForRegister

class function TCustomFormProcessingPackResNameGetter.ResName: AnsiString;
begin
 Result := 'CustomFormProcessingPack';
end;//TCustomFormProcessingPackResNameGetter.ResName

 {$R CustomFormProcessingPack.res}

initialization
 TkwPopFormFormStyle.RegisterInEngine;
 {* ����������� pop_form_FormStyle }
 TCustomFormProcessingPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
 {* ����������� ���� TCustomForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TFormStyle));
 {* ����������� ���� TFormStyle }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
