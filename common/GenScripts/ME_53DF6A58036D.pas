unit alcuHavanskyExportTaskPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuHavanskyExportTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(HavanskyExport)}
uses
 l3IntfUses
 , alcuExport
 , HavanskyExportTask_Const
 , k2Base
;

type
 TalcuHavanskyExportTaskPrim = class(TalcuExport)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TalcuHavanskyExportTaskPrim
{$IfEnd} // Defined(ServerTasks) AND Defined(HavanskyExport)

implementation

{$If Defined(ServerTasks) AND Defined(HavanskyExport)}
uses
 l3ImplUses
;

class function TalcuHavanskyExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53DF6A58036D_var*
//#UC END# *53AC03EE01FD_53DF6A58036D_var*
begin
//#UC START# *53AC03EE01FD_53DF6A58036D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53DF6A58036D_impl*
end;//TalcuHavanskyExportTaskPrim.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks) AND Defined(HavanskyExport)

end.
