unit csDownloadDocStream_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDownloadDocStream_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDownloadDocStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDownloadDocStream .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDownloadDocStream_FoundSelector: csDownloadDocStream_FoundSelector_Tag;

function k2_typcsDownloadDocStream_DocPart: csDownloadDocStream_DocPart_Tag;

function k2_typcsDownloadDocStream_DocPartSel: csDownloadDocStream_DocPartSel_Tag;

function k2_attrDocID: Integer;

function k2_attrLevel: Integer;

function k2_attrWithAttr: Integer;

function k2_attrFoundSelector: Integer;

function k2_attrDocPart: Integer;

function k2_attrDocPartSel: Integer;

function k2_attrDocFamily: Integer;

function k2_attrIsObjTopic: Integer;

function k2_attrDocumentType: Integer;
function k2_typcsDownloadDocStream: csDownloadDocStreamTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDownloadDocStream : csDownloadDocStreamTag = nil;

// start class csDownloadDocStreamTag

function k2_typcsDownloadDocStream: csDownloadDocStreamTag;
begin
 if (g_csDownloadDocStream = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDownloadDocStream := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDownloadDocStream;
 end;//g_csDownloadDocStream = nil
 Result := g_csDownloadDocStream;
end;
var
 g_k2_attrDocID: Integer = -1;

function k2_attrDocID: Integer;
begin
 if (g_k2_attrDocID = -1) then
  g_k2_attrDocID :=  Tk2Attributes.Instance.CheckIDByName('DocID');
 Result := g_k2_attrDocID;
end;

var
 g_k2_attrLevel: Integer = -1;

function k2_attrLevel: Integer;
begin
 if (g_k2_attrLevel = -1) then
  g_k2_attrLevel :=  Tk2Attributes.Instance.CheckIDByName('Level');
 Result := g_k2_attrLevel;
end;

var
 g_k2_attrWithAttr: Integer = -1;

function k2_attrWithAttr: Integer;
begin
 if (g_k2_attrWithAttr = -1) then
  g_k2_attrWithAttr :=  Tk2Attributes.Instance.CheckIDByName('WithAttr');
 Result := g_k2_attrWithAttr;
end;

var
 g_k2_attrFoundSelector: Integer = -1;

function k2_attrFoundSelector: Integer;
begin
 if (g_k2_attrFoundSelector = -1) then
  g_k2_attrFoundSelector :=  Tk2Attributes.Instance.CheckIDByName('FoundSelector');
 Result := g_k2_attrFoundSelector;
end;

var
 g_k2_attrDocPart: Integer = -1;

function k2_attrDocPart: Integer;
begin
 if (g_k2_attrDocPart = -1) then
  g_k2_attrDocPart :=  Tk2Attributes.Instance.CheckIDByName('DocPart');
 Result := g_k2_attrDocPart;
end;

var
 g_k2_attrDocPartSel: Integer = -1;

function k2_attrDocPartSel: Integer;
begin
 if (g_k2_attrDocPartSel = -1) then
  g_k2_attrDocPartSel :=  Tk2Attributes.Instance.CheckIDByName('DocPartSel');
 Result := g_k2_attrDocPartSel;
end;

var
 g_k2_attrDocFamily: Integer = -1;

function k2_attrDocFamily: Integer;
begin
 if (g_k2_attrDocFamily = -1) then
  g_k2_attrDocFamily :=  Tk2Attributes.Instance.CheckIDByName('DocFamily');
 Result := g_k2_attrDocFamily;
end;

var
 g_k2_attrIsObjTopic: Integer = -1;

function k2_attrIsObjTopic: Integer;
begin
 if (g_k2_attrIsObjTopic = -1) then
  g_k2_attrIsObjTopic :=  Tk2Attributes.Instance.CheckIDByName('IsObjTopic');
 Result := g_k2_attrIsObjTopic;
end;

var
 g_k2_attrDocumentType: Integer = -1;

function k2_attrDocumentType: Integer;
begin
 if (g_k2_attrDocumentType = -1) then
  g_k2_attrDocumentType :=  Tk2Attributes.Instance.CheckIDByName('DocumentType');
 Result := g_k2_attrDocumentType;
end;


var
 g_csDownloadDocStream_FoundSelector : csDownloadDocStream_FoundSelector_Tag = nil;

// start class FoundSelector

function k2_typcsDownloadDocStream_FoundSelector: csDownloadDocStream_FoundSelector_Tag;
begin
 if (g_csDownloadDocStream_FoundSelector = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDownloadDocStream_FoundSelector := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDownloadDocStream_FoundSelector;
 end;//g_csDownloadDocStream = nil
 Result := g_csDownloadDocStream_FoundSelector;
end;

var
 g_csDownloadDocStream_DocPart : csDownloadDocStream_DocPart_Tag = nil;

// start class DocPart

function k2_typcsDownloadDocStream_DocPart: csDownloadDocStream_DocPart_Tag;
begin
 if (g_csDownloadDocStream_DocPart = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDownloadDocStream_DocPart := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDownloadDocStream_DocPart;
 end;//g_csDownloadDocStream = nil
 Result := g_csDownloadDocStream_DocPart;
end;

var
 g_csDownloadDocStream_DocPartSel : csDownloadDocStream_DocPartSel_Tag = nil;

// start class DocPartSel

function k2_typcsDownloadDocStream_DocPartSel: csDownloadDocStream_DocPartSel_Tag;
begin
 if (g_csDownloadDocStream_DocPartSel = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDownloadDocStream_DocPartSel := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDownloadDocStream_DocPartSel;
 end;//g_csDownloadDocStream = nil
 Result := g_csDownloadDocStream_DocPartSel;
end;


end.