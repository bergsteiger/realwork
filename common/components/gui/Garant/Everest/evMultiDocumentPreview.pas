unit evMultiDocumentPreview;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evMultiDocumentPreview.pas"
// Начат: 02.03.2005 13:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Printing::TevMultiDocumentPreview
//
// Предварительный просмотр нескольких документов пачкой.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  afwMultiDocumentPreview,
  afwInterfaces
  ;

type
 TevMultiDocumentPreview = class(TafwMultiDocumentPreview)
  {* Предварительный просмотр нескольких документов пачкой. }
 protected
 // overridden protected methods
   function GetDocumentName: IafwCString; override;
 end;//TevMultiDocumentPreview

implementation

uses
  nevInterfaces
  ;

// start class TevMultiDocumentPreview

function TevMultiDocumentPreview.GetDocumentName: IafwCString;
//#UC START# *480DE6420179_47FA06400313_var*
//#UC END# *480DE6420179_47FA06400313_var*
begin
//#UC START# *480DE6420179_47FA06400313_impl*
 Result := str_nevpmDocumentList.AsCStr;
//#UC END# *480DE6420179_47FA06400313_impl*
end;//TevMultiDocumentPreview.GetDocumentName

end.