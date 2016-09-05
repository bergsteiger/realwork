unit tfwValueTypesListPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwValueTypesListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwValueTypesListPrim" MUID: (55BF376C001D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwValueTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwValueTypes;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TtfwValueTypesListPrim = {abstract} class(_l3UncomparabeObjectRefList_)
 end;//TtfwValueTypesListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55BF376C001Dimpl_uses*
 //#UC END# *55BF376C001Dimpl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55BF376C001D_var*
//#UC END# *47B2C42A0163_55BF376C001D_var*
begin
//#UC START# *47B2C42A0163_55BF376C001D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_55BF376C001D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55BF376C001D_var*
//#UC END# *47B99D4503A2_55BF376C001D_var*
begin
//#UC START# *47B99D4503A2_55BF376C001D_impl*
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_55BF376C001D_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwValueTypesListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
