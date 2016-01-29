unit NOT_FINISHED_alcuAutoAnnoExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAutoAnnoExportTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAutoAnnoExportTask
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
  alcuAutoAnnoExportTaskPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoAnnoExportTask = class(TalcuAutoAnnoExportTaskPrim)
 protected
 // overridden protected methods
    {$If not defined(Nemesis)}
   function GetDescription: AnsiString; override;
    {$IfEnd} //not Nemesis
 end;//TalcuAutoAnnoExportTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}

// start class TalcuAutoAnnoExportTask

{$If not defined(Nemesis)}
function TalcuAutoAnnoExportTask.GetDescription: AnsiString;
//#UC START# *53FB28170339_53F59F6F0341_var*
//#UC END# *53FB28170339_53F59F6F0341_var*
begin
//#UC START# *53FB28170339_53F59F6F0341_impl*
 !!! Needs to be implemented !!!
//#UC END# *53FB28170339_53F59F6F0341_impl*
end;//TalcuAutoAnnoExportTask.GetDescription
{$IfEnd} //not Nemesis

{$IfEnd} //ServerTasks

end.