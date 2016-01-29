{$IfNDef AppConfigTestMixin_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/AppConfigTestMixin.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCaseMixIn::Class>> Shared Delphi Tests::DailyTest::AppConfig::AppConfigTestMixin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define AppConfigTestMixin_imp}
{$If defined(nsTest) AND not defined(NoScripts)}
 _AppConfigTestMixin_ = {abstract} class(_AppConfigTestMixin_Parent_)
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   f_Config : TddAppConfigNode;
   f_ConfigStorage : IddConfigStorage;
 end;//_AppConfigTestMixin_
{$Else}

 _AppConfigTestMixin_ = _AppConfigTestMixin_Parent_;

{$IfEnd} //nsTest AND not NoScripts

{$Else AppConfigTestMixin_imp}

{$If defined(nsTest) AND not defined(NoScripts)}

// start class _AppConfigTestMixin_

procedure _AppConfigTestMixin_.Cleanup;
//#UC START# *479731C50290_52382EB9003F_var*
//#UC END# *479731C50290_52382EB9003F_var*
begin
//#UC START# *479731C50290_52382EB9003F_impl*
 FreeAndNil(f_Config);
 f_ConfigStorage := nil;
 inherited;
//#UC END# *479731C50290_52382EB9003F_impl*
end;//_AppConfigTestMixin_.Cleanup

{$IfEnd} //nsTest AND not NoScripts

{$EndIf AppConfigTestMixin_imp}
