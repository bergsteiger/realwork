unit csDisconnectReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDisconnectReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDisconnectReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDisconnectReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDisconnectReply: csDisconnectReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDisconnectReply : csDisconnectReplyTag = nil;

// start class csDisconnectReplyTag

function k2_typcsDisconnectReply: csDisconnectReplyTag;
begin
 if (g_csDisconnectReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDisconnectReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDisconnectReply;
 end;//g_csDisconnectReply = nil
 Result := g_csDisconnectReply;
end;

end.