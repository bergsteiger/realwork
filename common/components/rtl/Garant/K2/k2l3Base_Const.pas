unit k2l3Base_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2l3Base_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::CoreTypes::k2Core::l3Base
//
// ������� ����� � ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� l3Base - "������� ����� � ��������� ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typl3Base: l3BaseAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_l3Base : l3BaseAtom = nil;

// start class l3BaseAtom

function k2_typl3Base: l3BaseAtom;
begin
 if (g_l3Base = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_l3Base := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_l3Base;
 end;//g_l3Base = nil
 Result := g_l3Base;
end;

end.