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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenSelectedAttributes = {final} class(TPrimSelectedAttributesOptionsForm, SelectedAttributesFormDef)
   Entities : TvcmEntities;
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

{$R *.DFM}

initialization
 fm_enSelectedAttributes.SetFactory(TenSelectedAttributes.Make);
 {* Регистрация фабрики формы SelectedAttributes }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenSelectedAttributes);
 {* Регистрация SelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)

end.
