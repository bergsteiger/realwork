unit alcuTaskListPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuTaskListPrim" MUID: (52FA3DE1003D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddProcessTask;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuTaskListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TalcuTaskListPrim
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
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
//#UC START# *47B2C42A0163_52FA3DE1003D_var*
//#UC END# *47B2C42A0163_52FA3DE1003D_var*
begin
//#UC START# *47B2C42A0163_52FA3DE1003D_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA3DE1003D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FA3DE1003D_var*
//#UC END# *47B99D4503A2_52FA3DE1003D_var*
begin
//#UC START# *47B99D4503A2_52FA3DE1003D_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FA3DE1003D_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuTaskListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(ServerTasks)

end.
