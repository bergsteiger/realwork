unit NOT_FINISHED_alcuImport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuImport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::alcuImport
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
  csImport
  {$IfEnd} //not Nemesis
  
  ;

type
 TalcuImport = class(TcsImportTaskItem)
 protected
 // overridden protected methods
    {$If not defined(Nemesis)}
   procedure GetTaskResultClass : TcsClassResultClass; override;
     {* Сигнатура метода GetTaskResultClass : TcsClassResultClass }
    {$IfEnd} //not Nemesis
 end;//TalcuImport
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuImportTaskResult
  ;

// start class TalcuImport

{$If not defined(Nemesis)}
procedure TalcuImport.GetTaskResultClass : TcsClassResultClass;
//#UC START# *53E1CB0C03C9_5305AFFB01F5_var*
//#UC END# *53E1CB0C03C9_5305AFFB01F5_var*
begin
//#UC START# *53E1CB0C03C9_5305AFFB01F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E1CB0C03C9_5305AFFB01F5_impl*
end;//TalcuImport.GetTaskResultClass : TcsClassResultClass
{$IfEnd} //not Nemesis
{$IfEnd} //ServerTasks

end.