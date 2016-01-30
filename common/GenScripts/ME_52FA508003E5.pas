unit ddClientMessageSortableListPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddClientMessageSortableListPrim.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , csClientMessageRequest
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddClientMessage;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TddClientMessageSortableListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TddClientMessageSortableListPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FA508003E5_var*
//#UC END# *47B2C42A0163_52FA508003E5_var*
begin
//#UC START# *47B2C42A0163_52FA508003E5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA508003E5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FA508003E5_var*
//#UC END# *47B99D4503A2_52FA508003E5_var*
begin
//#UC START# *47B99D4503A2_52FA508003E5_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FA508003E5_impl*
end;//CompareExistingItems

type _Instance_R_ = TddClientMessageSortableListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
