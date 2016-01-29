unit ddCellsPropertyList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/ddCellsPropertyList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddCellsPropertyList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoDataContainer,
  ddCellProperty,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TddCellProperty;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddCellsPropertyList = class(_l3UncomparabeObjectRefList_)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 end;//TddCellsPropertyList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TddCellsPropertyList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5189EB3F0246_var*
//#UC END# *47B2C42A0163_5189EB3F0246_var*
begin
//#UC START# *47B2C42A0163_5189EB3F0246_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5189EB3F0246_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5189EB3F0246_var*
//#UC END# *47B99D4503A2_5189EB3F0246_var*
begin
//#UC START# *47B99D4503A2_5189EB3F0246_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5189EB3F0246_impl*
end;//CompareExistingItems

type _Instance_R_ = TddCellsPropertyList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class TddCellsPropertyList

{$If not defined(DesignTimeLibrary)}
class function TddCellsPropertyList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_5189EB3F0246_var*
//#UC END# *47A6FEE600FC_5189EB3F0246_var*
begin
//#UC START# *47A6FEE600FC_5189EB3F0246_impl*
 Result := True;
//#UC END# *47A6FEE600FC_5189EB3F0246_impl*
end;//TddCellsPropertyList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.