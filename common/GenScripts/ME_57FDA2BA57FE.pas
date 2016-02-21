unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;
 {* �������� ������ ����� }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// ���������: "UserType"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* ��������� ��� ���� ����� ut_CustomizeTasksPanel }
 ut_CustomizeTasksPanelName = 'ut_CustomizeTasksPanel';
  {* ��������� ������������� ����������������� ���� "�������� ������ �����" }
 ut_CustomizeTasksPanel = TvcmUserType(0);
  {* �������� ������ ����� }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_CustomizeTasksPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_CustomizeTasksPanel
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister

function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
