unit TaskID_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/TaskID_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::TaskID
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� TaskID .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrName: Integer;

function k2_typTaskID: TaskIDTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TaskID : TaskIDTag = nil;

// start class TaskIDTag

function k2_typTaskID: TaskIDTag;
begin
 if (g_TaskID = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_TaskID := TevdTasksSchema(Tk2TypeTable.GetInstance).t_TaskID;
 end;//g_TaskID = nil
 Result := g_TaskID;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


end.