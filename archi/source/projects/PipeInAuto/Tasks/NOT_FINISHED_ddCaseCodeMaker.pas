unit NOT_FINISHED_ddCaseCodeMaker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_ddCaseCodeMaker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::ddCaseCodeMaker
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
  ddCaseCodeTaskPrim
  {$IfEnd} //not Nemesis
  
  ;

type
 TddCaseCodeTask = class(TddCaseCodeTaskPrim)
 end;//TddCaseCodeTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
{$IfEnd} //ServerTasks
end.