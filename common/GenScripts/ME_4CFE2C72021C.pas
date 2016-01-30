unit NOT_FINISHED_vg_objects;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vg_objects.pas"
// Стереотип: "UtilityPack"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
;

type
 TvgText = class
 end;//TvgText

 TvgRectangle = class
 end;//TvgRectangle

 TvgImage = class
 end;//TvgImage
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
