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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimTurnOnTimeMachineOptionsForm = class(TPrimTurnOnTimeMachineForm)
  {* �������� ������ ������� }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimTurnOnTimeMachineOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C8A1B5C0356impl_uses*
 //#UC END# *4C8A1B5C0356impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimTurnOnTimeMachineOptionsForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, False);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, False);
 end;//with Entities.Entities
end;//TPrimTurnOnTimeMachineOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTurnOnTimeMachineOptionsForm);
 {* ����������� PrimTurnOnTimeMachineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
