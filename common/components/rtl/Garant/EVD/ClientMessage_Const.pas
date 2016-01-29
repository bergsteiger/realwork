unit ClientMessage_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ClientMessage_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::ClientMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ClientMessage .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typClientMessage_NotifyType: ClientMessage_NotifyType_Tag;

function k2_attrNotifyType: Integer;

function k2_attrData: Integer;

function k2_attrText: Integer;
function k2_typClientMessage: ClientMessageTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ClientMessage : ClientMessageTag = nil;

// start class ClientMessageTag

function k2_typClientMessage: ClientMessageTag;
begin
 if (g_ClientMessage = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ClientMessage := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ClientMessage;
 end;//g_ClientMessage = nil
 Result := g_ClientMessage;
end;
var
 g_k2_attrNotifyType: Integer = -1;

function k2_attrNotifyType: Integer;
begin
 if (g_k2_attrNotifyType = -1) then
  g_k2_attrNotifyType :=  Tk2Attributes.Instance.CheckIDByName('NotifyType');
 Result := g_k2_attrNotifyType;
end;

var
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;

var
 g_k2_attrText: Integer = -1;

function k2_attrText: Integer;
begin
 if (g_k2_attrText = -1) then
  g_k2_attrText :=  Tk2Attributes.Instance.CheckIDByName('Text');
 Result := g_k2_attrText;
end;


var
 g_ClientMessage_NotifyType : ClientMessage_NotifyType_Tag = nil;

// start class NotifyType

function k2_typClientMessage_NotifyType: ClientMessage_NotifyType_Tag;
begin
 if (g_ClientMessage_NotifyType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ClientMessage_NotifyType := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ClientMessage_NotifyType;
 end;//g_ClientMessage = nil
 Result := g_ClientMessage_NotifyType;
end;


end.