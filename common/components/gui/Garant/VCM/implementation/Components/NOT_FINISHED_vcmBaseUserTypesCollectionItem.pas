unit NOT_FINISHED_vcmBaseUserTypesCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\NOT_FINISHED_vcmBaseUserTypesCollectionItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmBaseUserTypesCollectionItem" MUID: (5006A4C80386)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserTypesCollectionItemPrim
;

type
 TvcmBaseUserTypesCollectionItem = class(TvcmUserTypesCollectionItemPrim)
 end;//TvcmBaseUserTypesCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5006A4C80386impl_uses*
 //#UC END# *5006A4C80386impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseUserTypesCollectionItem);
 {* Регистрация TvcmBaseUserTypesCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
