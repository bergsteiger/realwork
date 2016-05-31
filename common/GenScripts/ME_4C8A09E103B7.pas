unit PrimGroupPropertyOptions_Form;
 {* �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupPropertyOptions_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimGroupPropertyOptions" MUID: (4C8A09E103B7)
// ��� ����: "TPrimGroupPropertyOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupProperty_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimGroupPropertyOptionsForm = class(TPrimGroupPropertyForm)
  {* �������� ������ }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimGroupPropertyOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
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
 //#UC START# *4C8A09E103B7impl_uses*
 //#UC END# *4C8A09E103B7impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyOptionsForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  ShowInContextMenu(en_Result, op_Ok, True);
  ShowInToolbar(en_Result, op_Ok, True);
  ShowInContextMenu(en_Result, op_Cancel, True);
  ShowInToolbar(en_Result, op_Cancel, True);
 end;//with Entities.Entities
end;//TPrimGroupPropertyOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupPropertyOptionsForm);
 {* ����������� PrimGroupPropertyOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
