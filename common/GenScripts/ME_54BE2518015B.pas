unit alcuDetachedExecutorList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDetachedExecutorList.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Base
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3ThreadContainer;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuDetachedExecutorList = class(_l3UncomparabeObjectRefList_)
 end;//TalcuDetachedExecutorList
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_54BE2518015B_var*
//#UC END# *47B2C42A0163_54BE2518015B_var*
begin
//#UC START# *47B2C42A0163_54BE2518015B_impl*
 Assert(False);
//#UC END# *47B2C42A0163_54BE2518015B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_54BE2518015B_var*
//#UC END# *47B99D4503A2_54BE2518015B_var*
begin
//#UC START# *47B99D4503A2_54BE2518015B_impl*
 Assert(False);
//#UC END# *47B99D4503A2_54BE2518015B_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuDetachedExecutorList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(ServerTasks)

end.
