unit alcuAnnotationTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAnnotationTaskResult.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
 , AnnotationTaskResult_Const
 , k2Base
;

type
 TalcuAnnotationTaskResult = class(TcsTaskResult)
  protected
   function pm_GetNeedReport: Boolean;
   procedure pm_SetNeedReport(aValue: Boolean);
   function pm_GetIsSuccess: Boolean;
   procedure pm_SetIsSuccess(aValue: Boolean);
   function pm_GetNextDate: TDateTime;
   procedure pm_SetNextDate(aValue: TDateTime);
   function pm_GetReportMessage: AnsiString;
   procedure pm_SetReportMessage(const aValue: AnsiString);
   function pm_GetReportSubject: AnsiString;
   procedure pm_SetReportSubject(const aValue: AnsiString);
   function pm_GetReportAttach: AnsiString;
   procedure pm_SetReportAttach(const aValue: AnsiString);
   function pm_GetNeedSendToRobot: Boolean;
   procedure pm_SetNeedSendToRobot(aValue: Boolean);
   function pm_GetRobotMessage: AnsiString;
   procedure pm_SetRobotMessage(const aValue: AnsiString);
   function pm_GetRobotAttach: AnsiString;
   procedure pm_SetRobotAttach(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property NeedReport: Boolean
    read pm_GetNeedReport
    write pm_SetNeedReport;
   property IsSuccess: Boolean
    read pm_GetIsSuccess
    write pm_SetIsSuccess;
   property NextDate: TDateTime
    read pm_GetNextDate
    write pm_SetNextDate;
   property ReportMessage: AnsiString
    read pm_GetReportMessage
    write pm_SetReportMessage;
   property ReportSubject: AnsiString
    read pm_GetReportSubject
    write pm_SetReportSubject;
   property ReportAttach: AnsiString
    read pm_GetReportAttach
    write pm_SetReportAttach;
   property NeedSendToRobot: Boolean
    read pm_GetNeedSendToRobot
    write pm_SetNeedSendToRobot;
   property RobotMessage: AnsiString
    read pm_GetRobotMessage
    write pm_SetRobotMessage;
   property RobotAttach: AnsiString
    read pm_GetRobotAttach
    write pm_SetRobotAttach;
 end;//TalcuAnnotationTaskResult
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;

function TalcuAnnotationTaskResult.pm_GetNeedReport: Boolean;
//#UC START# *156110995BB9_53F6EDF00042get_var*
//#UC END# *156110995BB9_53F6EDF00042get_var*
begin
//#UC START# *156110995BB9_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *156110995BB9_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetNeedReport

procedure TalcuAnnotationTaskResult.pm_SetNeedReport(aValue: Boolean);
//#UC START# *156110995BB9_53F6EDF00042set_var*
//#UC END# *156110995BB9_53F6EDF00042set_var*
begin
//#UC START# *156110995BB9_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *156110995BB9_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetNeedReport

function TalcuAnnotationTaskResult.pm_GetIsSuccess: Boolean;
//#UC START# *7C0B1CBBB3D8_53F6EDF00042get_var*
//#UC END# *7C0B1CBBB3D8_53F6EDF00042get_var*
begin
//#UC START# *7C0B1CBBB3D8_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C0B1CBBB3D8_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetIsSuccess

procedure TalcuAnnotationTaskResult.pm_SetIsSuccess(aValue: Boolean);
//#UC START# *7C0B1CBBB3D8_53F6EDF00042set_var*
//#UC END# *7C0B1CBBB3D8_53F6EDF00042set_var*
begin
//#UC START# *7C0B1CBBB3D8_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C0B1CBBB3D8_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetIsSuccess

function TalcuAnnotationTaskResult.pm_GetNextDate: TDateTime;
//#UC START# *31A771BF25F3_53F6EDF00042get_var*
//#UC END# *31A771BF25F3_53F6EDF00042get_var*
begin
//#UC START# *31A771BF25F3_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *31A771BF25F3_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetNextDate

procedure TalcuAnnotationTaskResult.pm_SetNextDate(aValue: TDateTime);
//#UC START# *31A771BF25F3_53F6EDF00042set_var*
//#UC END# *31A771BF25F3_53F6EDF00042set_var*
begin
//#UC START# *31A771BF25F3_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *31A771BF25F3_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetNextDate

function TalcuAnnotationTaskResult.pm_GetReportMessage: AnsiString;
//#UC START# *1F0D535E162C_53F6EDF00042get_var*
//#UC END# *1F0D535E162C_53F6EDF00042get_var*
begin
//#UC START# *1F0D535E162C_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F0D535E162C_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetReportMessage

procedure TalcuAnnotationTaskResult.pm_SetReportMessage(const aValue: AnsiString);
//#UC START# *1F0D535E162C_53F6EDF00042set_var*
//#UC END# *1F0D535E162C_53F6EDF00042set_var*
begin
//#UC START# *1F0D535E162C_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F0D535E162C_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetReportMessage

function TalcuAnnotationTaskResult.pm_GetReportSubject: AnsiString;
//#UC START# *8B16BDD7D790_53F6EDF00042get_var*
//#UC END# *8B16BDD7D790_53F6EDF00042get_var*
begin
//#UC START# *8B16BDD7D790_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B16BDD7D790_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetReportSubject

procedure TalcuAnnotationTaskResult.pm_SetReportSubject(const aValue: AnsiString);
//#UC START# *8B16BDD7D790_53F6EDF00042set_var*
//#UC END# *8B16BDD7D790_53F6EDF00042set_var*
begin
//#UC START# *8B16BDD7D790_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B16BDD7D790_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetReportSubject

function TalcuAnnotationTaskResult.pm_GetReportAttach: AnsiString;
//#UC START# *8E44E53AF039_53F6EDF00042get_var*
//#UC END# *8E44E53AF039_53F6EDF00042get_var*
begin
//#UC START# *8E44E53AF039_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E44E53AF039_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetReportAttach

procedure TalcuAnnotationTaskResult.pm_SetReportAttach(const aValue: AnsiString);
//#UC START# *8E44E53AF039_53F6EDF00042set_var*
//#UC END# *8E44E53AF039_53F6EDF00042set_var*
begin
//#UC START# *8E44E53AF039_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E44E53AF039_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetReportAttach

function TalcuAnnotationTaskResult.pm_GetNeedSendToRobot: Boolean;
//#UC START# *216474BE6E34_53F6EDF00042get_var*
//#UC END# *216474BE6E34_53F6EDF00042get_var*
begin
//#UC START# *216474BE6E34_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *216474BE6E34_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetNeedSendToRobot

procedure TalcuAnnotationTaskResult.pm_SetNeedSendToRobot(aValue: Boolean);
//#UC START# *216474BE6E34_53F6EDF00042set_var*
//#UC END# *216474BE6E34_53F6EDF00042set_var*
begin
//#UC START# *216474BE6E34_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *216474BE6E34_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetNeedSendToRobot

function TalcuAnnotationTaskResult.pm_GetRobotMessage: AnsiString;
//#UC START# *9384C570A604_53F6EDF00042get_var*
//#UC END# *9384C570A604_53F6EDF00042get_var*
begin
//#UC START# *9384C570A604_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9384C570A604_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetRobotMessage

procedure TalcuAnnotationTaskResult.pm_SetRobotMessage(const aValue: AnsiString);
//#UC START# *9384C570A604_53F6EDF00042set_var*
//#UC END# *9384C570A604_53F6EDF00042set_var*
begin
//#UC START# *9384C570A604_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9384C570A604_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetRobotMessage

function TalcuAnnotationTaskResult.pm_GetRobotAttach: AnsiString;
//#UC START# *BBA3EEE1D19D_53F6EDF00042get_var*
//#UC END# *BBA3EEE1D19D_53F6EDF00042get_var*
begin
//#UC START# *BBA3EEE1D19D_53F6EDF00042get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BBA3EEE1D19D_53F6EDF00042get_impl*
end;//TalcuAnnotationTaskResult.pm_GetRobotAttach

procedure TalcuAnnotationTaskResult.pm_SetRobotAttach(const aValue: AnsiString);
//#UC START# *BBA3EEE1D19D_53F6EDF00042set_var*
//#UC END# *BBA3EEE1D19D_53F6EDF00042set_var*
begin
//#UC START# *BBA3EEE1D19D_53F6EDF00042set_impl*
 !!! Needs to be implemented !!!
//#UC END# *BBA3EEE1D19D_53F6EDF00042set_impl*
end;//TalcuAnnotationTaskResult.pm_SetRobotAttach

class function TalcuAnnotationTaskResult.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53F6EDF00042_var*
//#UC END# *53AC03EE01FD_53F6EDF00042_var*
begin
//#UC START# *53AC03EE01FD_53F6EDF00042_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53F6EDF00042_impl*
end;//TalcuAnnotationTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
