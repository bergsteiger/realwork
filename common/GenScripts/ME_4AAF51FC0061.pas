unit SelectedAttributes_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\SelectedAttributes_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "SelectedAttributes" MUID: (4AAF51FC0061)
// Имя типа: "TenSelectedAttributes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimSelectedAttributesOptions_Form
 , SearchLite_FormDefinitions_Controls
;

type
 TenSelectedAttributes = {final} class(TPrimSelectedAttributesOptionsForm, SelectedAttributesFormDef)
 end;//TenSelectedAttributes

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SelectedAttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenSelectedAttributes);
 {* Регистрация SelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enSelectedAttributes.SetFactory(TenSelectedAttributes.Make);
 {* Регистрация фабрики формы SelectedAttributes }

end.
