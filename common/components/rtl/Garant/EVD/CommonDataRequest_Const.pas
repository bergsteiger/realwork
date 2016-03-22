unit CommonDataRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/CommonDataRequest_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::CommonDataRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега CommonDataRequest .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typCommonDataRequest: CommonDataRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CommonDataRequest : CommonDataRequestTag = nil;

// start class CommonDataRequestTag

function k2_typCommonDataRequest: CommonDataRequestTag;
begin
 if (g_CommonDataRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CommonDataRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CommonDataRequest;
 end;//g_CommonDataRequest = nil
 Result := g_CommonDataRequest;
end;

end.