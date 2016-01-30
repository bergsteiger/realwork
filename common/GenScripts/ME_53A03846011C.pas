{$IfNDef l3CriticalSectionHolder_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas"
// Стереотип: "Impurity"

{$Define l3CriticalSectionHolder_imp}

 _l3CriticalSectionHolderPrim_Parent_ = _l3CriticalSectionHolder_Parent_;
 {$Include l3CriticalSectionHolderPrim.imp.pas}
 _l3CriticalSectionHolder_ = {abstract} class(_l3CriticalSectionHolderPrim_)
  protected
   procedure AfterDestroyCalled; override;
   procedure InitAfterAlloc; override;
 end;//_l3CriticalSectionHolder_

{$Else l3CriticalSectionHolder_imp}

{$IfNDef l3CriticalSectionHolder_imp_impl}

{$Define l3CriticalSectionHolder_imp_impl}

{$Include l3CriticalSectionHolderPrim.imp.pas}

procedure _l3CriticalSectionHolder_.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_53A03846011C_var*
//#UC END# *52BC2B9401F3_53A03846011C_var*
begin
//#UC START# *52BC2B9401F3_53A03846011C_impl*
 inherited;
 FreeCS;
//#UC END# *52BC2B9401F3_53A03846011C_impl*
end;//_l3CriticalSectionHolder_.AfterDestroyCalled

procedure _l3CriticalSectionHolder_.InitAfterAlloc;
//#UC START# *53AC02B602E3_53A03846011C_var*
//#UC END# *53AC02B602E3_53A03846011C_var*
begin
//#UC START# *53AC02B602E3_53A03846011C_impl*
 CreateCS;
 inherited;
//#UC END# *53AC02B602E3_53A03846011C_impl*
end;//_l3CriticalSectionHolder_.InitAfterAlloc

{$EndIf l3CriticalSectionHolder_imp_impl}

{$EndIf l3CriticalSectionHolder_imp}

