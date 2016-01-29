unit AutoClass_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/AutoClass_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::AutoClass
//
// Авто-класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AutoClass - "Авто-класс".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idAutoClass = 86;

function k2_attrFlags: Integer;

function k2_attrWeight: Integer;

function k2_typAutoClass: AutoClassTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AutoClass : AutoClassTag = nil;

// start class AutoClassTag

function k2_typAutoClass: AutoClassTag;
begin
 if (g_AutoClass = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_AutoClass := TevdNativeSchema(Tk2TypeTable.GetInstance).t_AutoClass;
 end;//g_AutoClass = nil
 Result := g_AutoClass;
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
 g_k2_attrWeight: Integer = -1;

function k2_attrWeight: Integer;
begin
 if (g_k2_attrWeight = -1) then
  g_k2_attrWeight :=  Tk2Attributes.Instance.CheckIDByName('Weight');
 Result := g_k2_attrWeight;
end;


end.