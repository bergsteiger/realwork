unit k2Empty_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2Empty_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::Empty
//
// ����������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Empty - "����������� ��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

const
 k2_idEmpty = 0;

function k2_typEmpty: EmptyAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Empty : EmptyAtom = nil;

// start class EmptyAtom

function k2_typEmpty: EmptyAtom;
begin
 if (g_Empty = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_Empty := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_Empty;
 end;//g_Empty = nil
 Result := g_Empty;
end;

end.