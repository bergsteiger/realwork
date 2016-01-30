unit NOT_FINISHED_alcuAutoClassifier;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuAutoClassifier.pas"
// Стереотип: "UtilityPack"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csAutoClassTask
 {$IfEnd} // NOT Defined(Nemesis)
 , csTaskResult
;

type
 TalcuAutoClassTask = class(TcsAutoClassTask)
  protected
   {$If NOT Defined(Nemesis)}
   procedure GetTaskResultClass : TcsClassResultClass; override;
   {$IfEnd} // NOT Defined(Nemesis)
 end;//TalcuAutoClassTask
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuAutoClassTaskResult
;

{$If NOT Defined(Nemesis)}
procedure TalcuAutoClassTask.GetTaskResultClass : TcsClassResultClass;
//#UC START# *53E1CB0C03C9_530354C00376_var*
//#UC END# *53E1CB0C03C9_530354C00376_var*
begin
//#UC START# *53E1CB0C03C9_530354C00376_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E1CB0C03C9_530354C00376_impl*
end;//TalcuAutoClassTask.GetTaskResultClass : TcsClassResultClass
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
