unit csMessageRecepientList;

// Модуль: "w:\common\components\rtl\Garant\cs\csMessageRecepientList.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csMessageRecepient
 , l3ProtoObject
 , csMessageRecepientListPrim
 , SyncObjs
;

type
 csMessageRecepientIterator_ForEachF_Action = function(anItem: TcsMessageRecepient): Boolean;
  {* Тип подитеративной функции для csMessageRecepientIterator.ForEachF }

 (*
 csMessageRecepientIterator = interface
  procedure ForEachF(anAction: csMessageRecepientIterator_ForEachF_Action);
 end;//csMessageRecepientIterator
 *)

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TcsMessageRecepientList = class(_l3CriticalSectionHolder_)
  private
   f_Items: TcsMessageRecepientListPrim;
    {* Поле для свойства Items }
  protected
   function pm_GetCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function Add(anItem: TcsMessageRecepient): TcsMessageRecepient;
   procedure Clear;
   procedure ForEachF(anAction: csMessageRecepientIterator_ForEachF_Action);
  protected
   property Items: TcsMessageRecepientListPrim
    read f_Items;
  public
   property Count: Integer
    read pm_GetCount;
 end;//TcsMessageRecepientList

function L2csMessageRecepientIteratorForEachFAction(anAction: pointer): csMessageRecepientIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для csMessageRecepientIterator.ForEachF }
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

function L2csMessageRecepientIteratorForEachFAction(anAction: pointer): csMessageRecepientIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для csMessageRecepientIterator.ForEachF }
asm
 jmp l3LocalStub
end;//L2csMessageRecepientIteratorForEachFAction

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

function TcsMessageRecepientList.pm_GetCount: Integer;
//#UC START# *53A2DE24004A_53A2D3BC030Aget_var*
//#UC END# *53A2DE24004A_53A2D3BC030Aget_var*
begin
//#UC START# *53A2DE24004A_53A2D3BC030Aget_impl*
 Result := Items.Count;
//#UC END# *53A2DE24004A_53A2D3BC030Aget_impl*
end;//TcsMessageRecepientList.pm_GetCount

function TcsMessageRecepientList.Add(anItem: TcsMessageRecepient): TcsMessageRecepient;
//#UC START# *53A2DD470028_53A2D3BC030A_var*
//#UC END# *53A2DD470028_53A2D3BC030A_var*
begin
//#UC START# *53A2DD470028_53A2D3BC030A_impl*
 Lock;
 try
  Result := Items[Items.Add(anItem)];
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2DD470028_53A2D3BC030A_impl*
end;//TcsMessageRecepientList.Add

procedure TcsMessageRecepientList.Clear;
//#UC START# *53A2DDCF036D_53A2D3BC030A_var*
//#UC END# *53A2DDCF036D_53A2D3BC030A_var*
begin
//#UC START# *53A2DDCF036D_53A2D3BC030A_impl*
 Lock;
 try
  Items.Clear;
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A2DDCF036D_53A2D3BC030A_impl*
end;//TcsMessageRecepientList.Clear

procedure TcsMessageRecepientList.ForEachF(anAction: csMessageRecepientIterator_ForEachF_Action);
//#UC START# *53A2DDAB0054_53A2D3BC030A_var*

type
 PObject = ^TObject;

 function DoIt(aData : PObject; anIndex : Integer) : Boolean;
 begin
  Result := anAction(TcsMessageRecepient(aData^));
 end;
 
var
 Hack : Pointer absolute anAction;
//#UC END# *53A2DDAB0054_53A2D3BC030A_var*
begin
//#UC START# *53A2DDAB0054_53A2D3BC030A_impl*
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
//#UC END# *53A2DDAB0054_53A2D3BC030A_impl*
end;//TcsMessageRecepientList.ForEachF

procedure TcsMessageRecepientList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53A2D3BC030A_var*
//#UC END# *479731C50290_53A2D3BC030A_var*
begin
//#UC START# *479731C50290_53A2D3BC030A_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_53A2D3BC030A_impl*
end;//TcsMessageRecepientList.Cleanup

procedure TcsMessageRecepientList.InitFields;
//#UC START# *47A042E100E2_53A2D3BC030A_var*
//#UC END# *47A042E100E2_53A2D3BC030A_var*
begin
//#UC START# *47A042E100E2_53A2D3BC030A_impl*
 inherited;
 f_Items := TcsMessageRecepientListPrim.Create;
//#UC END# *47A042E100E2_53A2D3BC030A_impl*
end;//TcsMessageRecepientList.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
