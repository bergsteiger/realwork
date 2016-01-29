unit TabStop_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/TabStop_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::TabStop
//
// Позиция табуляции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TabStop - "Позиция табуляции".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idTabStop = 114;

function k2_typTabStop_Type: TabStop_Type_Tag;

function k2_attrStart: Integer;

function k2_attrType: Integer;

function k2_attrText: Integer;
function k2_typTabStop: TabStopTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TabStop : TabStopTag = nil;

// start class TabStopTag

function k2_typTabStop: TabStopTag;
begin
 if (g_TabStop = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TabStop := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TabStop;
 end;//g_TabStop = nil
 Result := g_TabStop;
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
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;

var
 g_k2_attrText: Integer = -1;

function k2_attrText: Integer;
begin
 if (g_k2_attrText = -1) then
  g_k2_attrText :=  Tk2Attributes.Instance.CheckIDByName('Text');
 Result := g_k2_attrText;
end;


var
 g_TabStop_Type : TabStop_Type_Tag = nil;

// start class Type

function k2_typTabStop_Type: TabStop_Type_Tag;
begin
 if (g_TabStop_Type = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TabStop_Type := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TabStop_Type;
 end;//g_TabStop = nil
 Result := g_TabStop_Type;
end;


end.