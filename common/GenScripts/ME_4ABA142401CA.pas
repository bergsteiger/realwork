unit StyleEditorContainer_Form;
 {* �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorContainer_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorContainerOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_StyleEditorContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorContainerForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TStyleEditorContainerForm }

type
 StyleEditorContainerFormDef = interface
  {* ������������� ����� StyleEditorContainer }
  ['{27578D68-B109-4681-A8A0-250B1511D051}']
 end;//StyleEditorContainerFormDef

 TStyleEditorContainerForm = {final} class(TPrimStyleEditorContainerOptionsForm, StyleEditorContainerFormDef)
  {* �������� ������ }
 end;//TStyleEditorContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorContainerForm);
 {* ����������� StyleEditorContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
