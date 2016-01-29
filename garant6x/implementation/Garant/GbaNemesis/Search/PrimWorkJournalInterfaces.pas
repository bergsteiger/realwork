unit PrimWorkJournalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/PrimWorkJournalInterfaces.pas"
// Начат: 11.03.2011 14:21
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::PrimWorkJournalInterfaces
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
 InsWorkJournalListener = interface(IUnknown)
   ['{730A7894-DD4B-4BB7-95EE-77F4E7C2EE79}']
   procedure JournalShrinked;
 end;//InsWorkJournalListener
{$IfEnd} //not Admin

implementation

end.