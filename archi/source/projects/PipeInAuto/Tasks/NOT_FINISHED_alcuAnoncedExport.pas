unit NOT_FINISHED_alcuAnoncedExport;

// ������: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAnoncedExport.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuAnoncedExport" MUID: (5305ABFD00F1)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuExport
 , alcuAnoncedExportPrim
;

type
 TalcuAnoncedExport = class(TalcuExport)
 end;//TalcuAnoncedExport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 //#UC START# *5305ABFD00F1impl_uses*
 //#UC END# *5305ABFD00F1impl_uses*
;
{$IfEnd} // Defined(ServerTasks)

end.
