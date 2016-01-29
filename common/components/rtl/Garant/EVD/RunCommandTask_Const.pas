unit RunCommandTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/RunCommandTask_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::RunCommandTask
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� RunCommandTask .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typRunCommandTask: RunCommandTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RunCommandTask : RunCommandTaskTag = nil;

// start class RunCommandTaskTag

function k2_typRunCommandTask: RunCommandTaskTag;
begin
 if (g_RunCommandTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RunCommandTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RunCommandTask;
 end;//g_RunCommandTask = nil
 Result := g_RunCommandTask;
end;

end.