unit vgVisualObject_p;

// Модуль: "w:\common\components\rtl\external\VGScene\vgVisualObject_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgVisualObject
;

type
 // TvgVisualObject
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVGScene)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVGScene)

end.
