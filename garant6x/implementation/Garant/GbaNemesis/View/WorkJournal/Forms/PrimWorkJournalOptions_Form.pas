unit PrimWorkJournalOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournalOptions_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimWorkJournalOptions" MUID: (4CC7E19400DE)
// ��� ����: "TPrimWorkJournalOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWorkJournal_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimWorkJournalOptionsForm = class(TPrimWorkJournalForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimWorkJournalOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4CC7E19400DEimpl_uses*
 //#UC END# *4CC7E19400DEimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalOptionsForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_SavedQuery, op_OpenQuery, True);
  ShowInToolbar(en_SavedQuery, op_OpenQuery, False);
  ShowInContextMenu(en_SavedQuery, op_ExecuteQuery, True);
  ShowInToolbar(en_SavedQuery, op_ExecuteQuery, False);
 end;//with Entities.Entities
end;//TPrimWorkJournalOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalOptionsForm);
 {* ����������� PrimWorkJournalOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
