unit DictItem_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/DictItem_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::DictItem
//
// Элемент словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DictItem - "Элемент словаря".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idDictItem = 73;

function k2_typDictItem_Flags: DictItem_Flags_Tag;

function k2_attrFlags: Integer;
function k2_typDictItem: DictItemTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictItem : DictItemTag = nil;

// start class DictItemTag

function k2_typDictItem: DictItemTag;
begin
 if (g_DictItem = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DictItem := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DictItem;
 end;//g_DictItem = nil
 Result := g_DictItem;
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
 g_DictItem_Flags : DictItem_Flags_Tag = nil;

// start class Flags

function k2_typDictItem_Flags: DictItem_Flags_Tag;
begin
 if (g_DictItem_Flags = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DictItem_Flags := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DictItem_Flags;
 end;//g_DictItem = nil
 Result := g_DictItem_Flags;
end;


end.