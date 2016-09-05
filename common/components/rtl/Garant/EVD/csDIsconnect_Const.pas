unit csDisconnect_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/csDisconnect_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDisconnect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� csDisconnect .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDisconnect: csDisconnectTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDisconnect : csDisconnectTag = nil;

// start class csDisconnectTag

function k2_typcsDisconnect: csDisconnectTag;
begin
 if (g_csDisconnect = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDisconnect := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDisconnect;
 end;//g_csDisconnect = nil
 Result := g_csDisconnect;
end;

end.