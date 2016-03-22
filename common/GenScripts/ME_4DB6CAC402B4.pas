unit tfwWordRefList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordRefList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwWordRefList" MUID: (4DB6CAC402B4)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwWord;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TtfwWordRefList = class(_l3UncomparabeObjectRefList_)
 end;//TtfwWordRefList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
//#UC START# *47B2C42A0163_4DB6CAC402B4_var*
//#UC END# *47B2C42A0163_4DB6CAC402B4_var*
begin
//#UC START# *47B2C42A0163_4DB6CAC402B4_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4DB6CAC402B4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4DB6CAC402B4_var*
//#UC END# *47B99D4503A2_4DB6CAC402B4_var*
begin
//#UC START# *47B99D4503A2_4DB6CAC402B4_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4DB6CAC402B4_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwWordRefList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
