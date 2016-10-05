unit csMultiClearAttributesReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiClearAttributesReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiClearAttributesReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiClearAttributesReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiClearAttributesReply_RejectedIDList: csMultiClearAttributesReply_RejectedIDList_Tag;

function k2_attrRejectedIDList: Integer;

function k2_attrIsSuccess: Integer;

function k2_attrErrorMessage: Integer;
function k2_typcsMultiClearAttributesReply: csMultiClearAttributesReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiClearAttributesReply : csMultiClearAttributesReplyTag = nil;

// start class csMultiClearAttributesReplyTag

function k2_typcsMultiClearAttributesReply: csMultiClearAttributesReplyTag;
begin
 if (g_csMultiClearAttributesReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiClearAttributesReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiClearAttributesReply;
 end;//g_csMultiClearAttributesReply = nil
 Result := g_csMultiClearAttributesReply;
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
 g_csMultiClearAttributesReply_RejectedIDList : csMultiClearAttributesReply_RejectedIDList_Tag = nil;

// start class RejectedIDList

function k2_typcsMultiClearAttributesReply_RejectedIDList: csMultiClearAttributesReply_RejectedIDList_Tag;
begin
 if (g_csMultiClearAttributesReply_RejectedIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiClearAttributesReply_RejectedIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiClearAttributesReply_RejectedIDList;
 end;//g_csMultiClearAttributesReply = nil
 Result := g_csMultiClearAttributesReply_RejectedIDList;
end;


end.