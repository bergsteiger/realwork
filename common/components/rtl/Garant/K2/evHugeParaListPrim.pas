unit evHugeParaListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/evHugeParaListPrim.pas"
// Начат: 17.06.2009 15:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::TevHugeParaListPrim
//
// Список параграфов с числом свойств больше 32
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ListTag,
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_NoOwner}

type
//#UC START# *4A6062890343ci*
 {$Define l3Items_NoSort}
//#UC END# *4A6062890343ci*
 _l3VariantListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}
//#UC START# *4A6062890343cit*
//#UC END# *4A6062890343cit*
 TevHugeParaListPrim = class(_l3VariantListPrim_)
  {* Список параграфов с числом свойств больше 32 }
//#UC START# *4A6062890343publ*
//#UC END# *4A6062890343publ*
 end;//TevHugeParaListPrim

implementation

uses
  k2BaseTypes,
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

// start class TevHugeParaListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A6062890343_var*
//#UC END# *47B2C42A0163_4A6062890343_var*
begin
//#UC START# *47B2C42A0163_4A6062890343_impl*
 aTo.AssignTag(aFrom, k2_amAll - [k2_amNull]);
//#UC END# *47B2C42A0163_4A6062890343_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4A6062890343_var*
//#UC END# *47B99D4503A2_4A6062890343_var*
begin
//#UC START# *47B99D4503A2_4A6062890343_impl*
 {$IfDef l3Items_HasCustomSort}
 Result := CI.rA^.CompareWithTag(CI.rB^, CI.rSortIndex);
 {$Else  l3Items_HasCustomSort}
 Result := -1;
 Assert(false);
 {$EndIf l3Items_HasCustomSort}
//#UC END# *47B99D4503A2_4A6062890343_impl*
end;//CompareExistingItems

type _Instance_R_ = TevHugeParaListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}


//#UC START# *4A6062890343impl*
//#UC END# *4A6062890343impl*
end.