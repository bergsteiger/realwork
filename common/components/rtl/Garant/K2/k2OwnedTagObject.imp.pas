{$IfNDef k2OwnedTagObject_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas"
// Стереотип: "Impurity"

{$Define k2OwnedTagObject_imp}

 _k2OwnedTagObject_ = class(_k2OwnedTagObject_Parent_)
  {* Тег имеющий ссылку на владельца }
  private
   f_Owner: Tl3Variant;
  protected
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
 end;//_k2OwnedTagObject_

{$Else k2OwnedTagObject_imp}

{$IfNDef k2OwnedTagObject_imp_impl}

{$Define k2OwnedTagObject_imp_impl}

procedure _k2OwnedTagObject_.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_47AC6AEE0094_var*
//#UC END# *479F2B3302C1_47AC6AEE0094_var*
begin
//#UC START# *479F2B3302C1_47AC6AEE0094_impl*
 inherited;
 f_Owner := nil;
//#UC END# *479F2B3302C1_47AC6AEE0094_impl*
end;//_k2OwnedTagObject_.BeforeAddToCache

function _k2OwnedTagObject_.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_47AC6AEE0094get_var*
//#UC END# *53343980014A_47AC6AEE0094get_var*
begin
//#UC START# *53343980014A_47AC6AEE0094get_impl*
 Result := inherited pm_GetTagOwner;
 if not Result.IsValid then
 begin
  if (f_Owner = nil) then
   Result := Tk2NullTagImpl.Instance
  else
   Result := f_Owner;
  //Result := k2Tag(f_Owner);
 // - вернул строчку выше - т.к. оказалось, что Owner пока нужен - например для отрисовки
 //   или для возможности достучаться до редактора. Когда полностью перейдем на View,
 //   то это можно будет убрать.
 // - нечего к контейнеру документа стучаться как к тегу
 end;//not Result.IsValid
//#UC END# *53343980014A_47AC6AEE0094get_impl*
end;//_k2OwnedTagObject_.pm_GetTagOwner

procedure _k2OwnedTagObject_.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_47AC6AEE0094set_var*
//#UC END# *53343980014A_47AC6AEE0094set_var*
begin
//#UC START# *53343980014A_47AC6AEE0094set_impl*
 f_Owner := aValue.Box;
 inherited;
//#UC END# *53343980014A_47AC6AEE0094set_impl*
end;//_k2OwnedTagObject_.pm_SetTagOwner

{$EndIf k2OwnedTagObject_imp_impl}

{$EndIf k2OwnedTagObject_imp}

