unit NOT_FINISHED_vgAnimation;

// ������: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgAnimation.pas"
// ���������: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgObject
;

type
 TvgAnimation = class(TvgObject)
 end;//TvgAnimation
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
 TtfwClassRef.Register(TvgAnimation);
 {* ����������� TvgAnimation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
