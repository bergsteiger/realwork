unit csMultiChangeHyperLinksReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csMultiChangeHyperLinksReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::csMultiChangeHyperLinksReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csMultiChangeHyperLinksReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrIsSuccess: Integer;

function k2_attrErrorMessage: Integer;

function k2_typcsMultiChangeHyperLinksReply: csMultiChangeHyperLinksReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csMultiChangeHyperLinksReply : csMultiChangeHyperLinksReplyTag = nil;

// start class csMultiChangeHyperLinksReplyTag

function k2_typcsMultiChangeHyperLinksReply: csMultiChangeHyperLinksReplyTag;
begin
 if (g_csMultiChangeHyperLinksReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csMultiChangeHyperLinksReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csMultiChangeHyperLinksReply;
 end;//g_csMultiChangeHyperLinksReply = nil
 Result := g_csMultiChangeHyperLinksReply;
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
 g_k2_attrErrorMessage: Integer = -1;

function k2_attrErrorMessage: Integer;
begin
 if (g_k2_attrErrorMessage = -1) then
  g_k2_attrErrorMessage :=  Tk2Attributes.Instance.CheckIDByName('ErrorMessage');
 Result := g_k2_attrErrorMessage;
end;


end.