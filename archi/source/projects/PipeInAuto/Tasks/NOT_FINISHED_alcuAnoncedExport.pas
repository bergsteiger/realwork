unit NOT_FINISHED_alcuAnoncedExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuAnoncedExport.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuAnoncedExport
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