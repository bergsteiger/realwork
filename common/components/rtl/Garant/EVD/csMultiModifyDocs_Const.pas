unit csMultiModifyDocs_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiModifyDocs_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiModifyDocs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiModifyDocs .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiModifyDocs_DocIDList: csMultiModifyDocs_DocIDList_Tag;

function k2_typcsMultiModifyDocs_ActionType: csMultiModifyDocs_ActionType_Tag;

function k2_attrData: Integer;

function k2_attrFamilyID: Integer;

function k2_attrDocIDList: Integer;

function k2_attrActionType: Integer;

function k2_attrAnouncedDate: Integer;
function k2_typcsMultiModifyDocs: csMultiModifyDocsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiModifyDocs : csMultiModifyDocsTag = nil;

// start class csMultiModifyDocsTag

function k2_typcsMultiModifyDocs: csMultiModifyDocsTag;
begin
 if (g_csMultiModifyDocs = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiModifyDocs := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiModifyDocs;
 end;//g_csMultiModifyDocs = nil
 Result := g_csMultiModifyDocs;
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
 g_k2_attrFamilyID: Integer = -1;

function k2_attrFamilyID: Integer;
begin
 if (g_k2_attrFamilyID = -1) then
  g_k2_attrFamilyID :=  Tk2Attributes.Instance.CheckIDByName('FamilyID');
 Result := g_k2_attrFamilyID;
end;

var
 g_k2_attrDocIDList: Integer = -1;

function k2_attrDocIDList: Integer;
begin
 if (g_k2_attrDocIDList = -1) then
  g_k2_attrDocIDList :=  Tk2Attributes.Instance.CheckIDByName('DocIDList');
 Result := g_k2_attrDocIDList;
end;

var
 g_k2_attrActionType: Integer = -1;

function k2_attrActionType: Integer;
begin
 if (g_k2_attrActionType = -1) then
  g_k2_attrActionType :=  Tk2Attributes.Instance.CheckIDByName('ActionType');
 Result := g_k2_attrActionType;
end;

var
 g_k2_attrAnouncedDate: Integer = -1;

function k2_attrAnouncedDate: Integer;
begin
 if (g_k2_attrAnouncedDate = -1) then
  g_k2_attrAnouncedDate :=  Tk2Attributes.Instance.CheckIDByName('AnouncedDate');
 Result := g_k2_attrAnouncedDate;
end;


var
 g_csMultiModifyDocs_DocIDList : csMultiModifyDocs_DocIDList_Tag = nil;

// start class DocIDList

function k2_typcsMultiModifyDocs_DocIDList: csMultiModifyDocs_DocIDList_Tag;
begin
 if (g_csMultiModifyDocs_DocIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiModifyDocs_DocIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiModifyDocs_DocIDList;
 end;//g_csMultiModifyDocs = nil
 Result := g_csMultiModifyDocs_DocIDList;
end;

var
 g_csMultiModifyDocs_ActionType : csMultiModifyDocs_ActionType_Tag = nil;

// start class ActionType

function k2_typcsMultiModifyDocs_ActionType: csMultiModifyDocs_ActionType_Tag;
begin
 if (g_csMultiModifyDocs_ActionType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiModifyDocs_ActionType := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiModifyDocs_ActionType;
 end;//g_csMultiModifyDocs = nil
 Result := g_csMultiModifyDocs_ActionType;
end;


end.