unit NOT_FINISHED_alcuAutoExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAutoExportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoExportTask
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
  alcuAutoExportTaskPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoExportTask = class(TalcuAutoExportTaskPrim)
 end;//TalcuAutoExportTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuAutoExportTaskResult
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}


{$IfEnd} //ServerTasks
end.