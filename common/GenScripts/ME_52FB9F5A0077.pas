unit csMessageRecepientListPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csMessageRecepientListPrim.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , csMessageRecepient
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = TcsMessageRecepient;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TcsMessageRecepientListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TcsMessageRecepientListPrim
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
//#UC START# *47B2C42A0163_52FB9F5A0077_var*
//#UC END# *47B2C42A0163_52FB9F5A0077_var*
begin
//#UC START# *47B2C42A0163_52FB9F5A0077_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FB9F5A0077_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FB9F5A0077_var*
//#UC END# *47B99D4503A2_52FB9F5A0077_var*
begin
//#UC START# *47B99D4503A2_52FB9F5A0077_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_52FB9F5A0077_impl*
end;//CompareExistingItems

type _Instance_R_ = TcsMessageRecepientListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
