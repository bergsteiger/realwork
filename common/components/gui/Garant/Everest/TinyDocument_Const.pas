unit TinyDocument_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TinyDocument_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TinyDocument
//
// Простой документ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TinyDocument - "Простой документ".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTinyDocument = 83;

function k2_typTinyDocument: TinyDocumentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TinyDocument : TinyDocumentTag = nil;

// start class TinyDocumentTag

function k2_typTinyDocument: TinyDocumentTag;
begin
 if (g_TinyDocument = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TinyDocument := TevNativeSchema(Tk2TypeTable.GetInstance).t_TinyDocument;
 end;//g_TinyDocument = nil
 Result := g_TinyDocument;
end;

end.