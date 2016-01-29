unit LogRecord_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/LogRecord_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::LogRecord
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега LogRecord .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idLogRecord = 78;

function k2_attrUser: Integer;

function k2_attrTime: Integer;

function k2_typLogRecord: LogRecordTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LogRecord : LogRecordTag = nil;

// start class LogRecordTag

function k2_typLogRecord: LogRecordTag;
begin
 if (g_LogRecord = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_LogRecord := TevdNativeSchema(Tk2TypeTable.GetInstance).t_LogRecord;
 end;//g_LogRecord = nil
 Result := g_LogRecord;
end;
var
 g_k2_attrUser: Integer = -1;

function k2_attrUser: Integer;
begin
 if (g_k2_attrUser = -1) then
  g_k2_attrUser :=  Tk2Attributes.Instance.CheckIDByName('User');
 Result := g_k2_attrUser;
end;

var
 g_k2_attrTime: Integer = -1;

function k2_attrTime: Integer;
begin
 if (g_k2_attrTime = -1) then
  g_k2_attrTime :=  Tk2Attributes.Instance.CheckIDByName('Time');
 Result := g_k2_attrTime;
end;


end.