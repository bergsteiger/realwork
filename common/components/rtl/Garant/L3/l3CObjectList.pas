unit l3CObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3CObjectList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CObjectList
//
// ���������� ������ ���������� �� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ObjectList
  ;

type
 Tl3CObjectList = class(Tl3ObjectList)
  {* ���������� ������ ���������� �� �������. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CObjectList

implementation

// start class Tl3CObjectList

{$If not defined(DesignTimeLibrary)}
class function Tl3CObjectList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4773DBEA0260_var*
//#UC END# *47A6FEE600FC_4773DBEA0260_var*
begin
//#UC START# *47A6FEE600FC_4773DBEA0260_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DBEA0260_impl*
end;//Tl3CObjectList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.