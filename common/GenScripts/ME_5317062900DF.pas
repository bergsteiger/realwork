unit NOT_FINISHED_csAutoSpell;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csAutoSpell.pas"
// ���������: "UtilityPack"

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
