unit ncsReplyDecsriptionList;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsReplyDecsriptionList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsReplyDecsriptionList" MUID: (5461D6FC00F7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsReplyDescription
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TncsReplyDescription;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TncsReplyDecsriptionList = class(_l3UncomparabeObjectRefList_)
 end;//TncsReplyDecsriptionList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5461D6FC00F7impl_uses*
 //#UC END# *5461D6FC00F7impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5461D6FC00F7_var*
//#UC END# *47B2C42A0163_5461D6FC00F7_var*
begin
//#UC START# *47B2C42A0163_5461D6FC00F7_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5461D6FC00F7_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5461D6FC00F7_var*
//#UC END# *47B99D4503A2_5461D6FC00F7_var*
begin
//#UC START# *47B99D4503A2_5461D6FC00F7_impl*
 Assert(False);
//#UC END# *47B99D4503A2_5461D6FC00F7_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsReplyDecsriptionList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
