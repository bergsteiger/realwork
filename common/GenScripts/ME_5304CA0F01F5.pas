unit k2DictionaryIDIndexPrim;

// ������: "w:\common\components\rtl\Garant\K2\k2DictionaryIDIndexPrim.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

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
 _l3VariantListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}
 Tk2DictionaryIDIndexPrim = class(_l3VariantListPrim_)
 end;//Tk2DictionaryIDIndexPrim

implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5304CA0F01F5_var*
//#UC END# *47B2C42A0163_5304CA0F01F5_var*
begin
//#UC START# *47B2C42A0163_5304CA0F01F5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_5304CA0F01F5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_5304CA0F01F5_var*
//#UC END# *47B99D4503A2_5304CA0F01F5_var*
begin
//#UC START# *47B99D4503A2_5304CA0F01F5_impl*
 Result := CI.rA^.IntA[k2_tiHandle] - CI.rB^.IntA[k2_tiHandle];
//#UC END# *47B99D4503A2_5304CA0F01F5_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2DictionaryIDIndexPrim;

{$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}

end.
