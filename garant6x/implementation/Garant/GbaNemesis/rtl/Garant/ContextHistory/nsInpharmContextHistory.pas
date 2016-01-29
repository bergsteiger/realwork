unit nsInpharmContextHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ContextHistory"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/rtl/Garant/ContextHistory/nsInpharmContextHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::ContextHistory::ContextHistory::TnsInpharmContextHistory
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
  nsInpharmContextHistoryPrim,
  ContextHistoryInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsInpharmContextHistory = class(TnsInpharmContextHistoryPrim)
 public
 // public methods
   class function Make: InsContextSearchHistory; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsInpharmContextHistory
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsInpharmContextHistory

var g_TnsInpharmContextHistory : Pointer = nil;

procedure TnsInpharmContextHistoryFree;
begin
 IUnknown(g_TnsInpharmContextHistory) := nil;
end;


class function TnsInpharmContextHistory.Make: InsContextSearchHistory;
begin
 if (g_TnsInpharmContextHistory = nil) then
 begin
  l3System.AddExitProc(TnsInpharmContextHistoryFree);
  InsContextSearchHistory(g_TnsInpharmContextHistory) := inherited Make;
 end;
 Result := InsContextSearchHistory(g_TnsInpharmContextHistory);
end;

class function TnsInpharmContextHistory.Exists: Boolean;
 {-}
begin
 Result := g_TnsInpharmContextHistory <> nil;
end;//TnsInpharmContextHistory.Exists

{$IfEnd} //not Admin

end.