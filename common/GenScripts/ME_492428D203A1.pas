{$IfNDef CurrentChangedListener_imp}

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\CurrentChangedListener.imp.pas"
// —тереотип: "Impurity"

{$Define CurrentChangedListener_imp}

 _CurrentChangedListener_ = class(_CurrentChangedListener_Parent_)
  {* Ўаблон необходим дл€ реализаци€ поведени€ получени€ слушателем
уведомлени€ об изменении текущего в дереве и рассылки такого же
уведомлени€ своим слушател€м. }
  protected
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); virtual;
  public
   procedure Process(const aNode: Il3SimpleNode);
    {* обработать событие }
 end;//_CurrentChangedListener_

{$Else CurrentChangedListener_imp}

{$IfNDef CurrentChangedListener_imp_impl}

{$Define CurrentChangedListener_imp_impl}

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
 {* обработать событие }
//#UC START# *49590D4802EE_492428D203A1_var*
//#UC END# *49590D4802EE_492428D203A1_var*
begin
//#UC START# *49590D4802EE_492428D203A1_impl*
 CurrentChangedNotification(aNode);
//#UC END# *49590D4802EE_492428D203A1_impl*
end;//_CurrentChangedListener_.Process

{$EndIf CurrentChangedListener_imp_impl}

{$EndIf CurrentChangedListener_imp}

