unit ImportTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ImportTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::ImportTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ImportTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typImportTaskResult_ImportedDocList: ImportTaskResult_ImportedDocList_Tag;

function k2_attrMailBody: Integer;

function k2_attrImportedDocList: Integer;

function k2_attrUserNotification: Integer;

function k2_attrMailSubject: Integer;

function k2_attrEMailSubject: Integer;
function k2_typImportTaskResult: ImportTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ImportTaskResult : ImportTaskResultTag = nil;

// start class ImportTaskResultTag

function k2_typImportTaskResult: ImportTaskResultTag;
begin
 if (g_ImportTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ImportTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ImportTaskResult;
 end;//g_ImportTaskResult = nil
 Result := g_ImportTaskResult;
end;
var
 g_k2_attrMailBody: Integer = -1;

function k2_attrMailBody: Integer;
begin
 if (g_k2_attrMailBody = -1) then
  g_k2_attrMailBody :=  Tk2Attributes.Instance.CheckIDByName('MailBody');
 Result := g_k2_attrMailBody;
end;

var
 g_k2_attrImportedDocList: Integer = -1;

function k2_attrImportedDocList: Integer;
begin
 if (g_k2_attrImportedDocList = -1) then
  g_k2_attrImportedDocList :=  Tk2Attributes.Instance.CheckIDByName('ImportedDocList');
 Result := g_k2_attrImportedDocList;
end;

var
 g_k2_attrUserNotification: Integer = -1;

function k2_attrUserNotification: Integer;
begin
 if (g_k2_attrUserNotification = -1) then
  g_k2_attrUserNotification :=  Tk2Attributes.Instance.CheckIDByName('UserNotification');
 Result := g_k2_attrUserNotification;
end;

var
 g_k2_attrMailSubject: Integer = -1;

function k2_attrMailSubject: Integer;
begin
 if (g_k2_attrMailSubject = -1) then
  g_k2_attrMailSubject :=  Tk2Attributes.Instance.CheckIDByName('MailSubject');
 Result := g_k2_attrMailSubject;
end;

var
 g_k2_attrEMailSubject: Integer = -1;

function k2_attrEMailSubject: Integer;
begin
 if (g_k2_attrEMailSubject = -1) then
  g_k2_attrEMailSubject :=  Tk2Attributes.Instance.CheckIDByName('EMailSubject');
 Result := g_k2_attrEMailSubject;
end;


var
 g_ImportTaskResult_ImportedDocList : ImportTaskResult_ImportedDocList_Tag = nil;

// start class ImportedDocList

function k2_typImportTaskResult_ImportedDocList: ImportTaskResult_ImportedDocList_Tag;
begin
 if (g_ImportTaskResult_ImportedDocList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ImportTaskResult_ImportedDocList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ImportTaskResult_ImportedDocList;
 end;//g_ImportTaskResult = nil
 Result := g_ImportTaskResult_ImportedDocList;
end;


end.