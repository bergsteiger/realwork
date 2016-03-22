{$IfNDef afwSettingChanged_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "afwSettingChanged" MUID: (47EA85E7005B)
// Имя типа: "_afwSettingChanged_"

{$Define afwSettingChanged_imp}

 _afwSettingChanged_ = class(_afwSettingChanged_Parent_, IafwSettingListener)
  {* Примесь, реализующая IafwSettingListener. }
  protected
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; virtual;
    {* Обработчик изменения указанной настройки }
   function SettingChanged(const aSettingId: TafwSettingId): Boolean;
    {* настройки изменились. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//_afwSettingChanged_

{$Else afwSettingChanged_imp}

{$IfNDef afwSettingChanged_imp_impl}

{$Define afwSettingChanged_imp_impl}

function _afwSettingChanged_.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_47EA85E7005B_var*
//#UC END# *47EA863A035C_47EA85E7005B_var*
begin
//#UC START# *47EA863A035C_47EA85E7005B_impl*
 Result := False;
//#UC END# *47EA863A035C_47EA85E7005B_impl*
end;//_afwSettingChanged_.DoSettingChanged

function _afwSettingChanged_.SettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* настройки изменились. }
//#UC START# *475E8C33036C_47EA85E7005B_var*
//#UC END# *475E8C33036C_47EA85E7005B_var*
begin
//#UC START# *475E8C33036C_47EA85E7005B_impl*
 Result := DoSettingChanged(aSettingId);
//#UC END# *475E8C33036C_47EA85E7005B_impl*
end;//_afwSettingChanged_.SettingChanged

procedure _afwSettingChanged_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EA85E7005B_var*
//#UC END# *479731C50290_47EA85E7005B_var*
begin
//#UC START# *479731C50290_47EA85E7005B_impl*
 if TafwSettingsChangePublisher.Exists then
  TafwSettingsChangePublisher.Instance.RemoveListener(IafwSettingListener(Self));
 inherited;
//#UC END# *479731C50290_47EA85E7005B_impl*
end;//_afwSettingChanged_.Cleanup

procedure _afwSettingChanged_.InitFields;
//#UC START# *47A042E100E2_47EA85E7005B_var*
//#UC END# *47A042E100E2_47EA85E7005B_var*
begin
//#UC START# *47A042E100E2_47EA85E7005B_impl*
 inherited;
 TafwSettingsChangePublisher.Instance.AddListener(IafwSettingListener(Self));
//#UC END# *47A042E100E2_47EA85E7005B_impl*
end;//_afwSettingChanged_.InitFields

{$EndIf afwSettingChanged_imp_impl}

{$EndIf afwSettingChanged_imp}

