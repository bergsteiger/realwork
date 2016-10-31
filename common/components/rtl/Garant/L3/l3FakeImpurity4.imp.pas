{$IfNDef l3FakeImpurity4_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeImpurity4.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3FakeImpurity4" MUID: (MSM9730EE61DD77)
// Имя типа: "_l3FakeImpurity4_"

{$Define l3FakeImpurity4_imp}

 _l3FakeImpurity4_ = class(_l3FakeImpurity4_Parent_)
  public
   procedure SomeMethod; virtual;
 end;//_l3FakeImpurity4_

{$Else l3FakeImpurity4_imp}

{$IfNDef l3FakeImpurity4_imp_impl}

{$Define l3FakeImpurity4_imp_impl}

procedure _l3FakeImpurity4_.SomeMethod;
//#UC START# *MSM4686C820A833_MSM9730EE61DD77_var*
//#UC END# *MSM4686C820A833_MSM9730EE61DD77_var*
begin
//#UC START# *MSM4686C820A833_MSM9730EE61DD77_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSM4686C820A833_MSM9730EE61DD77_impl*
end;//_l3FakeImpurity4_.SomeMethod

{$EndIf l3FakeImpurity4_imp_impl}

{$EndIf l3FakeImpurity4_imp}

