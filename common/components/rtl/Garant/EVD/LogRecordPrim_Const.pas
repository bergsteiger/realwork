unit LogRecordPrim_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/LogRecordPrim_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::LogRecordPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега LogRecordPrim .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrType: Integer;

function k2_attrStart: Integer;

function k2_typLogRecordPrim: LogRecordPrimTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LogRecordPrim : LogRecordPrimTag = nil;

// start class LogRecordPrimTag

function k2_typLogRecordPrim: LogRecordPrimTag;
begin
 if (g_LogRecordPrim = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_LogRecordPrim := TevdNativeSchema(Tk2TypeTable.GetInstance).t_LogRecordPrim;
 end;//g_LogRecordPrim = nil
 Result := g_LogRecordPrim;
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
 g_k2_attrStart: Integer = -1;

function k2_attrStart: Integer;
begin
 if (g_k2_attrStart = -1) then
  g_k2_attrStart :=  Tk2Attributes.Instance.CheckIDByName('Start');
 Result := g_k2_attrStart;
end;


end.