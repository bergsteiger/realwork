unit NOT_FINISHED_l3_String;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3_String.pas"
// �����: 18.01.2008 15:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3_String
//
// ����� ����������� ������ � ����������� ������� �������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3CustomString
  ;

type
 Tl3_String = class(Tl3CustomString)
  {* ����� ����������� ������ � ����������� ������� �������� ������. }
 private
 // private fields
   f_String : Tl3WStrCast;
 public
 // public methods
   procedure NotifyDeletion(aPos: Integer;
     aLen: Integer); virtual;
 end;//Tl3_String

implementation

// start class Tl3_String

procedure Tl3_String.NotifyDeletion(aPos: Integer;
  aLen: Integer);
//#UC START# *4FB10B1D016B_4773DED9004C_var*
//#UC END# *4FB10B1D016B_4773DED9004C_var*
begin
//#UC START# *4FB10B1D016B_4773DED9004C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FB10B1D016B_4773DED9004C_impl*
end;//Tl3_String.NotifyDeletion

end.