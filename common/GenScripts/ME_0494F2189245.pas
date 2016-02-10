unit elCustomEditKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� elCustomEdit }

// ������: "w:\common\components\gui\Garant\Daily\Forms\elCustomEditKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , elCustomEdit_Form
 , elCustomEdit
 , tfwControlString
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_elCustomEdit = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� elCustomEdit
----
*������ �������������*:
[code]
'aControl' �����::elCustomEdit TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_elCustomEdit

 Tkw_elCustomEdit_Component_Edit = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Edit
----
*������ �������������*:
[code]
���������::Edit TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_elCustomEdit_Component_Edit

 TkwElCustomEditFormEdit = {final} class(TtfwPropertyLike)
  {* ����� ������� .TelCustomEditForm.Edit
[panel]������� Edit ����� TelCustomEditForm[panel]
*��� ����������:* TelCustomEdit
*������:*
[code]
OBJECT VAR l_TelCustomEdit
 aelCustomEditForm .TelCustomEditForm.Edit >>> l_TelCustomEdit
[code]  }
  private
   function Edit(const aCtx: TtfwContext;
    aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
    {* ���������� ����� ������� .TelCustomEditForm.Edit }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwElCustomEditFormEdit

class function Tkw_Form_elCustomEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::elCustomEdit';
end;//Tkw_Form_elCustomEdit.GetWordNameForRegister

function Tkw_Form_elCustomEdit.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3434B3E8108E_var*
//#UC END# *4DDFD2EA0116_3434B3E8108E_var*
begin
//#UC START# *4DDFD2EA0116_3434B3E8108E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3434B3E8108E_impl*
end;//Tkw_Form_elCustomEdit.GetString

class function Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::Edit';
end;//Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister

function Tkw_elCustomEdit_Component_Edit.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0DFEE6D6F51D_var*
//#UC END# *4DDFD2EA0116_0DFEE6D6F51D_var*
begin
//#UC START# *4DDFD2EA0116_0DFEE6D6F51D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0DFEE6D6F51D_impl*
end;//Tkw_elCustomEdit_Component_Edit.GetString

class procedure Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
//#UC START# *52A086150180_0DFEE6D6F51D_var*
//#UC END# *52A086150180_0DFEE6D6F51D_var*
begin
//#UC START# *52A086150180_0DFEE6D6F51D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0DFEE6D6F51D_impl*
end;//Tkw_elCustomEdit_Component_Edit.RegisterInEngine

function TkwElCustomEditFormEdit.Edit(const aCtx: TtfwContext;
 aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
 {* ���������� ����� ������� .TelCustomEditForm.Edit }
//#UC START# *D5D8EBBE2F93_713A666E50E1_var*
//#UC END# *D5D8EBBE2F93_713A666E50E1_var*
begin
//#UC START# *D5D8EBBE2F93_713A666E50E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5D8EBBE2F93_713A666E50E1_impl*
end;//TkwElCustomEditFormEdit.Edit

procedure TkwElCustomEditFormEdit.DoDoIt(const aCtx: TtfwContext);
var l_aelCustomEditForm: TelCustomEditForm;
begin
 try
  l_aelCustomEditForm := TelCustomEditForm(aCtx.rEngine.PopObjAs(TelCustomEditForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aelCustomEditForm: TelCustomEditForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Edit(aCtx, l_aelCustomEditForm));
end;//TkwElCustomEditFormEdit.DoDoIt

class function TkwElCustomEditFormEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TelCustomEditForm.Edit';
end;//TkwElCustomEditFormEdit.GetWordNameForRegister

procedure TkwElCustomEditFormEdit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwElCustomEditFormEdit.SetValuePrim

function TkwElCustomEditFormEdit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TelCustomEdit);
end;//TkwElCustomEditFormEdit.GetResultTypeInfo

function TkwElCustomEditFormEdit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwElCustomEditFormEdit.GetAllParamsCount

function TkwElCustomEditFormEdit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TelCustomEditForm)]);
end;//TkwElCustomEditFormEdit.ParamsTypes

initialization
 Tkw_Form_elCustomEdit.RegisterInEngine;
 {* ����������� Tkw_Form_elCustomEdit }
 Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
 {* ����������� Tkw_elCustomEdit_Component_Edit }
 TkwElCustomEditFormEdit.RegisterInEngine;
 {* ����������� elCustomEditForm_Edit }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEditForm));
 {* ����������� ���� elCustomEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEdit));
 {* ����������� ���� TelCustomEdit }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
