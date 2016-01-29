{$IfNDef k2ParentedTagObject_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2ParentedTagObject.imp.pas"
// Начат: 08.02.2008 16:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2CoreMixins::k2ParentedTagObject
//
// Тег, имещий ссылку на родителя.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2ParentedTagObject_imp}
 _k2ParentedTagObject_ = {mixin} class(_k2ParentedTagObject_Parent_)
  {* Тег, имещий ссылку на родителя. }
 protected
 // overridden property methods
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   f_Parent : Tl3Variant;
 end;//_k2ParentedTagObject_

{$Else k2ParentedTagObject_imp}

// start class _k2ParentedTagObject_

procedure _k2ParentedTagObject_.Cleanup;
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

{$EndIf k2ParentedTagObject_imp}
