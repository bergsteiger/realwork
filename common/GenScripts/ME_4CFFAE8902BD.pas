unit NOT_FINISHED_vg_layouts;

// ������: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vg_layouts.pas"
// ���������: "UtilityPack"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
;

type
 TvgNonVGLayout = class
 end;//TvgNonVGLayout

 TvgLayout = class
 end;//TvgLayout
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
