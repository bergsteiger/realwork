unit NOT_FINISHED_imageenview;

// Модуль: "w:\common\components\rtl\external\ImageEn\src\NOT_FINISHED_imageenview.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "imageenview" MUID: (4ACDBC4A0003)

interface

{$If NOT Defined(NoImageEn)}
uses
 l3IntfUses
;

type
 TImageEnView = class
 end;//TImageEnView
{$IfEnd} // NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoImageEn)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , ImageEnPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4ACDBC4A0003impl_uses*
 //#UC END# *4ACDBC4A0003impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TImageEnView);
 {* Регистрация TImageEnView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoImageEn)

end.
