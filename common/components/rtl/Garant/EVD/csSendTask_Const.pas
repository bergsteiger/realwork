unit csSendTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/csSendTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::csSendTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега csSendTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrData: Integer;

function k2_typcsSendTask: csSendTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_csSendTask : csSendTaskTag = nil;

// start class csSendTaskTag

function k2_typcsSendTask: csSendTaskTag;
begin
 if (g_csSendTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_csSendTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_csSendTask;
 end;//g_csSendTask = nil
 Result := g_csSendTask;
end;
var
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;


end.