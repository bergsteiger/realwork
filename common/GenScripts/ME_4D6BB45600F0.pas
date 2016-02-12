unit nscSimpleEditor_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditor_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , nscSimpleEditor
;

type
 // TnscSimpleEditor
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
