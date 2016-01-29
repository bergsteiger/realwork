unit ncsMessageClassList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsMessageClassList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsMessageClassList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  ncsMessage,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _ItemType_ = TncsMessageClass;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TncsMessageClassList = class(_l3PtrList_)
 end;//TncsMessageClassList
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsMessageClassList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_54539F0C00AD_var*
//#UC END# *47B07CF403D0_54539F0C00AD_var*
begin
//#UC START# *47B07CF403D0_54539F0C00AD_impl*
 Result := AnsiSameText(A.GetTaggedDataType.AsString, B.GetTaggedDataType.AsString);
//#UC END# *47B07CF403D0_54539F0C00AD_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_54539F0C00AD_var*
//#UC END# *47B2C42A0163_54539F0C00AD_var*
begin
//#UC START# *47B2C42A0163_54539F0C00AD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_54539F0C00AD_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_54539F0C00AD_var*
//#UC END# *47B99D4503A2_54539F0C00AD_var*
begin
//#UC START# *47B99D4503A2_54539F0C00AD_impl*
 Result := AnsiCompareText(CI.rA.GetTaggedDataType.AsString, CI.rB.GetTaggedDataType.AsString);
//#UC END# *47B99D4503A2_54539F0C00AD_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsMessageClassList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}


{$IfEnd} //not Nemesis
end.