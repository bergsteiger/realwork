unit alcuAnnotationTaskResult;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAnnotationTaskResult.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuAnnotationTaskResult" MUID: (53F6EDF00042)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , csTaskResult
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
 , AnnotationTaskResult_Const
;

function TalcuAnnotationTaskResult.pm_GetNeedReport: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedReport]);
end;//TalcuAnnotationTaskResult.pm_GetNeedReport

procedure TalcuAnnotationTaskResult.pm_SetNeedReport(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedReport, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetNeedReport

function TalcuAnnotationTaskResult.pm_GetIsSuccess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsSuccess]);
end;//TalcuAnnotationTaskResult.pm_GetIsSuccess

procedure TalcuAnnotationTaskResult.pm_SetIsSuccess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsSuccess, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetIsSuccess

function TalcuAnnotationTaskResult.pm_GetNextDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrNextDate]);
end;//TalcuAnnotationTaskResult.pm_GetNextDate

procedure TalcuAnnotationTaskResult.pm_SetNextDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrNextDate, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetNextDate

function TalcuAnnotationTaskResult.pm_GetReportMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportMessage]);
end;//TalcuAnnotationTaskResult.pm_GetReportMessage

procedure TalcuAnnotationTaskResult.pm_SetReportMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportMessage, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetReportMessage

function TalcuAnnotationTaskResult.pm_GetReportSubject: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportSubject]);
end;//TalcuAnnotationTaskResult.pm_GetReportSubject

procedure TalcuAnnotationTaskResult.pm_SetReportSubject(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportSubject, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetReportSubject

function TalcuAnnotationTaskResult.pm_GetReportAttach: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReportAttach]);
end;//TalcuAnnotationTaskResult.pm_GetReportAttach

procedure TalcuAnnotationTaskResult.pm_SetReportAttach(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReportAttach, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetReportAttach

function TalcuAnnotationTaskResult.pm_GetNeedSendToRobot: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedSendToRobot]);
end;//TalcuAnnotationTaskResult.pm_GetNeedSendToRobot

procedure TalcuAnnotationTaskResult.pm_SetNeedSendToRobot(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedSendToRobot, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetNeedSendToRobot

function TalcuAnnotationTaskResult.pm_GetRobotMessage: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrRobotMessage]);
end;//TalcuAnnotationTaskResult.pm_GetRobotMessage

procedure TalcuAnnotationTaskResult.pm_SetRobotMessage(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrRobotMessage, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetRobotMessage

function TalcuAnnotationTaskResult.pm_GetRobotAttach: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrRobotAttach]);
end;//TalcuAnnotationTaskResult.pm_GetRobotAttach

procedure TalcuAnnotationTaskResult.pm_SetRobotAttach(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrRobotAttach, nil] := (aValue);
end;//TalcuAnnotationTaskResult.pm_SetRobotAttach

class function TalcuAnnotationTaskResult.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAnnotationTaskResult;
end;//TalcuAnnotationTaskResult.GetTaggedDataType
{$IfEnd} // Defined(ServerTasks)

end.
