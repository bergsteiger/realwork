unit evStandardStylesListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStandardStylesListPrim.pas"
// Начат: 24.08.2011 19:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevStandardStylesListPrim
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
  evResultFontInterfaces,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 TevStandardStylesCacheByFixedFont = array [Boolean] of IevResultFont;

 TevStandardStylesCacheByVisibility = array [Boolean] of TevStandardStylesCacheByFixedFont;

 TevStandardStylesCacheByJustification = array [Boolean] of TevStandardStylesCacheByVisibility;

 TevStandardStylesCacheItem = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rValue : TevStandardStylesCacheByJustification;
   rID : Integer;
 end;//TevStandardStylesCacheItem

 _ItemType_ = TevStandardStylesCacheItem;
 _l3RecordListPrimPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}
 TevStandardStylesListPrim = class(_l3RecordListPrimPrim_)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   class procedure EvFreeStandardStylesCache(var theCache: TevStandardStylesCacheByJustification);
 end;//TevStandardStylesListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevStandardStylesListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  ); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4E55123003CD_var*
//#UC END# *47B07CF403D0_4E55123003CD_var*
begin
//#UC START# *47B07CF403D0_4E55123003CD_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4E55123003CD_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E55123003CD_var*
//#UC END# *47B2C42A0163_4E55123003CD_var*
begin
//#UC START# *47B2C42A0163_4E55123003CD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E55123003CD_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_4E55123003CD_var*
//#UC END# *47B94A5C006E_4E55123003CD_var*
begin
//#UC START# *47B94A5C006E_4E55123003CD_impl*
 TevStandardStylesListPrim.EvFreeStandardStylesCache(aPlace.rValue);
 Finalize(aPlace);
//#UC END# *47B94A5C006E_4E55123003CD_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4E55123003CD_var*
//#UC END# *47B99D4503A2_4E55123003CD_var*
begin
//#UC START# *47B99D4503A2_4E55123003CD_impl*
 Result := CI.rA.rID - CI.rB.rID;
//#UC END# *47B99D4503A2_4E55123003CD_impl*
end;//CompareExistingItems

type _Instance_R_ = TevStandardStylesListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}

// start class TevStandardStylesListPrim

class procedure TevStandardStylesListPrim.EvFreeStandardStylesCache(var theCache: TevStandardStylesCacheByJustification);
//#UC START# *4E55156E009C_4E55123003CD_var*
var
 j : Boolean{TevIndentType};
 k : Boolean;
 l : Boolean;
//#UC END# *4E55156E009C_4E55123003CD_var*
begin
//#UC START# *4E55156E009C_4E55123003CD_impl*
 for j := Low(j) to High(j) do
  for k := Low(k) to High(k) do
   for l := Low(l) to High(l) do
    if (theCache[j, k, l] <> nil) then
     theCache[j, k, l] := nil;
//#UC END# *4E55156E009C_4E55123003CD_impl*
end;//TevStandardStylesListPrim.EvFreeStandardStylesCache
// start class TevStandardStylesListPrim

procedure TevStandardStylesListPrim.InitFields;
//#UC START# *47A042E100E2_4E55123003CD_var*
//#UC END# *47A042E100E2_4E55123003CD_var*
begin
//#UC START# *47A042E100E2_4E55123003CD_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4E55123003CD_impl*
end;//TevStandardStylesListPrim.InitFields

end.