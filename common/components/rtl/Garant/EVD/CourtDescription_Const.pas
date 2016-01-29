unit CourtDescription_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/CourtDescription_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::CourtDescription
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега CourtDescription .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typCourtDescription_DecisionPhrases: CourtDescription_DecisionPhrases_Tag;

function k2_attrName: Integer;

function k2_attrSourceID: Integer;

function k2_attrNeedProcess: Integer;

function k2_attrDecisionPhrases: Integer;
function k2_typCourtDescription: CourtDescriptionTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CourtDescription : CourtDescriptionTag = nil;

// start class CourtDescriptionTag

function k2_typCourtDescription: CourtDescriptionTag;
begin
 if (g_CourtDescription = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CourtDescription := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CourtDescription;
 end;//g_CourtDescription = nil
 Result := g_CourtDescription;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;

var
 g_k2_attrSourceID: Integer = -1;

function k2_attrSourceID: Integer;
begin
 if (g_k2_attrSourceID = -1) then
  g_k2_attrSourceID :=  Tk2Attributes.Instance.CheckIDByName('SourceID');
 Result := g_k2_attrSourceID;
end;

var
 g_k2_attrNeedProcess: Integer = -1;

function k2_attrNeedProcess: Integer;
begin
 if (g_k2_attrNeedProcess = -1) then
  g_k2_attrNeedProcess :=  Tk2Attributes.Instance.CheckIDByName('NeedProcess');
 Result := g_k2_attrNeedProcess;
end;

var
 g_k2_attrDecisionPhrases: Integer = -1;

function k2_attrDecisionPhrases: Integer;
begin
 if (g_k2_attrDecisionPhrases = -1) then
  g_k2_attrDecisionPhrases :=  Tk2Attributes.Instance.CheckIDByName('DecisionPhrases');
 Result := g_k2_attrDecisionPhrases;
end;


var
 g_CourtDescription_DecisionPhrases : CourtDescription_DecisionPhrases_Tag = nil;

// start class DecisionPhrases

function k2_typCourtDescription_DecisionPhrases: CourtDescription_DecisionPhrases_Tag;
begin
 if (g_CourtDescription_DecisionPhrases = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CourtDescription_DecisionPhrases := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CourtDescription_DecisionPhrases;
 end;//g_CourtDescription = nil
 Result := g_CourtDescription_DecisionPhrases;
end;


end.