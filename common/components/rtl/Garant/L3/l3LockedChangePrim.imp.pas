{$IfNDef l3LockedChangePrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3LockedChangePrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3LockedChangePrim_imp}

 _l3LockedChangePrim_ = class(_l3LockedChangePrim_Parent_)
  private
   f_ChangeCount: Integer;
    {* Поле для свойства ChangeCount }
  protected
   procedure FireChanging; virtual;
   procedure FireChanged; virtual;
   procedure DoChanged; override;
   procedure DoChanging; override;
  public
   function IsChanging: Boolean; virtual;
  protected
   property ChangeCount: Integer
    read f_ChangeCount
    write f_ChangeCount;
 end;//_l3LockedChangePrim_

{$Else l3LockedChangePrim_imp}

{$IfNDef l3LockedChangePrim_imp_impl}

{$Define l3LockedChangePrim_imp_impl}

procedure _l3LockedChangePrim_.FireChanging;
//#UC START# *48FC9D1F016E_48FC9CD002FE_var*
//#UC END# *48FC9D1F016E_48FC9CD002FE_var*
begin
//#UC START# *48FC9D1F016E_48FC9CD002FE_impl*
 inherited DoChanging;
//#UC END# *48FC9D1F016E_48FC9CD002FE_impl*
end;//_l3LockedChangePrim_.FireChanging

procedure _l3LockedChangePrim_.FireChanged;
//#UC START# *48FC9D300237_48FC9CD002FE_var*
//#UC END# *48FC9D300237_48FC9CD002FE_var*
begin
//#UC START# *48FC9D300237_48FC9CD002FE_impl*
 inherited DoChanged;
//#UC END# *48FC9D300237_48FC9CD002FE_impl*
end;//_l3LockedChangePrim_.FireChanged

function _l3LockedChangePrim_.IsChanging: Boolean;
//#UC START# *48FC9D5E0310_48FC9CD002FE_var*
//#UC END# *48FC9D5E0310_48FC9CD002FE_var*
begin
//#UC START# *48FC9D5E0310_48FC9CD002FE_impl*
 Result := (f_ChangeCount > 0);
//#UC END# *48FC9D5E0310_48FC9CD002FE_impl*
end;//_l3LockedChangePrim_.IsChanging

procedure _l3LockedChangePrim_.DoChanged;
//#UC START# *54D9E08D0212_48FC9CD002FE_var*
//#UC END# *54D9E08D0212_48FC9CD002FE_var*
begin
//#UC START# *54D9E08D0212_48FC9CD002FE_impl*
 if (f_ChangeCount <= 0) then //это работает когда в скобках Changing/_Changed на визуалке подменили дерево
  f_ChangeCount := 1;
 Dec(f_ChangeCount);
 if (f_ChangeCount = 0) then
  FireChanged;
//#UC END# *54D9E08D0212_48FC9CD002FE_impl*
end;//_l3LockedChangePrim_.DoChanged

procedure _l3LockedChangePrim_.DoChanging;
//#UC START# *54D9E09D018D_48FC9CD002FE_var*
//#UC END# *54D9E09D018D_48FC9CD002FE_var*
begin
//#UC START# *54D9E09D018D_48FC9CD002FE_impl*
 Inc(f_ChangeCount);
 if (f_ChangeCount = 1) then
  FireChanging;
//#UC END# *54D9E09D018D_48FC9CD002FE_impl*
end;//_l3LockedChangePrim_.DoChanging

{$EndIf l3LockedChangePrim_imp_impl}

{$EndIf l3LockedChangePrim_imp}

