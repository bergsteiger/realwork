unit alcuTaskListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuTaskListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuTaskListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  l3ProtoDataContainer
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 _ItemType_ = TddProcessTask;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TalcuTaskListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TalcuTaskListPrim
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}

// start class TalcuTaskListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FA3DE1003D_var*
//#UC END# *47B2C42A0163_52FA3DE1003D_var*
begin
//#UC START# *47B2C42A0163_52FA3DE1003D_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA3DE1003D_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_52FA3DE1003D_var*
//#UC END# *47B99D4503A2_52FA3DE1003D_var*
begin
//#UC START# *47B99D4503A2_52FA3DE1003D_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FA3DE1003D_impl*
end;//CompareExistingItems

type _Instance_R_ = TalcuTaskListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //ServerTasks
end.