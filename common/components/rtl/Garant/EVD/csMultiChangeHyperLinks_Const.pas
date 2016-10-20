unit csMultiChangeHyperLinks_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiChangeHyperLinks_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiChangeHyperLinks
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiChangeHyperLinks .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsMultiChangeHyperLinks_DocumentIDList: csMultiChangeHyperLinks_DocumentIDList_Tag;

function k2_attrDocumentIDList: Integer;

function k2_attrOldDocID: Integer;

function k2_attrNewDocID: Integer;

function k2_attrFamilyID: Integer;
function k2_typcsMultiChangeHyperLinks: csMultiChangeHyperLinksTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiChangeHyperLinks : csMultiChangeHyperLinksTag = nil;

// start class csMultiChangeHyperLinksTag

function k2_typcsMultiChangeHyperLinks: csMultiChangeHyperLinksTag;
begin
 if (g_csMultiChangeHyperLinks = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiChangeHyperLinks := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiChangeHyperLinks;
 end;//g_csMultiChangeHyperLinks = nil
 Result := g_csMultiChangeHyperLinks;
end;
var
 g_k2_attrDocumentIDList: Integer = -1;

function k2_attrDocumentIDList: Integer;
begin
 if (g_k2_attrDocumentIDList = -1) then
  g_k2_attrDocumentIDList :=  Tk2Attributes.Instance.CheckIDByName('DocumentIDList');
 Result := g_k2_attrDocumentIDList;
end;

var
 g_k2_attrOldDocID: Integer = -1;

function k2_attrOldDocID: Integer;
begin
 if (g_k2_attrOldDocID = -1) then
  g_k2_attrOldDocID :=  Tk2Attributes.Instance.CheckIDByName('OldDocID');
 Result := g_k2_attrOldDocID;
end;

var
 g_k2_attrNewDocID: Integer = -1;

function k2_attrNewDocID: Integer;
begin
 if (g_k2_attrNewDocID = -1) then
  g_k2_attrNewDocID :=  Tk2Attributes.Instance.CheckIDByName('NewDocID');
 Result := g_k2_attrNewDocID;
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
 g_csMultiChangeHyperLinks_DocumentIDList : csMultiChangeHyperLinks_DocumentIDList_Tag = nil;

// start class DocumentIDList

function k2_typcsMultiChangeHyperLinks_DocumentIDList: csMultiChangeHyperLinks_DocumentIDList_Tag;
begin
 if (g_csMultiChangeHyperLinks_DocumentIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiChangeHyperLinks_DocumentIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiChangeHyperLinks_DocumentIDList;
 end;//g_csMultiChangeHyperLinks = nil
 Result := g_csMultiChangeHyperLinks_DocumentIDList;
end;


end.