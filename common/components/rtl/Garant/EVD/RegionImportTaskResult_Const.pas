unit RegionImportTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RegionImportTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RegionImportTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RegionImportTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrHasMoreFilesToProcess: Integer;

function k2_typRegionImportTaskResult: RegionImportTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RegionImportTaskResult : RegionImportTaskResultTag = nil;

// start class RegionImportTaskResultTag

function k2_typRegionImportTaskResult: RegionImportTaskResultTag;
begin
 if (g_RegionImportTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RegionImportTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RegionImportTaskResult;
 end;//g_RegionImportTaskResult = nil
 Result := g_RegionImportTaskResult;
end;
var
 g_k2_attrHasMoreFilesToProcess: Integer = -1;

function k2_attrHasMoreFilesToProcess: Integer;
begin
 if (g_k2_attrHasMoreFilesToProcess = -1) then
  g_k2_attrHasMoreFilesToProcess :=  Tk2Attributes.Instance.CheckIDByName('HasMoreFilesToProcess');
 Result := g_k2_attrHasMoreFilesToProcess;
end;


end.