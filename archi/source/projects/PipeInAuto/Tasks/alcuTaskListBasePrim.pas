unit alcuTaskListBasePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/alcuTaskListBasePrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::TasksLists::TalcuTaskListBasePrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3ProtoObject,
  l3PureMixIns
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
type
 _l3Changing_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 TalcuTaskListBasePrim = class(_l3Changing_)
 end;//TalcuTaskListBasePrim
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}


{$IfEnd} //AppServerSide AND ServerTasks
end.