unit PrimBaseSearchInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/PrimBaseSearchInterfaces.pas"
// Начат: 11.03.2011 14:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::PrimBaseSearchInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
type
 InsBaseSearchResultProcessor = interface(IUnknown)
   ['{C3264FA1-C168-4D5E-94B7-3D7DE897A780}']
   procedure SearchResultEmpty(TryFullList: Boolean);
   procedure SearchResultExists;
   procedure AnotherSearchSuccessed;
   procedure AnotherSearchCancelled;
 end;//InsBaseSearchResultProcessor
{$IfEnd} //not Admin

implementation

end.