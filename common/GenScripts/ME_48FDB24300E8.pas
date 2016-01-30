{$IfNDef nsNodeNotifier_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifier.imp.pas"
// Стереотип: "Impurity"

{$Define nsNodeNotifier_imp}

 _nsNodeNotifierImplementation_Parent_ = _nsNodeNotifier_Parent_;
 {$Include nsNodeNotifierImplementation.imp.pas}
 _nsNodeNotifier_ = class(_nsNodeNotifierImplementation_)
  protected
   procedure Changing;
   procedure Changed;
 end;//_nsNodeNotifier_

{$Else nsNodeNotifier_imp}

{$IfNDef nsNodeNotifier_imp_impl}

{$Define nsNodeNotifier_imp_impl}

{$Include nsNodeNotifierImplementation.imp.pas}

procedure _nsNodeNotifier_.Changing;
//#UC START# *48FDB28502C3_48FDB24300E8_var*
//#UC END# *48FDB28502C3_48FDB24300E8_var*
begin
//#UC START# *48FDB28502C3_48FDB24300E8_impl*
 OldChanging;
//#UC END# *48FDB28502C3_48FDB24300E8_impl*
end;//_nsNodeNotifier_.Changing

procedure _nsNodeNotifier_.Changed;
//#UC START# *48FDB29002D2_48FDB24300E8_var*
//#UC END# *48FDB29002D2_48FDB24300E8_var*
begin
//#UC START# *48FDB29002D2_48FDB24300E8_impl*
 OldChanged;
//#UC END# *48FDB29002D2_48FDB24300E8_impl*
end;//_nsNodeNotifier_.Changed

{$EndIf nsNodeNotifier_imp_impl}

{$EndIf nsNodeNotifier_imp}

