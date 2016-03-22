unit ProcessTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ProcessTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::ProcessTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ProcessTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typProcessTask_Status: ProcessTask_Status_Tag;

function k2_typProcessTask_DocumentIDList: ProcessTask_DocumentIDList_Tag;

function k2_attrComment: Integer;

function k2_attrStatus: Integer;

function k2_attrDocumentIDList: Integer;

function k2_attrReplyAddress: Integer;
function k2_typProcessTask: ProcessTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ProcessTask : ProcessTaskTag = nil;

// start class ProcessTaskTag

function k2_typProcessTask: ProcessTaskTag;
begin
 if (g_ProcessTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ProcessTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ProcessTask;
 end;//g_ProcessTask = nil
 Result := g_ProcessTask;
end;
var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
end;

var
 g_k2_attrStatus: Integer = -1;

function k2_attrStatus: Integer;
begin
 if (g_k2_attrStatus = -1) then
  g_k2_attrStatus :=  Tk2Attributes.Instance.CheckIDByName('Status');
 Result := g_k2_attrStatus;
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
 g_k2_attrReplyAddress: Integer = -1;

function k2_attrReplyAddress: Integer;
begin
 if (g_k2_attrReplyAddress = -1) then
  g_k2_attrReplyAddress :=  Tk2Attributes.Instance.CheckIDByName('ReplyAddress');
 Result := g_k2_attrReplyAddress;
end;


var
 g_ProcessTask_Status : ProcessTask_Status_Tag = nil;

// start class Status

function k2_typProcessTask_Status: ProcessTask_Status_Tag;
begin
 if (g_ProcessTask_Status = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ProcessTask_Status := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ProcessTask_Status;
 end;//g_ProcessTask = nil
 Result := g_ProcessTask_Status;
end;

var
 g_ProcessTask_DocumentIDList : ProcessTask_DocumentIDList_Tag = nil;

// start class DocumentIDList

function k2_typProcessTask_DocumentIDList: ProcessTask_DocumentIDList_Tag;
begin
 if (g_ProcessTask_DocumentIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ProcessTask_DocumentIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ProcessTask_DocumentIDList;
 end;//g_ProcessTask = nil
 Result := g_ProcessTask_DocumentIDList;
end;


end.