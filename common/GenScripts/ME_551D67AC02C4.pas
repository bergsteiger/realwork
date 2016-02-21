unit ChromeLikeTab_p;

// Модуль: "w:\common\components\gui\Garant\VCM\ChromeLikeTab_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , ChromeLikeTabSetControl
 {$IfEnd} // NOT Defined(NoVGScene)
 , RectWrap
;

type
 // TChromeLikeTab
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
