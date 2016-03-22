unit FileDesc_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/FileDesc_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::FileDesc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега FileDesc .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrName: Integer;

function k2_attrCRC: Integer;

function k2_attrDateTime: Integer;

function k2_attrSize: Integer;

function k2_typFileDesc: FileDescTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_FileDesc : FileDescTag = nil;

// start class FileDescTag

function k2_typFileDesc: FileDescTag;
begin
 if (g_FileDesc = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_FileDesc := TevdTasksSchema(Tk2TypeTable.GetInstance).t_FileDesc;
 end;//g_FileDesc = nil
 Result := g_FileDesc;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;

var
 g_k2_attrCRC: Integer = -1;

function k2_attrCRC: Integer;
begin
 if (g_k2_attrCRC = -1) then
  g_k2_attrCRC :=  Tk2Attributes.Instance.CheckIDByName('CRC');
 Result := g_k2_attrCRC;
end;

var
 g_k2_attrDateTime: Integer = -1;

function k2_attrDateTime: Integer;
begin
 if (g_k2_attrDateTime = -1) then
  g_k2_attrDateTime :=  Tk2Attributes.Instance.CheckIDByName('DateTime');
 Result := g_k2_attrDateTime;
end;

var
 g_k2_attrSize: Integer = -1;

function k2_attrSize: Integer;
begin
 if (g_k2_attrSize = -1) then
  g_k2_attrSize :=  Tk2Attributes.Instance.CheckIDByName('Size');
 Result := g_k2_attrSize;
end;


end.