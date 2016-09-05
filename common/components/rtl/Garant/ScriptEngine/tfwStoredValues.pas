unit tfwStoredValues;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValues.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStoredValues" MUID: (4F49408A03C0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwStoredValue;
 _l3RecordListPrimPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}
 TtfwStoredValues = class(_l3RecordListPrimPrim_, ItfwStoredValues)
  protected
   procedure Restore(const aCtx: TtfwContext);
   function Grow: PtfwStoredValue;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create; reintroduce;
   class function Make: ItfwStoredValues; reintroduce;
 end;//TtfwStoredValues
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledVar
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F49408A03C0impl_uses*
 //#UC END# *4F49408A03C0impl_uses*
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
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
//#UC START# *47B07CF403D0_4F49408A03C0_var*
//#UC END# *47B07CF403D0_4F49408A03C0_var*
begin
//#UC START# *47B07CF403D0_4F49408A03C0_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4F49408A03C0_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F49408A03C0_var*
//#UC END# *47B2C42A0163_4F49408A03C0_var*
begin
//#UC START# *47B2C42A0163_4F49408A03C0_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F49408A03C0_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4F49408A03C0_var*
//#UC END# *47B94A5C006E_4F49408A03C0_var*
begin
//#UC START# *47B94A5C006E_4F49408A03C0_impl*
 aPlace.rValue.Clear;
 Finalize(aPlace.rValue);
 Finalize(aPlace);
//#UC END# *47B94A5C006E_4F49408A03C0_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F49408A03C0_var*
//#UC END# *47B99D4503A2_4F49408A03C0_var*
begin
//#UC START# *47B99D4503A2_4F49408A03C0_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F49408A03C0_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwStoredValues;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}

constructor TtfwStoredValues.Create;
//#UC START# *4F4947D50241_4F49408A03C0_var*
//#UC END# *4F4947D50241_4F49408A03C0_var*
begin
//#UC START# *4F4947D50241_4F49408A03C0_impl*
 inherited Create;
//#UC END# *4F4947D50241_4F49408A03C0_impl*
end;//TtfwStoredValues.Create

class function TtfwStoredValues.Make: ItfwStoredValues;
var
 l_Inst : TtfwStoredValues;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwStoredValues.Make

procedure TtfwStoredValues.Restore(const aCtx: TtfwContext);
//#UC START# *4F494C0D009A_4F49408A03C0_var*
var
 l_Index : Integer;
(* l_V : TtfwStoredValue;*)
//#UC END# *4F494C0D009A_4F49408A03C0_var*
begin
//#UC START# *4F494C0D009A_4F49408A03C0_impl*
 for l_Index := 0 to Pred(Count) do
  with ItemSlot(l_Index)^ do
   rWord.SetValuePrim(rValue, aCtx);
(* begin
  l_V := Items[l_Index];
  try
   l_V.rWord.SetValue(l_V.rValue, aCtx, false);
  finally
   Finalize(l_V);
  end;///try..finally
 end;//for l_Index*)
//#UC END# *4F494C0D009A_4F49408A03C0_impl*
end;//TtfwStoredValues.Restore

function TtfwStoredValues.Grow: PtfwStoredValue;
//#UC START# *56012ACE02B2_4F49408A03C0_var*
//#UC END# *56012ACE02B2_4F49408A03C0_var*
begin
//#UC START# *56012ACE02B2_4F49408A03C0_impl*
 Result := PtfwStoredValue(GrowByOne);
//#UC END# *56012ACE02B2_4F49408A03C0_impl*
end;//TtfwStoredValues.Grow

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwStoredValues.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4F49408A03C0_var*
//#UC END# *47A6FEE600FC_4F49408A03C0_var*
begin
//#UC START# *47A6FEE600FC_4F49408A03C0_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4F49408A03C0_impl*
end;//TtfwStoredValues.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(NoScripts)
end.
