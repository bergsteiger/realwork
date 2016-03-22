unit DateTime_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/DateTime_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DateTime
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DateTime .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typDateTime: DateTimeTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DateTime : DateTimeTag = nil;

// start class DateTimeTag

function k2_typDateTime: DateTimeTag;
begin
 if (g_DateTime = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DateTime := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DateTime;
 end;//g_DateTime = nil
 Result := g_DateTime;
end;

end.