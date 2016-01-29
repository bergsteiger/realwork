unit AutoAnnoExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoAnnoExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AutoAnnoExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoAnnoExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAutoAnnoExportTask_BelongsIDList: AutoAnnoExportTask_BelongsIDList_Tag;

function k2_attrStartDate: Integer;

function k2_attrEndDate: Integer;

function k2_attrBelongsIDList: Integer;
function k2_typAutoAnnoExportTask: AutoAnnoExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoAnnoExportTask : AutoAnnoExportTaskTag = nil;

// start class AutoAnnoExportTaskTag

function k2_typAutoAnnoExportTask: AutoAnnoExportTaskTag;
begin
 if (g_AutoAnnoExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoAnnoExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoAnnoExportTask;
 end;//g_AutoAnnoExportTask = nil
 Result := g_AutoAnnoExportTask;
end;
var
 g_k2_attrStartDate: Integer = -1;

function k2_attrStartDate: Integer;
begin
 if (g_k2_attrStartDate = -1) then
  g_k2_attrStartDate :=  Tk2Attributes.Instance.CheckIDByName('StartDate');
 Result := g_k2_attrStartDate;
end;

var
 g_k2_attrEndDate: Integer = -1;

function k2_attrEndDate: Integer;
begin
 if (g_k2_attrEndDate = -1) then
  g_k2_attrEndDate :=  Tk2Attributes.Instance.CheckIDByName('EndDate');
 Result := g_k2_attrEndDate;
end;

var
 g_k2_attrBelongsIDList: Integer = -1;

function k2_attrBelongsIDList: Integer;
begin
 if (g_k2_attrBelongsIDList = -1) then
  g_k2_attrBelongsIDList :=  Tk2Attributes.Instance.CheckIDByName('BelongsIDList');
 Result := g_k2_attrBelongsIDList;
end;


var
 g_AutoAnnoExportTask_BelongsIDList : AutoAnnoExportTask_BelongsIDList_Tag = nil;

// start class BelongsIDList

function k2_typAutoAnnoExportTask_BelongsIDList: AutoAnnoExportTask_BelongsIDList_Tag;
begin
 if (g_AutoAnnoExportTask_BelongsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AutoAnnoExportTask_BelongsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AutoAnnoExportTask_BelongsIDList;
 end;//g_AutoAnnoExportTask = nil
 Result := g_AutoAnnoExportTask_BelongsIDList;
end;


end.