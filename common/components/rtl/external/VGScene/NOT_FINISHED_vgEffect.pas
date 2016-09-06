unit NOT_FINISHED_vgEffect;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgEffect.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgEffect" MUID: (4D5E914F002C)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgObject
;

type
 TvgEffect = class(TvgObject)
 end;//TvgEffect
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D5E914F002Cimpl_uses*
 //#UC END# *4D5E914F002Cimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgEffect);
 {* Регистрация TvgEffect }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
