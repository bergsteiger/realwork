unit eeTreeViewExport_p;

// Модуль: "w:\common\components\gui\Garant\Nemesis\eeTreeViewExport_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\Nemesis\l3Define.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3IntfUses
 , eeTreeViewExport
 , l3TreeInterfaces
;

type
 // TeeTreeViewExport
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

implementation

{$If Defined(Nemesis) AND NOT Defined(XE)}
uses
 l3ImplUses
 , nscTaskPanelInterfaces
 , SysUtils
;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(XE)

end.
