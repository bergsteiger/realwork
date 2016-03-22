unit NOT_FINISHED_CosNaming_int;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\idl\NOT_FINISHED_CosNaming_int.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CosNaming_int" MUID: (4CA1CBA90131)

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
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
