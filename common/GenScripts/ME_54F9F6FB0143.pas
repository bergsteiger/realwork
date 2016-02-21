unit ContextHistoryInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\ContextHistoryInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 InsContextSearchHistoryNotifier = interface
  ['{25C6AC9C-73FF-42BF-9698-3B5205CC201C}']
  procedure HistoryChanged(const aNewHistory: IvcmStrings);
  procedure ContextSearched;
 end;//InsContextSearchHistoryNotifier

 (*
 MnsContextSearchHistory = interface
  procedure AddNotifier(const aNotifier: InsContextSearchHistoryNotifier);
  function History: IvcmStrings;
  procedure RemoveNotifier(const aNotifier: InsContextSearchHistoryNotifier);
  procedure Searched(const aContext: IvcmStrings);
  procedure Clear;
 end;//MnsContextSearchHistory
 *)

 InsContextSearchHistory = interface
  ['{F8992110-90FB-4A46-A23D-60C7F226D9FE}']
  procedure AddNotifier(const aNotifier: InsContextSearchHistoryNotifier);
  function History: IvcmStrings;
  procedure RemoveNotifier(const aNotifier: InsContextSearchHistoryNotifier);
  procedure Searched(const aContext: IvcmStrings);
  procedure Clear;
 end;//InsContextSearchHistory

 TnsContextHistoryKind = (
  ns_chkDocument
   {* Истрия контекстов для всего кроме Инфарма }
  , ns_chkInpharm
   {* История контекстов для Инфарма }
 );//TnsContextHistoryKind
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
