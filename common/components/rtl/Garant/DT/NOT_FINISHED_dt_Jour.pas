unit NOT_FINISHED_dt_Jour;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_Jour.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dt_Jour" MUID: (51B6C800005F)

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
