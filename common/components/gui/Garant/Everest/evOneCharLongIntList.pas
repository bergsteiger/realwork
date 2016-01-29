unit evOneCharLongIntList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evOneCharLongIntList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TevOneCharLongIntList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Integer;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}
 TevOneCharLongIntList = class(_l3AtomicListPrim_)
 end;//TevOneCharLongIntList

implementation

uses
  l3UnitsTools,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevOneCharLongIntList

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4F2F68D80106_var*
//#UC END# *47B99D4503A2_4F2F68D80106_var*
begin
//#UC START# *47B99D4503A2_4F2F68D80106_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 if Abs(CI.rA^ - CI.rB^) <= evCellWidthEpsilon then
  Result := 0
 else
  Result := CI.rA^ - CI.rB^;
//#UC END# *47B99D4503A2_4F2F68D80106_impl*
end;//CompareExistingItems

type _Instance_R_ = TevOneCharLongIntList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicListPrim.imp.pas}

end.