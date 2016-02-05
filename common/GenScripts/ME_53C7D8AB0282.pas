unit k2TypeTableCreatedListeners;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypeTableCreatedListeners.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Classes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = TNotifyEvent;
 _l3StandardTypedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3StandardTypedList.imp.pas}
 Tk2TypeTableCreatedListeners = class(_l3StandardTypedList_)
  public
   procedure AddListener(aListener: TNotifyEvent);
   procedure NotifyListeners(aSender: TObject);
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tk2TypeTableCreatedListeners;
    {* Метод получения экземпляра синглетона Tk2TypeTableCreatedListeners }
 end;//Tk2TypeTableCreatedListeners

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_Tk2TypeTableCreatedListeners: Tk2TypeTableCreatedListeners = nil;
 {* Экземпляр синглетона Tk2TypeTableCreatedListeners }

procedure Tk2TypeTableCreatedListenersFree;
 {* Метод освобождения экземпляра синглетона Tk2TypeTableCreatedListeners }
begin
 l3Free(g_Tk2TypeTableCreatedListeners);
end;//Tk2TypeTableCreatedListenersFree

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)}
;
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
); forward;

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)}
;
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_53C7D8AB0282_var*
//#UC END# *47B07CF403D0_53C7D8AB0282_var*
begin
//#UC START# *47B07CF403D0_53C7D8AB0282_impl*
 Result := false;
 Assert(false)
//#UC END# *47B07CF403D0_53C7D8AB0282_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53C7D8AB0282_var*
//#UC END# *47B2C42A0163_53C7D8AB0282_var*
begin
//#UC START# *47B2C42A0163_53C7D8AB0282_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53C7D8AB0282_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_53C7D8AB0282_var*
//#UC END# *47B935AF0066_53C7D8AB0282_var*
begin
//#UC START# *47B935AF0066_53C7D8AB0282_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_53C7D8AB0282_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_53C7D8AB0282_var*
//#UC END# *47B94A5C006E_53C7D8AB0282_var*
begin
//#UC START# *47B94A5C006E_53C7D8AB0282_impl*
 aPlace := nil;
//#UC END# *47B94A5C006E_53C7D8AB0282_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53C7D8AB0282_var*
//#UC END# *47B99D4503A2_53C7D8AB0282_var*
begin
//#UC START# *47B99D4503A2_53C7D8AB0282_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53C7D8AB0282_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2TypeTableCreatedListeners;

{$Include l3StandardTypedList.imp.pas}

procedure Tk2TypeTableCreatedListeners.AddListener(aListener: TNotifyEvent);
//#UC START# *53C7D9E60110_53C7D8AB0282_var*
//#UC END# *53C7D9E60110_53C7D8AB0282_var*
begin
//#UC START# *53C7D9E60110_53C7D8AB0282_impl*
 Assert(Assigned(aListener));
 Add(aListener);
//#UC END# *53C7D9E60110_53C7D8AB0282_impl*
end;//Tk2TypeTableCreatedListeners.AddListener

procedure Tk2TypeTableCreatedListeners.NotifyListeners(aSender: TObject);
//#UC START# *53C7DA8400D6_53C7D8AB0282_var*
var
 l_Index : Integer;
 l_L : TNotifyEvent;
//#UC END# *53C7DA8400D6_53C7D8AB0282_var*
begin
//#UC START# *53C7DA8400D6_53C7D8AB0282_impl*
 for l_Index := 0 to Pred(Count) do
 begin
  l_L := Items[l_Index];
  l_L(aSender);
 end;//for l_Index
//#UC END# *53C7DA8400D6_53C7D8AB0282_impl*
end;//Tk2TypeTableCreatedListeners.NotifyListeners

class function Tk2TypeTableCreatedListeners.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2TypeTableCreatedListeners <> nil;
end;//Tk2TypeTableCreatedListeners.Exists

class function Tk2TypeTableCreatedListeners.Instance: Tk2TypeTableCreatedListeners;
 {* Метод получения экземпляра синглетона Tk2TypeTableCreatedListeners }
begin
 if (g_Tk2TypeTableCreatedListeners = nil) then
 begin
  l3System.AddExitProc(Tk2TypeTableCreatedListenersFree);
  g_Tk2TypeTableCreatedListeners := Create;
 end;
 Result := g_Tk2TypeTableCreatedListeners;
end;//Tk2TypeTableCreatedListeners.Instance

end.
