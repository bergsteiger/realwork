unit GetTaskRequest_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/GetTaskRequest_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::GetTaskRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� GetTaskRequest .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typGetTaskRequest: GetTaskRequestTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_GetTaskRequest : GetTaskRequestTag = nil;

// start class GetTaskRequestTag

function k2_typGetTaskRequest: GetTaskRequestTag;
begin
 if (g_GetTaskRequest = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_GetTaskRequest := TevdTasksSchema(Tk2TypeTable.GetInstance).t_GetTaskRequest;
 end;//g_GetTaskRequest = nil
 Result := g_GetTaskRequest;
end;

end.