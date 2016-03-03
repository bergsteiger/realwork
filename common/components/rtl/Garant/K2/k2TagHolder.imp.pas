{$IfNDef k2TagHolder_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2TagHolder.imp.pas"
// Стереотип: "Impurity"

{$Define k2TagHolder_imp}

 _k2TagHolder_ = class(_k2TagHolder_Parent_)
  private
   f_Redirect: Tl3Variant;
    {* Поле для свойства Redirect }
  protected
   procedure pm_SetRedirect(aValue: Tl3Variant); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  protected
   property Redirect: Tl3Variant
    read f_Redirect
    write pm_SetRedirect;
 end;//_k2TagHolder_

{$Else k2TagHolder_imp}

{$IfNDef k2TagHolder_imp_impl}

{$Define k2TagHolder_imp_impl}

procedure _k2TagHolder_.pm_SetRedirect(aValue: Tl3Variant);
//#UC START# *533ED10E0160_4A573C5F01FFset_var*
//#UC END# *533ED10E0160_4A573C5F01FFset_var*
begin
//#UC START# *533ED10E0160_4A573C5F01FFset_impl*
 aValue.SetRef(f_Redirect);
//#UC END# *533ED10E0160_4A573C5F01FFset_impl*
end;//_k2TagHolder_.pm_SetRedirect

procedure _k2TagHolder_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A573C5F01FF_var*
//#UC END# *479731C50290_4A573C5F01FF_var*
begin
//#UC START# *479731C50290_4A573C5F01FF_impl*
 Redirect := nil;
 inherited;
//#UC END# *479731C50290_4A573C5F01FF_impl*
end;//_k2TagHolder_.Cleanup

{$EndIf k2TagHolder_imp_impl}

{$EndIf k2TagHolder_imp}

