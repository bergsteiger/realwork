unit csSendTaskReply_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csSendTaskReply_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csSendTaskReply
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csSendTaskReply .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrIsSuccess: Integer;

function k2_typcsSendTaskReply: csSendTaskReplyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csSendTaskReply : csSendTaskReplyTag = nil;

// start class csSendTaskReplyTag

function k2_typcsSendTaskReply: csSendTaskReplyTag;
begin
 if (g_csSendTaskReply = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csSendTaskReply := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csSendTaskReply;
 end;//g_csSendTaskReply = nil
 Result := g_csSendTaskReply;
end;
var
 g_k2_attrIsSuccess: Integer = -1;

function k2_attrIsSuccess: Integer;
begin
 if (g_k2_attrIsSuccess = -1) then
  g_k2_attrIsSuccess :=  Tk2Attributes.Instance.CheckIDByName('IsSuccess');
 Result := g_k2_attrIsSuccess;
end;


end.