unit csDownloadDocStreamReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDownloadDocStreamReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csDownloadDocStreamReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDownloadDocStreamReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrIsSuccess: Integer;

function k2_attrData: Integer;

function k2_attrErrorMessage: Integer;

function k2_typcsDownloadDocStreamReply: csDownloadDocStreamReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDownloadDocStreamReply : csDownloadDocStreamReplyTag = nil;

// start class csDownloadDocStreamReplyTag

function k2_typcsDownloadDocStreamReply: csDownloadDocStreamReplyTag;
begin
 if (g_csDownloadDocStreamReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDownloadDocStreamReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDownloadDocStreamReply;
 end;//g_csDownloadDocStreamReply = nil
 Result := g_csDownloadDocStreamReply;
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
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;

var
 g_k2_attrErrorMessage: Integer = -1;

function k2_attrErrorMessage: Integer;
begin
 if (g_k2_attrErrorMessage = -1) then
  g_k2_attrErrorMessage :=  Tk2Attributes.Instance.CheckIDByName('ErrorMessage');
 Result := g_k2_attrErrorMessage;
end;


end.