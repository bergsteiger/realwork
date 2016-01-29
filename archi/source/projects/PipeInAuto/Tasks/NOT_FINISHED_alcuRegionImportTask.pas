unit NOT_FINISHED_alcuRegionImportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuRegionImportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRegionImportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  alcuRegionImportTaskPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuRegionImportTask = class(TalcuRegionImportTaskPrim)
 end;//TalcuRegionImportTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuRegionImportTaskResult
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}


{$IfEnd} //ServerTasks
end.