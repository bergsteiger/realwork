unit Component_p;

// Модуль: "w:\common\components\gui\Garant\AFW\Component_p.pas"
// Стереотип: "TestClass"

{$Include l3Define.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , Classes
;

type
 // TComponent
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
