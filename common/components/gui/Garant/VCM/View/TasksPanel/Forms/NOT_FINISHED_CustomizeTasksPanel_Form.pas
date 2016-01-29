unit NOT_FINISHED_CustomizeTasksPanel_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/View/TasksPanel/Forms/NOT_FINISHED_CustomizeTasksPanel_Form.pas"
// �����: 13.09.2010 20:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimTasksPanelMenu::CustomizeTasksPanel
//
// �������� ������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls,
  l3StringIDEx,
  PrimCustomizeTasksPanel_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType,
  vtCtrls,
  vtPanel,
  vtLabel,
  vtButton,
  vtGroupBox,
  eeTreeView,
  eeButton
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Buttons
  {$IfEnd} //not NoVCL
  ,
  eeCheckBox,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
  TCustomizeTasksPanelForm = {final form} class(TPrimCustomizeTasksPanelForm)
   {* �������� ������ ����� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TCustomizeTasksPanelForm
{$IfEnd} //not NoVCM

implementation

{$R *.DFM}

{$If not defined(NoVCM)}
uses
  vcmCustOpsRepGroupList
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  CustomizeTasksPanelKeywordsPack
  {$IfEnd} //not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

var
    { ������������ ������ ut_CustomizeTasksPanelLocalConstants }
   str_ut_CustomizeTasksPanelCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : '�������� ������ �����');
    { ��������� ����������������� ���� "�������� ������ �����" }

// start class TCustomizeTasksPanelForm

procedure TCustomizeTasksPanelForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_CustomizeTasksPanelName,
  str_ut_CustomizeTasksPanelCaption,
  str_ut_CustomizeTasksPanelCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_CustomizeTasksPanelName
end;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� CustomizeTasksPanel
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoVCM)}
// ������������� str_ut_CustomizeTasksPanelCaption
 str_ut_CustomizeTasksPanelCaption.Init;
{$IfEnd} //not NoVCM

end.