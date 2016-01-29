unit Version_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/Version_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Version
//
// Версия
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Version - "Версия".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idVersion = 136;

function k2_attrIsActive: Integer;

function k2_attrType: Integer;

function k2_typVersion: VersionTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Version : VersionTag = nil;

// start class VersionTag

function k2_typVersion: VersionTag;
begin
 if (g_Version = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Version := TevNativeSchema(Tk2TypeTable.GetInstance).t_Version;
 end;//g_Version = nil
 Result := g_Version;
end;
var
 g_k2_attrIsActive: Integer = -1;

function k2_attrIsActive: Integer;
begin
 if (g_k2_attrIsActive = -1) then
  g_k2_attrIsActive :=  Tk2Attributes.Instance.CheckIDByName('IsActive');
 Result := g_k2_attrIsActive;
end;

var
 g_k2_attrType: Integer = -1;

function k2_attrType: Integer;
begin
 if (g_k2_attrType = -1) then
  g_k2_attrType :=  Tk2Attributes.Instance.CheckIDByName('Type');
 Result := g_k2_attrType;
end;


end.