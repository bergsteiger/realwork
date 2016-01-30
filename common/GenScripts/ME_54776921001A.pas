unit vcmBaseMenuForChromeLike_p;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmBaseMenuForChromeLike_p.pas"
// Стереотип: "TestClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vcmBaseMenuForChromeLike
 {$IfEnd} // NOT Defined(NoVGScene)
 , vcmMenuForChromeLikeItemWrap
;

type
 // TvcmBaseMenuForChromeLike
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
