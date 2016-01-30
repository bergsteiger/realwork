unit NOT_FINISHED_vcmRepOperationsCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmRepOperationsCollectionItem.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseOperationsCollectionItem
;

type
 TvcmFormActivate = class
 end;//TvcmFormActivate

 TvcmRepOperationsCollectionItem = class(TvcmBaseOperationsCollectionItem)
 end;//TvcmRepOperationsCollectionItem
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
 TtfwClassRef.Register(TvcmRepOperationsCollectionItem);
 {* Регистрация TvcmRepOperationsCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
