unit ULong_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/ULong_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::ULong
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� ULong .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typULong: ULongAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ULong : ULongAtom = nil;

// start class ULongAtom

function k2_typULong: ULongAtom;
begin
 if (g_ULong = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ULong := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ULong;
 end;//g_ULong = nil
 Result := g_ULong;
end;

end.