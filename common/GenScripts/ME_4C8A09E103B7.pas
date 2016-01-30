unit PrimGroupPropertyOptions_Form;
 {* �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupPropertyOptions_Form.pas"
// ���������: "VCMForm"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupProperty_Form
;

type
 TPrimGroupPropertyOptionsForm = class(TPrimGroupPropertyForm)
  {* �������� ������ }
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimGroupPropertyOptionsForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C8A09E103B7_var*
//#UC END# *4C762A1501FC_4C8A09E103B7_var*
begin
//#UC START# *4C762A1501FC_4C8A09E103B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C8A09E103B7_impl*
end;//TPrimGroupPropertyOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimGroupPropertyOptionsForm.Cancel;
 {* ������ }
//#UC START# *4C762AB601E1_4C8A09E103B7_var*
//#UC END# *4C762AB601E1_4C8A09E103B7_var*
begin
//#UC START# *4C762AB601E1_4C8A09E103B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C8A09E103B7_impl*
end;//TPrimGroupPropertyOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupPropertyOptionsForm);
 {* ����������� PrimGroupPropertyOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
