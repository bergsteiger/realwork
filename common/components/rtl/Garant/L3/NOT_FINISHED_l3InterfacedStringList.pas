unit NOT_FINISHED_l3InterfacedStringList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3InterfacedStringList.pas"
// �����: 2003/10/09 14:47:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3InterfacedStringList
//
// ����� ����������� ������ ����� �� ���������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringList,
  l3_String
  ;

type
 Tl3InterfacedString = class(Tl3_String)
  {* ����� ����������� ������ � ������������ �������� ���������� }
 private
 // private fields
   f_Intf : IUnknown;
    {* ���� ��� �������� Intf}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public properties
   property Intf: IUnknown
     read f_Intf
     write f_Intf;
 end;//Tl3InterfacedString

 Tl3InterfacedStringList = class(Tl3StringList)
  {* ����� ����������� ������ ����� �� ���������� ������������ }
 end;//Tl3InterfacedStringList

implementation

// start class Tl3InterfacedString

procedure Tl3InterfacedString.Cleanup;
//#UC START# *479731C50290_4912AA1802AD_var*
//#UC END# *479731C50290_4912AA1802AD_var*
begin
//#UC START# *479731C50290_4912AA1802AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4912AA1802AD_impl*
end;//Tl3InterfacedString.Cleanup

procedure Tl3InterfacedString.ClearFields;
 {-}
begin
 Intf := nil;
 inherited;
end;//Tl3InterfacedString.ClearFields

end.