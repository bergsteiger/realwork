unit XMLTag_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/XMLTag_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::XMLTag
//
// XML-тег
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега XMLTag - "XML-тег".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idXMLTag = 123;

function k2_typXMLTag: XMLTagTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_XMLTag : XMLTagTag = nil;

// start class XMLTagTag

function k2_typXMLTag: XMLTagTag;
begin
 if (g_XMLTag = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_XMLTag := TevNativeSchema(Tk2TypeTable.GetInstance).t_XMLTag;
 end;//g_XMLTag = nil
 Result := g_XMLTag;
end;

end.