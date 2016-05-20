unit TreeAttributeSelect_Form;
 {* Выбор значений древовидного атрибута }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelect_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "TreeAttributeSelect" MUID: (4AAF487F03BC)
// Имя типа: "TefTreeAttributeSelect"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelectOptions_Form
 , SearchLite_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefTreeAttributeSelect = {final} class(TPrimTreeAttributeSelectOptionsForm, TreeAttributeSelectFormDef)
  {* Выбор значений древовидного атрибута }
   Entities : TvcmEntities;
 end;//TefTreeAttributeSelect

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TreeAttributeSelectKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefTreeAttributeSelect);
 {* Регистрация TreeAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efTreeAttributeSelect.SetFactory(TefTreeAttributeSelect.Make);
 {* Регистрация фабрики формы TreeAttributeSelect }

end.
