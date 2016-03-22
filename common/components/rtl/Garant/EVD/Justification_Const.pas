unit Justification_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Justification_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Justification
//
// ������������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Justification - "������������ ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typJustification: JustificationAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Justification : JustificationAtom = nil;

// start class JustificationAtom

function k2_typJustification: JustificationAtom;
begin
 if (g_Justification = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Justification := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Justification;
 end;//g_Justification = nil
 Result := g_Justification;
end;

end.