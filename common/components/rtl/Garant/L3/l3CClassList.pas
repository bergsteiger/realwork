unit l3CClassList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3CClassList.pas"
// �����: 06.02.2008 16:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CClassList
//
// ���������� ������ �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ClassList
  ;

type
 Tl3CClassList = class(Tl3ClassList)
  {* ���������� ������ �������. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tl3CClassList

implementation

// start class Tl3CClassList

{$If not defined(DesignTimeLibrary)}
class function Tl3CClassList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4773DC3502A7_var*
//#UC END# *47A6FEE600FC_4773DC3502A7_var*
begin
//#UC START# *47A6FEE600FC_4773DC3502A7_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC3502A7_impl*
end;//Tl3CClassList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.