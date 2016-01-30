unit daParamListPrim;

// ������: "w:\common\components\rtl\Garant\DA\daParamListPrim.pas"
// ���������: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaParam;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefListPrim.imp.pas}
 TdaParamListPrim = class(_l3InterfaceRefListPrim_)
 end;//TdaParamListPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_5555A0950303_var*
//#UC END# *47B07CF403D0_5555A0950303_var*
begin
//#UC START# *47B07CF403D0_5555A0950303_impl*
 Result := AnsiSameText(A.Name, B.Name);
//#UC END# *47B07CF403D0_5555A0950303_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5555A0950303_var*
//#UC END# *47B2C42A0163_5555A0950303_var*
begin
//#UC START# *47B2C42A0163_5555A0950303_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5555A0950303_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_5555A0950303_var*
//#UC END# *47B99D4503A2_5555A0950303_var*
begin
//#UC START# *47B99D4503A2_5555A0950303_impl*
 Result := AnsiCompareText(CI.rA.Name, CI.rB.Name);
//#UC END# *47B99D4503A2_5555A0950303_impl*
end;//CompareExistingItems

type _Instance_R_ = TdaParamListPrim;

{$Include l3InterfaceRefListPrim.imp.pas}

end.
