unit mdpSyncStages_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/mdpSyncStages_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::mdpSyncStages
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� mdpSyncStages .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typmdpSyncStages: mdpSyncStagesTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_mdpSyncStages : mdpSyncStagesTag = nil;

// start class mdpSyncStagesTag

function k2_typmdpSyncStages: mdpSyncStagesTag;
begin
 if (g_mdpSyncStages = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_mdpSyncStages := TevdTasksSchema(Tk2TypeTable.GetInstance).t_mdpSyncStages;
 end;//g_mdpSyncStages = nil
 Result := g_mdpSyncStages;
end;

end.