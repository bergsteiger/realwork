unit DocumentQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/DocumentQuery_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::DocumentQuery
//
// Запрос для поиска документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DocumentQuery - "Запрос для поиска документа".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDocumentQuery = 138;

function k2_typDocumentQuery: DocumentQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocumentQuery : DocumentQueryTag = nil;

// start class DocumentQueryTag

function k2_typDocumentQuery: DocumentQueryTag;
begin
 if (g_DocumentQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DocumentQuery := TevNativeSchema(Tk2TypeTable.GetInstance).t_DocumentQuery;
 end;//g_DocumentQuery = nil
 Result := g_DocumentQuery;
end;

end.