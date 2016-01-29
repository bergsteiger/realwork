unit k2TypeTableCreatedListeners;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypeTableCreatedListeners.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2Core::Tk2TypeTableCreatedListeners
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  Classes,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;

 {$Define l3Items_NoSort}

type
 _ItemType_ = TNotifyEvent;
 _l3StandardTypedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}
 Tk2TypeTableCreatedListeners = class(_l3StandardTypedList_)
 public
 // public methods
   procedure AddListener(aListener: TNotifyEvent);
   procedure NotifyListeners(aSender: TObject);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tk2TypeTableCreatedListeners;
    {- возвращает экземпляр синглетона. }
 end;//Tk2TypeTableCreatedListeners

implementation

uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


// start class Tk2TypeTableCreatedListeners

var g_Tk2TypeTableCreatedListeners : Tk2TypeTableCreatedListeners = nil;

procedure Tk2TypeTableCreatedListenersFree;
begin
 l3Free(g_Tk2TypeTableCreatedListeners);
end;

class function Tk2TypeTableCreatedListeners.Instance: Tk2TypeTableCreatedListeners;
begin
 if (g_Tk2TypeTableCreatedListeners = nil) then
 begin
  l3System.AddExitProc(Tk2TypeTableCreatedListenersFree);
  g_Tk2TypeTableCreatedListeners := Create;
 end;
 Result := g_Tk2TypeTableCreatedListeners;
end;


{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  ); forward;

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  ); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_53C7D8AB0282_var*
//#UC END# *47B07CF403D0_53C7D8AB0282_var*
begin
//#UC START# *47B07CF403D0_53C7D8AB0282_impl*
 Result := false;
 Assert(false)
//#UC END# *47B07CF403D0_53C7D8AB0282_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53C7D8AB0282_var*
//#UC END# *47B2C42A0163_53C7D8AB0282_var*
begin
//#UC START# *47B2C42A0163_53C7D8AB0282_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53C7D8AB0282_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_53C7D8AB0282_var*
//#UC END# *47B935AF0066_53C7D8AB0282_var*
begin
//#UC START# *47B935AF0066_53C7D8AB0282_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_53C7D8AB0282_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_53C7D8AB0282_var*
//#UC END# *47B94A5C006E_53C7D8AB0282_var*
begin
//#UC START# *47B94A5C006E_53C7D8AB0282_impl*
 aPlace := nil;
//#UC END# *47B94A5C006E_53C7D8AB0282_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_53C7D8AB0282_var*
//#UC END# *47B99D4503A2_53C7D8AB0282_var*
begin
//#UC START# *47B99D4503A2_53C7D8AB0282_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53C7D8AB0282_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2TypeTableCreatedListeners;

{$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}

// start class Tk2TypeTableCreatedListeners

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
 {-}
begin
 Result := g_Tk2TypeTableCreatedListeners <> nil;
end;//Tk2TypeTableCreatedListeners.Exists

end.