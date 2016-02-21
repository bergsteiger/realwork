unit StyleEditorNavigator_Form;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigator_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorNavigator_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_StyleEditorNavigatorForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorNavigatorForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TStyleEditorNavigatorForm }

type
 StyleEditorNavigatorFormDef = interface
  {* ������������� ����� StyleEditorNavigator }
  ['{CA4048B0-89BD-4120-9949-4497958117C6}']
 end;//StyleEditorNavigatorFormDef

 TStyleEditorNavigatorForm = {final} class(TPrimStyleEditorNavigatorForm, StyleEditorNavigatorFormDef)
  {* ������ ������ }
 end;//TStyleEditorNavigatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , StyleEditorNavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
 {* ����������� StyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_StyleEditorNavigatorForm.SetFactory(TStyleEditorNavigatorForm.Make);
 {* ����������� ������� ����� StyleEditorNavigator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
