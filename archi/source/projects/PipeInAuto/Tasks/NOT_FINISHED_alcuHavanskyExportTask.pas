unit NOT_FINISHED_alcuHavanskyExportTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuHavanskyExportTask.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuHavanskyExportTask
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
  {$If defined(HavanskyExport) AND defined(ServerTasks)}
  ,
  alcuHavanskyExportTaskPrim
  {$IfEnd} //HavanskyExport AND ServerTasks
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuHavanskyExportTask = class(TalcuHavanskyExportTaskPrim)
 end;//TalcuHavanskyExportTask
{$IfEnd} //ServerTasks

implementation

end.