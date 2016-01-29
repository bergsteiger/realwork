unit ServerStatusRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ServerStatusRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::ServerStatusRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ServerStatusRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typServerStatusRequest: ServerStatusRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ServerStatusRequest : ServerStatusRequestTag = nil;

// start class ServerStatusRequestTag

function k2_typServerStatusRequest: ServerStatusRequestTag;
begin
 if (g_ServerStatusRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ServerStatusRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ServerStatusRequest;
 end;//g_ServerStatusRequest = nil
 Result := g_ServerStatusRequest;
end;

end.