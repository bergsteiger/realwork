unit NOT_FINISHED_vgEffect;

// ������: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgEffect.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgObject
;

type
 TvgEffect = class(TvgObject)
 end;//TvgEffect
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
 TtfwClassRef.Register(TvgEffect);
 {* ����������� TvgEffect }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
