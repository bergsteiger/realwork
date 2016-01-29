unit AnnotationTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AnnotationTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AnnotationTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AnnotationTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrNeedReport: Integer;

function k2_attrIsSuccess: Integer;

function k2_attrNextDate: Integer;

function k2_attrReportMessage: Integer;

function k2_attrReportSubject: Integer;

function k2_attrReportAttach: Integer;

function k2_attrNeedSendToRobot: Integer;

function k2_attrRobotMessage: Integer;

function k2_attrRobotAttach: Integer;

function k2_typAnnotationTaskResult: AnnotationTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AnnotationTaskResult : AnnotationTaskResultTag = nil;

// start class AnnotationTaskResultTag

function k2_typAnnotationTaskResult: AnnotationTaskResultTag;
begin
 if (g_AnnotationTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnnotationTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnnotationTaskResult;
 end;//g_AnnotationTaskResult = nil
 Result := g_AnnotationTaskResult;
end;
var
 g_k2_attrNeedReport: Integer = -1;

function k2_attrNeedReport: Integer;
begin
 if (g_k2_attrNeedReport = -1) then
  g_k2_attrNeedReport :=  Tk2Attributes.Instance.CheckIDByName('NeedReport');
 Result := g_k2_attrNeedReport;
end;

var
 g_k2_attrIsSuccess: Integer = -1;

function k2_attrIsSuccess: Integer;
begin
 if (g_k2_attrIsSuccess = -1) then
  g_k2_attrIsSuccess :=  Tk2Attributes.Instance.CheckIDByName('IsSuccess');
 Result := g_k2_attrIsSuccess;
end;

var
 g_k2_attrNextDate: Integer = -1;

function k2_attrNextDate: Integer;
begin
 if (g_k2_attrNextDate = -1) then
  g_k2_attrNextDate :=  Tk2Attributes.Instance.CheckIDByName('NextDate');
 Result := g_k2_attrNextDate;
end;

var
 g_k2_attrReportMessage: Integer = -1;

function k2_attrReportMessage: Integer;
begin
 if (g_k2_attrReportMessage = -1) then
  g_k2_attrReportMessage :=  Tk2Attributes.Instance.CheckIDByName('ReportMessage');
 Result := g_k2_attrReportMessage;
end;

var
 g_k2_attrReportSubject: Integer = -1;

function k2_attrReportSubject: Integer;
begin
 if (g_k2_attrReportSubject = -1) then
  g_k2_attrReportSubject :=  Tk2Attributes.Instance.CheckIDByName('ReportSubject');
 Result := g_k2_attrReportSubject;
end;

var
 g_k2_attrReportAttach: Integer = -1;

function k2_attrReportAttach: Integer;
begin
 if (g_k2_attrReportAttach = -1) then
  g_k2_attrReportAttach :=  Tk2Attributes.Instance.CheckIDByName('ReportAttach');
 Result := g_k2_attrReportAttach;
end;

var
 g_k2_attrNeedSendToRobot: Integer = -1;

function k2_attrNeedSendToRobot: Integer;
begin
 if (g_k2_attrNeedSendToRobot = -1) then
  g_k2_attrNeedSendToRobot :=  Tk2Attributes.Instance.CheckIDByName('NeedSendToRobot');
 Result := g_k2_attrNeedSendToRobot;
end;

var
 g_k2_attrRobotMessage: Integer = -1;

function k2_attrRobotMessage: Integer;
begin
 if (g_k2_attrRobotMessage = -1) then
  g_k2_attrRobotMessage :=  Tk2Attributes.Instance.CheckIDByName('RobotMessage');
 Result := g_k2_attrRobotMessage;
end;

var
 g_k2_attrRobotAttach: Integer = -1;

function k2_attrRobotAttach: Integer;
begin
 if (g_k2_attrRobotAttach = -1) then
  g_k2_attrRobotAttach :=  Tk2Attributes.Instance.CheckIDByName('RobotAttach');
 Result := g_k2_attrRobotAttach;
end;


end.