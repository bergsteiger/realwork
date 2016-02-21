unit alcuDetachedExecutorPool;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutorPool.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoObject
 , alcuDetachedExecutorList
 , l3Base
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TalcuDetachedExecutorPool = class(_l3CriticalSectionHolder_)
  private
   f_Data: TalcuDetachedExecutorList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Launch(anExecutor: Tl3ThreadContainer);
   procedure Pack;
 end;//TalcuDetachedExecutorPool
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

procedure TalcuDetachedExecutorPool.Launch(anExecutor: Tl3ThreadContainer);
//#UC START# *54BE5EBC03D3_54BE32A30011_var*
//#UC END# *54BE5EBC03D3_54BE32A30011_var*
begin
//#UC START# *54BE5EBC03D3_54BE32A30011_impl*
 Lock;
 try
  f_Data.Add(anExecutor);
  anExecutor.Suspended := False;
 finally
  Unlock;
 end;
//#UC END# *54BE5EBC03D3_54BE32A30011_impl*
end;//TalcuDetachedExecutorPool.Launch

procedure TalcuDetachedExecutorPool.Pack;
//#UC START# *54BE5ED201CC_54BE32A30011_var*
var
 l_IDX: Integer;
//#UC END# *54BE5ED201CC_54BE32A30011_var*
begin
//#UC START# *54BE5ED201CC_54BE32A30011_impl*
 Lock;
 try
  for l_IDX := f_Data.Count - 1 downto 0 do
   if f_Data[l_IDX].Suspended then
    f_Data.Delete(l_IDX);
 finally
  Unlock;
 end;
//#UC END# *54BE5ED201CC_54BE32A30011_impl*
end;//TalcuDetachedExecutorPool.Pack

procedure TalcuDetachedExecutorPool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54BE32A30011_var*
//#UC END# *479731C50290_54BE32A30011_var*
begin
//#UC START# *479731C50290_54BE32A30011_impl*
 FreeAndNil(f_Data);
 inherited;
//#UC END# *479731C50290_54BE32A30011_impl*
end;//TalcuDetachedExecutorPool.Cleanup

procedure TalcuDetachedExecutorPool.InitFields;
//#UC START# *47A042E100E2_54BE32A30011_var*
//#UC END# *47A042E100E2_54BE32A30011_var*
begin
//#UC START# *47A042E100E2_54BE32A30011_impl*
 inherited;
 f_Data := TalcuDetachedExecutorList.Make;
//#UC END# *47A042E100E2_54BE32A30011_impl*
end;//TalcuDetachedExecutorPool.InitFields
{$IfEnd} // Defined(ServerTasks)

end.
