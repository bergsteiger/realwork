unit arBelaCountryList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ar"
// Модуль: "w:/common/components/rtl/Garant/ar/arBelaCountryList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ar::Belarus::TarBelaCountryList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\l3Define.inc}

interface

{$If not defined(Nemesis)}
uses
  l3Interfaces,
  l3Date,
  l3ProtoDataContainer,
  l3Memory,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TarBelaCountryRec = record
   rName : Il3CString;
   rSigned : TStDate;
   rRatify : TStDate;
 end;//TarBelaCountryRec

 _ItemType_ = TarBelaCountryRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TarBelaCountryList = class(_l3RecordListPrim_)
 end;//TarBelaCountryList
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TarBelaCountryList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_56B08EB602EB_var*
//#UC END# *47B07CF403D0_56B08EB602EB_var*
begin
//#UC START# *47B07CF403D0_56B08EB602EB_impl*
 Result := l3Same(A.rName, B.rName) and (A.rSigned = B.rSigned) and (A.rRatify = B.rRatify);
//#UC END# *47B07CF403D0_56B08EB602EB_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_56B08EB602EB_var*
//#UC END# *47B2C42A0163_56B08EB602EB_var*
begin
//#UC START# *47B2C42A0163_56B08EB602EB_impl*
 Assert(False);
//#UC END# *47B2C42A0163_56B08EB602EB_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_56B08EB602EB_var*
//#UC END# *47B99D4503A2_56B08EB602EB_var*
begin
//#UC START# *47B99D4503A2_56B08EB602EB_impl*
 Result := l3Compare(CI.rA.rName.AsWStr, CI.rB.rName.AsWStr);
 if Result = 0 then
  Result := CI.rA.rSigned - CI.rB.rSigned;
 if Result = 0 then
  Result := CI.rA.rRatify - CI.rB.rRatify;
//#UC END# *47B99D4503A2_56B08EB602EB_impl*
end;//CompareExistingItems

type _Instance_R_ = TarBelaCountryList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}


{$IfEnd} //not Nemesis
end.