unit NOT_FINISHED_csSpellCorrectTask;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csSpellCorrectTask.pas"
// ���������: "SimpleClass"
// ������� ������: "TcsSpellCorrectTask" MUID: (53B254540178)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

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
