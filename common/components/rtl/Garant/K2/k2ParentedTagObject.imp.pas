{$IfNDef k2ParentedTagObject_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "k2ParentedTagObject" MUID: (47AC58810008)
// Имя типа: "_k2ParentedTagObject_"

{$Define k2ParentedTagObject_imp}

 _k2ParentedTagObject_ = class(_k2ParentedTagObject_Parent_)
  {* Тег, имещий ссылку на родителя. }
  protected
   f_Parent: Tl3Variant;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
 end;//_k2ParentedTagObject_

{$Else k2ParentedTagObject_imp}

{$IfNDef k2ParentedTagObject_imp_impl}

{$Define k2ParentedTagObject_imp_impl}

procedure _k2ParentedTagObject_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47AC58810008_var*
//#UC END# *479731C50290_47AC58810008_var*
begin
//#UC START# *479731C50290_47AC58810008_impl*
 f_Parent := nil;
 inherited;
//#UC END# *479731C50290_47AC58810008_impl*
end;//_k2ParentedTagObject_.Cleanup

function _k2ParentedTagObject_.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_47AC58810008get_var*
//#UC END# *53343980014A_47AC58810008get_var*
begin
//#UC START# *53343980014A_47AC58810008get_impl*
 if (f_Parent = nil) then
  Result := Tk2NullTagImpl.Instance
 else
  Result := f_Parent;
//#UC END# *53343980014A_47AC58810008get_impl*
end;//_k2ParentedTagObject_.pm_GetTagOwner

procedure _k2ParentedTagObject_.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_47AC58810008set_var*
//#UC END# *53343980014A_47AC58810008set_var*
begin
//#UC START# *53343980014A_47AC58810008set_impl*
 f_Parent := aValue.Box;
 inherited;
//#UC END# *53343980014A_47AC58810008set_impl*
end;//_k2ParentedTagObject_.pm_SetTagOwner

{$EndIf k2ParentedTagObject_imp_impl}

{$EndIf k2ParentedTagObject_imp}

