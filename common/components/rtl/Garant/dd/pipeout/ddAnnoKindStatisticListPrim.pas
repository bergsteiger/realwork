unit ddAnnoKindStatisticListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/PipeOut/ddAnnoKindStatisticListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::PipeOut::TddAnnoKindStatisticListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
  l3ProtoDataContainer,
  ddPipeOutInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_HasCustomSort}

const
  { Constants }
 dd_siByName = 1;

type
 _ItemType_ = IddAnnoKindSortItem;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TddAnnoKindStatisticListPrim = class(_l3InterfaceRefListPrim_)
 end;//TddAnnoKindStatisticListPrim

implementation

uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TddAnnoKindStatisticListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_564C65EC0136_var*
//#UC END# *47B07CF403D0_564C65EC0136_var*
begin
//#UC START# *47B07CF403D0_564C65EC0136_impl*
 Result := (A.ID = B.ID);
//#UC END# *47B07CF403D0_564C65EC0136_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_564C65EC0136_var*
//#UC END# *47B2C42A0163_564C65EC0136_var*
begin
//#UC START# *47B2C42A0163_564C65EC0136_impl*
 Assert(False, 'TddAnnoKindStatisticListPrim.AssignItem');
//#UC END# *47B2C42A0163_564C65EC0136_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_564C65EC0136_var*
//#UC END# *47B99D4503A2_564C65EC0136_var*
begin
//#UC START# *47B99D4503A2_564C65EC0136_impl*
 if CI.rSortIndex = l3_siNative then
  Result := CI.rA.ID - CI.rB.ID
 else
  Result := l3Compare(CI.rA.Name.AsWStr, CI.rB.Name.AsWStr, l3_siCaseUnsensitive)
//#UC END# *47B99D4503A2_564C65EC0136_impl*
end;//CompareExistingItems

type _Instance_R_ = TddAnnoKindStatisticListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.