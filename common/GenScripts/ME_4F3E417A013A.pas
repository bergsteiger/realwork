unit kwStringListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwStringListPrim" MUID: (4F3E417A013A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , kwString
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TkwString;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TkwStringListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TkwStringListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
//#UC START# *47B2C42A0163_4F3E417A013A_var*
//#UC END# *47B2C42A0163_4F3E417A013A_var*
begin
//#UC START# *47B2C42A0163_4F3E417A013A_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F3E417A013A_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F3E417A013A_var*
//#UC END# *47B99D4503A2_4F3E417A013A_var*
begin
//#UC START# *47B99D4503A2_4F3E417A013A_impl*
 Result := l3Compare(l3PCharLen(CI.rA.Value), l3PCharLen(CI.rB.Value));
//#UC END# *47B99D4503A2_4F3E417A013A_impl*
end;//CompareExistingItems

type _Instance_R_ = TkwStringListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
