unit evCellsOffsetsPairList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evCellsOffsetsPairList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TevCellsOffsetsPairList
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
  evCellsOffsetsPair,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TevCellsOffsetsPair;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevCellsOffsetsPairList = class(_l3UncomparabeObjectRefList_)
 public
 // public methods
   function PenultimateItem: TevCellsOffsetsPair;
 end;//TevCellsOffsetsPairList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevCellsOffsetsPairList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F2F72A103AB_var*
//#UC END# *47B2C42A0163_4F2F72A103AB_var*
begin
//#UC START# *47B2C42A0163_4F2F72A103AB_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F2F72A103AB_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4F2F72A103AB_var*
//#UC END# *47B99D4503A2_4F2F72A103AB_var*
begin
//#UC START# *47B99D4503A2_4F2F72A103AB_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F2F72A103AB_impl*
end;//CompareExistingItems

type _Instance_R_ = TevCellsOffsetsPairList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class TevCellsOffsetsPairList

function TevCellsOffsetsPairList.PenultimateItem: TevCellsOffsetsPair;
//#UC START# *4FC618A7012C_4F2F72A103AB_var*
//#UC END# *4FC618A7012C_4F2F72A103AB_var*
begin
//#UC START# *4FC618A7012C_4F2F72A103AB_impl*
 if Count > 1 then
  Result := Items[Count - 2]
 else
  Result := nil;
//#UC END# *4FC618A7012C_4F2F72A103AB_impl*
end;//TevCellsOffsetsPairList.PenultimateItem

end.