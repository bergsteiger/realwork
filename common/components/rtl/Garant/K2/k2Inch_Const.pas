unit k2Inch_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2Inch_Const.pas"
// �����: 17.07.1998 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::Inch
//
// ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Inch - "����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typInch: InchAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Inch : InchAtom = nil;

// start class InchAtom

function k2_typInch: InchAtom;
begin
 if (g_Inch = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Inch := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Inch;
 end;//g_Inch = nil
 Result := g_Inch;
end;

end.