unit PrimTurnOnTimeMachineOptions_Form;
 {* �������� ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimTurnOnTimeMachineOptions_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimTurnOnTimeMachineOptions" MUID: (4C8A1B5C0356)
// ��� ����: "TPrimTurnOnTimeMachineOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOnTimeMachine_Form
;

type
 TPrimTurnOnTimeMachineOptionsForm = class(TPrimTurnOnTimeMachineForm)
  {* �������� ������ ������� }
 end;//TPrimTurnOnTimeMachineOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOnTimeMachineOptionsForm);
 {* ����������� PrimTurnOnTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
