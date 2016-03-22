unit NOT_FINISHED_csImport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csImport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csImport" MUID: (530356A1014F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csImportTaskPrim
;

type
 TcsImportTaskItem = class(TcsImportTaskPrim)
 end;//TcsImportTaskItem
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
