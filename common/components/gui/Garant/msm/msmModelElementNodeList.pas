unit msmModelElementNodeList;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementNodeList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementNodeList" MUID: (57AC61D402B3)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmModelElementNode
 , l3TreeInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TmsmModelElementNode;
 _l3RefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}
 TmsmModelElementNodeList = class(_l3RefList_)
  private
   f_LastAccessedElementIndex: Integer;
  protected
   function GetItem(Index: Integer): _ItemType_; override;
  public
   function IndexOfNode(const aNode: Il3SimpleNode): Integer;
   function AddNode(const aNode: Il3SimpleNode): Integer;
   procedure InsertNode(anIndex: Integer;
    const aNode: Il3SimpleNode);
   procedure RemoveNode(const aNode: Il3SimpleNode);
   function IndexOf(anItem: TmsmModelElementNode): Integer;
   procedure Remove(anItem: TmsmModelElementNode);
 end;//TmsmModelElementNodeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57AC61D402B3impl_uses*
 //#UC END# *57AC61D402B3impl_uses*
;

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
//#UC START# *47B07CF403D0_57AC61D402B3_var*
//#UC END# *47B07CF403D0_57AC61D402B3_var*
begin
//#UC START# *47B07CF403D0_57AC61D402B3_impl*
 Result := Il3SimpleNode(A).IsSame(B);
//#UC END# *47B07CF403D0_57AC61D402B3_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57AC61D402B3_var*
//#UC END# *47B2C42A0163_57AC61D402B3_var*
begin
//#UC START# *47B2C42A0163_57AC61D402B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57AC61D402B3_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_57AC61D402B3_var*
//#UC END# *47B935AF0066_57AC61D402B3_var*
begin
//#UC START# *47B935AF0066_57AC61D402B3_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_57AC61D402B3_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_57AC61D402B3_var*
//#UC END# *47B94A5C006E_57AC61D402B3_var*
begin
//#UC START# *47B94A5C006E_57AC61D402B3_impl*
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_57AC61D402B3_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57AC61D402B3_var*
//#UC END# *47B99D4503A2_57AC61D402B3_var*
begin
//#UC START# *47B99D4503A2_57AC61D402B3_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57AC61D402B3_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmModelElementNodeList;

{$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}

function TmsmModelElementNodeList.IndexOfNode(const aNode: Il3SimpleNode): Integer;
//#UC START# *57AC740902D1_57AC61D402B3_var*
//#UC END# *57AC740902D1_57AC61D402B3_var*
begin
//#UC START# *57AC740902D1_57AC61D402B3_impl*
 Result := IndexOf((aNode As ITmsmModelElementNodeWrap).GetSelf);
//#UC END# *57AC740902D1_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.IndexOfNode

function TmsmModelElementNodeList.AddNode(const aNode: Il3SimpleNode): Integer;
//#UC START# *57AC79C3032D_57AC61D402B3_var*
//#UC END# *57AC79C3032D_57AC61D402B3_var*
begin
//#UC START# *57AC79C3032D_57AC61D402B3_impl*
 Result := Add((aNode As ITmsmModelElementNodeWrap).GetSelf);
//#UC END# *57AC79C3032D_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.AddNode

procedure TmsmModelElementNodeList.InsertNode(anIndex: Integer;
 const aNode: Il3SimpleNode);
//#UC START# *57AC79D40359_57AC61D402B3_var*
//#UC END# *57AC79D40359_57AC61D402B3_var*
begin
//#UC START# *57AC79D40359_57AC61D402B3_impl*
 Insert(anIndex, (aNode As ITmsmModelElementNodeWrap).GetSelf);
//#UC END# *57AC79D40359_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.InsertNode

procedure TmsmModelElementNodeList.RemoveNode(const aNode: Il3SimpleNode);
//#UC START# *57AC79F901CC_57AC61D402B3_var*
//#UC END# *57AC79F901CC_57AC61D402B3_var*
begin
//#UC START# *57AC79F901CC_57AC61D402B3_impl*
 Remove((aNode As ITmsmModelElementNodeWrap).GetSelf);
//#UC END# *57AC79F901CC_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.RemoveNode

function TmsmModelElementNodeList.IndexOf(anItem: TmsmModelElementNode): Integer;
//#UC START# *57DFBB530171_57AC61D402B3_var*
//#UC END# *57DFBB530171_57AC61D402B3_var*
begin
//#UC START# *57DFBB530171_57AC61D402B3_impl*
 if (f_LastAccessedElementIndex >= 0) AND (f_LastAccessedElementIndex < Count) then
 begin
  if Il3SimpleNode(Items[f_LastAccessedElementIndex]).IsSame(anItem) then
  begin
   Result := f_LastAccessedElementIndex;
   Exit;
  end;//Il3SimpleNode(Items[f_LastAccessedElementIndex]).IsSame(anItem)
 end;//f_LastAccessedElementIndex >= 0..
 Result := inherited IndexOf(anItem);
//#UC END# *57DFBB530171_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.IndexOf

procedure TmsmModelElementNodeList.Remove(anItem: TmsmModelElementNode);
//#UC START# *57DFBB730022_57AC61D402B3_var*
var
 l_Index : Integer;
//#UC END# *57DFBB730022_57AC61D402B3_var*
begin
//#UC START# *57DFBB730022_57AC61D402B3_impl*
 l_Index := IndexOf(anItem);
 if (l_Index >= 0) then
  Delete(l_Index);
//#UC END# *57DFBB730022_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.Remove

function TmsmModelElementNodeList.GetItem(Index: Integer): _ItemType_;
//#UC START# *47B1CCC901BE_57AC61D402B3_var*
//#UC END# *47B1CCC901BE_57AC61D402B3_var*
begin
//#UC START# *47B1CCC901BE_57AC61D402B3_impl*
 Result := inherited GetItem(Index);
 f_LastAccessedElementIndex := Index;
//#UC END# *47B1CCC901BE_57AC61D402B3_impl*
end;//TmsmModelElementNodeList.GetItem

end.
