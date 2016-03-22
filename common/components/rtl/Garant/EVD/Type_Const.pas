unit Type_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/Type_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::Type
//
// ��� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Type - "��� �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typType: TypeAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Type : TypeAtom = nil;

// start class TypeAtom

function k2_typType: TypeAtom;
begin
 if (g_Type = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_Type := TevdTasksSchema(Tk2TypeTable.GetInstance).t_Type;
 end;//g_Type = nil
 Result := g_Type;
end;

end.