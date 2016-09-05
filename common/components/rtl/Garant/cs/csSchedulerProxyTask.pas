unit csSchedulerProxyTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csSchedulerProxyTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsSchedulerProxyTask" MUID: (57065CCE0306)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsSchedulerProxyTask = class(TddProcessTask)
  protected
   function pm_GetSchedulerTaskType: Integer;
   procedure pm_SetSchedulerTaskType(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property SchedulerTaskType: Integer
    read pm_GetSchedulerTaskType
    write pm_SetSchedulerTaskType;
 end;//TcsSchedulerProxyTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SchedulerProxyTask_Const
 //#UC START# *57065CCE0306impl_uses*
 //#UC END# *57065CCE0306impl_uses*
;

function TcsSchedulerProxyTask.pm_GetSchedulerTaskType: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrSchedulerTaskType]);
end;//TcsSchedulerProxyTask.pm_GetSchedulerTaskType

procedure TcsSchedulerProxyTask.pm_SetSchedulerTaskType(aValue: Integer);
begin
 TaggedData.IntW[k2_attrSchedulerTaskType, nil] := (aValue);
end;//TcsSchedulerProxyTask.pm_SetSchedulerTaskType

class function TcsSchedulerProxyTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typSchedulerProxyTask;
end;//TcsSchedulerProxyTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
