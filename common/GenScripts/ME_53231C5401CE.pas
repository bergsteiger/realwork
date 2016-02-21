unit k2ToolPrimList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2ToolPrimList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2ToolPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2ToolPrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tk2ToolPrimList = class(_l3UncomparabeObjectRefList_)
 end;//Tk2ToolPrimList

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
//#UC START# *47B2C42A0163_53231C5401CE_var*
//#UC END# *47B2C42A0163_53231C5401CE_var*
begin
//#UC START# *47B2C42A0163_53231C5401CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53231C5401CE_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53231C5401CE_var*
//#UC END# *47B99D4503A2_53231C5401CE_var*
begin
//#UC START# *47B99D4503A2_53231C5401CE_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53231C5401CE_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2ToolPrimList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
