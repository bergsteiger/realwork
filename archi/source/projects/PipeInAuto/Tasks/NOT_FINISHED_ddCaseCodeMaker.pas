unit NOT_FINISHED_ddCaseCodeMaker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_ddCaseCodeMaker.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::ddCaseCodeMaker
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