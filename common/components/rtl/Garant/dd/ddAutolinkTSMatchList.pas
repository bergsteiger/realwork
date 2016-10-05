unit ddAutolinkTSMatchList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAutolinkTSMatchList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddAutolinkTSMatchList" MUID: (57E5134103D5)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddAutolinkInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IddAutolinkTSMatch;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TddAutolinkTSMatchList = class(_l3InterfaceRefListPrim_)
  public
   function IsMatch(aDocType: Integer;
    aSource: Integer): Boolean;
 end;//TddAutolinkTSMatchList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57E5134103D5impl_uses*
 //#UC END# *57E5134103D5impl_uses*
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57E5134103D5_var*
//#UC END# *47B07CF403D0_57E5134103D5_var*
begin
//#UC START# *47B07CF403D0_57E5134103D5_impl*
 Result := (A.DocType = B.DocType) and (A.Source = B.Source);
//#UC END# *47B07CF403D0_57E5134103D5_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57E5134103D5_var*
//#UC END# *47B2C42A0163_57E5134103D5_var*
begin
//#UC START# *47B2C42A0163_57E5134103D5_impl*
 Assert(False);
//#UC END# *47B2C42A0163_57E5134103D5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57E5134103D5_var*
//#UC END# *47B99D4503A2_57E5134103D5_var*
begin
//#UC START# *47B99D4503A2_57E5134103D5_impl*
 Assert(False);
 Result := -1;
//#UC END# *47B99D4503A2_57E5134103D5_impl*
end;//CompareExistingItems

type _Instance_R_ = TddAutolinkTSMatchList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

function TddAutolinkTSMatchList.IsMatch(aDocType: Integer;
 aSource: Integer): Boolean;
//#UC START# *57E517A8014F_57E5134103D5_var*
var
 I: Integer;
//#UC END# *57E517A8014F_57E5134103D5_var*
begin
//#UC START# *57E517A8014F_57E5134103D5_impl*
 Result := False;
 for I := 0 to Hi do
  if Items[I].IsMatch(aDocType, aSource) then
  begin
   Result := True;
   Break;
  end;
//#UC END# *57E517A8014F_57E5134103D5_impl*
end;//TddAutolinkTSMatchList.IsMatch

end.
