unit nsDocumentContextHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsDocumentContextHistory.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsDocumentContextHistoryPrim
 , ContextHistoryInterfaces
;

type
 TnsDocumentContextHistory = class(TnsDocumentContextHistoryPrim)
  public
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsDocumentContextHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsDocumentContextHistory: Pointer = nil;
 {* Экземпляр синглетона TnsDocumentContextHistory }

procedure TnsDocumentContextHistoryFree;
 {* Метод освобождения экземпляра синглетона TnsDocumentContextHistory }
begin
 IUnknown(g_TnsDocumentContextHistory) := nil;
end;//TnsDocumentContextHistoryFree

class function TnsDocumentContextHistory.Make: InsContextSearchHistory;
begin
 if (g_TnsDocumentContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsDocumentContextHistoryFree);
  InsContextSearchHistory(g_TnsDocumentContextHistory) := inherited Make;
 end;
 Result := InsContextSearchHistory(g_TnsDocumentContextHistory);
end;//TnsDocumentContextHistory.Make

class function TnsDocumentContextHistory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsDocumentContextHistory <> nil;
end;//TnsDocumentContextHistory.Exists
{$IfEnd} // NOT Defined(Admin)

end.
