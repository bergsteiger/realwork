unit csUploadDocStream_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csUploadDocStream_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csUploadDocStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csUploadDocStream .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsUploadDocStream_DocPart: csUploadDocStream_DocPart_Tag;

function k2_typcsUploadDocStream_DocClass: csUploadDocStream_DocClass_Tag;

function k2_attrData: Integer;

function k2_attrIsObjTopic: Integer;

function k2_attrDocFamily: Integer;

function k2_attrDocID: Integer;

function k2_attrDocPart: Integer;

function k2_attrParseToDB: Integer;

function k2_attrIsClassChanged: Integer;

function k2_attrNeedSaveText: Integer;

function k2_attrDocClass: Integer;
function k2_typcsUploadDocStream: csUploadDocStreamTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csUploadDocStream : csUploadDocStreamTag = nil;

// start class csUploadDocStreamTag

function k2_typcsUploadDocStream: csUploadDocStreamTag;
begin
 if (g_csUploadDocStream = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csUploadDocStream := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csUploadDocStream;
 end;//g_csUploadDocStream = nil
 Result := g_csUploadDocStream;
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
 g_k2_attrIsObjTopic: Integer = -1;

function k2_attrIsObjTopic: Integer;
begin
 if (g_k2_attrIsObjTopic = -1) then
  g_k2_attrIsObjTopic :=  Tk2Attributes.Instance.CheckIDByName('IsObjTopic');
 Result := g_k2_attrIsObjTopic;
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
 g_k2_attrDocID: Integer = -1;

function k2_attrDocID: Integer;
begin
 if (g_k2_attrDocID = -1) then
  g_k2_attrDocID :=  Tk2Attributes.Instance.CheckIDByName('DocID');
 Result := g_k2_attrDocID;
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
 g_k2_attrParseToDB: Integer = -1;

function k2_attrParseToDB: Integer;
begin
 if (g_k2_attrParseToDB = -1) then
  g_k2_attrParseToDB :=  Tk2Attributes.Instance.CheckIDByName('ParseToDB');
 Result := g_k2_attrParseToDB;
end;

var
 g_k2_attrIsClassChanged: Integer = -1;

function k2_attrIsClassChanged: Integer;
begin
 if (g_k2_attrIsClassChanged = -1) then
  g_k2_attrIsClassChanged :=  Tk2Attributes.Instance.CheckIDByName('IsClassChanged');
 Result := g_k2_attrIsClassChanged;
end;

var
 g_k2_attrNeedSaveText: Integer = -1;

function k2_attrNeedSaveText: Integer;
begin
 if (g_k2_attrNeedSaveText = -1) then
  g_k2_attrNeedSaveText :=  Tk2Attributes.Instance.CheckIDByName('NeedSaveText');
 Result := g_k2_attrNeedSaveText;
end;

var
 g_k2_attrDocClass: Integer = -1;

function k2_attrDocClass: Integer;
begin
 if (g_k2_attrDocClass = -1) then
  g_k2_attrDocClass :=  Tk2Attributes.Instance.CheckIDByName('DocClass');
 Result := g_k2_attrDocClass;
end;


var
 g_csUploadDocStream_DocPart : csUploadDocStream_DocPart_Tag = nil;

// start class DocPart

function k2_typcsUploadDocStream_DocPart: csUploadDocStream_DocPart_Tag;
begin
 if (g_csUploadDocStream_DocPart = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csUploadDocStream_DocPart := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csUploadDocStream_DocPart;
 end;//g_csUploadDocStream = nil
 Result := g_csUploadDocStream_DocPart;
end;

var
 g_csUploadDocStream_DocClass : csUploadDocStream_DocClass_Tag = nil;

// start class DocClass

function k2_typcsUploadDocStream_DocClass: csUploadDocStream_DocClass_Tag;
begin
 if (g_csUploadDocStream_DocClass = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csUploadDocStream_DocClass := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csUploadDocStream_DocClass;
 end;//g_csUploadDocStream = nil
 Result := g_csUploadDocStream_DocClass;
end;


end.