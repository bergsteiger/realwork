{$IfNDef nsUserSettingsListener_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsUserSettingsListener" MUID: (4958BD880163)
// Имя типа: "_nsUserSettingsListener_"

{$Define nsUserSettingsListener_imp}

 _nsUserSettingsListener_ = class(_nsUserSettingsListener_Parent_, InsUserSettingsListener)
  {* Слушатель изменения настроек пользователя }
  protected
   procedure UserSettingsChanged; virtual;
    {* Изменились настройки пользователя }
   procedure Cleanup; override;
   procedure InitFields; override;
   procedure Changed;
    {* вызывается после изменения\восстановления настроек }
 end;//_nsUserSettingsListener_

{$Else nsUserSettingsListener_imp}

{$IfNDef nsUserSettingsListener_imp_impl}

{$Define nsUserSettingsListener_imp_impl}

procedure _nsUserSettingsListener_.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_4958BD880163_var*
//#UC END# *4958BE910345_4958BD880163_var*
begin
//#UC START# *4958BE910345_4958BD880163_impl*
 // - ничего не делаем
//#UC END# *4958BE910345_4958BD880163_impl*
end;//_nsUserSettingsListener_.UserSettingsChanged

procedure _nsUserSettingsListener_.Cleanup;
//#UC START# *4958BF0203C3_4958BD880163_var*
var
 l_Settings: InsSettings;
//#UC END# *4958BF0203C3_4958BD880163_var*
begin
//#UC START# *4958BF0203C3_4958BD880163_impl*
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.RemoveListener(InsUserSettingsListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
 inherited;
//#UC END# *4958BF0203C3_4958BD880163_impl*
end;//_nsUserSettingsListener_.Cleanup

procedure _nsUserSettingsListener_.InitFields;
//#UC START# *4958BF2302DF_4958BD880163_var*
var
 l_Settings: InsSettings;
//#UC END# *4958BF2302DF_4958BD880163_var*
begin
//#UC START# *4958BF2302DF_4958BD880163_impl*
 inherited;
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.AddListener(InsUserSettingsListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
//#UC END# *4958BF2302DF_4958BD880163_impl*
end;//_nsUserSettingsListener_.InitFields

procedure _nsUserSettingsListener_.Changed;
 {* вызывается после изменения\восстановления настроек }
//#UC START# *491443FE01BE_4958BD880163_var*
//#UC END# *491443FE01BE_4958BD880163_var*
begin
//#UC START# *491443FE01BE_4958BD880163_impl*
 UserSettingsChanged;
//#UC END# *491443FE01BE_4958BD880163_impl*
end;//_nsUserSettingsListener_.Changed

{$EndIf nsUserSettingsListener_imp_impl}

{$EndIf nsUserSettingsListener_imp}

