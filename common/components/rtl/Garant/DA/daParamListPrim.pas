unit daParamListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daParamListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaParamListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoDataContainer,
  daInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IdaParam;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TdaParamListPrim = class(_l3InterfaceRefListPrim_)
 end;//TdaParamListPrim

implementation

uses
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

// start class TdaParamListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_5555A0950303_var*
//#UC END# *47B07CF403D0_5555A0950303_var*
begin
//#UC START# *47B07CF403D0_5555A0950303_impl*
 Result := AnsiSameText(A.Name, B.Name);
//#UC END# *47B07CF403D0_5555A0950303_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5555A0950303_var*
//#UC END# *47B2C42A0163_5555A0950303_var*
begin
//#UC START# *47B2C42A0163_5555A0950303_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5555A0950303_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5555A0950303_var*
//#UC END# *47B99D4503A2_5555A0950303_var*
begin
//#UC START# *47B99D4503A2_5555A0950303_impl*
 Result := AnsiCompareText(CI.rA.Name, CI.rB.Name);
//#UC END# *47B99D4503A2_5555A0950303_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaParamListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.