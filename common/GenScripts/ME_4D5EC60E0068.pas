unit NOT_FINISHED_vgBrushBitmap;

// ������: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgBrushBitmap.pas"
// ���������: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgPersistent
;

type
 TvgBrushBitmap = class(TvgPersistent)
 end;//TvgBrushBitmap
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
