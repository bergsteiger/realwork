unit csMessage_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMessage_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMessage .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMessage_Kind: csMessage_Kind_Tag;

function k2_attrKind: Integer;

function k2_attrMessageID: Integer;

function k2_attrTimeStamp: Integer;
function k2_typcsMessage: csMessageTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMessage : csMessageTag = nil;

// start class csMessageTag

function k2_typcsMessage: csMessageTag;
begin
 if (g_csMessage = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMessage := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMessage;
 end;//g_csMessage = nil
 Result := g_csMessage;
end;
var
 g_k2_attrKind: Integer = -1;

function k2_attrKind: Integer;
begin
 if (g_k2_attrKind = -1) then
  g_k2_attrKind :=  Tk2Attributes.Instance.CheckIDByName('Kind');
 Result := g_k2_attrKind;
end;

var
 g_k2_attrMessageID: Integer = -1;

function k2_attrMessageID: Integer;
begin
 if (g_k2_attrMessageID = -1) then
  g_k2_attrMessageID :=  Tk2Attributes.Instance.CheckIDByName('MessageID');
 Result := g_k2_attrMessageID;
end;

var
 g_k2_attrTimeStamp: Integer = -1;

function k2_attrTimeStamp: Integer;
begin
 if (g_k2_attrTimeStamp = -1) then
  g_k2_attrTimeStamp :=  Tk2Attributes.Instance.CheckIDByName('TimeStamp');
 Result := g_k2_attrTimeStamp;
end;


var
 g_csMessage_Kind : csMessage_Kind_Tag = nil;

// start class Kind

function k2_typcsMessage_Kind: csMessage_Kind_Tag;
begin
 if (g_csMessage_Kind = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMessage_Kind := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMessage_Kind;
 end;//g_csMessage = nil
 Result := g_csMessage_Kind;
end;


end.