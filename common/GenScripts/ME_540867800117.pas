unit alcuRegionImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuRegionImportTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , alcuImportTaskResult
 , k2Base
;

type
 TalcuRegionImportTaskResult = class(TalcuImportTaskResult)
  protected
   function pm_GetHasMoreFilesToProcess: Boolean;
   procedure pm_SetHasMoreFilesToProcess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property HasMoreFilesToProcess: Boolean
    read pm_GetHasMoreFilesToProcess
    write pm_SetHasMoreFilesToProcess;
 end;//TalcuRegionImportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , RegionImportTaskResult_Const
;

function TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess: Boolean;
//#UC START# *21C8D96C6236_540867800117get_var*
//#UC END# *21C8D96C6236_540867800117get_var*
begin
//#UC START# *21C8D96C6236_540867800117get_impl*
 !!! Needs to be implemented !!!
//#UC END# *21C8D96C6236_540867800117get_impl*
end;//TalcuRegionImportTaskResult.pm_GetHasMoreFilesToProcess

procedure TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess(aValue: Boolean);
//#UC START# *21C8D96C6236_540867800117set_var*
//#UC END# *21C8D96C6236_540867800117set_var*
begin
//#UC START# *21C8D96C6236_540867800117set_impl*
 !!! Needs to be implemented !!!
//#UC END# *21C8D96C6236_540867800117set_impl*
end;//TalcuRegionImportTaskResult.pm_SetHasMoreFilesToProcess

class function TalcuRegionImportTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_540867800117_var*
//#UC END# *53AC03EE01FD_540867800117_var*
begin
//#UC START# *53AC03EE01FD_540867800117_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_540867800117_impl*
end;//TalcuRegionImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
