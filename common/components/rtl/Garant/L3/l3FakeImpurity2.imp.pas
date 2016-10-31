{$IfNDef l3FakeImpurity2_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeImpurity2.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3FakeImpurity2" MUID: (MSM0E95DD9CA1DF)
// Имя типа: "_l3FakeImpurity2_"

{$Define l3FakeImpurity2_imp}

 _l3FakeImpurity2_ = class(_l3FakeImpurity2_Parent_)
  public
   procedure SomeMethod; virtual;
 end;//_l3FakeImpurity2_

{$Else l3FakeImpurity2_imp}

{$IfNDef l3FakeImpurity2_imp_impl}

{$Define l3FakeImpurity2_imp_impl}

procedure _l3FakeImpurity2_.SomeMethod;
//#UC START# *MSMF73AC06C053A_MSM0E95DD9CA1DF_var*
//#UC END# *MSMF73AC06C053A_MSM0E95DD9CA1DF_var*
begin
//#UC START# *MSMF73AC06C053A_MSM0E95DD9CA1DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *MSMF73AC06C053A_MSM0E95DD9CA1DF_impl*
end;//_l3FakeImpurity2_.SomeMethod

{$EndIf l3FakeImpurity2_imp_impl}

{$EndIf l3FakeImpurity2_imp}

