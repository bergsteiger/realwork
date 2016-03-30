unit vgCustomBitmap;

// Модуль: "w:\common\components\rtl\external\VGScene\vgCustomBitmap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgCustomBitmap" MUID: (4D542A150195)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgInterfacedPersistent
;

type
 TvgCustomBitmap = {abstract} class(TvgInterfacedPersistent)
 end;//TvgCustomBitmap
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
