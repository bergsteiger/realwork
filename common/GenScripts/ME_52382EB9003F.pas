{$IfNDef AppConfigTestMixin_imp}

// Модуль: "w:\common\components\rtl\Garant\Daily\AppConfigTestMixin.imp.pas"
// Стереотип: "TestCaseMixIn"

{$Define AppConfigTestMixin_imp}

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
 _AppConfigTestMixin_ = {abstract} class(_AppConfigTestMixin_Parent_)
  protected
   f_Config: TddAppConfigNode;
   f_ConfigStorage: IddConfigStorage;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//_AppConfigTestMixin_

{$Else Defined(nsTest) AND NOT Defined(NoScripts)}

_AppConfigTestMixin_ = _AppConfigTestMixin_Parent_;

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
{$Else AppConfigTestMixin_imp}

{$IfNDef AppConfigTestMixin_imp_impl}

{$Define AppConfigTestMixin_imp_impl}

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
procedure _AppConfigTestMixin_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52382EB9003F_var*
//#UC END# *479731C50290_52382EB9003F_var*
begin
//#UC START# *479731C50290_52382EB9003F_impl*
 FreeAndNil(f_Config);
 f_ConfigStorage := nil;
 inherited;
//#UC END# *479731C50290_52382EB9003F_impl*
end;//_AppConfigTestMixin_.Cleanup
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

{$EndIf AppConfigTestMixin_imp_impl}

{$EndIf AppConfigTestMixin_imp}

