unit PostgresProviderParams_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/PostgresProviderParams_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::PostgresProviderParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега PostgresProviderParams .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrDataServerHostName: Integer;

function k2_attrDataServerPort: Integer;

function k2_typPostgresProviderParams: PostgresProviderParamsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_PostgresProviderParams : PostgresProviderParamsTag = nil;

// start class PostgresProviderParamsTag

function k2_typPostgresProviderParams: PostgresProviderParamsTag;
begin
 if (g_PostgresProviderParams = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_PostgresProviderParams := TevdTasksSchema(Tk2TypeTable.GetInstance).t_PostgresProviderParams;
 end;//g_PostgresProviderParams = nil
 Result := g_PostgresProviderParams;
end;
var
 g_k2_attrDataServerHostName: Integer = -1;

function k2_attrDataServerHostName: Integer;
begin
 if (g_k2_attrDataServerHostName = -1) then
  g_k2_attrDataServerHostName :=  Tk2Attributes.Instance.CheckIDByName('DataServerHostName');
 Result := g_k2_attrDataServerHostName;
end;

var
 g_k2_attrDataServerPort: Integer = -1;

function k2_attrDataServerPort: Integer;
begin
 if (g_k2_attrDataServerPort = -1) then
  g_k2_attrDataServerPort :=  Tk2Attributes.Instance.CheckIDByName('DataServerPort');
 Result := g_k2_attrDataServerPort;
end;


end.