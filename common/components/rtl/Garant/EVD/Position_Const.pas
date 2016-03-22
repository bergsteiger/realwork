unit Position_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Position_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Position
//
// ������� � ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Position - "������� � ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typPosition: PositionAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Position : PositionAtom = nil;

// start class PositionAtom

function k2_typPosition: PositionAtom;
begin
 if (g_Position = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Position := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Position;
 end;//g_Position = nil
 Result := g_Position;
end;

end.