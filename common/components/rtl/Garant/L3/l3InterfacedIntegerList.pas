unit l3InterfacedIntegerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3InterfacedIntegerList.pas"
// �����: 04.10.2010 13:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3InterfacedIntegerList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3ProtoIntegerList
  ;

type
 Tl3InterfacedIntegerList = class(Tl3ProtoIntegerList, Il3IntegerList)
 protected
 // realized methods
   function pm_GetCount: Integer;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3InterfacedIntegerList

implementation

// start class Tl3InterfacedIntegerList

function Tl3InterfacedIntegerList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4CA9A422001Bget_var*
//#UC END# *4BB08B8902F2_4CA9A422001Bget_var*
begin
//#UC START# *4BB08B8902F2_4CA9A422001Bget_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4CA9A422001Bget_impl*
end;//Tl3InterfacedIntegerList.pm_GetCount

{$If not defined(DesignTimeLibrary)}
class function Tl3InterfacedIntegerList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4CA9A422001B_var*
//#UC END# *47A6FEE600FC_4CA9A422001B_var*
begin
//#UC START# *47A6FEE600FC_4CA9A422001B_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4CA9A422001B_impl*
end;//Tl3InterfacedIntegerList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.