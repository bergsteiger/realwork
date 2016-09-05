unit NOT_FINISHED_csAutoSpell;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csAutoSpell.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csAutoSpell" MUID: (5317062900DF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csAutoSpellTaskPrim
;

type
 TcsAutoSpellTask = class(TcsAutoSpellTaskPrim)
 end;//TcsAutoSpellTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5317062900DFimpl_uses*
 //#UC END# *5317062900DFimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
