unit Document_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Document_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Document
//
// Документ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Document - "Документ".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDocument = 20;

function k2_typDocument_Subs: Document_Subs_Tag;

function k2_typDocument_Groups: Document_Groups_Tag;

function k2_typDocument_AccGroups: Document_AccGroups_Tag;

function k2_typDocument_Sources: Document_Sources_Tag;

function k2_typDocument_Warnings: Document_Warnings_Tag;

function k2_typDocument_NumANDDates: Document_NumANDDates_Tag;

function k2_typDocument_LogRecords: Document_LogRecords_Tag;

function k2_typDocument_SysLogRecords: Document_SysLogRecords_Tag;

function k2_typDocument_Versions: Document_Versions_Tag;

function k2_typDocument_Stages: Document_Stages_Tag;

function k2_typDocument_Checks: Document_Checks_Tag;

function k2_typDocument_PublishedIn: Document_PublishedIn_Tag;

function k2_typDocument_Territory: Document_Territory_Tag;

function k2_typDocument_Norm: Document_Norm_Tag;

function k2_typDocument_ActiveIntervals: Document_ActiveIntervals_Tag;

function k2_typDocument_Alarms: Document_Alarms_Tag;

function k2_typDocument_AnnoClasses: Document_AnnoClasses_Tag;

function k2_typDocument_LinkedDocuments: Document_LinkedDocuments_Tag;

function k2_typDocument_CaseDocParticipants: Document_CaseDocParticipants_Tag;

function k2_typDocument_EditableParts: Document_EditableParts_Tag;

function k2_attrHeight: Integer;

function k2_attrType: Integer;

function k2_attrUserType: Integer;

function k2_attrInternalHandle: Integer;

function k2_attrSortDate: Integer;

function k2_attrRelExternalHandle: Integer;

function k2_attrRelInternalHandle: Integer;

function k2_attrPriority: Integer;

function k2_attrExternalPath: Integer;

function k2_attrPriceLevel: Integer;

function k2_attrComment: Integer;

function k2_attrInternalVerLink: Integer;

function k2_attrExternalVerLink: Integer;

function k2_attrMaxHyperlinkHandle: Integer;

function k2_attrInternalNextVerLink: Integer;

function k2_attrExternalNextVerLink: Integer;

function k2_attrUrgency: Integer;

function k2_attrLanguage: Integer;

function k2_attrParas: Integer;

function k2_attrSubs: Integer;

function k2_attrGroups: Integer;

function k2_attrAccGroups: Integer;

function k2_attrSources: Integer;

function k2_attrWarnings: Integer;

function k2_attrNumANDDates: Integer;

function k2_attrLogRecords: Integer;

function k2_attrSysLogRecords: Integer;

function k2_attrVersions: Integer;

function k2_attrStages: Integer;

function k2_attrChecks: Integer;

function k2_attrPublishedIn: Integer;

function k2_attrTerritory: Integer;

function k2_attrNorm: Integer;

function k2_attrActiveIntervals: Integer;

function k2_attrAlarms: Integer;

function k2_attrAnnoClasses: Integer;

function k2_attrLinkedDocuments: Integer;

function k2_attrNameComment: Integer;

function k2_attrCaseDocParticipants: Integer;

function k2_attrNoCompare: Integer;

function k2_attrMDPPageID: Integer;

function k2_attrHasAnno: Integer;

function k2_attrMaxSubID: Integer;

function k2_attrData: Integer;

function k2_attrEditableParts: Integer;
function k2_typDocument: DocumentTag;

//#UC START# *4857B5260267const_intf*
//#UC END# *4857B5260267const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Document : DocumentTag = nil;

// start class DocumentTag

