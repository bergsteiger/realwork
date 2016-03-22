unit k2Color_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2Color_Const.pas"
// �����: 17.07.1998 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::Color
//
// ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Color - "����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typColor: ColorAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Color : ColorAtom = nil;

// start class ColorAtom

function k2_typColor: ColorAtom;
begin
 if (g_Color = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Color := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Color;
 end;//g_Color = nil
 Result := g_Color;
end;

end.