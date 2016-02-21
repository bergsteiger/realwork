unit ProgressIndicator_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\ProgressIndicator_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimProgressIndicator_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efProgressIndicator: TvcmFormDescriptor = (rFormID : (rName : 'efProgressIndicator'; rID : 0); rFactory : nil);
  {* ������������� ����� TefProgressIndicator }

type
 ProgressIndicatorFormDef = interface
  {* ������������� ����� ProgressIndicator }
  ['{83193317-8438-475F-9F0C-1C44F08B2DA4}']
 end;//ProgressIndicatorFormDef

 TefProgressIndicator = {final} class(TPrimProgressIndicatorForm, ProgressIndicatorFormDef)
 end;//TefProgressIndicator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ProgressIndicatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefProgressIndicator);
 {* ����������� ProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
