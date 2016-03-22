unit AutoSpellTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoSpellTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AutoSpellTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoSpellTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrReportMessage: Integer;

function k2_attrReportAttach: Integer;

function k2_typAutoSpellTaskResult: AutoSpellTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoSpellTaskResult : AutoSpellTaskResultTag = nil;

// start class AutoSpellTaskResultTag

function k2_typAutoSpellTaskResult: AutoSpellTaskResultTag;
begin
 if (g_AutoSpellTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoSpellTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoSpellTaskResult;
 end;//g_AutoSpellTaskResult = nil
 Result := g_AutoSpellTaskResult;
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
 g_k2_attrReportAttach: Integer = -1;

function k2_attrReportAttach: Integer;
begin
 if (g_k2_attrReportAttach = -1) then
  g_k2_attrReportAttach :=  Tk2Attributes.Instance.CheckIDByName('ReportAttach');
 Result := g_k2_attrReportAttach;
end;


end.