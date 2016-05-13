unit vgCustomResources;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomResources.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgCustomResources" MUID: (4D54299F035D)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgComponent
;

type
 TvgCustomResources = {abstract} class(TvgComponent)
 end;//TvgCustomResources
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCustomResources);
 {* Регистрация TvgCustomResources }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
