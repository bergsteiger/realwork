unit NOT_FINISHED_csExport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csExport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csExport" MUID: (530355040385)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csExportTaskPrim
;

type
 TcsExport = class(TcsExportTaskPrim)
 end;//TcsExport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *530355040385impl_uses*
 //#UC END# *530355040385impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
