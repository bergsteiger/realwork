unit vgCustomCanvas;

// ������: "w:\common\components\rtl\external\VGScene\vgCustomCanvas.pas"
// ���������: "SimpleClass"
// ������� ������: "TvgCustomCanvas" MUID: (4D5435820356)

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
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
