unit alcuExecutorWithIncomingTaskList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tasks"
// ������: "w:/archi/source/projects/PipeInAuto/Tasks/alcuExecutorWithIncomingTaskList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::CoreExecutors::TalcuExecutorWithIncomingTaskList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  l3ProtoObject
  {$If not defined(Nemesis)}
  ,
  ddServerTaskList
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuExecutorWithIncomingTaskList = class(Tl3ProtoObject)
 private
 // private fields
   f_IncomingList : TddServerTaskList;
    {* ���� ��� �������� IncomingList}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(aList: TddServerTaskList); reintroduce;
 protected
 // protected properties
   property IncomingList: TddServerTaskList
     read f_IncomingList;
 end;//TalcuExecutorWithIncomingTaskList
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  SysUtils
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuExecutorWithIncomingTaskList

constructor TalcuExecutorWithIncomingTaskList.Create(aList: TddServerTaskList);
//#UC START# *54856F0B019F_54856E500154_var*
//#UC END# *54856F0B019F_54856E500154_var*
begin
//#UC START# *54856F0B019F_54856E500154_impl*
 inherited Create;
 aList.SetRefTo(f_IncomingList);
//#UC END# *54856F0B019F_54856E500154_impl*
end;//TalcuExecutorWithIncomingTaskList.Create

procedure TalcuExecutorWithIncomingTaskList.Cleanup;
//#UC START# *479731C50290_54856E500154_var*
//#UC END# *479731C50290_54856E500154_var*
begin
//#UC START# *479731C50290_54856E500154_impl*
 FreeAndNil(f_IncomingList);
 inherited;
//#UC END# *479731C50290_54856E500154_impl*
end;//TalcuExecutorWithIncomingTaskList.Cleanup

{$IfEnd} //ServerTasks

end.