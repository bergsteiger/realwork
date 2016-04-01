unit NOT_COMPLETED_csUserDefinedExport;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csUserDefinedExport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUserDefinedExport" MUID: (53B26E050371)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csUserDefinedExportTaskPrim
;

type
 TcsUserDefinedExport = class(TcsUserDefinedExportTaskPrim)
 end;//TcsUserDefinedExport
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
