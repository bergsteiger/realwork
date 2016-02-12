unit l3IDIndexPrim;
 {* Индекс объектов по их Handle. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3IDIndexPrim.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3PrimString;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3IDIndexPrim = class(_l3UncomparabeObjectRefList_)
  {* Индекс объектов по их Handle. }
 end;//Tl3IDIndexPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B9AB6902AF_var*
//#UC END# *47B2C42A0163_47B9AB6902AF_var*
begin
//#UC START# *47B2C42A0163_47B9AB6902AF_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B9AB6902AF_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47B9AB6902AF_var*
//#UC END# *47B99D4503A2_47B9AB6902AF_var*
begin
//#UC START# *47B99D4503A2_47B9AB6902AF_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA^.StringID - CI.rB^.StringID;
//#UC END# *47B99D4503A2_47B9AB6902AF_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3IDIndexPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
