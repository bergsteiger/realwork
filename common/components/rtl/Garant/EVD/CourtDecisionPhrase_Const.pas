unit CourtDecisionPhrase_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/CourtDecisionPhrase_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::CourtDecisionPhrase
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� CourtDecisionPhrase .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrPhrase: Integer;

function k2_typCourtDecisionPhrase: CourtDecisionPhraseTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CourtDecisionPhrase : CourtDecisionPhraseTag = nil;

// start class CourtDecisionPhraseTag

function k2_typCourtDecisionPhrase: CourtDecisionPhraseTag;
begin
 if (g_CourtDecisionPhrase = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CourtDecisionPhrase := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CourtDecisionPhrase;
 end;//g_CourtDecisionPhrase = nil
 Result := g_CourtDecisionPhrase;
end;
var
 g_k2_attrPhrase: Integer = -1;

function k2_attrPhrase: Integer;
begin
 if (g_k2_attrPhrase = -1) then
  g_k2_attrPhrase :=  Tk2Attributes.Instance.CheckIDByName('Phrase');
 Result := g_k2_attrPhrase;
end;


end.