unit NOT_FINISHED_alcuHavanskyExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuHavanskyExportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuHavanskyExportTask
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
  Classes
  {$If defined(HavanskyExport) AND defined(ServerTasks)}
  ,
  alcuHavanskyExportTaskPrim
  {$IfEnd} //HavanskyExport AND ServerTasks
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuHavanskyExportTask = class(TalcuHavanskyExportTaskPrim)
 end;//TalcuHavanskyExportTask
{$IfEnd} //ServerTasks

implementation

end.