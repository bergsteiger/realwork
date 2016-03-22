unit csGetTaskDescription_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetTaskDescription_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csGetTaskDescription
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetTaskDescription .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTaskID: Integer;

function k2_typcsGetTaskDescription: csGetTaskDescriptionTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetTaskDescription : csGetTaskDescriptionTag = nil;

// start class csGetTaskDescriptionTag

function k2_typcsGetTaskDescription: csGetTaskDescriptionTag;
begin
 if (g_csGetTaskDescription = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetTaskDescription := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetTaskDescription;
 end;//g_csGetTaskDescription = nil
 Result := g_csGetTaskDescription;
end;
var
 g_k2_attrTaskID: Integer = -1;

function k2_attrTaskID: Integer;
begin
 if (g_k2_attrTaskID = -1) then
  g_k2_attrTaskID :=  Tk2Attributes.Instance.CheckIDByName('TaskID');
 Result := g_k2_attrTaskID;
end;


end.