unit ddServerTaskList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddServerTaskList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::ddServerTaskList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  csProcessTask,
  ddServerTaskListPrim,
  SyncObjs
  ;

type
  csProcessTaskWorkuper_WorkupF_Action = function (anItem: TddProcessTask): Boolean;
   {* Тип подитеративной функции для csProcessTaskWorkuper.WorkupF }

(*
 csProcessTaskWorkuper = PureMixIn
   {iterator} procedure WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
 end;//csProcessTaskWorkuper
*)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TddServerTaskList = class(_l3CriticalSectionHolder_)
 private
 // private fields
   f_Items : TddServerTaskListPrim;
 public
 // realized methods
   {iterator} procedure WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   function Pop: TddProcessTask;
   function Push(aTask: TddProcessTask): Integer;
 end;//TddServerTaskList
function L2CsProcessTaskWorkuperWorkupFAction(anAction: pointer): csProcessTaskWorkuper_WorkupF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для csProcessTaskWorkuper.WorkupF }
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  SysUtils
  ;

// start class csProcessTaskWorkuper

function L2CsProcessTaskWorkuperWorkupFAction(anAction: pointer): csProcessTaskWorkuper_WorkupF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2CsProcessTaskWorkuperWorkupFAction
{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class TddServerTaskList

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

{iterator} procedure TddServerTaskList.WorkupF(anAction: csProcessTaskWorkuper_WorkupF_Action);
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
{$IfEnd} //not Nemesis

end.