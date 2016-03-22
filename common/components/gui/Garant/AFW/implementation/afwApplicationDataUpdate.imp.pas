{$IfNDef afwApplicationDataUpdate_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "afwApplicationDataUpdate" MUID: (47EA4BEF0140)
// Имя типа: "_afwApplicationDataUpdate_"

{$Define afwApplicationDataUpdate_imp}

 _afwApplicationDataUpdate_ = class(_afwApplicationDataUpdate_Parent_, IafwApplicationDataListener)
  {* Примесь, реализующая IafwApplicationDataListener. }
  protected
   procedure FinishDataUpdate; virtual;
   procedure UpdateFinished;
    {* Информирует слушателя об окончании обновления данных }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//_afwApplicationDataUpdate_

{$Else afwApplicationDataUpdate_imp}

{$IfNDef afwApplicationDataUpdate_imp_impl}

{$Define afwApplicationDataUpdate_imp_impl}

procedure _afwApplicationDataUpdate_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_47EA4BEF0140_var*
//#UC END# *47EA4E9002C6_47EA4BEF0140_var*
begin
//#UC START# *47EA4E9002C6_47EA4BEF0140_impl*
 // ничего не делаем
//#UC END# *47EA4E9002C6_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.FinishDataUpdate

procedure _afwApplicationDataUpdate_.UpdateFinished;
 {* Информирует слушателя об окончании обновления данных }
//#UC START# *4768DD730235_47EA4BEF0140_var*
//#UC END# *4768DD730235_47EA4BEF0140_var*
begin
//#UC START# *4768DD730235_47EA4BEF0140_impl*
 FinishDataUpdate;
//#UC END# *4768DD730235_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.UpdateFinished

procedure _afwApplicationDataUpdate_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EA4BEF0140_var*
//#UC END# *479731C50290_47EA4BEF0140_var*
begin
//#UC START# *479731C50290_47EA4BEF0140_impl*
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.Cleanup

procedure _afwApplicationDataUpdate_.InitFields;
//#UC START# *47A042E100E2_47EA4BEF0140_var*
//#UC END# *47A042E100E2_47EA4BEF0140_var*
begin
//#UC START# *47A042E100E2_47EA4BEF0140_impl*
 inherited;
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.AddListener(Self);
//#UC END# *47A042E100E2_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.InitFields

{$EndIf afwApplicationDataUpdate_imp_impl}

{$EndIf afwApplicationDataUpdate_imp}

