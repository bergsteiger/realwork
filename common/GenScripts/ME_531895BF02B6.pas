unit k2FontNameListPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\k2FontNameListPrim.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2FontName
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2FontName;
 _l3UncomparabeObjectRefList_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 Tk2FontNameListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tk2FontNameListPrim

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_531895BF02B6_var*
//#UC END# *47B2C42A0163_531895BF02B6_var*
begin
//#UC START# *47B2C42A0163_531895BF02B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_531895BF02B6_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_531895BF02B6_var*
//#UC END# *47B99D4503A2_531895BF02B6_var*
begin
//#UC START# *47B99D4503A2_531895BF02B6_impl*
 Result := l3Compare(CI.rA.AsWStr, CI.rB.AsWStr, l3_siCaseUnsensitive);
//#UC END# *47B99D4503A2_531895BF02B6_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2FontNameListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}

end.
