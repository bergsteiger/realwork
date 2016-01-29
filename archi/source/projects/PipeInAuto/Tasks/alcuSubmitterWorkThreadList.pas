unit alcuSubmitterWorkThreadList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuSubmitterWorkThreadList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ServerAsyncExecution::TalcuSubmitterWorkThreadList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3ProtoDataContainer,
  alcuAsyncSubmitter,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
type
 _ItemType_ = TalcuSubmitterWorkThread;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuSubmitterWorkThreadList = class(_l3UncomparabeObjectRefList_)
 end;//TalcuSubmitterWorkThreadList
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}

// start class TalcuSubmitterWorkThreadList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53CE0BD20380_var*
//#UC END# *47B2C42A0163_53CE0BD20380_var*
begin
//#UC START# *47B2C42A0163_53CE0BD20380_impl*
 Assert(false);
//#UC END# *47B2C42A0163_53CE0BD20380_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
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


{$IfEnd} //AppServerSide AND ServerTasks
end.