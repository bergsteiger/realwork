unit PrimCustomizeTools_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\PrimCustomizeTools_Form.pas"
// ���������: "VCMForm"

{$Include sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
;

type
 TPrimCustomizeToolsForm = class
 end;//TPrimCustomizeToolsForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCustomizeToolsForm);
 {* ����������� PrimCustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
