unit k2SetOf_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2SetOf_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::CoreTypes::k2Core::SetOf
//
// ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SetOf - "���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typSetOf: SetOfAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SetOf : SetOfAtom = nil;

// start class SetOfAtom

function k2_typSetOf: SetOfAtom;
begin
 if (g_SetOf = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_SetOf := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_SetOf;
 end;//g_SetOf = nil
 Result := g_SetOf;
end;

end.