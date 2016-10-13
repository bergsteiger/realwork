unit csMultiOperationReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiOperationReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiOperationReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiOperationReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiOperationReply_RejectedIDList: csMultiOperationReply_RejectedIDList_Tag;

function k2_attrIsSuccess: Integer;

function k2_attrErrorMessage: Integer;

function k2_attrRejectedIDList: Integer;

function k2_attrProcessedCount: Integer;
function k2_typcsMultiOperationReply: csMultiOperationReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiOperationReply : csMultiOperationReplyTag = nil;

// start class csMultiOperationReplyTag

function k2_typcsMultiOperationReply: csMultiOperationReplyTag;
begin
 if (g_csMultiOperationReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiOperationReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiOperationReply;
 end;//g_csMultiOperationReply = nil
 Result := g_csMultiOperationReply;
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
 g_k2_attrErrorMessage: Integer = -1;

function k2_attrErrorMessage: Integer;
begin
 if (g_k2_attrErrorMessage = -1) then
  g_k2_attrErrorMessage :=  Tk2Attributes.Instance.CheckIDByName('ErrorMessage');
 Result := g_k2_attrErrorMessage;
end;

var
 g_k2_attrRejectedIDList: Integer = -1;

function k2_attrRejectedIDList: Integer;
begin
 if (g_k2_attrRejectedIDList = -1) then
  g_k2_attrRejectedIDList :=  Tk2Attributes.Instance.CheckIDByName('RejectedIDList');
 Result := g_k2_attrRejectedIDList;
end;

var
 g_k2_attrProcessedCount: Integer = -1;

function k2_attrProcessedCount: Integer;
begin
 if (g_k2_attrProcessedCount = -1) then
  g_k2_attrProcessedCount :=  Tk2Attributes.Instance.CheckIDByName('ProcessedCount');
 Result := g_k2_attrProcessedCount;
end;


var
 g_csMultiOperationReply_RejectedIDList : csMultiOperationReply_RejectedIDList_Tag = nil;

// start class RejectedIDList

function k2_typcsMultiOperationReply_RejectedIDList: csMultiOperationReply_RejectedIDList_Tag;
begin
 if (g_csMultiOperationReply_RejectedIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiOperationReply_RejectedIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiOperationReply_RejectedIDList;
 end;//g_csMultiOperationReply = nil
 Result := g_csMultiOperationReply_RejectedIDList;
end;


end.