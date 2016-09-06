{$IfNDef msmListLikeModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmListLikeModel" MUID: (57B57EDB003F)
// Имя типа: "_msmListLikeModel_"

{$Define msmListLikeModel_imp}

 _msmListLikeModel_ = {abstract} class(TmsmModel)
  private
   f_ElementView: TmsmModelElementView;
   f_ElementToAction: ImsmModelElement;
   f_CurrentElement: ImsmModelElement;
  protected
   function Get_ElementToAction: ImsmModelElement;
   procedure Set_ElementToAction(const aValue: ImsmModelElement);
   function Get_CurrentElement: ImsmModelElement;
   procedure Set_CurrentElement(const aValue: ImsmModelElement);
   function Get_Caption: AnsiString;
   procedure ClearFields; override;
 end;//_msmListLikeModel_

{$Else msmListLikeModel_imp}

{$IfNDef msmListLikeModel_imp_impl}

{$Define msmListLikeModel_imp_impl}

function _msmListLikeModel_.Get_ElementToAction: ImsmModelElement;
//#UC START# *57B2B019009C_57B57EDB003Fget_var*
//#UC END# *57B2B019009C_57B57EDB003Fget_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fget_impl*
 Result := f_ElementToAction;
//#UC END# *57B2B019009C_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_ElementToAction

procedure _msmListLikeModel_.Set_ElementToAction(const aValue: ImsmModelElement);
//#UC START# *57B2B019009C_57B57EDB003Fset_var*
//#UC END# *57B2B019009C_57B57EDB003Fset_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fset_impl*
 f_ElementToAction := aValue;
 Fire(ActionElementEvent.Instance);
//#UC END# *57B2B019009C_57B57EDB003Fset_impl*
end;//_msmListLikeModel_.Set_ElementToAction

function _msmListLikeModel_.Get_CurrentElement: ImsmModelElement;
//#UC START# *57B31CF301D2_57B57EDB003Fget_var*
//#UC END# *57B31CF301D2_57B57EDB003Fget_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fget_impl*
 Result := f_CurrentElement;
//#UC END# *57B31CF301D2_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_CurrentElement

procedure _msmListLikeModel_.Set_CurrentElement(const aValue: ImsmModelElement);
//#UC START# *57B31CF301D2_57B57EDB003Fset_var*
//#UC END# *57B31CF301D2_57B57EDB003Fset_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fset_impl*
 f_CurrentElement := aValue;
 Fire(CurrentElementChangedEvent.Instance);
//#UC END# *57B31CF301D2_57B57EDB003Fset_impl*
end;//_msmListLikeModel_.Set_CurrentElement

function _msmListLikeModel_.Get_Caption: AnsiString;
//#UC START# *57B49A8201E1_57B57EDB003Fget_var*
//#UC END# *57B49A8201E1_57B57EDB003Fget_var*
begin
//#UC START# *57B49A8201E1_57B57EDB003Fget_impl*
 Result := f_ElementView.rListName;
 if (Result = 'SelfList') then
  Result := f_ElementView.rTextName;
 if (Result = 'DocumentationNotEmpty') then
  Result := 'Doc';
//#UC END# *57B49A8201E1_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_Caption

procedure _msmListLikeModel_.ClearFields;
begin
 Finalize(f_ElementView);
 f_ElementToAction := nil;
 f_CurrentElement := nil;
 inherited;
end;//_msmListLikeModel_.ClearFields

{$EndIf msmListLikeModel_imp_impl}

{$EndIf msmListLikeModel_imp}

