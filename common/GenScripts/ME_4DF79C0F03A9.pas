unit tfwKConst;
 {* Константы для общения тестового фреймфорка с К }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\tfwKConst.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

const
{$If Defined(Archi)}
 KUser = 'architester';
 KUserPassword = '6v2K3024';
{$IfEnd} // Defined(Archi)
{$If Defined(Nemesis) AND Defined(InsiderTest)}
 KUser = 'f1tester';
 KUserPassword = 'f1_tester_user';
{$IfEnd} // Defined(Nemesis) AND Defined(InsiderTest)
{$If NOT Defined(Nemesis) AND NOT Defined(Archi) AND NOT Defined(EverestLite)}
 KUser = '';
 KUserPassword = '';
{$IfEnd} // NOT Defined(Nemesis) AND NOT Defined(Archi) AND NOT Defined(EverestLite)
{$If Defined(Nemesis) AND NOT Defined(InsiderTest)}
 KUser = 'shdtester';
 KUserPassword = 'shdtester';
{$IfEnd} // Defined(Nemesis) AND NOT Defined(InsiderTest)
{$If Defined(EverestLite)}
 KUser = 'architester';
 KUserPassword = '6v2K3024';
{$IfEnd} // Defined(EverestLite)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
