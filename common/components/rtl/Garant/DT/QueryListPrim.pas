unit QueryListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/QueryListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Query::TQueryListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  SavedQuery,
  l3PureMixIns,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes,
  l3NotifyPtrList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
 {$Define l3Items_IsProto}

 {$Define l3Items_HasChanging}

type
 _ItemType_ = TSavedQuery;
 _l3Changing_Parent_ = Tl3ProtoDataContainer;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 _l3UncomparabeObjectRefList_Parent_ = _l3Changing_;
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _l3ChangingChangedNotifier_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}
 _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
 {$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}
 _l3OpenArray_Parent_ = _l3LockedChange_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 TQueryListPrim = class(_l3OpenArray_)
 end;//TQueryListPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TQueryListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FCAC0E0384_var*
//#UC END# *47B2C42A0163_52FCAC0E0384_var*
begin
//#UC START# *47B2C42A0163_52FCAC0E0384_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FCAC0E0384_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_52FCAC0E0384_var*
//#UC END# *47B99D4503A2_52FCAC0E0384_var*
begin
//#UC START# *47B99D4503A2_52FCAC0E0384_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FCAC0E0384_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

type _Instance_R_ = TQueryListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}


{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}


{$IfEnd} //not Nemesis
end.