unit daSortFieldList;

// Модуль: "w:\common\components\rtl\Garant\DA\daSortFieldList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaSortFieldList" MUID: (5680F609012D)

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

type
 _ItemType_ = IdaSortField;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TdaSortFieldList = class(_l3InterfaceRefListPrim_)
 end;//TdaSortFieldList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5680F609012Dimpl_uses*
 //#UC END# *5680F609012Dimpl_uses*
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
//#UC START# *47B07CF403D0_5680F609012D_var*
//#UC END# *47B07CF403D0_5680F609012D_var*
begin
//#UC START# *47B07CF403D0_5680F609012D_impl*
 Result := A.SelectField = B.SelectField;
//#UC END# *47B07CF403D0_5680F609012D_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5680F609012D_var*
//#UC END# *47B2C42A0163_5680F609012D_var*
begin
//#UC START# *47B2C42A0163_5680F609012D_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5680F609012D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5680F609012D_var*
//#UC END# *47B99D4503A2_5680F609012D_var*
begin
//#UC START# *47B99D4503A2_5680F609012D_impl*
 Result := -1;
 Assert(False);
//#UC END# *47B99D4503A2_5680F609012D_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaSortFieldList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.
