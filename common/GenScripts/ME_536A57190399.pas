unit vgRemindersLine_p;

// ������: "w:\common\components\gui\Garant\VT\vgRemindersLine_p.pas"
// ���������: "TestClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLine
 {$IfEnd} // NOT Defined(NoVGScene)
;

type
 // TvgRemindersLine
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
