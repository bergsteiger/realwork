{$IfNDef l3FakeImpurity3_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeImpurity3.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3FakeImpurity3" MUID: (MSM9ACC955BEAB7)
// Имя типа: "_l3FakeImpurity3_"

{$Define l3FakeImpurity3_imp}

 _l3FakeImpurity3_ = class(_l3FakeImpurity3_Parent_)
  public
   procedure SomeMethod; virtual;
 end;//_l3FakeImpurity3_

{$Else l3FakeImpurity3_imp}

{$IfNDef l3FakeImpurity3_imp_impl}

{$Define l3FakeImpurity3_imp_impl}

procedure _l3FakeImpurity3_.SomeMethod;
//#UC START# *MSM91B961FAC130_MSM9ACC955BEAB7_var*
//#UC END# *MSM91B961FAC130_MSM9ACC955BEAB7_var*
begin
//#UC START# *MSM91B961FAC130_MSM9ACC955BEAB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM91B961FAC130_MSM9ACC955BEAB7_impl*
end;//_l3FakeImpurity3_.SomeMethod

{$EndIf l3FakeImpurity3_imp_impl}

{$EndIf l3FakeImpurity3_imp}

