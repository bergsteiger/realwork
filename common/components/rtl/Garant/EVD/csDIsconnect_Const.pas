unit csDIsconnect_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csDIsconnect_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDIsconnect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csDIsconnect .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDIsconnect: csDIsconnectTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDIsconnect : csDIsconnectTag = nil;

// start class csDIsconnectTag

function k2_typcsDIsconnect: csDIsconnectTag;
begin
 if (g_csDIsconnect = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDIsconnect := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDIsconnect;
 end;//g_csDIsconnect = nil
 Result := g_csDIsconnect;
end;

end.