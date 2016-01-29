unit evSearcherAndReplacerPairList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evSearcherAndReplacerPairList.pas"
// Начат: 25.08.2011 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Containers::TevSearcherAndReplacerPairList
//
// {RequestLink:280009855}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 TevSearcherAndReplacerPair = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rSearcher : IevSearcher;
   rReplacer : IevReplacer;
 end;//TevSearcherAndReplacerPair

 {$Define l3Items_NoSort}

 _ItemType_ = TevSearcherAndReplacerPair;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TevSearcherAndReplacerPairList = class(_l3RecordListPrim_)
  {* [RequestLink:280009855] }
 end;//TevSearcherAndReplacerPairList

function TevSearcherAndReplacerPair_C(const aSearcher: IevSearcher;
     const aReplacer: IevReplacer): TevSearcherAndReplacerPair;

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevSearcherAndReplacerPairList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4E56306403C2_var*
//#UC END# *47B07CF403D0_4E56306403C2_var*
begin
//#UC START# *47B07CF403D0_4E56306403C2_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4E56306403C2_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E56306403C2_var*
//#UC END# *47B2C42A0163_4E56306403C2_var*
begin
//#UC START# *47B2C42A0163_4E56306403C2_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E56306403C2_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4E56306403C2_var*
//#UC END# *47B99D4503A2_4E56306403C2_var*
begin
//#UC START# *47B99D4503A2_4E56306403C2_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4E56306403C2_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSearcherAndReplacerPairList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}


function TevSearcherAndReplacerPair_C(const aSearcher: IevSearcher;
        const aReplacer: IevReplacer): TevSearcherAndReplacerPair;
//#UC START# *4E56313900E0_4E5630E20149_var*
//#UC END# *4E56313900E0_4E5630E20149_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4E56313900E0_4E5630E20149_impl*
 Result.rSearcher := aSearcher;
 Result.rReplacer := aReplacer;
//#UC END# *4E56313900E0_4E5630E20149_impl*
end;//TevSearcherAndReplacerPair.C

end.