unit nsInpharmContextHistory;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\nsInpharmContextHistory.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsInpharmContextHistoryPrim
 , ContextHistoryInterfaces
;

type
 TnsInpharmContextHistory = class(TnsInpharmContextHistoryPrim)
  public
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsInpharmContextHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsInpharmContextHistory: Pointer = nil;
 {* Экземпляр синглетона TnsInpharmContextHistory }

procedure TnsInpharmContextHistoryFree;
 {* Метод освобождения экземпляра синглетона TnsInpharmContextHistory }
begin
 IUnknown(g_TnsInpharmContextHistory) := nil;
end;//TnsInpharmContextHistoryFree

class function TnsInpharmContextHistory.Make: InsContextSearchHistory;
begin
 if (g_TnsInpharmContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsInpharmContextHistoryFree);
  InsContextSearchHistory(g_TnsInpharmContextHistory) := inherited Make;
 end;
 Result := InsContextSearchHistory(g_TnsInpharmContextHistory);
end;//TnsInpharmContextHistory.Make

class function TnsInpharmContextHistory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsInpharmContextHistory <> nil;
end;//TnsInpharmContextHistory.Exists
{$IfEnd} // NOT Defined(Admin)

end.
