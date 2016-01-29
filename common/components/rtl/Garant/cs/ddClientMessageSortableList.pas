unit ddClientMessageSortableList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddClientMessageSortableList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::ddClientMessageSortableList
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
  csClientMessageRequest,
  ddClientMessageSortableListPrim,
  SyncObjs
  ;

type
  ddClientMessageIterator_ForEachF_Action = function (anItem: TddClientMessage): Boolean;
   {* Тип подитеративной функции для ddClientMessageIterator.ForEachF }

(*
 ddClientMessageIterator = PureMixIn
   {iterator} procedure ForEachF(anAction: ddClientMessageIterator_ForEachF_Action);
 end;//ddClientMessageIterator
*)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TddClientMessageSortableList = class(_l3CriticalSectionHolder_)
 private
 // private fields
   f_Items : TddClientMessageSortableListPrim;
    {* Поле для свойства Items}
 protected
 // property methods
   function pm_GetCount: Integer;
 public
 // realized methods
   {iterator} procedure ForEachF(anAction: ddClientMessageIterator_ForEachF_Action);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure Add(anItem: TddClientMessage);
   procedure Clear;
 protected
 // protected properties
   property Items: TddClientMessageSortableListPrim
     read f_Items;
 public
 // public properties
   property Count: Integer
     read pm_GetCount;
 end;//TddClientMessageSortableList
function L2DdClientMessageIteratorForEachFAction(anAction: pointer): ddClientMessageIterator_ForEachF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для ddClientMessageIterator.ForEachF }
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  SysUtils
  ;

// start class ddClientMessageIterator

function L2DdClientMessageIteratorForEachFAction(anAction: pointer): ddClientMessageIterator_ForEachF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2DdClientMessageIteratorForEachFAction
{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class TddClientMessageSortableList

procedure TddClientMessageSortableList.Add(anItem: TddClientMessage);
//#UC START# *53A2FA070288_53A2EA3D0044_var*
//#UC END# *53A2FA070288_53A2EA3D0044_var*
begin
//#UC START# *53A2FA070288_53A2EA3D0044_impl*
 Lock;
 try
  Items.Add(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2FA070288_53A2EA3D0044_impl*
end;//TddClientMessageSortableList.Add

procedure TddClientMessageSortableList.Clear;
//#UC START# *53A2FA2003C6_53A2EA3D0044_var*
//#UC END# *53A2FA2003C6_53A2EA3D0044_var*
begin
//#UC START# *53A2FA2003C6_53A2EA3D0044_impl*
 Lock;
 try
  Items.Clear;
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2FA2003C6_53A2EA3D0044_impl*
end;//TddClientMessageSortableList.Clear

function TddClientMessageSortableList.pm_GetCount: Integer;
//#UC START# *53A2FA8802B1_53A2EA3D0044get_var*
//#UC END# *53A2FA8802B1_53A2EA3D0044get_var*
begin
//#UC START# *53A2FA8802B1_53A2EA3D0044get_impl*
 Result := Items.Count;
//#UC END# *53A2FA8802B1_53A2EA3D0044get_impl*
end;//TddClientMessageSortableList.pm_GetCount

{iterator} procedure TddClientMessageSortableList.ForEachF(anAction: ddClientMessageIterator_ForEachF_Action);
//#UC START# *53A2FAD90339_53A2EA3D0044_var*

type
 PObject = ^TObject;

 function DoIt(aData : PObject; anIndex : Integer) : Boolean;
 begin
  Result := anAction(TddClientMessage(aData^));
 end;
 
var
 Hack : Pointer absolute anAction;
//#UC END# *53A2FAD90339_53A2EA3D0044_var*
begin
//#UC START# *53A2FAD90339_53A2EA3D0044_impl*
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
//#UC END# *53A2FAD90339_53A2EA3D0044_impl*
end;//TddClientMessageSortableList.ForEachF

procedure TddClientMessageSortableList.Cleanup;
//#UC START# *479731C50290_53A2EA3D0044_var*
//#UC END# *479731C50290_53A2EA3D0044_var*
begin
//#UC START# *479731C50290_53A2EA3D0044_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_53A2EA3D0044_impl*
end;//TddClientMessageSortableList.Cleanup

procedure TddClientMessageSortableList.InitFields;
//#UC START# *47A042E100E2_53A2EA3D0044_var*
//#UC END# *47A042E100E2_53A2EA3D0044_var*
begin
//#UC START# *47A042E100E2_53A2EA3D0044_impl*
 inherited;
 f_Items := TddClientMessageSortableListPrim.MakeSorted;
//#UC END# *47A042E100E2_53A2EA3D0044_impl*
end;//TddClientMessageSortableList.InitFields
{$IfEnd} //not Nemesis

end.