unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/View/TasksPanel/Forms/CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// �����: 13.09.2010 20:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations::VCMCustomization::View::TasksPanel::PrimTasksPanelMenu::CustomizeTasksPanel::ut_CustomizeTasksPanel
//
// �������� ������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { ��������� ��� ���� ����� ut_CustomizeTasksPanel }
   ut_CustomizeTasksPanelName = 'ut_CustomizeTasksPanel';
    { ��������� ������������� ����������������� ���� "�������� ������ �����" }
   ut_CustomizeTasksPanel = TvcmUserType(0);
    { �������� ������ ����� }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
{$If not defined(NoScripts) AND not defined(NoVCM)}
type
   Tkw_FormUserType_ut_CustomizeTasksPanel = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_CustomizeTasksPanel }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CustomizeTasksPanel
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_CustomizeTasksPanel

class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
 {-}
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger

{$IfEnd} //not NoScripts AND not NoVCM
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_CustomizeTasksPanel
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.