unit eeSubExport;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSubExport.pas"
// Стереотип: "SimpleClass"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evSubImplementation
;

type
 TeeSubExport = class(TevSubImplementation)
 end;//TeeSubExport
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
