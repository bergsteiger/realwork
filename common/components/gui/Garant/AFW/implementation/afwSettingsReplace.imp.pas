{$IfNDef afwSettingsReplace_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "afwSettingsReplace" MUID: (47EA8AEF0077)
// Имя типа: "_afwSettingsReplace_"

{$Define afwSettingsReplace_imp}

 _afwSettingsReplace_ = class(_afwSettingsReplace_Parent_, IafwSettingsReplaceListener)
  {* Примесь, реализующая IafwSettingsReplaceListener. }
  protected
   procedure SettingsReplaceStart; virtual;
   procedure SettingsReplaceFinish; virtual;
   procedure Start;
    {* перед заменой настроек. }
   procedure Finish;
    {* после замены настроек. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//_afwSettingsReplace_

{$Else afwSettingsReplace_imp}

{$IfNDef afwSettingsReplace_imp_impl}

{$Define afwSettingsReplace_imp_impl}

procedure _afwSettingsReplace_.SettingsReplaceStart;
//#UC START# *47EA8B8C03CB_47EA8AEF0077_var*
//#UC END# *47EA8B8C03CB_47EA8AEF0077_var*
begin
//#UC START# *47EA8B8C03CB_47EA8AEF0077_impl*
 // ничего не делаем
//#UC END# *47EA8B8C03CB_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.SettingsReplaceStart

procedure _afwSettingsReplace_.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_47EA8AEF0077_var*
//#UC END# *47EA8B9601FE_47EA8AEF0077_var*
begin
//#UC START# *47EA8B9601FE_47EA8AEF0077_impl*
 // ничего не делаем
//#UC END# *47EA8B9601FE_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.SettingsReplaceFinish

procedure _afwSettingsReplace_.Start;
 {* перед заменой настроек. }
//#UC START# *475E8D96021D_47EA8AEF0077_var*
//#UC END# *475E8D96021D_47EA8AEF0077_var*
begin
//#UC START# *475E8D96021D_47EA8AEF0077_impl*
 SettingsReplaceStart;
//#UC END# *475E8D96021D_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.Start

procedure _afwSettingsReplace_.Finish;
 {* после замены настроек. }
//#UC START# *475E8DA60031_47EA8AEF0077_var*
//#UC END# *475E8DA60031_47EA8AEF0077_var*
begin
//#UC START# *475E8DA60031_47EA8AEF0077_impl*
 SettingsReplaceFinish;
//#UC END# *475E8DA60031_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.Finish

procedure _afwSettingsReplace_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EA8AEF0077_var*
//#UC END# *479731C50290_47EA8AEF0077_var*
begin
//#UC START# *479731C50290_47EA8AEF0077_impl*
 if TafwSettingsChangePublisher.Exists then
   TafwSettingsChangePublisher.Instance.RemoveListener(IafwSettingsReplaceListener(Self));
 inherited;
//#UC END# *479731C50290_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.Cleanup

procedure _afwSettingsReplace_.InitFields;
//#UC START# *47A042E100E2_47EA8AEF0077_var*
//#UC END# *47A042E100E2_47EA8AEF0077_var*
begin
//#UC START# *47A042E100E2_47EA8AEF0077_impl*
 inherited;
 TafwSettingsChangePublisher.Instance.AddListener(IafwSettingsReplaceListener(Self));
//#UC END# *47A042E100E2_47EA8AEF0077_impl*
end;//_afwSettingsReplace_.InitFields

{$EndIf afwSettingsReplace_imp_impl}

{$EndIf afwSettingsReplace_imp}

