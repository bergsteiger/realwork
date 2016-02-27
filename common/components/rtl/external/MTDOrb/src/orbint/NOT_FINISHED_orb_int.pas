unit NOT_FINISHED_orb_int;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\orbint\NOT_FINISHED_orb_int.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 IORB = interface
  ['{C15E149E-1B9A-444D-AF9E-03FA901B8775}']
 end;//IORB

 IORBObject = interface
  ['{95F4B62E-65BC-44DF-9890-76F757494DDA}']
 end;//IORBObject
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
