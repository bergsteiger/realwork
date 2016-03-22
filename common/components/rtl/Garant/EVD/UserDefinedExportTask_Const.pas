unit UserDefinedExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/UserDefinedExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::UserDefinedExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега UserDefinedExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrQueryFile: Integer;

function k2_attrTimeToRun: Integer;

function k2_typUserDefinedExportTask: UserDefinedExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_UserDefinedExportTask : UserDefinedExportTaskTag = nil;

// start class UserDefinedExportTaskTag

function k2_typUserDefinedExportTask: UserDefinedExportTaskTag;
begin
 if (g_UserDefinedExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_UserDefinedExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_UserDefinedExportTask;
 end;//g_UserDefinedExportTask = nil
 Result := g_UserDefinedExportTask;
end;
var
 g_k2_attrQueryFile: Integer = -1;

function k2_attrQueryFile: Integer;
begin
 if (g_k2_attrQueryFile = -1) then
  g_k2_attrQueryFile :=  Tk2Attributes.Instance.CheckIDByName('QueryFile');
 Result := g_k2_attrQueryFile;
end;

var
 g_k2_attrTimeToRun: Integer = -1;

function k2_attrTimeToRun: Integer;
begin
 if (g_k2_attrTimeToRun = -1) then
  g_k2_attrTimeToRun :=  Tk2Attributes.Instance.CheckIDByName('TimeToRun');
 Result := g_k2_attrTimeToRun;
end;


end.