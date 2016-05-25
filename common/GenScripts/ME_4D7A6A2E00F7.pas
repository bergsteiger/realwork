unit DictionContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionContainer_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "DictionContainer" MUID: (4D7A6A2E00F7)
// Имя типа: "TDictionContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDictionContainer_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDictionContainerForm = {final} class(TPrimDictionContainerForm, DictionContainerFormDef)
   Entities : TvcmEntities;
 end;//TDictionContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DictionContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_DictionContainerForm.SetFactory(TDictionContainerForm.Make);
 {* Регистрация фабрики формы DictionContainer }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDictionContainerForm);
 {* Регистрация DictionContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
