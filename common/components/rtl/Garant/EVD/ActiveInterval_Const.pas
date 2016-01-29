unit ActiveInterval_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/ActiveInterval_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::ActiveInterval
//
// Интервал действия
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ActiveInterval - "Интервал действия".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idActiveInterval = 84;

function k2_attrHandle: Integer;

function k2_attrStart: Integer;

function k2_attrComment: Integer;

function k2_attrType: Integer;

function k2_attrFinish: Integer;

function k2_typActiveInterval: ActiveIntervalTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ActiveInterval : ActiveIntervalTag = nil;

// start class ActiveIntervalTag

function k2_typActiveInterval: ActiveIntervalTag;
begin
 if (g_ActiveInterval = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_ActiveInterval := TevdNativeSchema(Tk2TypeTable.GetInstance).t_ActiveInterval;
 end;//g_ActiveInterval = nil
 Result := g_ActiveInterval;
end;
var
 g_k2_attrHandle: Integer = -1;

function k2_attrHandle: Integer;
begin
 if (g_k2_attrHandle = -1) then
  g_k2_attrHandle :=  Tk2Attributes.Instance.CheckIDByName('Handle');
 Result := g_k2_attrHandle;
end;

var
 g_k2_attrStart: Integer = -1;

function k2_attrStart: Integer;
begin
 if (g_k2_attrStart = -1) then
  g_k2_attrStart :=  Tk2Attributes.Instance.CheckIDByName('Start');
 Result := g_k2_attrStart;
end;

var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
end;

var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;

var
 g_k2_attrFinish: Integer = -1;

function k2_attrFinish: Integer;
begin
 if (g_k2_attrFinish = -1) then
  g_k2_attrFinish :=  Tk2Attributes.Instance.CheckIDByName('Finish');
 Result := g_k2_attrFinish;
end;


end.