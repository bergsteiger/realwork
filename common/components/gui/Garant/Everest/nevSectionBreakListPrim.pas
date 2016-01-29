unit nevSectionBreakListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevSectionBreakListPrim.pas"
// Начат: 11.10.2008 9:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Document::TnevSectionBreakListPrim
//
// Базовый список разрывов разделов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = InevObject;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TnevSectionBreakListPrim = class(_l3InterfaceRefListPrim_)
  {* Базовый список разрывов разделов }
 end;//TnevSectionBreakListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TnevSectionBreakListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_49192D0702C5_var*
//#UC END# *47B07CF403D0_49192D0702C5_var*
begin
//#UC START# *47B07CF403D0_49192D0702C5_impl*
 Result := (A = B) OR A.AsObject.Box.IsSame(B.AsObject.Box);
//#UC END# *47B07CF403D0_49192D0702C5_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_49192D0702C5_var*
//#UC END# *47B2C42A0163_49192D0702C5_var*
begin
//#UC START# *47B2C42A0163_49192D0702C5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_49192D0702C5_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_49192D0702C5_var*
var
 l_PA : InevBasePoint;
 l_PB : InevBasePoint;
//#UC END# *47B99D4503A2_49192D0702C5_var*
begin
//#UC START# *47B99D4503A2_49192D0702C5_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 l_PA := CI.rA.MakePoint.PointToParentByLevel(MaxInt);
 l_PB := CI.rB.MakePoint.PointToParentByLevel(MaxInt);
 Result := l_PA.Compare(l_PB);
//#UC END# *47B99D4503A2_49192D0702C5_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevSectionBreakListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.