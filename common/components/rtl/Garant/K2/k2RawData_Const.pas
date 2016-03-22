unit k2RawData_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2RawData_Const.pas"
// �����: 17.07.1998 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::K2::Standard::k2Native::RawData
//
// "�����" ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� RawData - ""�����" ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typRawData: RawDataAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RawData : RawDataAtom = nil;

// start class RawDataAtom

function k2_typRawData: RawDataAtom;
begin
 if (g_RawData = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_RawData := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_RawData;
 end;//g_RawData = nil
 Result := g_RawData;
end;

end.