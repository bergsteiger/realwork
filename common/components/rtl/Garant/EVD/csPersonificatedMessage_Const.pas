unit csPersonificatedMessage_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csPersonificatedMessage_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csPersonificatedMessage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csPersonificatedMessage .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrUserID: Integer;

function k2_typcsPersonificatedMessage: csPersonificatedMessageTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csPersonificatedMessage : csPersonificatedMessageTag = nil;

// start class csPersonificatedMessageTag

function k2_typcsPersonificatedMessage: csPersonificatedMessageTag;
begin
 if (g_csPersonificatedMessage = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csPersonificatedMessage := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csPersonificatedMessage;
 end;//g_csPersonificatedMessage = nil
 Result := g_csPersonificatedMessage;
end;
var
 g_k2_attrUserID: Integer = -1;

function k2_attrUserID: Integer;
begin
 if (g_k2_attrUserID = -1) then
  g_k2_attrUserID :=  Tk2Attributes.Instance.CheckIDByName('UserID');
 Result := g_k2_attrUserID;
end;


end.