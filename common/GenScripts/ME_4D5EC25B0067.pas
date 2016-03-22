unit NOT_FINISHED_vgPosition;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgPosition.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgPosition" MUID: (4D5EC25B0067)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgPersistent
;

type
 TvgPosition = class(TvgPersistent)
 end;//TvgPosition
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
