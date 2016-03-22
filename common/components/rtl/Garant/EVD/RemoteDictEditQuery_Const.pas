unit RemoteDictEditQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RemoteDictEditQuery_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RemoteDictEditQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RemoteDictEditQuery .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typRemoteDictEditQuery: RemoteDictEditQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RemoteDictEditQuery : RemoteDictEditQueryTag = nil;

// start class RemoteDictEditQueryTag

function k2_typRemoteDictEditQuery: RemoteDictEditQueryTag;
begin
 if (g_RemoteDictEditQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RemoteDictEditQuery := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RemoteDictEditQuery;
 end;//g_RemoteDictEditQuery = nil
 Result := g_RemoteDictEditQuery;
end;

end.