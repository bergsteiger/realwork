{$IfNDef msmCaptionModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmCaptionModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmCaptionModel" MUID: (57CD32280214)
// Имя типа: "_msmCaptionModel_"

{$Define msmCaptionModel_imp}

 _msmCaptionModel_ = class(TmsmModel, ImsmCaptionModel)
  private
   f_Caption: Il3CString;
  protected
   function Get_Caption: Il3CString;
   procedure Set_Caption(const aValue: Il3CString);
   procedure ClearFields; override;
 end;//_msmCaptionModel_

{$Else msmCaptionModel_imp}

{$IfNDef msmCaptionModel_imp_impl}

{$Define msmCaptionModel_imp_impl}

function _msmCaptionModel_.Get_Caption: Il3CString;
//#UC START# *57B1A47403C5_57CD32280214get_var*
//#UC END# *57B1A47403C5_57CD32280214get_var*
begin
//#UC START# *57B1A47403C5_57CD32280214get_impl*
 Result := f_Caption;
//#UC END# *57B1A47403C5_57CD32280214get_impl*
end;//_msmCaptionModel_.Get_Caption

procedure _msmCaptionModel_.Set_Caption(const aValue: Il3CString);
//#UC START# *57B1A47403C5_57CD32280214set_var*
//#UC END# *57B1A47403C5_57CD32280214set_var*
begin
//#UC START# *57B1A47403C5_57CD32280214set_impl*
 f_Caption := aValue;
 Fire(CaptionChangedEvent.Instance);
//#UC END# *57B1A47403C5_57CD32280214set_impl*
end;//_msmCaptionModel_.Set_Caption

procedure _msmCaptionModel_.ClearFields;
begin
 f_Caption := nil;
 inherited;
end;//_msmCaptionModel_.ClearFields

{$EndIf msmCaptionModel_imp_impl}

{$EndIf msmCaptionModel_imp}

