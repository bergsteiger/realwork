unit l3BaseWithIDListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3BaseWithIDListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3BaseWithIDListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleDataContainer,
  l3BaseWithID,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tl3BaseWithID;
 _l3UncomparabeObjectRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3BaseWithIDListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tl3BaseWithIDListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tl3BaseWithIDListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47BD864F00D2_var*
//#UC END# *47B2C42A0163_47BD864F00D2_var*
begin
//#UC START# *47B2C42A0163_47BD864F00D2_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47BD864F00D2_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_47BD864F00D2_var*
//#UC END# *47B99D4503A2_47BD864F00D2_var*
begin
//#UC START# *47B99D4503A2_47BD864F00D2_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.ID - CI.rB.ID;
//#UC END# *47B99D4503A2_47BD864F00D2_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3BaseWithIDListPrim;

{$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}

end.