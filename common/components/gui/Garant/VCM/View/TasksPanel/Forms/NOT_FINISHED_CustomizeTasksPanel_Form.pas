unit NOT_FINISHED_CustomizeTasksPanel_Form;
 {* �������� ������ ����� }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\NOT_FINISHED_CustomizeTasksPanel_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "CustomizeTasksPanel" MUID: (4C8E4D4F027D)
// ��� ����: "TCustomizeTasksPanelForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimCustomizeTasksPanel_Form
;

type
 TCustomizeTasksPanelForm = {final} class(TPrimCustomizeTasksPanelForm)
  {* �������� ������ ����� }
 end;//TCustomizeTasksPanelForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 , vcmCustOpsRepGroupList
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , CustomizeTasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_CustomizeTasksPanelLocalConstants }
 str_ut_CustomizeTasksPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeTasksPanelCaption'; rValue : '�������� ������ �����');
  {* ��������� ����������������� ���� "�������� ������ �����" }

initialization
 str_ut_CustomizeTasksPanelCaption.Init;
 {* ������������� str_ut_CustomizeTasksPanelCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeTasksPanelForm);
 {* ����������� CustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
