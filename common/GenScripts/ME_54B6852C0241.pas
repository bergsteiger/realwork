{$IfNDef l3CriticalSectionHolderPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3CriticalSectionHolderPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3CriticalSectionHolderPrim_imp}

 _l3CriticalSectionHolderPrim_ = class(_l3CriticalSectionHolderPrim_Parent_)
  private
   f_LockCount: Integer;
   f_CS: TCriticalSection;
  private
   procedure CreateCS;
   procedure FreeCS;
  public
   procedure Lock;
   procedure Unlock;
 end;//_l3CriticalSectionHolderPrim_

{$Else l3CriticalSectionHolderPrim_imp}

{$IfNDef l3CriticalSectionHolderPrim_imp_impl}

{$Define l3CriticalSectionHolderPrim_imp_impl}

procedure _l3CriticalSectionHolderPrim_.Lock;
//#UC START# *53A039050219_54B6852C0241_var*
//#UC END# *53A039050219_54B6852C0241_var*
begin
//#UC START# *53A039050219_54B6852C0241_impl*
 Assert(f_CS <> nil);
 f_CS.Enter;
 Inc(f_LockCount);
//#UC END# *53A039050219_54B6852C0241_impl*
end;//_l3CriticalSectionHolderPrim_.Lock

procedure _l3CriticalSectionHolderPrim_.Unlock;
//#UC START# *53A039150130_54B6852C0241_var*
//#UC END# *53A039150130_54B6852C0241_var*
begin
//#UC START# *53A039150130_54B6852C0241_impl*
 Assert(f_CS <> nil);
 Dec(f_LockCount);
 f_CS.Leave;
//#UC END# *53A039150130_54B6852C0241_impl*
end;//_l3CriticalSectionHolderPrim_.Unlock

procedure _l3CriticalSectionHolderPrim_.CreateCS;
//#UC START# *54B6860D01ED_54B6852C0241_var*
//#UC END# *54B6860D01ED_54B6852C0241_var*
begin
//#UC START# *54B6860D01ED_54B6852C0241_impl*
 f_LockCount := 0;
 Assert(f_CS = nil);
 f_CS := TCriticalSection.Create;
//#UC END# *54B6860D01ED_54B6852C0241_impl*
end;//_l3CriticalSectionHolderPrim_.CreateCS

procedure _l3CriticalSectionHolderPrim_.FreeCS;
//#UC START# *54B686270035_54B6852C0241_var*
//#UC END# *54B686270035_54B6852C0241_var*
begin
//#UC START# *54B686270035_54B6852C0241_impl*
 Assert(f_LockCount = 0, 'Похоже, что непарные вызовы критической секции');
 FreeAndNil(f_CS);
//#UC END# *54B686270035_54B6852C0241_impl*
end;//_l3CriticalSectionHolderPrim_.FreeCS

{$EndIf l3CriticalSectionHolderPrim_imp_impl}

{$EndIf l3CriticalSectionHolderPrim_imp}

