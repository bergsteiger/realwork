unit NOT_FINISHED_dt_Jour;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_Jour.pas"
// ���������: "UtilityPack"
// ������� ������: "dt_Jour" MUID: (51B6C800005F)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TAbstractJournal = class
 end;//TAbstractJournal

 EdtBrokenFileLock = class
 end;//EdtBrokenFileLock
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *51B6C800005Fimpl_uses*
 //#UC END# *51B6C800005Fimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
