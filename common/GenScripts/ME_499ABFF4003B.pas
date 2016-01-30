unit nscNavigatorPageControl_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscNavigatorPageControl_p.pas"
// Стереотип: "TestClass"

{$Include l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , nscNavigator
 , ElPgCtl
;

type
 // TnscNavigatorPageControl
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
