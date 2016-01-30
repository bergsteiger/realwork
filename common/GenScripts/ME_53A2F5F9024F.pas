unit ddClientMessageSortableList;

// Модуль: "w:\common\components\rtl\Garant\cs\ddClientMessageSortableList.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csClientMessageRequest
 , l3ProtoObject
 , ddClientMessageSortableListPrim
 , SyncObjs
;

type
 ddClientMessageIterator_ForEachF_Action = function(anItem: TddClientMessage): Boolean;
  {* Тип подитеративной функции для ddClientMessageIterator.ForEachF }

 (*
 ddClientMessageIterator = interface
  procedure ForEachF;
 end;//ddClientMessageIterator
 *)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include l3CriticalSectionHolder.imp.pas}
 TddClientMessageSortableList = class(_l3CriticalSectionHolder_)
  private
   f_Items: TddClientMessageSortableListPrim;
    {* Поле для свойства Items }
  protected
   function pm_GetCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Add(anItem: TddClientMessage);
   procedure Clear;
   procedure ForEachF;
  protected
   property Items: TddClientMessageSortableListPrim
    read f_Items;
  public
   property Count: Integer
    read pm_GetCount;
 end;//TddClientMessageSortableList

function L2_ddClientMessageIterator_ForEachF_Action(anAction: pointer): ddClientMessageIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для ddClientMessageIterator.ForEachF }
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

function L2_ddClientMessageIterator_ForEachF_Action(anAction: pointer): ddClientMessageIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для ddClientMessageIterator.ForEachF }
asm
 jmp l3LocalStub
end;//L2_ddClientMessageIterator_ForEachF_Action

{$Include l3CriticalSectionHolder.imp.pas}

function TddClientMessageSortableList.pm_GetCount: Integer;
//#UC START# *53A2FA8802B1_53A2EA3D0044get_var*
//#UC END# *53A2FA8802B1_53A2EA3D0044get_var*
begin
//#UC START# *53A2FA8802B1_53A2EA3D0044get_impl*
 Result := Items.Count;
//#UC END# *53A2FA8802B1_53A2EA3D0044get_impl*
end;//TddClientMessageSortableList.pm_GetCount

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

procedure TddClientMessageSortableList.ForEachF;
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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Nemesis)

end.
