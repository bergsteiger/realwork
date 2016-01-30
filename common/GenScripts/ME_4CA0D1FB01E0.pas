unit NOT_FINISHED_pi_int;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\idl\NOT_FINISHED_pi_int.pas"
// Стереотип: "Interfaces"

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 IORBInitInfo = interface
  ['{120E9EB2-D621-4816-8998-92450A60DCC6}']
 end;//IORBInitInfo

 IClientRequestInfo = interface
  ['{29495677-12CA-40E5-A99E-B8482D52AD32}']
 end;//IClientRequestInfo
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
