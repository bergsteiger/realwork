unit NOT_FINISHED_csSpellCorrectTask;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csSpellCorrectTask.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csSpellCorrectTaskPrim
;

type
 TcsSpellCorrectTask = class(TcsSpellCorrectTaskPrim)
 end;//TcsSpellCorrectTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
