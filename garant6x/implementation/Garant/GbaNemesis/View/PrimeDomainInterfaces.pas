unit PrimeDomainInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$Strange"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimeDomainInterfaces.pas"
// Начат: 21.10.2009 21:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::View$Strange::PrimeDomainInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimeUnit
  ;

type
 InsPrimeNode = interface(IUnknown)
  {* Узел дерева новостных лент }
   ['{E5BF71FF-A857-40FD-A325-7B8F18DEEA50}']
   function pm_GetData: IPrime;
   property Data: IPrime
     read pm_GetData;
 end;//InsPrimeNode
{$IfEnd} //not Admin

implementation

end.