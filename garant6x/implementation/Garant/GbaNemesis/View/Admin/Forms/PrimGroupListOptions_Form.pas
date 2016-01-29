unit PrimGroupListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupListOptions_Form.pas"
// �����: 10.09.2010 14:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 �������������::Admin::View::Admin::PrimGroupListOptions
//
// ������ �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  PrimGroupList_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimGroupListOptionsForm = {form} class(TPrimGroupListForm)
  {* ������ ������������� }
 protected
  procedure InitEntities; override;
 end;//TPrimGroupListOptionsForm

 TvcmEntityFormRef = TPrimGroupListOptionsForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  Admin_Users_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimGroupListOptionsForm

procedure TPrimGroupListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  
  ShowInContextMenu(en_Groups, op_Add, false);
  ShowInToolbar(en_Groups, op_Add, true);
  
  ShowInContextMenu(en_Groups, op_ChangeBaseAccess, true);
  ShowInToolbar(en_Groups, op_ChangeBaseAccess, false);
  
  ShowInContextMenu(en_Groups, op_Rename, true);
  ShowInToolbar(en_Groups, op_Rename, true);
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� PrimGroupListOptions
 TtfwClassRef.Register(TPrimGroupListOptionsForm);
{$IfEnd} //Admin AND not NoScripts

end.