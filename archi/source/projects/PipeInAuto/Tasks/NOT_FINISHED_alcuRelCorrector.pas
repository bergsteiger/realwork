unit NOT_FINISHED_alcuRelCorrector;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuRelCorrector.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::alcuRelCorrector
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
 TalcuRelPublishTask = class(TcsImportTaskItem)
 end;//TalcuRelPublishTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  alcuRelPublishTaskResult
  ;

{$IfEnd} //ServerTasks
end.