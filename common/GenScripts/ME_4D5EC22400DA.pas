unit NOT_FINISHED_vgBounds;

// ������: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgBounds.pas"
// ���������: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgPersistent
;

type
 TvgBounds = class(TvgPersistent)
 end;//TvgBounds
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
