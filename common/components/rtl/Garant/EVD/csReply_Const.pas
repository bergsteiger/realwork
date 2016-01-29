unit csReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsReply: csReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csReply : csReplyTag = nil;

// start class csReplyTag

function k2_typcsReply: csReplyTag;
begin
 if (g_csReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csReply;
 end;//g_csReply = nil
 Result := g_csReply;
end;

end.