unit StyleEditorNavigator_Form;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigator_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "StyleEditorNavigator" MUID: (4ABA14480078)
// ��� ����: "TStyleEditorNavigatorForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorNavigator_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_StyleEditorNavigatorForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorNavigatorForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TStyleEditorNavigatorForm }

type
 TStyleEditorNavigatorForm = class;

 StyleEditorNavigatorFormDef = interface
  {* ������������� ����� StyleEditorNavigator }
  ['{CA4048B0-89BD-4120-9949-4497958117C6}']
 end;//StyleEditorNavigatorFormDef

 TStyleEditorNavigatorForm = {final} class(TPrimStyleEditorNavigatorForm, StyleEditorNavigatorFormDef)
  {* ������ ������ }
   Entities : TvcmEntities;
 end;//TStyleEditorNavigatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorNavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_StyleEditorNavigatorForm.SetFactory(TStyleEditorNavigatorForm.Make);
 {* ����������� ������� ����� StyleEditorNavigator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
 {* ����������� StyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
