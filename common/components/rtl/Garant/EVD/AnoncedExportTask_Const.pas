unit AnoncedExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AnoncedExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AnoncedExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AnoncedExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAnoncedExportTask_AccGroupsIDList: AnoncedExportTask_AccGroupsIDList_Tag;

function k2_attrOnThursdayMode: Integer;

function k2_attrNotifyEMailList: Integer;

function k2_attrAnoncedDate: Integer;

function k2_attrAccGroupsIDList: Integer;
function k2_typAnoncedExportTask: AnoncedExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AnoncedExportTask : AnoncedExportTaskTag = nil;

// start class AnoncedExportTaskTag

function k2_typAnoncedExportTask: AnoncedExportTaskTag;
begin
 if (g_AnoncedExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnoncedExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnoncedExportTask;
 end;//g_AnoncedExportTask = nil
 Result := g_AnoncedExportTask;
end;
var
 g_k2_attrOnThursdayMode: Integer = -1;

function k2_attrOnThursdayMode: Integer;
begin
 if (g_k2_attrOnThursdayMode = -1) then
  g_k2_attrOnThursdayMode :=  Tk2Attributes.Instance.CheckIDByName('OnThursdayMode');
 Result := g_k2_attrOnThursdayMode;
end;

var
 g_k2_attrNotifyEMailList: Integer = -1;

function k2_attrNotifyEMailList: Integer;
begin
 if (g_k2_attrNotifyEMailList = -1) then
  g_k2_attrNotifyEMailList :=  Tk2Attributes.Instance.CheckIDByName('NotifyEMailList');
 Result := g_k2_attrNotifyEMailList;
end;

var
 g_k2_attrAnoncedDate: Integer = -1;

function k2_attrAnoncedDate: Integer;
begin
 if (g_k2_attrAnoncedDate = -1) then
  g_k2_attrAnoncedDate :=  Tk2Attributes.Instance.CheckIDByName('AnoncedDate');
 Result := g_k2_attrAnoncedDate;
end;

var
 g_k2_attrAccGroupsIDList: Integer = -1;

function k2_attrAccGroupsIDList: Integer;
begin
 if (g_k2_attrAccGroupsIDList = -1) then
  g_k2_attrAccGroupsIDList :=  Tk2Attributes.Instance.CheckIDByName('AccGroupsIDList');
 Result := g_k2_attrAccGroupsIDList;
end;


var
 g_AnoncedExportTask_AccGroupsIDList : AnoncedExportTask_AccGroupsIDList_Tag = nil;

// start class AccGroupsIDList

function k2_typAnoncedExportTask_AccGroupsIDList: AnoncedExportTask_AccGroupsIDList_Tag;
begin
 if (g_AnoncedExportTask_AccGroupsIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AnoncedExportTask_AccGroupsIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AnoncedExportTask_AccGroupsIDList;
 end;//g_AnoncedExportTask = nil
 Result := g_AnoncedExportTask_AccGroupsIDList;
end;


end.