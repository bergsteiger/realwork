unit StyleEditorNavigator_Form;
 {* Дерево стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorNavigator_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "StyleEditorNavigator" MUID: (4ABA14480078)
// Имя типа: "TStyleEditorNavigatorForm"

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
  {* Идентификатор формы TStyleEditorNavigatorForm }

type
 TStyleEditorNavigatorForm = class;

 StyleEditorNavigatorFormDef = interface
  {* Идентификатор формы StyleEditorNavigator }
  ['{CA4048B0-89BD-4120-9949-4497958117C6}']
 end;//StyleEditorNavigatorFormDef

 TStyleEditorNavigatorForm = {final} class(TPrimStyleEditorNavigatorForm, StyleEditorNavigatorFormDef)
  {* Дерево стилей }
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
 {* Регистрация фабрики формы StyleEditorNavigator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorNavigatorForm);
 {* Регистрация StyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
