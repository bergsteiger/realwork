unit Time_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Time_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::EVD::Standard::evdNative::Time
//
// �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Time - "�����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typTime: TimeAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Time : TimeAtom = nil;

// start class TimeAtom

function k2_typTime: TimeAtom;
begin
 if (g_Time = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Time := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Time;
 end;//g_Time = nil
 Result := g_Time;
end;

end.