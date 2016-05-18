unit elCustomEditKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� elCustomEdit }

// ������: "w:\common\components\gui\Garant\Daily\Forms\elCustomEditKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "elCustomEditKeywordsPack" MUID: (4BCE9D210265_Pack)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , elCustomEdit_Form
 , tfwPropertyLike
 , elCustomEdit
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwElCustomEditFormEdit = {final} class(TtfwPropertyLike)
  {* ����� ������� .TelCustomEditForm.Edit }
  private
   function Edit(const aCtx: TtfwContext;
    aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
    {* ���������� ����� ������� .TelCustomEditForm.Edit }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwElCustomEditFormEdit

 Tkw_Form_elCustomEdit = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� elCustomEdit
----
*������ �������������*:
[code]�����::elCustomEdit TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_elCustomEdit

 Tkw_elCustomEdit_Component_Edit = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Edit
----
*������ �������������*:
[code]���������::Edit TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_elCustomEdit_Component_Edit

function TkwElCustomEditFormEdit.Edit(const aCtx: TtfwContext;
 aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
 {* ���������� ����� ������� .TelCustomEditForm.Edit }
begin
 Result := aelCustomEditForm.Edit;
end;//TkwElCustomEditFormEdit.Edit

class function TkwElCustomEditFormEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TelCustomEditForm.Edit';
end;//TkwElCustomEditFormEdit.GetWordNameForRegister

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

procedure TkwElCustomEditFormEdit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Edit', aCtx);
end;//TkwElCustomEditFormEdit.SetValuePrim

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

function Tkw_Form_elCustomEdit.GetString: AnsiString;
begin
 Result := 'elCustomEditForm';
end;//Tkw_Form_elCustomEdit.GetString

class procedure Tkw_Form_elCustomEdit.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TelCustomEditForm);
end;//Tkw_Form_elCustomEdit.RegisterInEngine

class function Tkw_Form_elCustomEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::elCustomEdit';
end;//Tkw_Form_elCustomEdit.GetWordNameForRegister

function Tkw_elCustomEdit_Component_Edit.GetString: AnsiString;
begin
 Result := 'Edit';
end;//Tkw_elCustomEdit_Component_Edit.GetString

class procedure Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TelCustomEdit);
end;//Tkw_elCustomEdit_Component_Edit.RegisterInEngine

class function Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::Edit';
end;//Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister

initialization
 TkwElCustomEditFormEdit.RegisterInEngine;
 {* ����������� elCustomEditForm_Edit }
 Tkw_Form_elCustomEdit.RegisterInEngine;
 {* ����������� Tkw_Form_elCustomEdit }
 Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
 {* ����������� Tkw_elCustomEdit_Component_Edit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEditForm));
 {* ����������� ���� TelCustomEditForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEdit));
 {* ����������� ���� TelCustomEdit }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