function k2_typDocument: DocumentTag;
begin
 if (g_Document = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document;
 end;//g_Document = nil
 Result := g_Document;
end;
var
 g_k2_attrHeight: Integer = -1;

function k2_attrHeight: Integer;
begin
 if (g_k2_attrHeight = -1) then
  g_k2_attrHeight :=  Tk2Attributes.Instance.CheckIDByName('Height');
 Result := g_k2_attrHeight;
end;

var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;

var
 g_k2_attrUserType: Integer = -1;

function k2_attrUserType: Integer;
begin
 if (g_k2_attrUserType = -1) then
  g_k2_attrUserType :=  Tk2Attributes.Instance.CheckIDByName('UserType');
 Result := g_k2_attrUserType;
end;

var
 g_k2_attrInternalHandle: Integer = -1;

function k2_attrInternalHandle: Integer;
begin
 if (g_k2_attrInternalHandle = -1) then
  g_k2_attrInternalHandle :=  Tk2Attributes.Instance.CheckIDByName('InternalHandle');
 Result := g_k2_attrInternalHandle;
end;

var
 g_k2_attrSortDate: Integer = -1;

function k2_attrSortDate: Integer;
begin
 if (g_k2_attrSortDate = -1) then
  g_k2_attrSortDate :=  Tk2Attributes.Instance.CheckIDByName('SortDate');
 Result := g_k2_attrSortDate;
end;

var
 g_k2_attrRelExternalHandle: Integer = -1;

function k2_attrRelExternalHandle: Integer;
begin
 if (g_k2_attrRelExternalHandle = -1) then
  g_k2_attrRelExternalHandle :=  Tk2Attributes.Instance.CheckIDByName('RelExternalHandle');
 Result := g_k2_attrRelExternalHandle;
end;

var
 g_k2_attrRelInternalHandle: Integer = -1;

function k2_attrRelInternalHandle: Integer;
begin
 if (g_k2_attrRelInternalHandle = -1) then
  g_k2_attrRelInternalHandle :=  Tk2Attributes.Instance.CheckIDByName('RelInternalHandle');
 Result := g_k2_attrRelInternalHandle;
end;

var
 g_k2_attrPriority: Integer = -1;

function k2_attrPriority: Integer;
begin
 if (g_k2_attrPriority = -1) then
  g_k2_attrPriority :=  Tk2Attributes.Instance.CheckIDByName('Priority');
 Result := g_k2_attrPriority;
end;

var
 g_k2_attrExternalPath: Integer = -1;

function k2_attrExternalPath: Integer;
begin
 if (g_k2_attrExternalPath = -1) then
  g_k2_attrExternalPath :=  Tk2Attributes.Instance.CheckIDByName('ExternalPath');
 Result := g_k2_attrExternalPath;
end;

var
 g_k2_attrPriceLevel: Integer = -1;

function k2_attrPriceLevel: Integer;
begin
 if (g_k2_attrPriceLevel = -1) then
  g_k2_attrPriceLevel :=  Tk2Attributes.Instance.CheckIDByName('PriceLevel');
 Result := g_k2_attrPriceLevel;
end;

var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
end;

var
 g_k2_attrInternalVerLink: Integer = -1;

function k2_attrInternalVerLink: Integer;
begin
 if (g_k2_attrInternalVerLink = -1) then
  g_k2_attrInternalVerLink :=  Tk2Attributes.Instance.CheckIDByName('InternalVerLink');
 Result := g_k2_attrInternalVerLink;
end;

var
 g_k2_attrExternalVerLink: Integer = -1;

function k2_attrExternalVerLink: Integer;
begin
 if (g_k2_attrExternalVerLink = -1) then
  g_k2_attrExternalVerLink :=  Tk2Attributes.Instance.CheckIDByName('ExternalVerLink');
 Result := g_k2_attrExternalVerLink;
end;

var
 g_k2_attrMaxHyperlinkHandle: Integer = -1;

function k2_attrMaxHyperlinkHandle: Integer;
begin
 if (g_k2_attrMaxHyperlinkHandle = -1) then
  g_k2_attrMaxHyperlinkHandle :=  Tk2Attributes.Instance.CheckIDByName('MaxHyperlinkHandle');
 Result := g_k2_attrMaxHyperlinkHandle;
end;

var
 g_k2_attrInternalNextVerLink: Integer = -1;

function k2_attrInternalNextVerLink: Integer;
begin
 if (g_k2_attrInternalNextVerLink = -1) then
  g_k2_attrInternalNextVerLink :=  Tk2Attributes.Instance.CheckIDByName('InternalNextVerLink');
 Result := g_k2_attrInternalNextVerLink;
end;

var
 g_k2_attrExternalNextVerLink: Integer = -1;

function k2_attrExternalNextVerLink: Integer;
begin
 if (g_k2_attrExternalNextVerLink = -1) then
  g_k2_attrExternalNextVerLink :=  Tk2Attributes.Instance.CheckIDByName('ExternalNextVerLink');
 Result := g_k2_attrExternalNextVerLink;
end;

var
 g_k2_attrUrgency: Integer = -1;

function k2_attrUrgency: Integer;
begin
 if (g_k2_attrUrgency = -1) then
  g_k2_attrUrgency :=  Tk2Attributes.Instance.CheckIDByName('Urgency');
 Result := g_k2_attrUrgency;
end;

var
 g_k2_attrLanguage: Integer = -1;

function k2_attrLanguage: Integer;
begin
 if (g_k2_attrLanguage = -1) then
  g_k2_attrLanguage :=  Tk2Attributes.Instance.CheckIDByName('Language');
 Result := g_k2_attrLanguage;
end;

var
 g_k2_attrParas: Integer = -1;

function k2_attrParas: Integer;
begin
 if (g_k2_attrParas = -1) then
  g_k2_attrParas :=  Tk2Attributes.Instance.CheckIDByName('Paras');
 Result := g_k2_attrParas;
end;

var
 g_k2_attrSubs: Integer = -1;

function k2_attrSubs: Integer;
begin
 if (g_k2_attrSubs = -1) then
  g_k2_attrSubs :=  Tk2Attributes.Instance.CheckIDByName('Subs');
 Result := g_k2_attrSubs;
end;

var
 g_k2_attrGroups: Integer = -1;

function k2_attrGroups: Integer;
begin
 if (g_k2_attrGroups = -1) then
  g_k2_attrGroups :=  Tk2Attributes.Instance.CheckIDByName('Groups');
 Result := g_k2_attrGroups;
end;

var
 g_k2_attrAccGroups: Integer = -1;

function k2_attrAccGroups: Integer;
begin
 if (g_k2_attrAccGroups = -1) then
  g_k2_attrAccGroups :=  Tk2Attributes.Instance.CheckIDByName('AccGroups');
 Result := g_k2_attrAccGroups;
end;

var
 g_k2_attrSources: Integer = -1;

function k2_attrSources: Integer;
begin
 if (g_k2_attrSources = -1) then
  g_k2_attrSources :=  Tk2Attributes.Instance.CheckIDByName('Sources');
 Result := g_k2_attrSources;
end;

var
 g_k2_attrWarnings: Integer = -1;

function k2_attrWarnings: Integer;
begin
 if (g_k2_attrWarnings = -1) then
  g_k2_attrWarnings :=  Tk2Attributes.Instance.CheckIDByName('Warnings');
 Result := g_k2_attrWarnings;
end;

var
 g_k2_attrNumANDDates: Integer = -1;

function k2_attrNumANDDates: Integer;
begin
 if (g_k2_attrNumANDDates = -1) then
  g_k2_attrNumANDDates :=  Tk2Attributes.Instance.CheckIDByName('NumANDDates');
 Result := g_k2_attrNumANDDates;
end;

var
 g_k2_attrLogRecords: Integer = -1;

function k2_attrLogRecords: Integer;
begin
 if (g_k2_attrLogRecords = -1) then
  g_k2_attrLogRecords :=  Tk2Attributes.Instance.CheckIDByName('LogRecords');
 Result := g_k2_attrLogRecords;
end;

var
 g_k2_attrSysLogRecords: Integer = -1;

function k2_attrSysLogRecords: Integer;
begin
 if (g_k2_attrSysLogRecords = -1) then
  g_k2_attrSysLogRecords :=  Tk2Attributes.Instance.CheckIDByName('SysLogRecords');
 Result := g_k2_attrSysLogRecords;
end;

var
 g_k2_attrVersions: Integer = -1;

function k2_attrVersions: Integer;
begin
 if (g_k2_attrVersions = -1) then
  g_k2_attrVersions :=  Tk2Attributes.Instance.CheckIDByName('Versions');
 Result := g_k2_attrVersions;
end;

var
 g_k2_attrStages: Integer = -1;

function k2_attrStages: Integer;
begin
 if (g_k2_attrStages = -1) then
  g_k2_attrStages :=  Tk2Attributes.Instance.CheckIDByName('Stages');
 Result := g_k2_attrStages;
end;

var
 g_k2_attrChecks: Integer = -1;

function k2_attrChecks: Integer;
begin
 if (g_k2_attrChecks = -1) then
  g_k2_attrChecks :=  Tk2Attributes.Instance.CheckIDByName('Checks');
 Result := g_k2_attrChecks;
end;

var
 g_k2_attrPublishedIn: Integer = -1;

function k2_attrPublishedIn: Integer;
begin
 if (g_k2_attrPublishedIn = -1) then
  g_k2_attrPublishedIn :=  Tk2Attributes.Instance.CheckIDByName('PublishedIn');
 Result := g_k2_attrPublishedIn;
end;

var
 g_k2_attrTerritory: Integer = -1;

function k2_attrTerritory: Integer;
begin
 if (g_k2_attrTerritory = -1) then
  g_k2_attrTerritory :=  Tk2Attributes.Instance.CheckIDByName('Territory');
 Result := g_k2_attrTerritory;
end;

var
 g_k2_attrNorm: Integer = -1;

function k2_attrNorm: Integer;
begin
 if (g_k2_attrNorm = -1) then
  g_k2_attrNorm :=  Tk2Attributes.Instance.CheckIDByName('Norm');
 Result := g_k2_attrNorm;
end;

var
 g_k2_attrActiveIntervals: Integer = -1;

function k2_attrActiveIntervals: Integer;
begin
 if (g_k2_attrActiveIntervals = -1) then
  g_k2_attrActiveIntervals :=  Tk2Attributes.Instance.CheckIDByName('ActiveIntervals');
 Result := g_k2_attrActiveIntervals;
end;

var
 g_k2_attrAlarms: Integer = -1;

function k2_attrAlarms: Integer;
begin
 if (g_k2_attrAlarms = -1) then
  g_k2_attrAlarms :=  Tk2Attributes.Instance.CheckIDByName('Alarms');
 Result := g_k2_attrAlarms;
end;

var
 g_k2_attrAnnoClasses: Integer = -1;

function k2_attrAnnoClasses: Integer;
begin
 if (g_k2_attrAnnoClasses = -1) then
  g_k2_attrAnnoClasses :=  Tk2Attributes.Instance.CheckIDByName('AnnoClasses');
 Result := g_k2_attrAnnoClasses;
end;

var
 g_k2_attrLinkedDocuments: Integer = -1;

function k2_attrLinkedDocuments: Integer;
begin
 if (g_k2_attrLinkedDocuments = -1) then
  g_k2_attrLinkedDocuments :=  Tk2Attributes.Instance.CheckIDByName('LinkedDocuments');
 Result := g_k2_attrLinkedDocuments;
end;

var
 g_k2_attrNameComment: Integer = -1;

function k2_attrNameComment: Integer;
begin
 if (g_k2_attrNameComment = -1) then
  g_k2_attrNameComment :=  Tk2Attributes.Instance.CheckIDByName('NameComment');
 Result := g_k2_attrNameComment;
end;

var
 g_k2_attrCaseDocParticipants: Integer = -1;

function k2_attrCaseDocParticipants: Integer;
begin
 if (g_k2_attrCaseDocParticipants = -1) then
  g_k2_attrCaseDocParticipants :=  Tk2Attributes.Instance.CheckIDByName('CaseDocParticipants');
 Result := g_k2_attrCaseDocParticipants;
end;

var
 g_k2_attrNoCompare: Integer = -1;

function k2_attrNoCompare: Integer;
begin
 if (g_k2_attrNoCompare = -1) then
  g_k2_attrNoCompare :=  Tk2Attributes.Instance.CheckIDByName('NoCompare');
 Result := g_k2_attrNoCompare;
end;

var
 g_k2_attrMDPPageID: Integer = -1;

function k2_attrMDPPageID: Integer;
begin
 if (g_k2_attrMDPPageID = -1) then
  g_k2_attrMDPPageID :=  Tk2Attributes.Instance.CheckIDByName('MDPPageID');
 Result := g_k2_attrMDPPageID;
end;

var
 g_k2_attrHasAnno: Integer = -1;

function k2_attrHasAnno: Integer;
begin
 if (g_k2_attrHasAnno = -1) then
  g_k2_attrHasAnno :=  Tk2Attributes.Instance.CheckIDByName('HasAnno');
 Result := g_k2_attrHasAnno;
end;

var
 g_k2_attrMaxSubID: Integer = -1;

function k2_attrMaxSubID: Integer;
begin
 if (g_k2_attrMaxSubID = -1) then
  g_k2_attrMaxSubID :=  Tk2Attributes.Instance.CheckIDByName('MaxSubID');
 Result := g_k2_attrMaxSubID;
end;

var
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;

var
 g_k2_attrEditableParts: Integer = -1;

function k2_attrEditableParts: Integer;
begin
 if (g_k2_attrEditableParts = -1) then
  g_k2_attrEditableParts :=  Tk2Attributes.Instance.CheckIDByName('EditableParts');
 Result := g_k2_attrEditableParts;
end;


var
 g_Document_Subs : Document_Subs_Tag = nil;

// start class Subs

function k2_typDocument_Subs: Document_Subs_Tag;
begin
 if (g_Document_Subs = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Subs := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Subs;
 end;//g_Document = nil
 Result := g_Document_Subs;
end;

var
 g_Document_Groups : Document_Groups_Tag = nil;

// start class Groups

function k2_typDocument_Groups: Document_Groups_Tag;
begin
 if (g_Document_Groups = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Groups := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Groups;
 end;//g_Document = nil
 Result := g_Document_Groups;
end;

var
 g_Document_AccGroups : Document_AccGroups_Tag = nil;

// start class AccGroups

function k2_typDocument_AccGroups: Document_AccGroups_Tag;
begin
 if (g_Document_AccGroups = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_AccGroups := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_AccGroups;
 end;//g_Document = nil
 Result := g_Document_AccGroups;
end;

var
 g_Document_Sources : Document_Sources_Tag = nil;

// start class Sources

function k2_typDocument_Sources: Document_Sources_Tag;
begin
 if (g_Document_Sources = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Sources := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Sources;
 end;//g_Document = nil
 Result := g_Document_Sources;
end;

var
 g_Document_Warnings : Document_Warnings_Tag = nil;

// start class Warnings

function k2_typDocument_Warnings: Document_Warnings_Tag;
begin
 if (g_Document_Warnings = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Warnings := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Warnings;
 end;//g_Document = nil
 Result := g_Document_Warnings;
end;

var
 g_Document_NumANDDates : Document_NumANDDates_Tag = nil;

// start class NumANDDates

function k2_typDocument_NumANDDates: Document_NumANDDates_Tag;
begin
 if (g_Document_NumANDDates = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_NumANDDates := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_NumANDDates;
 end;//g_Document = nil
 Result := g_Document_NumANDDates;
end;

var
 g_Document_LogRecords : Document_LogRecords_Tag = nil;

// start class LogRecords

function k2_typDocument_LogRecords: Document_LogRecords_Tag;
begin
 if (g_Document_LogRecords = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_LogRecords := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_LogRecords;
 end;//g_Document = nil
 Result := g_Document_LogRecords;
end;

var
 g_Document_SysLogRecords : Document_SysLogRecords_Tag = nil;

// start class SysLogRecords

function k2_typDocument_SysLogRecords: Document_SysLogRecords_Tag;
begin
 if (g_Document_SysLogRecords = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_SysLogRecords := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_SysLogRecords;
 end;//g_Document = nil
 Result := g_Document_SysLogRecords;
end;

var
 g_Document_Versions : Document_Versions_Tag = nil;

// start class Versions

function k2_typDocument_Versions: Document_Versions_Tag;
begin
 if (g_Document_Versions = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Versions := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Versions;
 end;//g_Document = nil
 Result := g_Document_Versions;
end;

var
 g_Document_Stages : Document_Stages_Tag = nil;

// start class Stages

function k2_typDocument_Stages: Document_Stages_Tag;
begin
 if (g_Document_Stages = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Stages := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Stages;
 end;//g_Document = nil
 Result := g_Document_Stages;
end;

var
 g_Document_Checks : Document_Checks_Tag = nil;

// start class Checks

function k2_typDocument_Checks: Document_Checks_Tag;
begin
 if (g_Document_Checks = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Checks := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Checks;
 end;//g_Document = nil
 Result := g_Document_Checks;
end;

var
 g_Document_PublishedIn : Document_PublishedIn_Tag = nil;

// start class PublishedIn

function k2_typDocument_PublishedIn: Document_PublishedIn_Tag;
begin
 if (g_Document_PublishedIn = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_PublishedIn := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_PublishedIn;
 end;//g_Document = nil
 Result := g_Document_PublishedIn;
end;

var
 g_Document_Territory : Document_Territory_Tag = nil;

// start class Territory

function k2_typDocument_Territory: Document_Territory_Tag;
begin
 if (g_Document_Territory = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Territory := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Territory;
 end;//g_Document = nil
 Result := g_Document_Territory;
end;

var
 g_Document_Norm : Document_Norm_Tag = nil;

// start class Norm

function k2_typDocument_Norm: Document_Norm_Tag;
begin
 if (g_Document_Norm = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Norm := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Norm;
 end;//g_Document = nil
 Result := g_Document_Norm;
end;

var
 g_Document_ActiveIntervals : Document_ActiveIntervals_Tag = nil;

// start class ActiveIntervals

function k2_typDocument_ActiveIntervals: Document_ActiveIntervals_Tag;
begin
 if (g_Document_ActiveIntervals = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_ActiveIntervals := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_ActiveIntervals;
 end;//g_Document = nil
 Result := g_Document_ActiveIntervals;
end;

var
 g_Document_Alarms : Document_Alarms_Tag = nil;

// start class Alarms

function k2_typDocument_Alarms: Document_Alarms_Tag;
begin
 if (g_Document_Alarms = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_Alarms := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_Alarms;
 end;//g_Document = nil
 Result := g_Document_Alarms;
end;

var
 g_Document_AnnoClasses : Document_AnnoClasses_Tag = nil;

// start class AnnoClasses

function k2_typDocument_AnnoClasses: Document_AnnoClasses_Tag;
begin
 if (g_Document_AnnoClasses = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_AnnoClasses := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_AnnoClasses;
 end;//g_Document = nil
 Result := g_Document_AnnoClasses;
end;

var
 g_Document_LinkedDocuments : Document_LinkedDocuments_Tag = nil;

// start class LinkedDocuments

function k2_typDocument_LinkedDocuments: Document_LinkedDocuments_Tag;
begin
 if (g_Document_LinkedDocuments = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_LinkedDocuments := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_LinkedDocuments;
 end;//g_Document = nil
 Result := g_Document_LinkedDocuments;
end;

var
 g_Document_CaseDocParticipants : Document_CaseDocParticipants_Tag = nil;

// start class CaseDocParticipants

function k2_typDocument_CaseDocParticipants: Document_CaseDocParticipants_Tag;
begin
 if (g_Document_CaseDocParticipants = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_CaseDocParticipants := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_CaseDocParticipants;
 end;//g_Document = nil
 Result := g_Document_CaseDocParticipants;
end;

var
 g_Document_EditableParts : Document_EditableParts_Tag = nil;

// start class EditableParts

function k2_typDocument_EditableParts: Document_EditableParts_Tag;
begin
 if (g_Document_EditableParts = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Document_EditableParts := TevNativeSchema(Tk2TypeTable.GetInstance).t_Document_EditableParts;
 end;//g_Document = nil
 Result := g_Document_EditableParts;
end;


end.