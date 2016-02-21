unit daFieldDescriptionListPrim;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldDescriptionListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NeedsBeforeFreeItem}

type
 _ItemType_ = IdaFieldDescription;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TdaFieldDescriptionListPrim = class(_l3InterfaceRefListPrim_)
  protected
   {$If Defined(l3Items_NeedsBeforeFreeItem)}
   procedure BeforeFreeItem(var aPlace: _ItemType_); override;
    {* Нотификация потомкам об освобождении элемента списка }
   {$IfEnd} // Defined(l3Items_NeedsBeforeFreeItem)
 end;//TdaFieldDescriptionListPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
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
//#UC START# *47B07CF403D0_5538E9AE0163_var*
//#UC END# *47B07CF403D0_5538E9AE0163_var*
begin
//#UC START# *47B07CF403D0_5538E9AE0163_impl*
 Result := AnsiSameText(A.Name, B.Name);
//#UC END# *47B07CF403D0_5538E9AE0163_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5538E9AE0163_var*
//#UC END# *47B2C42A0163_5538E9AE0163_var*
begin
//#UC START# *47B2C42A0163_5538E9AE0163_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5538E9AE0163_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5538E9AE0163_var*
//#UC END# *47B99D4503A2_5538E9AE0163_var*
begin
//#UC START# *47B99D4503A2_5538E9AE0163_impl*
 Result := AnsiCompareText(CI.rA.Name, CI.rB.Name);
//#UC END# *47B99D4503A2_5538E9AE0163_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaFieldDescriptionListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

{$If Defined(l3Items_NeedsBeforeFreeItem)}
procedure TdaFieldDescriptionListPrim.BeforeFreeItem(var aPlace: _ItemType_);
 {* Нотификация потомкам об освобождении элемента списка }
//#UC START# *4B87FCF8038B_5538E9AE0163_var*
//#UC END# *4B87FCF8038B_5538E9AE0163_var*
begin
//#UC START# *4B87FCF8038B_5538E9AE0163_impl*
 aPlace.BindToTable;
//#UC END# *4B87FCF8038B_5538E9AE0163_impl*
end;//TdaFieldDescriptionListPrim.BeforeFreeItem
{$IfEnd} // Defined(l3Items_NeedsBeforeFreeItem)

end.
