unit NOT_FINISHED_alcuImport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuImport.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::alcuImport
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
  csImport
  {$IfEnd} //not Nemesis
  
  ;

type
 TalcuImport = class(TcsImportTaskItem)
 protected
 // overridden protected methods
    {$If not defined(Nemesis)}
   procedure GetTaskResultClass : TcsClassResultClass; override;
     {* ��������� ������ GetTaskResultClass : TcsClassResultClass }
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