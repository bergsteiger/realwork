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
;

type
 TPrimGroupPropertyOptionsForm = class(TPrimGroupPropertyForm)
  {* �������� ������ }
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupPropertyOptionsForm);
 {* ����������� PrimGroupPropertyOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
