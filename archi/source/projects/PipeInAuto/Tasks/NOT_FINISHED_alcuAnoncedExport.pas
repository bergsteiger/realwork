unit NOT_FINISHED_alcuAnoncedExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAnoncedExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAnoncedExport
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
  alcuExport,
  alcuAnoncedExportPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAnoncedExport = class(TalcuExportTalcuAnoncedExportPrim)
 end;//TalcuAnoncedExport
{$IfEnd} //ServerTasks

implementation

end.