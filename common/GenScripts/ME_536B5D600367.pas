unit vgReminder_p;

// Модуль: "w:\common\components\gui\Garant\VT\vgReminder_p.pas"
// Стереотип: "TestClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLine
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_objects
 {$IfEnd} // NOT Defined(NoVGScene)
;

type
 // TvgReminder
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
