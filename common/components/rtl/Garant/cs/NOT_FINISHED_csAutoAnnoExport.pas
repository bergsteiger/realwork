unit NOT_FINISHED_csAutoAnnoExport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csAutoAnnoExport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csAutoAnnoExport" MUID: (5317037001E5)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csAutoAnnoExportPrim
;

type
 TcsAutoAnnoExport = class(TcsAutoAnnoExportPrim)
 end;//TcsAutoAnnoExport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5317037001E5impl_uses*
 //#UC END# *5317037001E5impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
