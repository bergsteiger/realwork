unit NOT_FINISHED_vcmUserTypesCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmUserTypesCollectionItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmUserTypesCollectionItem" MUID: (5006A4E003AB)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseUserTypesCollectionItem
;

type
 TvcmUserTypesCollectionItem = class(TvcmBaseUserTypesCollectionItem)
 end;//TvcmUserTypesCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5006A4E003ABimpl_uses*
 //#UC END# *5006A4E003ABimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmUserTypesCollectionItem);
 {* Регистрация TvcmUserTypesCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
