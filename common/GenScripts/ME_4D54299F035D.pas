unit vgCustomResources;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomResources.pas"
// Стереотип: "SimpleClass"

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
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
