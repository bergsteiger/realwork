unit NOT_COMPLETED_csSpellCorrectTask;

// ������: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csSpellCorrectTask.pas"
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
