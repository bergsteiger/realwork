unit csDIsconnectReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDIsconnectReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDIsconnectReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDIsconnectReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDIsconnectReply: csDIsconnectReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDIsconnectReply : csDIsconnectReplyTag = nil;

// start class csDIsconnectReplyTag

function k2_typcsDIsconnectReply: csDIsconnectReplyTag;
begin
 if (g_csDIsconnectReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDIsconnectReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDIsconnectReply;
 end;//g_csDIsconnectReply = nil
 Result := g_csDIsconnectReply;
end;

end.