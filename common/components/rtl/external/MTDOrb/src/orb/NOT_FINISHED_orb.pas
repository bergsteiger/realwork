unit NOT_FINISHED_orb;

// Модуль: "w:\common\components\rtl\external\MTDOrb\src\orb\NOT_FINISHED_orb.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "orb" MUID: (4CA0D35D00BF)

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , orb_int
 , Classes
;

type
 TLocalORBObject = class
 end;//TLocalORBObject

function ORB_Init(props: TStrings): IORB;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;

function ORB_Init(props: TStrings): IORB;
//#UC START# *4CA1CCDD0268_4CA0D35D00BF_var*
//#UC END# *4CA1CCDD0268_4CA0D35D00BF_var*
begin
//#UC START# *4CA1CCDD0268_4CA0D35D00BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA1CCDD0268_4CA0D35D00BF_impl*
end;//ORB_Init
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
