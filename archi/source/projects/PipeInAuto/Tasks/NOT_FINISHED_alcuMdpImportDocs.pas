unit NOT_FINISHED_alcuMdpImportDocs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuMdpImportDocs.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuMdpImportDocs
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
  csMdpImportDocs
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuMdpImportDocs = class(TcsMdpImportDocs)
 end;//TalcuMdpImportDocs
{$IfEnd} //ServerTasks

implementation

end.