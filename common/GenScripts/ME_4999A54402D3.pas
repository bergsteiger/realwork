unit afwCaret_p;

// Модуль: "w:\common\components\gui\Garant\Everest\afwCaret_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , afwCaret
 , afwInsCaretType
 , afwOvrCaretType
;

type
 // TafwCaret
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
