unit alcuAutoExportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoExportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAutoExportTaskResult" MUID: (54001C560310)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , k2Base
;

type
 TalcuAutoExportTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
 end;//TalcuAutoExportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , AutoExportTaskResult_Const
;

function TalcuAutoExportTaskResult.pm_GetReportMessage: AnsiString;
//#UC START# *EB77B4B1C662_54001C560310get_var*
//#UC END# *EB77B4B1C662_54001C560310get_var*
begin
//#UC START# *EB77B4B1C662_54001C560310get_impl*
 !!! Needs to be implemented !!!
//#UC END# *EB77B4B1C662_54001C560310get_impl*
end;//TalcuAutoExportTaskResult.pm_GetReportMessage

procedure TalcuAutoExportTaskResult.pm_SetReportMessage(const aValue: AnsiString);
//#UC START# *EB77B4B1C662_54001C560310set_var*
//#UC END# *EB77B4B1C662_54001C560310set_var*
begin
//#UC START# *EB77B4B1C662_54001C560310set_impl*
 !!! Needs to be implemented !!!
//#UC END# *EB77B4B1C662_54001C560310set_impl*
end;//TalcuAutoExportTaskResult.pm_SetReportMessage

function TalcuAutoExportTaskResult.pm_GetIsSuccess: Boolean;
//#UC START# *2004A146699E_54001C560310get_var*
//#UC END# *2004A146699E_54001C560310get_var*
begin
//#UC START# *2004A146699E_54001C560310get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2004A146699E_54001C560310get_impl*
end;//TalcuAutoExportTaskResult.pm_GetIsSuccess

procedure TalcuAutoExportTaskResult.pm_SetIsSuccess(aValue: Boolean);
//#UC START# *2004A146699E_54001C560310set_var*
//#UC END# *2004A146699E_54001C560310set_var*
begin
//#UC START# *2004A146699E_54001C560310set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2004A146699E_54001C560310set_impl*
end;//TalcuAutoExportTaskResult.pm_SetIsSuccess

class function TalcuAutoExportTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54001C560310_var*
//#UC END# *53AC03EE01FD_54001C560310_var*
begin
//#UC START# *53AC03EE01FD_54001C560310_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54001C560310_impl*
end;//TalcuAutoExportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
