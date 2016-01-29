unit HavanskyExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/HavanskyExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::HavanskyExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега HavanskyExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typHavanskyExportTask: HavanskyExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_HavanskyExportTask : HavanskyExportTaskTag = nil;

// start class HavanskyExportTaskTag

function k2_typHavanskyExportTask: HavanskyExportTaskTag;
begin
 if (g_HavanskyExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_HavanskyExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_HavanskyExportTask;
 end;//g_HavanskyExportTask = nil
 Result := g_HavanskyExportTask;
end;

end.