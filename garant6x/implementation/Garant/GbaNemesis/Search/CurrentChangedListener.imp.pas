{$IfNDef CurrentChangedListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/CurrentChangedListener.imp.pas"
// Начат: 2008/01/30 08:25:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::SearchLite::Search::Search::CurrentChangedListener
//
// Шаблон необходим для реализация поведения получения слушателем
// уведомления об изменении текущего в дереве и рассылки такого же
// уведомления своим слушателям.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define CurrentChangedListener_imp}
 _CurrentChangedListener_ = {mixin} class(_CurrentChangedListener_Parent_)
  {* Шаблон необходим для реализация поведения получения слушателем
уведомления об изменении текущего в дереве и рассылки такого же
уведомления своим слушателям. }
 public
 // realized methods
   procedure Process(const aNode: Il3SimpleNode);
     {* обработать событие }
 protected
 // protected methods
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); virtual;
 end;//_CurrentChangedListener_

{$Else CurrentChangedListener_imp}

// start class _CurrentChangedListener_

procedure _CurrentChangedListener_.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *49242A4E0252_492428D203A1_var*
var
 l_Index    : Integer;
 l_Listener : IbsCurrentChangedListener;
 l_Item     : IUnknown;
//#UC END# *49242A4E0252_492428D203A1_var*
begin
//#UC START# *49242A4E0252_492428D203A1_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsCurrentChangedListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.Process(aNode);
  end;//if (NotifiedObjList <> nil)
//#UC END# *49242A4E0252_492428D203A1_impl*
end;//_CurrentChangedListener_.CurrentChangedNotification

procedure _CurrentChangedListener_.Process(const aNode: Il3SimpleNode);
//#UC START# *49590D4802EE_492428D203A1_var*
//#UC END# *49590D4802EE_492428D203A1_var*
begin
//#UC START# *49590D4802EE_492428D203A1_impl*
 CurrentChangedNotification(aNode);
//#UC END# *49590D4802EE_492428D203A1_impl*
end;//_CurrentChangedListener_.Process

{$EndIf CurrentChangedListener_imp}
