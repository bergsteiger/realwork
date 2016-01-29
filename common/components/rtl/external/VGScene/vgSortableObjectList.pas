unit vgSortableObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgSortableObjectList.pas"
// Начат: 11.02.2011 15:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgSortableObjectList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoDataContainer,
  vgCustomObject,
  vgTypesPrim,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 _ItemType_ = TvgCustomObject;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TvgSortableObjectList = class(_l3PtrList_)
 public
 // public methods
   procedure Sort(aComparer: TvgObjectSortCompare);
 end;//TvgSortableObjectList
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

var
   f_CurrentComparer : TvgObjectSortCompare = nil;

// start class TvgSortableObjectList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4D552B230161_var*
//#UC END# *47B07CF403D0_4D552B230161_var*
begin
//#UC START# *47B07CF403D0_4D552B230161_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_4D552B230161_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D552B230161_var*
//#UC END# *47B2C42A0163_4D552B230161_var*
begin
//#UC START# *47B2C42A0163_4D552B230161_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D552B230161_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4D552B230161_var*
//#UC END# *47B99D4503A2_4D552B230161_var*
begin
//#UC START# *47B99D4503A2_4D552B230161_impl*
 Assert(Assigned(f_CurrentComparer));
 Result := f_CurrentComparer(CI.rA^, CI.rB^);
//#UC END# *47B99D4503A2_4D552B230161_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgSortableObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}

// start class TvgSortableObjectList

procedure TvgSortableObjectList.Sort(aComparer: TvgObjectSortCompare);
//#UC START# *4D552BB90144_4D552B230161_var*
//#UC END# *4D552BB90144_4D552B230161_var*
begin
//#UC START# *4D552BB90144_4D552B230161_impl*
 Assert(not Assigned(f_CurrentComparer));
 f_CurrentComparer := aComparer;
 try
  inherited Sort;
 finally
  f_CurrentComparer := nil;
 end;//try..finaly
//#UC END# *4D552BB90144_4D552B230161_impl*
end;//TvgSortableObjectList.Sort

{$IfEnd} //not NoVGScene

end.