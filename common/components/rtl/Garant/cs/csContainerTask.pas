unit csContainerTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csContainerTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsContainerTask" MUID: (56FE5C970264)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , csTasksHelpers
 , k2Base
;

type
 TcsContainerTask = class(TddProcessTask)
  protected
   function pm_GetTasksList: TasksListHelper;
   function pm_GetParallelExecutionMode: Boolean;
   procedure pm_SetParallelExecutionMode(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TasksList: TasksListHelper
    read pm_GetTasksList;
   property ParallelExecutionMode: Boolean
    read pm_GetParallelExecutionMode
    write pm_SetParallelExecutionMode;
 end;//TcsContainerTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ContainerTask_Const
 //#UC START# *56FE5C970264impl_uses*
 //#UC END# *56FE5C970264impl_uses*
;

function TcsContainerTask.pm_GetTasksList: TasksListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TTasksListHelper.Make(TaggedData.cAtom(k2_attrTasksList));
end;//TcsContainerTask.pm_GetTasksList

function TcsContainerTask.pm_GetParallelExecutionMode: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrParallelExecutionMode]);
end;//TcsContainerTask.pm_GetParallelExecutionMode

procedure TcsContainerTask.pm_SetParallelExecutionMode(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrParallelExecutionMode, nil] := (aValue);
end;//TcsContainerTask.pm_SetParallelExecutionMode

class function TcsContainerTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typContainerTask;
end;//TcsContainerTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
