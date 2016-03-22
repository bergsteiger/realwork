unit Sub_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Sub_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Sub
//
// Метка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Sub - "Метка".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idSub = 15;

function k2_typSub_Classes: Sub_Classes_Tag;

function k2_typSub_AutoClasses: Sub_AutoClasses_Tag;

function k2_typSub_Types: Sub_Types_Tag;

function k2_typSub_KeyWords: Sub_KeyWords_Tag;

function k2_typSub_Prefix: Sub_Prefix_Tag;

function k2_typSub_ServiceInfo: Sub_ServiceInfo_Tag;

function k2_attrClasses: Integer;

function k2_attrAutoClasses: Integer;

function k2_attrTypes: Integer;

function k2_attrKeyWords: Integer;

function k2_attrPrefix: Integer;

function k2_attrServiceInfo: Integer;

function k2_attrFlags: Integer;
function k2_typSub: SubTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Sub : SubTag = nil;

// start class SubTag

function k2_typSub: SubTag;
begin
 if (g_Sub = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub;
 end;//g_Sub = nil
 Result := g_Sub;
end;
var
 g_k2_attrClasses: Integer = -1;

function k2_attrClasses: Integer;
begin
 if (g_k2_attrClasses = -1) then
  g_k2_attrClasses :=  Tk2Attributes.Instance.CheckIDByName('Classes');
 Result := g_k2_attrClasses;
end;

var
 g_k2_attrAutoClasses: Integer = -1;

function k2_attrAutoClasses: Integer;
begin
 if (g_k2_attrAutoClasses = -1) then
  g_k2_attrAutoClasses :=  Tk2Attributes.Instance.CheckIDByName('AutoClasses');
 Result := g_k2_attrAutoClasses;
end;

var
 g_k2_attrTypes: Integer = -1;

function k2_attrTypes: Integer;
begin
 if (g_k2_attrTypes = -1) then
  g_k2_attrTypes :=  Tk2Attributes.Instance.CheckIDByName('Types');
 Result := g_k2_attrTypes;
end;

var
 g_k2_attrKeyWords: Integer = -1;

function k2_attrKeyWords: Integer;
begin
 if (g_k2_attrKeyWords = -1) then
  g_k2_attrKeyWords :=  Tk2Attributes.Instance.CheckIDByName('KeyWords');
 Result := g_k2_attrKeyWords;
end;

var
 g_k2_attrPrefix: Integer = -1;

function k2_attrPrefix: Integer;
begin
 if (g_k2_attrPrefix = -1) then
  g_k2_attrPrefix :=  Tk2Attributes.Instance.CheckIDByName('Prefix');
 Result := g_k2_attrPrefix;
end;

var
 g_k2_attrServiceInfo: Integer = -1;

function k2_attrServiceInfo: Integer;
begin
 if (g_k2_attrServiceInfo = -1) then
  g_k2_attrServiceInfo :=  Tk2Attributes.Instance.CheckIDByName('ServiceInfo');
 Result := g_k2_attrServiceInfo;
end;

var
 g_k2_attrFlags: Integer = -1;

function k2_attrFlags: Integer;
begin
 if (g_k2_attrFlags = -1) then
  g_k2_attrFlags :=  Tk2Attributes.Instance.CheckIDByName('Flags');
 Result := g_k2_attrFlags;
end;


var
 g_Sub_Classes : Sub_Classes_Tag = nil;

// start class Classes

function k2_typSub_Classes: Sub_Classes_Tag;
begin
 if (g_Sub_Classes = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_Classes := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_Classes;
 end;//g_Sub = nil
 Result := g_Sub_Classes;
end;

var
 g_Sub_AutoClasses : Sub_AutoClasses_Tag = nil;

// start class AutoClasses

function k2_typSub_AutoClasses: Sub_AutoClasses_Tag;
begin
 if (g_Sub_AutoClasses = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_AutoClasses := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_AutoClasses;
 end;//g_Sub = nil
 Result := g_Sub_AutoClasses;
end;

var
 g_Sub_Types : Sub_Types_Tag = nil;

// start class Types

function k2_typSub_Types: Sub_Types_Tag;
begin
 if (g_Sub_Types = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_Types := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_Types;
 end;//g_Sub = nil
 Result := g_Sub_Types;
end;

var
 g_Sub_KeyWords : Sub_KeyWords_Tag = nil;

// start class KeyWords

function k2_typSub_KeyWords: Sub_KeyWords_Tag;
begin
 if (g_Sub_KeyWords = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_KeyWords := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_KeyWords;
 end;//g_Sub = nil
 Result := g_Sub_KeyWords;
end;

var
 g_Sub_Prefix : Sub_Prefix_Tag = nil;

// start class Prefix

function k2_typSub_Prefix: Sub_Prefix_Tag;
begin
 if (g_Sub_Prefix = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_Prefix := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_Prefix;
 end;//g_Sub = nil
 Result := g_Sub_Prefix;
end;

var
 g_Sub_ServiceInfo : Sub_ServiceInfo_Tag = nil;

// start class ServiceInfo

function k2_typSub_ServiceInfo: Sub_ServiceInfo_Tag;
begin
 if (g_Sub_ServiceInfo = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Sub_ServiceInfo := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Sub_ServiceInfo;
 end;//g_Sub = nil
 Result := g_Sub_ServiceInfo;
end;


end.