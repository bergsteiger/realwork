{$IfNDef l3ChangingWithLock_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3ChangingWithLock.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3ChangingWithLock" MUID: (54CB3F0F01C0)
// ��� ����: "_l3ChangingWithLock_"

{$Define l3ChangingWithLock_imp}

 _l3ChangingChangedNotifier_Parent_ = _l3ChangingWithLock_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}
 _l3ChangingWithLock_ = class(_l3ChangingChangedNotifier_)
  private
   f_NotificationLockCount: Integer;
   f_NeedFireChanged: Boolean;
   f_CanFireChanging: Boolean;
  protected
   procedure DoChanged; override;
   procedure DoChanging; override;
  public
   procedure LockNotification;
   procedure UnLockNotification;
 end;//_l3ChangingWithLock_

{$Else l3ChangingWithLock_imp}

{$IfNDef l3ChangingWithLock_imp_impl}

{$Define l3ChangingWithLock_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}

procedure _l3ChangingWithLock_.LockNotification;
//#UC START# *54CB3F2A02B0_54CB3F0F01C0_var*
//#UC END# *54CB3F2A02B0_54CB3F0F01C0_var*
begin
//#UC START# *54CB3F2A02B0_54CB3F0F01C0_impl*
 Inc(f_NotificationLockCount);
 If f_NotificationLockCount = 1 then
  f_CanFireChanging := True;
//#UC END# *54CB3F2A02B0_54CB3F0F01C0_impl*
end;//_l3ChangingWithLock_.LockNotification

procedure _l3ChangingWithLock_.UnLockNotification;
//#UC START# *54CB3F3F000F_54CB3F0F01C0_var*
//#UC END# *54CB3F3F000F_54CB3F0F01C0_var*
begin
//#UC START# *54CB3F3F000F_54CB3F0F01C0_impl*
 if f_NotificationLockCount > 0 then
 begin
  Dec(f_NotificationLockCount);
  if (f_NotificationLockCount = 0) and f_NeedFireChanged then
   Changed;
 end;
//#UC END# *54CB3F3F000F_54CB3F0F01C0_impl*
end;//_l3ChangingWithLock_.UnLockNotification

procedure _l3ChangingWithLock_.DoChanged;
//#UC START# *54D9E08D0212_54CB3F0F01C0_var*
//#UC END# *54D9E08D0212_54CB3F0F01C0_var*
begin
//#UC START# *54D9E08D0212_54CB3F0F01C0_impl*
 if f_NotificationLockCount > 0 then
  f_NeedFireChanged := True
 else
 begin
  inherited;
  f_NeedFireChanged := False;
 end;
//#UC END# *54D9E08D0212_54CB3F0F01C0_impl*
end;//_l3ChangingWithLock_.DoChanged

procedure _l3ChangingWithLock_.DoChanging;
//#UC START# *54D9E09D018D_54CB3F0F01C0_var*
//#UC END# *54D9E09D018D_54CB3F0F01C0_var*
begin
//#UC START# *54D9E09D018D_54CB3F0F01C0_impl*
 if f_NotificationLockCount > 0 then
 begin
  if f_CanFireChanging then
  begin
   f_CanFireChanging := False;
   inherited;
  end;
 end
 else
  inherited;
//#UC END# *54D9E09D018D_54CB3F0F01C0_impl*
end;//_l3ChangingWithLock_.DoChanging

{$EndIf l3ChangingWithLock_imp_impl}

{$EndIf l3ChangingWithLock_imp}

