unit NOT_FINISHED_csUserDefinedExport;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csUserDefinedExport.pas"
// ���������: "SimpleClass"

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
