unit alcuAutoClassTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAutoClassTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , AutoClassTaskResult_Const
 , evdTasksHelpers
 , k2Base
;

type
 TalcuAutoClassTaskResult = class(TcsTaskResult)
  protected
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetMissedDocsStr: AnsiString;
   procedure pm_SetMissedDocsStr(const aValue: AnsiString);
   function pm_GetDocumentIDList: DocumentIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property MissedDocsStr: AnsiString
    read pm_GetMissedDocsStr
    write pm_SetMissedDocsStr;
   property DocumentIDList: DocumentIDListHelper
    read pm_GetDocumentIDList;
 end;//TalcuAutoClassTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

function TalcuAutoClassTaskResult.pm_GetReportMessage: AnsiString;
//#UC START# *0632E6B8F326_53F472280036get_var*
//#UC END# *0632E6B8F326_53F472280036get_var*
begin
//#UC START# *0632E6B8F326_53F472280036get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0632E6B8F326_53F472280036get_impl*
end;//TalcuAutoClassTaskResult.pm_GetReportMessage

procedure TalcuAutoClassTaskResult.pm_SetReportMessage(const aValue: AnsiString);
//#UC START# *0632E6B8F326_53F472280036set_var*
//#UC END# *0632E6B8F326_53F472280036set_var*
begin
//#UC START# *0632E6B8F326_53F472280036set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0632E6B8F326_53F472280036set_impl*
end;//TalcuAutoClassTaskResult.pm_SetReportMessage

function TalcuAutoClassTaskResult.pm_GetMissedDocsStr: AnsiString;
//#UC START# *10D805489FFC_53F472280036get_var*
//#UC END# *10D805489FFC_53F472280036get_var*
begin
//#UC START# *10D805489FFC_53F472280036get_impl*
 !!! Needs to be implemented !!!
//#UC END# *10D805489FFC_53F472280036get_impl*
end;//TalcuAutoClassTaskResult.pm_GetMissedDocsStr

procedure TalcuAutoClassTaskResult.pm_SetMissedDocsStr(const aValue: AnsiString);
//#UC START# *10D805489FFC_53F472280036set_var*
//#UC END# *10D805489FFC_53F472280036set_var*
begin
//#UC START# *10D805489FFC_53F472280036set_impl*
 !!! Needs to be implemented !!!
//#UC END# *10D805489FFC_53F472280036set_impl*
end;//TalcuAutoClassTaskResult.pm_SetMissedDocsStr

function TalcuAutoClassTaskResult.pm_GetDocumentIDList: DocumentIDListHelper;
//#UC START# *A47CDE8B8269_53F472280036get_var*
//#UC END# *A47CDE8B8269_53F472280036get_var*
begin
//#UC START# *A47CDE8B8269_53F472280036get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A47CDE8B8269_53F472280036get_impl*
end;//TalcuAutoClassTaskResult.pm_GetDocumentIDList

class function TalcuAutoClassTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53F472280036_var*
//#UC END# *53AC03EE01FD_53F472280036_var*
begin
//#UC START# *53AC03EE01FD_53F472280036_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53F472280036_impl*
end;//TalcuAutoClassTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
