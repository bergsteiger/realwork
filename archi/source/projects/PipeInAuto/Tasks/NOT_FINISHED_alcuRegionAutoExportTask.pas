unit NOT_FINISHED_alcuRegionAutoExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuRegionAutoExportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuRegionAutoExportTask
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
  alcuRegionAutoExportTaskPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuRegionAutoExportTask = class(TalcuRegionAutoExportTaskPrim)
 end;//TalcuRegionAutoExportTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuFTPBrowser,
  alcuFTPBrowserParams
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}


{$IfEnd} //ServerTasks
end.