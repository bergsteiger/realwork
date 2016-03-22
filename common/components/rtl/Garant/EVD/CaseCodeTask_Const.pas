unit CaseCodeTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/CaseCodeTask_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::CaseCodeTask
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� CaseCodeTask .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typCaseCodeTask: CaseCodeTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CaseCodeTask : CaseCodeTaskTag = nil;

// start class CaseCodeTaskTag

function k2_typCaseCodeTask: CaseCodeTaskTag;
begin
 if (g_CaseCodeTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CaseCodeTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CaseCodeTask;
 end;//g_CaseCodeTask = nil
 Result := g_CaseCodeTask;
end;

end.