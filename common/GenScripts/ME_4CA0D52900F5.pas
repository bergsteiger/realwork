unit NOT_FINISHED_orbtypes;

// ������: "w:\common\components\rtl\external\MTDOrb\src\orb\NOT_FINISHED_orbtypes.pas"
// ���������: "Interfaces"
// ������� ������: "orbtypes" MUID: (4CA0D52900F5)

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 ServiceContext = record
 end;//ServiceContext

 ServiceId = ;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
