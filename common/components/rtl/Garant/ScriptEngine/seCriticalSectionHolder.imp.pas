{$IfNDef seCriticalSectionHolder_imp}

// ������: "w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas"
// ���������: "Impurity"
// ������� ������: "seCriticalSectionHolder" MUID: (57C5572B036F)
// ��� ����: "_seCriticalSectionHolder_"

{$Define seCriticalSectionHolder_imp}

 _seCriticalSectionHolderPrim_Parent_ = _seCriticalSectionHolder_Parent_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolderPrim.imp.pas}
 _seCriticalSectionHolder_ = class(_seCriticalSectionHolderPrim_)
  public
   procedure Lock;
   procedure Unlock;
 end;//_seCriticalSectionHolder_

{$Else seCriticalSectionHolder_imp}

{$IfNDef seCriticalSectionHolder_imp_impl}

{$Define seCriticalSectionHolder_imp_impl}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolderPrim.imp.pas}

procedure _seCriticalSectionHolder_.Lock;
//#UC START# *57C5574D0227_57C5572B036F_var*
//#UC END# *57C5574D0227_57C5572B036F_var*
begin
//#UC START# *57C5574D0227_57C5572B036F_impl*
 {$IfDef seThreadSafe}
 inherited Lock;
 {$EndIf seThreadSafe}
//#UC END# *57C5574D0227_57C5572B036F_impl*
end;//_seCriticalSectionHolder_.Lock

procedure _seCriticalSectionHolder_.Unlock;
//#UC START# *57C5575903E6_57C5572B036F_var*
//#UC END# *57C5575903E6_57C5572B036F_var*
begin
//#UC START# *57C5575903E6_57C5572B036F_impl*
 {$IfDef seThreadSafe}
 inherited Unlock;
 {$EndIf seThreadSafe}
//#UC END# *57C5575903E6_57C5572B036F_impl*
end;//_seCriticalSectionHolder_.Unlock

{$EndIf seCriticalSectionHolder_imp_impl}

{$EndIf seCriticalSectionHolder_imp}

