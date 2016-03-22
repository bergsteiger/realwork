unit csGetPartialTaskDescription_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetPartialTaskDescription_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csGetPartialTaskDescription
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetPartialTaskDescription .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrFileName: Integer;

function k2_typcsGetPartialTaskDescription: csGetPartialTaskDescriptionTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetPartialTaskDescription : csGetPartialTaskDescriptionTag = nil;

// start class csGetPartialTaskDescriptionTag

function k2_typcsGetPartialTaskDescription: csGetPartialTaskDescriptionTag;
begin
 if (g_csGetPartialTaskDescription = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetPartialTaskDescription := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetPartialTaskDescription;
 end;//g_csGetPartialTaskDescription = nil
 Result := g_csGetPartialTaskDescription;
end;
var
 g_k2_attrFileName: Integer = -1;

function k2_attrFileName: Integer;
begin
 if (g_k2_attrFileName = -1) then
  g_k2_attrFileName :=  Tk2Attributes.Instance.CheckIDByName('FileName');
 Result := g_k2_attrFileName;
end;


end.