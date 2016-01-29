unit NOT_FINISHED_alcuAACImport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAACImport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAACImport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AAC) AND defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csAACImport
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AAC AND ServerTasks

{$If defined(AAC) AND defined(ServerTasks)}
type
 TalcuAACImport = class(TcsAACImport)
 end;//TalcuAACImport
{$IfEnd} //AAC AND ServerTasks

implementation

{$If defined(AAC) AND defined(ServerTasks)}
uses
  alcuAACImportTaskResult
  ;
{$IfEnd} //AAC AND ServerTasks

{$If defined(AAC) AND defined(ServerTasks)}


{$IfEnd} //AAC AND ServerTasks
end.