unit nevRangeList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevRangeList.pas"
// �����: 20.03.2008 16:44
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevRangeList
//
// ������ ���������� ��������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 _ItemType_ = InevRange;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevRangeList = class(_l3InterfaceRefList_)
  {* ������ ���������� ��������� ���������. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   function Clone: TnevRangeList;
 end;//TnevRangeList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnevRangeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TnevRangeList

function TnevRangeList.Clone: TnevRangeList;
//#UC START# *4DD2681E03BF_47E26A16008E_var*
type
 RnevRangeList = class of TnevRangeList;
//#UC END# *4DD2681E03BF_47E26A16008E_var*
begin
//#UC START# *4DD2681E03BF_47E26A16008E_impl*
 Result := RnevRangeList(ClassType).Create;
 Result.JoinWith(Self);
//#UC END# *4DD2681E03BF_47E26A16008E_impl*
end;//TnevRangeList.Clone

{$If not defined(DesignTimeLibrary)}
class function TnevRangeList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_47E26A16008E_var*
//#UC END# *47A6FEE600FC_47E26A16008E_var*
begin
//#UC START# *47A6FEE600FC_47E26A16008E_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47E26A16008E_impl*
end;//TnevRangeList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.