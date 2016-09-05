unit csDisconnect_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDisconnect_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDisconnect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDisconnect .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDisconnect: csDisconnectTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDisconnect : csDisconnectTag = nil;

// start class csDisconnectTag

function k2_typcsDisconnect: csDisconnectTag;
begin
 if (g_csDisconnect = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDisconnect := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDisconnect;
 end;//g_csDisconnect = nil
 Result := g_csDisconnect;
end;

end.