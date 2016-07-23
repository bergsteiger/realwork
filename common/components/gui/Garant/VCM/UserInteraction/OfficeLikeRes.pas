unit OfficeLikeRes;

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLikeRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "OfficeLike" MUID: (4ADDCE970294)
// Имя типа: "TOfficeLikeRes"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
;

type
 TOfficeLikeRes = {abstract} class(TvcmApplication)
 end;//TOfficeLikeRes
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , moToolbarMenu
 , vcmBaseOperationsCollectionItem
 , vcmUserControls
 , PrimToolbarMenu_Module
 , OfficeLikeMain_Form
 , evExtFormat
 //#UC START# *4ADDCE970294impl_uses*
 //#UC END# *4ADDCE970294impl_uses*
;
{$IfEnd} // NOT Defined(NoVCM)

end.
