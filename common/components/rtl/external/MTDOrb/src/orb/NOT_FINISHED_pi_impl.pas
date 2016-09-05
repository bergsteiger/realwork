unit NOT_FINISHED_pi_impl;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\orb\NOT_FINISHED_pi_impl.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "pi_impl" MUID: (4CA0D8A80194)

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 TPIManager = class
 end;//TPIManager
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 //#UC START# *4CA0D8A80194impl_uses*
 //#UC END# *4CA0D8A80194impl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
