unit NOT_FINISHED_csExport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csExport.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
