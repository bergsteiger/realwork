unit SpellCorrectTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/SpellCorrectTask_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::SpellCorrectTask
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SpellCorrectTask .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typSpellCorrectTask_ReplacementFile: SpellCorrectTask_ReplacementFile_Tag;

function k2_attrReplacementFile: Integer;
function k2_typSpellCorrectTask: SpellCorrectTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SpellCorrectTask : SpellCorrectTaskTag = nil;

// start class SpellCorrectTaskTag

function k2_typSpellCorrectTask: SpellCorrectTaskTag;
begin
 if (g_SpellCorrectTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_SpellCorrectTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_SpellCorrectTask;
 end;//g_SpellCorrectTask = nil
 Result := g_SpellCorrectTask;
end;
var
 g_k2_attrReplacementFile: Integer = -1;

function k2_attrReplacementFile: Integer;
begin
 if (g_k2_attrReplacementFile = -1) then
  g_k2_attrReplacementFile :=  Tk2Attributes.Instance.CheckIDByName('ReplacementFile');
 Result := g_k2_attrReplacementFile;
end;


var
 g_SpellCorrectTask_ReplacementFile : SpellCorrectTask_ReplacementFile_Tag = nil;

// start class ReplacementFile

function k2_typSpellCorrectTask_ReplacementFile: SpellCorrectTask_ReplacementFile_Tag;
begin
 if (g_SpellCorrectTask_ReplacementFile = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_SpellCorrectTask_ReplacementFile := TevdTasksSchema(Tk2TypeTable.GetInstance).t_SpellCorrectTask_ReplacementFile;
 end;//g_SpellCorrectTask = nil
 Result := g_SpellCorrectTask_ReplacementFile;
end;


end.