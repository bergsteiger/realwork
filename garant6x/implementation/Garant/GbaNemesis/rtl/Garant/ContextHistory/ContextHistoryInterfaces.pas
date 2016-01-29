unit ContextHistoryInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ContextHistory"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/rtl/Garant/ContextHistory/ContextHistoryInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Common For Shell And Monitoring::Search::ContextHistory::ContextHistoryInterfaces
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;

type
 InsContextSearchHistoryNotifier = interface(IUnknown)
   ['{25C6AC9C-73FF-42BF-9698-3B5205CC201C}']
   procedure HistoryChanged(const aNewHistory: IvcmStrings);
   procedure ContextSearched;
 end;//InsContextSearchHistoryNotifier

(*
 MnsContextSearchHistory = PureMixIn
   procedure AddNotifier(const aNotifier: InsContextSearchHistoryNotifier);
   function History: IvcmStrings;
   procedure RemoveNotifier(const aNotifier: InsContextSearchHistoryNotifier);
   procedure Searched(const aContext: IvcmStrings);
   procedure Clear;
 end;//MnsContextSearchHistory
*)

 InsContextSearchHistory = interface(IUnknown)
   ['{F8992110-90FB-4A46-A23D-60C7F226D9FE}']
  // MnsContextSearchHistory
   procedure AddNotifier(const aNotifier: InsContextSearchHistoryNotifier);
   function History: IvcmStrings;
   procedure RemoveNotifier(const aNotifier: InsContextSearchHistoryNotifier);
   procedure Searched(const aContext: IvcmStrings);
   procedure Clear;
 end;//InsContextSearchHistory

 TnsContextHistoryKind = (
   ns_chkDocument // Истрия контекстов для всего кроме Инфарма
 , ns_chkInpharm // История контекстов для Инфарма
 );//TnsContextHistoryKind
{$IfEnd} //not Admin

implementation

end.