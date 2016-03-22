unit AutoExportTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoExportTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AutoExportTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoExportTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrReportMessage: Integer;

function k2_attrIsSuccess: Integer;

function k2_typAutoExportTaskResult: AutoExportTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoExportTaskResult : AutoExportTaskResultTag = nil;

// start class AutoExportTaskResultTag

function k2_typAutoExportTaskResult: AutoExportTaskResultTag;
begin
 if (g_AutoExportTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoExportTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoExportTaskResult;
 end;//g_AutoExportTaskResult = nil
 Result := g_AutoExportTaskResult;
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
 g_k2_attrIsSuccess: Integer = -1;

function k2_attrIsSuccess: Integer;
begin
 if (g_k2_attrIsSuccess = -1) then
  g_k2_attrIsSuccess :=  Tk2Attributes.Instance.CheckIDByName('IsSuccess');
 Result := g_k2_attrIsSuccess;
end;


end.