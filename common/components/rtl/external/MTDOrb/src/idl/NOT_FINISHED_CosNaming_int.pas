unit NOT_FINISHED_CosNaming_int;

// ������: "w:\common\components\rtl\external\MTDOrb\src\idl\NOT_FINISHED_CosNaming_int.pas"
// ���������: "UtilityPack"
// ������� ������: "CosNaming_int" MUID: (4CA1CBA90131)

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 INamingContext = interface
  ['{0384D0BB-0399-4340-8D2D-1DDCEAFAE2D6}']
 end;//INamingContext

 TName = record
 end;//TName
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 //#UC START# *4CA1CBA90131impl_uses*
 //#UC END# *4CA1CBA90131impl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
