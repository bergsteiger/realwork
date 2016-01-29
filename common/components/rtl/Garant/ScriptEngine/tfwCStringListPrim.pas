unit tfwCStringListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Parsing"
// ������: "tfwCStringListPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Parsing::CString::TtfwCStringListPrim
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

uses
  l3Interfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3CString;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TtfwCStringListPrim = class(_l3InterfaceRefListPrim_)
 end;//TtfwCStringListPrim

implementation

uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TtfwCStringListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4F473F4E01E5_var*
//#UC END# *47B07CF403D0_4F473F4E01E5_var*
begin
//#UC START# *47B07CF403D0_4F473F4E01E5_impl*
 Result := (A = B);
 // - ���������� ���������, �������� ���� � ������ ���� ����������
//#UC END# *47B07CF403D0_4F473F4E01E5_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F473F4E01E5_var*
//#UC END# *47B2C42A0163_4F473F4E01E5_var*
begin
//#UC START# *47B2C42A0163_4F473F4E01E5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F473F4E01E5_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4F473F4E01E5_var*
//#UC END# *47B99D4503A2_4F473F4E01E5_var*
begin
//#UC START# *47B99D4503A2_4F473F4E01E5_impl*
 {$IfDef l3Items_HasCustomSort}
 Result := l3Compare(l3PCharLen(CI.rA^), l3PCharLen(CI.rB^), CI.rSortIndex);
 {$Else  l3Items_HasCustomSort}
 Result := l3Compare(l3PCharLen(CI.rA^), l3PCharLen(CI.rB^));
 {$EndIf l3Items_HasCustomSort}
//#UC END# *47B99D4503A2_4F473F4E01E5_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwCStringListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.