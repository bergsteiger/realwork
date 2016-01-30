{$IfNDef nsUserSettingsEditListener_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas"
// Стереотип: "Impurity"

{$Define nsUserSettingsEditListener_imp}

 _nsUserSettingsEditListener_ = class(_nsUserSettingsEditListener_Parent_, InsUserSettingsEditListener)
  {* Слушатель событий редактирования конфигураций }
  protected
   procedure StartSettingsEdit; virtual;
   procedure Cleanup; override;
   procedure InitFields; override;
   procedure StartEdit;
    {* вызывается перед началом редактирования конфигурации }
 end;//_nsUserSettingsEditListener_

{$Else nsUserSettingsEditListener_imp}

{$IfNDef nsUserSettingsEditListener_imp_impl}

{$Define nsUserSettingsEditListener_imp_impl}

procedure _nsUserSettingsEditListener_.StartSettingsEdit;
//#UC START# *4958F46C003B_4958F42B0205_var*
//#UC END# *4958F46C003B_4958F42B0205_var*
begin
//#UC START# *4958F46C003B_4958F42B0205_impl*
 // - ничего не делаем
//#UC END# *4958F46C003B_4958F42B0205_impl*
end;//_nsUserSettingsEditListener_.StartSettingsEdit

procedure _nsUserSettingsEditListener_.Cleanup;
//#UC START# *4958F48202D6_4958F42B0205_var*
var
 l_Settings: InsSettings;
//#UC END# *4958F48202D6_4958F42B0205_var*
begin
//#UC START# *4958F48202D6_4958F42B0205_impl*
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.RemoveListener(InsUserSettingsEditListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
 inherited;
//#UC END# *4958F48202D6_4958F42B0205_impl*
end;//_nsUserSettingsEditListener_.Cleanup

procedure _nsUserSettingsEditListener_.InitFields;
//#UC START# *4958F48F033E_4958F42B0205_var*
var
 l_Settings: InsSettings;
//#UC END# *4958F48F033E_4958F42B0205_var*
begin
//#UC START# *4958F48F033E_4958F42B0205_impl*
 inherited;
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.AddListener(InsUserSettingsEditListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
//#UC END# *4958F48F033E_4958F42B0205_impl*
end;//_nsUserSettingsEditListener_.InitFields

procedure _nsUserSettingsEditListener_.StartEdit;
 {* вызывается перед началом редактирования конфигурации }
//#UC START# *4914443E0326_4958F42B0205_var*
//#UC END# *4914443E0326_4958F42B0205_var*
begin
//#UC START# *4914443E0326_4958F42B0205_impl*
 StartSettingsEdit;
//#UC END# *4914443E0326_4958F42B0205_impl*
end;//_nsUserSettingsEditListener_.StartEdit

{$EndIf nsUserSettingsEditListener_imp_impl}

{$EndIf nsUserSettingsEditListener_imp}

