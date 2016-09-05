unit afwSettingsImplPrimPrim;

// ������: "w:\common\components\gui\Garant\AFW\afwSettingsImplPrimPrim.pas"
// ���������: "SimpleClass"
// ������� ������: "TafwSettingsImplPrimPrim" MUID: (4F6C6EAD0053)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , afwInterfaces
;

type
 IafwSettingsImpl = interface
  ['{A764A778-3678-4317-BAA8-F586E633D82F}']
  function GetString(const aSettingId: TafwSettingId;
   out theValue: Il3CString): Boolean;
  function GetLong(const aSettingId: TafwSettingId;
   out theValue: Integer): Boolean;
  function GetBool(const aSettingId: TafwSettingId;
   out theValue: Boolean): Boolean;
  procedure SetString(const aSettingId: TafwSettingId;
   aValue: PAnsiChar);
  procedure SetLong(const aSettingId: TafwSettingId;
   aValue: Integer);
  procedure SetBool(const aSettingId: TafwSettingId;
   aValue: Boolean);
 end;//IafwSettingsImpl

 TafwKeyValue = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rKey: Il3CString;
   rValue: Il3CString;
 end;//TafwKeyValue

 _ItemType_ = TafwKeyValue;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TafwSettingsImplPrimPrim = class(_l3RecordListPrim_)
 end;//TafwSettingsImplPrimPrim

function TafwKeyValue_C(const aKey: Il3CString;
 const aValue: Il3CString): TafwKeyValue;

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F6C6EAD0053impl_uses*
 //#UC END# *4F6C6EAD0053impl_uses*
;

function TafwKeyValue_C(const aKey: Il3CString;
 const aValue: Il3CString): TafwKeyValue;
//#UC START# *4F6C7D1F0329_4F6C7CEB035A_var*
//#UC END# *4F6C7D1F0329_4F6C7CEB035A_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4F6C7D1F0329_4F6C7CEB035A_impl*
 Result.rKey := aKey;
 Result.rValue := aValue;
//#UC END# *4F6C7D1F0329_4F6C7CEB035A_impl*
end;//TafwKeyValue_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_4F6C6EAD0053_var*
//#UC END# *47B07CF403D0_4F6C6EAD0053_var*
begin
//#UC START# *47B07CF403D0_4F6C6EAD0053_impl*
 Result := l3Same(A.rKey, B.rKey);
//#UC END# *47B07CF403D0_4F6C6EAD0053_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F6C6EAD0053_var*
//#UC END# *47B2C42A0163_4F6C6EAD0053_var*
begin
//#UC START# *47B2C42A0163_4F6C6EAD0053_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F6C6EAD0053_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4F6C6EAD0053_var*
//#UC END# *47B99D4503A2_4F6C6EAD0053_var*
begin
//#UC START# *47B99D4503A2_4F6C6EAD0053_impl*
 Result := l3Compare(l3PCharLen(CI.rA.rKey), l3PCharLen(CI.rB.rKey));
//#UC END# *47B99D4503A2_4F6C6EAD0053_impl*
end;//CompareExistingItems

type _Instance_R_ = TafwSettingsImplPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

end.
