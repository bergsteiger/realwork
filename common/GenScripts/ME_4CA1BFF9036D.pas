unit NOT_FINISHED_Contents_int;

// Модуль: "w:\common\components\rtl\Garant\ServerGate\NOT_FINISHED_Contents_int.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Contents_int" MUID: (4CA1BFF9036D)

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 IServerGate_Contents_KPage = interface
  ['{E2284957-394E-44C4-85EE-69FD82DD9D56}']
 end;//IServerGate_Contents_KPage

 IServerGate_Contents_KPageFactoryManagerSrv = interface
  ['{79180EA5-C291-4CB7-9000-29EFC7E58725}']
 end;//IServerGate_Contents_KPageFactoryManagerSrv
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
