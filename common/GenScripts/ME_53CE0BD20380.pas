unit alcuSubmitterWorkThreadList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuSubmitterWorkThreadList.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , alcuAsyncSubmitter
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TalcuSubmitterWorkThread;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuSubmitterWorkThreadList = class(_l3UncomparabeObjectRefList_)
 end;//TalcuSubmitterWorkThreadList
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
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
//#UC START# *47B2C42A0163_53CE0BD20380_var*
//#UC END# *47B2C42A0163_53CE0BD20380_var*
begin
//#UC START# *47B2C42A0163_53CE0BD20380_impl*
 Assert(false);
//#UC END# *47B2C42A0163_53CE0BD20380_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53CE0BD20380_var*
//#UC END# *47B99D4503A2_53CE0BD20380_var*
begin
//#UC START# *47B99D4503A2_53CE0BD20380_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53CE0BD20380_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuSubmitterWorkThreadList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
