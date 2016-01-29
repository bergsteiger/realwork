unit csGetTaskDescriptionReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csGetTaskDescriptionReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csGetTaskDescriptionReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csGetTaskDescriptionReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsGetTaskDescriptionReply_FileDesc: csGetTaskDescriptionReply_FileDesc_Tag;

function k2_attrLocalFolder: Integer;

function k2_attrRemoteFolder: Integer;

function k2_attrFileDesc: Integer;
function k2_typcsGetTaskDescriptionReply: csGetTaskDescriptionReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csGetTaskDescriptionReply : csGetTaskDescriptionReplyTag = nil;

// start class csGetTaskDescriptionReplyTag

function k2_typcsGetTaskDescriptionReply: csGetTaskDescriptionReplyTag;
begin
 if (g_csGetTaskDescriptionReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetTaskDescriptionReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetTaskDescriptionReply;
 end;//g_csGetTaskDescriptionReply = nil
 Result := g_csGetTaskDescriptionReply;
end;
var
 g_k2_attrLocalFolder: Integer = -1;

function k2_attrLocalFolder: Integer;
begin
 if (g_k2_attrLocalFolder = -1) then
  g_k2_attrLocalFolder :=  Tk2Attributes.Instance.CheckIDByName('LocalFolder');
 Result := g_k2_attrLocalFolder;
end;

var
 g_k2_attrRemoteFolder: Integer = -1;

function k2_attrRemoteFolder: Integer;
begin
 if (g_k2_attrRemoteFolder = -1) then
  g_k2_attrRemoteFolder :=  Tk2Attributes.Instance.CheckIDByName('RemoteFolder');
 Result := g_k2_attrRemoteFolder;
end;

var
 g_k2_attrFileDesc: Integer = -1;

function k2_attrFileDesc: Integer;
begin
 if (g_k2_attrFileDesc = -1) then
  g_k2_attrFileDesc :=  Tk2Attributes.Instance.CheckIDByName('FileDesc');
 Result := g_k2_attrFileDesc;
end;


var
 g_csGetTaskDescriptionReply_FileDesc : csGetTaskDescriptionReply_FileDesc_Tag = nil;

// start class FileDesc

function k2_typcsGetTaskDescriptionReply_FileDesc: csGetTaskDescriptionReply_FileDesc_Tag;
begin
 if (g_csGetTaskDescriptionReply_FileDesc = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csGetTaskDescriptionReply_FileDesc := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csGetTaskDescriptionReply_FileDesc;
 end;//g_csGetTaskDescriptionReply = nil
 Result := g_csGetTaskDescriptionReply_FileDesc;
end;


end.