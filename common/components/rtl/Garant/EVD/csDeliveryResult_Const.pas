unit csDeliveryResult_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csDeliveryResult_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csDeliveryResult
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csDeliveryResult .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typcsDeliveryResult_ResultKind: csDeliveryResult_ResultKind_Tag;

function k2_attrTaskID: Integer;

function k2_attrResultKind: Integer;
function k2_typcsDeliveryResult: csDeliveryResultTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csDeliveryResult : csDeliveryResultTag = nil;

// start class csDeliveryResultTag

function k2_typcsDeliveryResult: csDeliveryResultTag;
begin
 if (g_csDeliveryResult = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDeliveryResult := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDeliveryResult;
 end;//g_csDeliveryResult = nil
 Result := g_csDeliveryResult;
end;
var
 g_k2_attrTaskID: Integer = -1;

function k2_attrTaskID: Integer;
begin
 if (g_k2_attrTaskID = -1) then
  g_k2_attrTaskID :=  Tk2Attributes.Instance.CheckIDByName('TaskID');
 Result := g_k2_attrTaskID;
end;

var
 g_k2_attrResultKind: Integer = -1;

function k2_attrResultKind: Integer;
begin
 if (g_k2_attrResultKind = -1) then
  g_k2_attrResultKind :=  Tk2Attributes.Instance.CheckIDByName('ResultKind');
 Result := g_k2_attrResultKind;
end;


var
 g_csDeliveryResult_ResultKind : csDeliveryResult_ResultKind_Tag = nil;

// start class ResultKind

function k2_typcsDeliveryResult_ResultKind: csDeliveryResult_ResultKind_Tag;
begin
 if (g_csDeliveryResult_ResultKind = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csDeliveryResult_ResultKind := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csDeliveryResult_ResultKind;
 end;//g_csDeliveryResult = nil
 Result := g_csDeliveryResult_ResultKind;
end;


end.