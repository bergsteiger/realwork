unit NOT_FINISHED_alcuAutoClassifier;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAutoClassifier.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::alcuAutoClassifier
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csAutoClassTask
  {$IfEnd} //not Nemesis
  ,
  csTaskResult
  ;

type
 TalcuAutoClassTask = class(TcsAutoClassTask)
 protected
 // overridden property methods
   {$If not defined(Nemesis)}

   {$IfEnd} //not Nemesis
 protected
 // overridden protected methods
    {$If not defined(Nemesis)}
   procedure GetTaskResultClass : TcsClassResultClass; override;
     {* ��������� ������ GetTaskResultClass : TcsClassResultClass }
    {$IfEnd} //not Nemesis
 end;//TalcuAutoClassTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuAutoClassTaskResult
  ;

// start class TalcuAutoClassTask

{$If not defined(Nemesis)}
procedure TalcuAutoClassTask.GetTaskResultClass : TcsClassResultClass;
//#UC START# *53E1CB0C03C9_530354C00376_var*
//#UC END# *53E1CB0C03C9_530354C00376_var*
begin
//#UC START# *53E1CB0C03C9_530354C00376_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E1CB0C03C9_530354C00376_impl*
end;//TalcuAutoClassTask.GetTaskResultClass : TcsClassResultClass
{$IfEnd} //not Nemesis
{$IfEnd} //ServerTasks

end.