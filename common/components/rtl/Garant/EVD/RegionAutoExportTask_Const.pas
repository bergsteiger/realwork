unit RegionAutoExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RegionAutoExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::RegionAutoExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RegionAutoExportTask .
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

function k2_attrResultWarehouse: Integer;

function k2_typRegionAutoExportTask: RegionAutoExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RegionAutoExportTask : RegionAutoExportTaskTag = nil;

// start class RegionAutoExportTaskTag

function k2_typRegionAutoExportTask: RegionAutoExportTaskTag;
begin
 if (g_RegionAutoExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RegionAutoExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RegionAutoExportTask;
 end;//g_RegionAutoExportTask = nil
 Result := g_RegionAutoExportTask;
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
 g_k2_attrResultWarehouse: Integer = -1;

function k2_attrResultWarehouse: Integer;
begin
 if (g_k2_attrResultWarehouse = -1) then
  g_k2_attrResultWarehouse :=  Tk2Attributes.Instance.CheckIDByName('ResultWarehouse');
 Result := g_k2_attrResultWarehouse;
end;


end.