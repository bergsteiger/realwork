unit vgCustomCanvas;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomCanvas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgCustomCanvas" MUID: (4D5435820356)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgPersistent
;

type
 TvgCustomCanvas = {abstract} class(TvgPersistent)
 end;//TvgCustomCanvas
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 //#UC START# *4D5435820356impl_uses*
 //#UC END# *4D5435820356impl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
