unit NOT_COMPLETED_alcuImportTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_COMPLETED_alcuImportTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuImportTaskResult" MUID: (53E1D0D00252)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , evdTasksHelpers
 , k2Base
;

type
 TalcuImportTaskResult = class(TcsTaskResult)
  protected
   function pm_GetMailBody: AnsiString;
   procedure pm_SetMailBody(const aValue: AnsiString);
   function pm_GetImportedDocList: ImportedDocListHelper;
   function pm_GetUserNotification: AnsiString;
   procedure pm_SetUserNotification(const aValue: AnsiString);
   function pm_GetMailSubject: AnsiString;
   procedure pm_SetMailSubject(const aValue: AnsiString);
   function pm_GetEMailSubject: AnsiString;
   procedure pm_SetEMailSubject(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property MailBody: AnsiString
    read pm_GetMailBody
    write pm_SetMailBody;
   property ImportedDocList: ImportedDocListHelper
    read pm_GetImportedDocList;
   property UserNotification: AnsiString
    read pm_GetUserNotification
    write pm_SetUserNotification;
   property MailSubject: AnsiString
    read pm_GetMailSubject
    write pm_SetMailSubject;
   property EMailSubject: AnsiString
    read pm_GetEMailSubject
    write pm_SetEMailSubject;
 end;//TalcuImportTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , ImportTaskResult_Const
;

function TalcuImportTaskResult.pm_GetMailBody: AnsiString;
//#UC START# *AF613FEFED45_53E1D0D00252get_var*
//#UC END# *AF613FEFED45_53E1D0D00252get_var*
begin
//#UC START# *AF613FEFED45_53E1D0D00252get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF613FEFED45_53E1D0D00252get_impl*
end;//TalcuImportTaskResult.pm_GetMailBody

procedure TalcuImportTaskResult.pm_SetMailBody(const aValue: AnsiString);
//#UC START# *AF613FEFED45_53E1D0D00252set_var*
//#UC END# *AF613FEFED45_53E1D0D00252set_var*
begin
//#UC START# *AF613FEFED45_53E1D0D00252set_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF613FEFED45_53E1D0D00252set_impl*
end;//TalcuImportTaskResult.pm_SetMailBody

function TalcuImportTaskResult.pm_GetImportedDocList: ImportedDocListHelper;
//#UC START# *E9096F97F529_53E1D0D00252get_var*
//#UC END# *E9096F97F529_53E1D0D00252get_var*
begin
//#UC START# *E9096F97F529_53E1D0D00252get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9096F97F529_53E1D0D00252get_impl*
end;//TalcuImportTaskResult.pm_GetImportedDocList

function TalcuImportTaskResult.pm_GetUserNotification: AnsiString;
//#UC START# *9D4CEB3DAD3D_53E1D0D00252get_var*
//#UC END# *9D4CEB3DAD3D_53E1D0D00252get_var*
begin
//#UC START# *9D4CEB3DAD3D_53E1D0D00252get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D4CEB3DAD3D_53E1D0D00252get_impl*
end;//TalcuImportTaskResult.pm_GetUserNotification

procedure TalcuImportTaskResult.pm_SetUserNotification(const aValue: AnsiString);
//#UC START# *9D4CEB3DAD3D_53E1D0D00252set_var*
//#UC END# *9D4CEB3DAD3D_53E1D0D00252set_var*
begin
//#UC START# *9D4CEB3DAD3D_53E1D0D00252set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D4CEB3DAD3D_53E1D0D00252set_impl*
end;//TalcuImportTaskResult.pm_SetUserNotification

function TalcuImportTaskResult.pm_GetMailSubject: AnsiString;
//#UC START# *C878B7965184_53E1D0D00252get_var*
//#UC END# *C878B7965184_53E1D0D00252get_var*
begin
//#UC START# *C878B7965184_53E1D0D00252get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C878B7965184_53E1D0D00252get_impl*
end;//TalcuImportTaskResult.pm_GetMailSubject

procedure TalcuImportTaskResult.pm_SetMailSubject(const aValue: AnsiString);
//#UC START# *C878B7965184_53E1D0D00252set_var*
//#UC END# *C878B7965184_53E1D0D00252set_var*
begin
//#UC START# *C878B7965184_53E1D0D00252set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C878B7965184_53E1D0D00252set_impl*
end;//TalcuImportTaskResult.pm_SetMailSubject

function TalcuImportTaskResult.pm_GetEMailSubject: AnsiString;
//#UC START# *0434CD7FED8A_53E1D0D00252get_var*
//#UC END# *0434CD7FED8A_53E1D0D00252get_var*
begin
//#UC START# *0434CD7FED8A_53E1D0D00252get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0434CD7FED8A_53E1D0D00252get_impl*
end;//TalcuImportTaskResult.pm_GetEMailSubject

procedure TalcuImportTaskResult.pm_SetEMailSubject(const aValue: AnsiString);
//#UC START# *0434CD7FED8A_53E1D0D00252set_var*
//#UC END# *0434CD7FED8A_53E1D0D00252set_var*
begin
//#UC START# *0434CD7FED8A_53E1D0D00252set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0434CD7FED8A_53E1D0D00252set_impl*
end;//TalcuImportTaskResult.pm_SetEMailSubject

class function TalcuImportTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53E1D0D00252_var*
//#UC END# *53AC03EE01FD_53E1D0D00252_var*
begin
//#UC START# *53AC03EE01FD_53E1D0D00252_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53E1D0D00252_impl*
end;//TalcuImportTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
