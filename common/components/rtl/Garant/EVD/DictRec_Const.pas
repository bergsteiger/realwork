unit DictRec_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/DictRec_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::DictRec
//
// Словарная запись
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DictRec - "Словарная запись".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrName: Integer;

function k2_attrShortName: Integer;

function k2_typDictRec: DictRecTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictRec : DictRecTag = nil;

// start class DictRecTag

function k2_typDictRec: DictRecTag;
begin
 if (g_DictRec = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DictRec := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DictRec;
 end;//g_DictRec = nil
 Result := g_DictRec;
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
 g_k2_attrShortName: Integer = -1;

function k2_attrShortName: Integer;
begin
 if (g_k2_attrShortName = -1) then
  g_k2_attrShortName :=  Tk2Attributes.Instance.CheckIDByName('ShortName');
 Result := g_k2_attrShortName;
end;


end.