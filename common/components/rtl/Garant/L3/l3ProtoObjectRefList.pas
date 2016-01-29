unit l3ProtoObjectRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3ProtoObjectRefList.pas"
// Начат: 18.11.2010 15:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3ProtoObjectRefList
//
// Список ССЫЛОК на Tl3ProtoObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tl3ProtoObject;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ProtoObjectRefList = class(_l3UncomparabeObjectRefList_)
  {* Список ССЫЛОК на Tl3ProtoObject }
 end;//Tl3ProtoObjectRefList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tl3ProtoObjectRefList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4CE521C80107_var*
//#UC END# *47B2C42A0163_4CE521C80107_var*
begin
//#UC START# *47B2C42A0163_4CE521C80107_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4CE521C80107_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4CE521C80107_var*
//#UC END# *47B99D4503A2_4CE521C80107_var*
begin
//#UC START# *47B99D4503A2_4CE521C80107_impl*
 Assert(false, 'Критерий сравнения двух нетипизированных объектов на самом деле непонятен');
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_4CE521C80107_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ProtoObjectRefList;

{$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}

end.