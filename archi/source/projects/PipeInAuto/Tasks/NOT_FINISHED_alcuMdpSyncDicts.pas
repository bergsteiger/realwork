unit NOT_FINISHED_alcuMdpSyncDicts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuMdpSyncDicts.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuMdpSyncDicts
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
  csMdpSyncDicts
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuMdpSyncDicts = class(TcsMdpSyncDicts)
 end;//TalcuMdpSyncDicts
{$IfEnd} //ServerTasks

implementation

end.