unit RelPublishTaskResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/RelPublishTaskResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::RelPublishTaskResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега RelPublishTaskResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrMailBody: Integer;

function k2_attrIsError: Integer;

function k2_typRelPublishTaskResult: RelPublishTaskResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_RelPublishTaskResult : RelPublishTaskResultTag = nil;

// start class RelPublishTaskResultTag

function k2_typRelPublishTaskResult: RelPublishTaskResultTag;
begin
 if (g_RelPublishTaskResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_RelPublishTaskResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_RelPublishTaskResult;
 end;//g_RelPublishTaskResult = nil
 Result := g_RelPublishTaskResult;
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
 g_k2_attrIsError: Integer = -1;

function k2_attrIsError: Integer;
begin
 if (g_k2_attrIsError = -1) then
  g_k2_attrIsError :=  Tk2Attributes.Instance.CheckIDByName('IsError');
 Result := g_k2_attrIsError;
end;


end.