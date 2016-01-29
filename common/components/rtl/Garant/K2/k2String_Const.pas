unit k2String_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2String_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::K2::CoreTypes::k2Core::String
//
// Строка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега String - "Строка".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_attrValue: Integer;

function k2_typString: StringTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_String : StringTag = nil;

// start class StringTag

function k2_typString: StringTag;
begin
 if (g_String = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_String := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_String;
 end;//g_String = nil
 Result := g_String;
end;
var
 g_k2_attrValue: Integer = -1;

function k2_attrValue: Integer;
begin
 if (g_k2_attrValue = -1) then
  g_k2_attrValue :=  Tk2Attributes.Instance.CheckIDByName('Value');
 Result := g_k2_attrValue;
end;


end.