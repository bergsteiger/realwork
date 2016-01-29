unit AutoClassTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoClassTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AutoClassTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoClassTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAutoClassTaskResult_DocumentIDList: AutoClassTaskResult_DocumentIDList_Tag;

function k2_attrReportMessage: Integer;

function k2_attrMissedDocsStr: Integer;

function k2_attrDocumentIDList: Integer;
function k2_typAutoClassTaskResult: AutoClassTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoClassTaskResult : AutoClassTaskResultTag = nil;

// start class AutoClassTaskResultTag

function k2_typAutoClassTaskResult: AutoClassTaskResultTag;
begin
 if (g_AutoClassTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoClassTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoClassTaskResult;
 end;//g_AutoClassTaskResult = nil
 Result := g_AutoClassTaskResult;
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
 g_k2_attrMissedDocsStr: Integer = -1;

function k2_attrMissedDocsStr: Integer;
begin
 if (g_k2_attrMissedDocsStr = -1) then
  g_k2_attrMissedDocsStr :=  Tk2Attributes.Instance.CheckIDByName('MissedDocsStr');
 Result := g_k2_attrMissedDocsStr;
end;

var
 g_k2_attrDocumentIDList: Integer = -1;

function k2_attrDocumentIDList: Integer;
begin
 if (g_k2_attrDocumentIDList = -1) then
  g_k2_attrDocumentIDList :=  Tk2Attributes.Instance.CheckIDByName('DocumentIDList');
 Result := g_k2_attrDocumentIDList;
end;


var
 g_AutoClassTaskResult_DocumentIDList : AutoClassTaskResult_DocumentIDList_Tag = nil;

// start class DocumentIDList

function k2_typAutoClassTaskResult_DocumentIDList: AutoClassTaskResult_DocumentIDList_Tag;
begin
 if (g_AutoClassTaskResult_DocumentIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoClassTaskResult_DocumentIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoClassTaskResult_DocumentIDList;
 end;//g_AutoClassTaskResult = nil
 Result := g_AutoClassTaskResult_DocumentIDList;
end;


end.