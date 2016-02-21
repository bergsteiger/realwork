unit ddServerTaskList;

// Модуль: "w:\common\components\rtl\Garant\cs\ddServerTaskList.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , l3ProtoObject
 , ddServerTaskListPrim
 , SyncObjs
;

type
 csProcessTaskWorkuper_WorkupF_Action = function(anItem: TddProcessTask): Boolean;
  {* Тип подитеративной функции для csProcessTaskWorkuper.WorkupF }

 (*
 csProcessTaskWorkuper = interface
  procedure WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
 end;//csProcessTaskWorkuper
 *)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TddServerTaskList = class(_l3CriticalSectionHolder_)
  private
   f_Items: TddServerTaskListPrim;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function Pop: TddProcessTask;
   function Push(aTask: TddProcessTask): Integer;
   procedure WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
 end;//TddServerTaskList

function L2csProcessTaskWorkuperWorkupFAction(anAction: pointer): csProcessTaskWorkuper_WorkupF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для csProcessTaskWorkuper.WorkupF }
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

function L2csProcessTaskWorkuperWorkupFAction(anAction: pointer): csProcessTaskWorkuper_WorkupF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для csProcessTaskWorkuper.WorkupF }
asm
 jmp l3LocalStub
end;//L2csProcessTaskWorkuperWorkupFAction

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

function TddServerTaskList.Pop: TddProcessTask;
//#UC START# *53A1657F036D_52FA5F460142_var*
//#UC END# *53A1657F036D_52FA5F460142_var*
begin
//#UC START# *53A1657F036D_52FA5F460142_impl*
 Lock;
 try
  Result := f_Items[0].Use;
  f_Items.Delete(0);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A1657F036D_52FA5F460142_impl*
end;//TddServerTaskList.Pop

function TddServerTaskList.Push(aTask: TddProcessTask): Integer;
//#UC START# *53A1659B0334_52FA5F460142_var*
//#UC END# *53A1659B0334_52FA5F460142_var*
begin
//#UC START# *53A1659B0334_52FA5F460142_impl*
 Assert(Assigned(aTask));
 Lock;
 try
  Result:= f_Items.Add(aTask);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A1659B0334_52FA5F460142_impl*
end;//TddServerTaskList.Push

procedure TddServerTaskList.WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
//#UC START# *53A172F8025D_52FA5F460142_var*
var
 l_Task: TddProcessTask;
 Hack : Pointer absolute anAction;
//#UC END# *53A172F8025D_52FA5F460142_var*
begin
//#UC START# *53A172F8025D_52FA5F460142_impl*
 try
  Lock;
  try
   while (f_Items.Count > 0) do
   begin
    l_Task := Self.Pop;
    try
     if not anAction(l_Task) then
      break; 
    finally
     FreeAndNil(l_Task);
    end;//try..finally
   end;// while f_RawList.Count > 0
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *53A172F8025D_52FA5F460142_impl*
end;//TddServerTaskList.WorkupF

procedure TddServerTaskList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52FA5F460142_var*
//#UC END# *479731C50290_52FA5F460142_var*
begin
//#UC START# *479731C50290_52FA5F460142_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_52FA5F460142_impl*
end;//TddServerTaskList.Cleanup

procedure TddServerTaskList.InitFields;
//#UC START# *47A042E100E2_52FA5F460142_var*
//#UC END# *47A042E100E2_52FA5F460142_var*
begin
//#UC START# *47A042E100E2_52FA5F460142_impl*
 inherited;
 f_Items := TddServerTaskListPrim.MakeSorted;
 //Sorted := True;
//#UC END# *47A042E100E2_52FA5F460142_impl*
end;//TddServerTaskList.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
