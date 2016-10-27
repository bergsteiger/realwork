unit CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType;
 {* �������� ������ ����� }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\CustomizeTasksPanel_ut_CustomizeTasksPanel_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_CustomizeTasksPanel" MUID: (57FDA2BA57FE)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : '�������� ������ �����');
  {* ��������� ����������������� ���� "�������� ������ �����" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_CustomizeTasksPanel = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_CustomizeTasksPanel }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_CustomizeTasksPanel
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger: Integer;
begin
 Result := ut_CustomizeTasksPanel;
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetInteger

class function Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_CustomizeTasksPanel';
end;//Tkw_FormUserType_ut_CustomizeTasksPanel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_CustomizeTasksPanelCaption.Init;
 {* ������������� str_ut_CustomizeTasksPanelCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTasksPanel.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
