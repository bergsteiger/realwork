unit attribute_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "attribute_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: Tag::Class Shared Delphi Sand Box::SandBox::Meta::Meta::attribute
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега attribute .
{$Include ..\SandBox\sbDefine.inc}

interface

uses
  k2Base {a},
  Meta_Schema
  ;

function k2_typattribute: attributeTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_attribute : attributeTag = nil;

// start class attributeTag

function k2_typattribute: attributeTag;
begin
 if (g_attribute = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TMetaSchema);
  g_attribute := TMetaSchema(Tk2TypeTable.GetInstance).t_attribute;
 end;//g_attribute = nil
 Result := g_attribute;
end;

end.