{$IfNDef msmEventFire_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmEventFire.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmEventFire" MUID: (57B6A905031E)
// Имя типа: "_msmEventFire_"

{$Define msmEventFire_imp}

 _msmEventFire_ = {abstract} class(_msmEventFire_Parent_)
  public
   procedure Fire(anEvent: TmsmEvent);
 end;//_msmEventFire_

{$Else msmEventFire_imp}

{$IfNDef msmEventFire_imp_impl}

{$Define msmEventFire_imp_impl}

procedure _msmEventFire_.Fire(anEvent: TmsmEvent);
//#UC START# *57ADE59000CB_57B6A905031E_var*
var
 l_Index : Integer;
//#UC END# *57ADE59000CB_57B6A905031E_var*
begin
//#UC START# *57ADE59000CB_57B6A905031E_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   f_Subscribers.Items[l_Index].Fire(anEvent);
//#UC END# *57ADE59000CB_57B6A905031E_impl*
end;//_msmEventFire_.Fire

{$EndIf msmEventFire_imp_impl}

{$EndIf msmEventFire_imp}

