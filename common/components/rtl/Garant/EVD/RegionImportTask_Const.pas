unit RegionImportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RegionImportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RegionImportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RegionImportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrRegionIndex: Integer;

function k2_attrFTPParams: Integer;

function k2_attrFileNameMask: Integer;

function k2_attrSourceWarehouse: Integer;

function k2_typRegionImportTask: RegionImportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RegionImportTask : RegionImportTaskTag = nil;

// start class RegionImportTaskTag

function k2_typRegionImportTask: RegionImportTaskTag;
begin
 if (g_RegionImportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RegionImportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RegionImportTask;
 end;//g_RegionImportTask = nil
 Result := g_RegionImportTask;
end;
var
 g_k2_attrRegionIndex: Integer = -1;

function k2_attrRegionIndex: Integer;
begin
 if (g_k2_attrRegionIndex = -1) then
  g_k2_attrRegionIndex :=  Tk2Attributes.Instance.CheckIDByName('RegionIndex');
 Result := g_k2_attrRegionIndex;
end;

var
 g_k2_attrFTPParams: Integer = -1;

function k2_attrFTPParams: Integer;
begin
 if (g_k2_attrFTPParams = -1) then
  g_k2_attrFTPParams :=  Tk2Attributes.Instance.CheckIDByName('FTPParams');
 Result := g_k2_attrFTPParams;
end;

var
 g_k2_attrFileNameMask: Integer = -1;

function k2_attrFileNameMask: Integer;
begin
 if (g_k2_attrFileNameMask = -1) then
  g_k2_attrFileNameMask :=  Tk2Attributes.Instance.CheckIDByName('FileNameMask');
 Result := g_k2_attrFileNameMask;
end;

var
 g_k2_attrSourceWarehouse: Integer = -1;

function k2_attrSourceWarehouse: Integer;
begin
 if (g_k2_attrSourceWarehouse = -1) then
  g_k2_attrSourceWarehouse :=  Tk2Attributes.Instance.CheckIDByName('SourceWarehouse');
 Result := g_k2_attrSourceWarehouse;
end;


end.