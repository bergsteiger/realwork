unit l3MultiThreadIntegerList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MultiThreadIntegerList.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ProtoIntegerList
 , SyncObjs
;

type
 IntegerIterator_ForEachF_Action = function(anItem: Integer): Boolean;
  {* Тип подитеративной функции для IntegerIterator.ForEachF }

 IntegerIterator_ForOneF_Action = function(anItem: Integer): Boolean;
  {* Тип подитеративной функции для IntegerIterator.ForOneF }

 (*
 IntegerIterator = interface
  procedure ForEachF;
  procedure ForOneF;
 end;//IntegerIterator
 *)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include l3CriticalSectionHolder.imp.pas}
 Tl3MultiThreadIntegerList = class(_l3CriticalSectionHolder_)
  private
   f_Items: Tl3ProtoIntegerList;
    {* Поле для свойства Items }
  protected
   function NeedSort: Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Add(anItem: Integer);
   procedure Remove(anItem: Integer);
   procedure Clear;
   procedure ForEachF;
   procedure ForOneF;
  protected
   property Items: Tl3ProtoIntegerList
    read f_Items;
 end;//Tl3MultiThreadIntegerList

function L2_IntegerIterator_ForEachF_Action(anAction: pointer): IntegerIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IntegerIterator.ForEachF }
function L2_IntegerIterator_ForOneF_Action(anAction: pointer): IntegerIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IntegerIterator.ForOneF }

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

function L2_IntegerIterator_ForEachF_Action(anAction: pointer): IntegerIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IntegerIterator.ForEachF }
asm
 jmp l3LocalStub
end;//L2_IntegerIterator_ForEachF_Action

function L2_IntegerIterator_ForOneF_Action(anAction: pointer): IntegerIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для IntegerIterator.ForOneF }
asm
 jmp l3LocalStub
end;//L2_IntegerIterator_ForOneF_Action

{$Include l3CriticalSectionHolder.imp.pas}

procedure Tl3MultiThreadIntegerList.Add(anItem: Integer);
//#UC START# *53A2C8C10024_53A2C7AA03BF_var*
//#UC END# *53A2C8C10024_53A2C7AA03BF_var*
begin
//#UC START# *53A2C8C10024_53A2C7AA03BF_impl*
 Lock;
 try
  Items.Add(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2C8C10024_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.Add

procedure Tl3MultiThreadIntegerList.Remove(anItem: Integer);
//#UC START# *53A2C8EE02B5_53A2C7AA03BF_var*
//#UC END# *53A2C8EE02B5_53A2C7AA03BF_var*
begin
//#UC START# *53A2C8EE02B5_53A2C7AA03BF_impl*
 Lock;
 try
  Items.Remove(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2C8EE02B5_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.Remove

function Tl3MultiThreadIntegerList.NeedSort: Boolean;
//#UC START# *53A2C90A0344_53A2C7AA03BF_var*
//#UC END# *53A2C90A0344_53A2C7AA03BF_var*
begin
//#UC START# *53A2C90A0344_53A2C7AA03BF_impl*
 Result := false;
//#UC END# *53A2C90A0344_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.NeedSort

procedure Tl3MultiThreadIntegerList.Clear;
//#UC START# *53A84920013D_53A2C7AA03BF_var*
//#UC END# *53A84920013D_53A2C7AA03BF_var*
begin
//#UC START# *53A84920013D_53A2C7AA03BF_impl*
 Lock;
 try
  Items.Clear;
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A84920013D_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.Clear

procedure Tl3MultiThreadIntegerList.ForEachF;
//#UC START# *53A2C89B0302_53A2C7AA03BF_var*

 function DoIt(aData : PInteger; anIndex : Integer) : Boolean;
 begin
  Result := anAction(aData^);
 end;

var
 Hack : Pointer absolute anAction;
//#UC END# *53A2C89B0302_53A2C7AA03BF_var*
begin
//#UC START# *53A2C89B0302_53A2C7AA03BF_impl*
 try
  Lock;
  try
   f_Items.IterateAllF(l3L2IA(@DoIt));
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *53A2C89B0302_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.ForEachF

procedure Tl3MultiThreadIntegerList.ForOneF;
//#UC START# *53A84EAD0005_53A2C7AA03BF_var*
var
 Hack : Pointer absolute anAction;
//#UC END# *53A84EAD0005_53A2C7AA03BF_var*
begin
//#UC START# *53A84EAD0005_53A2C7AA03BF_impl*
 try
  Lock;
  try
   if (anIndex >= 0) AND (anIndex < f_Items.Count) then
    anAction(f_Items[anIndex]);
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *53A84EAD0005_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.ForOneF

procedure Tl3MultiThreadIntegerList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53A2C7AA03BF_var*
//#UC END# *479731C50290_53A2C7AA03BF_var*
begin
//#UC START# *479731C50290_53A2C7AA03BF_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.Cleanup

procedure Tl3MultiThreadIntegerList.InitFields;
//#UC START# *47A042E100E2_53A2C7AA03BF_var*
//#UC END# *47A042E100E2_53A2C7AA03BF_var*
begin
//#UC START# *47A042E100E2_53A2C7AA03BF_impl*
 inherited;
 if NeedSort then
  f_Items := Tl3ProtoIntegerList.MakeSorted
 else
  f_Items := Tl3ProtoIntegerList.Create;
//#UC END# *47A042E100E2_53A2C7AA03BF_impl*
end;//Tl3MultiThreadIntegerList.InitFields

end.
