unit ImportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ImportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::ImportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ImportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typImportTask_SourceFiles: ImportTask_SourceFiles_Tag;

function k2_typImportTask_RegionIDList: ImportTask_RegionIDList_Tag;

function k2_attrDeleteIncluded: Integer;

function k2_attrIsAnnotation: Integer;

function k2_attrIsRegion: Integer;

function k2_attrSourceDir: Integer;

function k2_attrSourceFiles: Integer;

function k2_attrRegionIDList: Integer;

function k2_attrSafeDir: Integer;

function k2_attrNeedSendMailReport: Integer;
function k2_typImportTask: ImportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ImportTask : ImportTaskTag = nil;

// start class ImportTaskTag

function k2_typImportTask: ImportTaskTag;
begin
 if (g_ImportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ImportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ImportTask;
 end;//g_ImportTask = nil
 Result := g_ImportTask;
end;
var
 g_k2_attrDeleteIncluded: Integer = -1;

function k2_attrDeleteIncluded: Integer;
begin
 if (g_k2_attrDeleteIncluded = -1) then
  g_k2_attrDeleteIncluded :=  Tk2Attributes.Instance.CheckIDByName('DeleteIncluded');
 Result := g_k2_attrDeleteIncluded;
end;

var
 g_k2_attrIsAnnotation: Integer = -1;

function k2_attrIsAnnotation: Integer;
begin
 if (g_k2_attrIsAnnotation = -1) then
  g_k2_attrIsAnnotation :=  Tk2Attributes.Instance.CheckIDByName('IsAnnotation');
 Result := g_k2_attrIsAnnotation;
end;

var
 g_k2_attrIsRegion: Integer = -1;

function k2_attrIsRegion: Integer;
begin
 if (g_k2_attrIsRegion = -1) then
  g_k2_attrIsRegion :=  Tk2Attributes.Instance.CheckIDByName('IsRegion');
 Result := g_k2_attrIsRegion;
end;

var
 g_k2_attrSourceDir: Integer = -1;

function k2_attrSourceDir: Integer;
begin
 if (g_k2_attrSourceDir = -1) then
  g_k2_attrSourceDir :=  Tk2Attributes.Instance.CheckIDByName('SourceDir');
 Result := g_k2_attrSourceDir;
end;

var
 g_k2_attrSourceFiles: Integer = -1;

function k2_attrSourceFiles: Integer;
begin
 if (g_k2_attrSourceFiles = -1) then
  g_k2_attrSourceFiles :=  Tk2Attributes.Instance.CheckIDByName('SourceFiles');
 Result := g_k2_attrSourceFiles;
end;

var
 g_k2_attrRegionIDList: Integer = -1;

function k2_attrRegionIDList: Integer;
begin
 if (g_k2_attrRegionIDList = -1) then
  g_k2_attrRegionIDList :=  Tk2Attributes.Instance.CheckIDByName('RegionIDList');
 Result := g_k2_attrRegionIDList;
end;

var
 g_k2_attrSafeDir: Integer = -1;

function k2_attrSafeDir: Integer;
begin
 if (g_k2_attrSafeDir = -1) then
  g_k2_attrSafeDir :=  Tk2Attributes.Instance.CheckIDByName('SafeDir');
 Result := g_k2_attrSafeDir;
end;

var
 g_k2_attrNeedSendMailReport: Integer = -1;

function k2_attrNeedSendMailReport: Integer;
begin
 if (g_k2_attrNeedSendMailReport = -1) then
  g_k2_attrNeedSendMailReport :=  Tk2Attributes.Instance.CheckIDByName('NeedSendMailReport');
 Result := g_k2_attrNeedSendMailReport;
end;


var
 g_ImportTask_SourceFiles : ImportTask_SourceFiles_Tag = nil;

// start class SourceFiles

function k2_typImportTask_SourceFiles: ImportTask_SourceFiles_Tag;
begin
 if (g_ImportTask_SourceFiles = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ImportTask_SourceFiles := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ImportTask_SourceFiles;
 end;//g_ImportTask = nil
 Result := g_ImportTask_SourceFiles;
end;

var
 g_ImportTask_RegionIDList : ImportTask_RegionIDList_Tag = nil;

// start class RegionIDList

function k2_typImportTask_RegionIDList: ImportTask_RegionIDList_Tag;
begin
 if (g_ImportTask_RegionIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ImportTask_RegionIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ImportTask_RegionIDList;
 end;//g_ImportTask = nil
 Result := g_ImportTask_RegionIDList;
end;


end.