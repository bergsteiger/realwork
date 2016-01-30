unit nevSelection_p;
 {* Выделение в редакторе }

// Модуль: "w:\common\components\gui\Garant\Everest\nevSelection_p.pas"
// Стереотип: "TestClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , nevSelection
 , nevBase
 , afwCaret
;

type
 // TnevSelection
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , k2Tags
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE)

end.
