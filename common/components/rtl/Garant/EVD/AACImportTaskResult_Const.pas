unit AACImportTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AACImportTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::AACImportTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AACImportTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrIsSuccess: Integer;

function k2_attrAttachFileName: Integer;

function k2_attrMailBody: Integer;

function k2_attrNeedRestart: Integer;

function k2_typAACImportTaskResult: AACImportTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AACImportTaskResult : AACImportTaskResultTag = nil;

// start class AACImportTaskResultTag

function k2_typAACImportTaskResult: AACImportTaskResultTag;
begin
 if (g_AACImportTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImportTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImportTaskResult;
 end;//g_AACImportTaskResult = nil
 Result := g_AACImportTaskResult;
end;
var
 g_k2_attrIsSuccess: Integer = -1;

function k2_attrIsSuccess: Integer;
begin
 if (g_k2_attrIsSuccess = -1) then
  g_k2_attrIsSuccess :=  Tk2Attributes.Instance.CheckIDByName('IsSuccess');
 Result := g_k2_attrIsSuccess;
end;

var
 g_k2_attrAttachFileName: Integer = -1;

function k2_attrAttachFileName: Integer;
begin
 if (g_k2_attrAttachFileName = -1) then
  g_k2_attrAttachFileName :=  Tk2Attributes.Instance.CheckIDByName('AttachFileName');
 Result := g_k2_attrAttachFileName;
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
 g_k2_attrNeedRestart: Integer = -1;

function k2_attrNeedRestart: Integer;
begin
 if (g_k2_attrNeedRestart = -1) then
  g_k2_attrNeedRestart :=  Tk2Attributes.Instance.CheckIDByName('NeedRestart');
 Result := g_k2_attrNeedRestart;
end;


end.