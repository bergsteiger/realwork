unit NOT_FINISHED_alcuAnnotationTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAnnotationTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAnnotationTask
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
  {$If not defined(Nemesis)}
  ,
  csAnnotationTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAnnotationTask = class(TcsAnnotationTask)
 end;//TalcuAnnotationTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuAnnotationTaskResult
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}


{$IfEnd} //ServerTasks
end.