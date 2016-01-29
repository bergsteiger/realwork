{$IfNDef k2TagHolder_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2TagHolder.imp.pas"
// Начат: 10.07.2009 17:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::K2::k2PrimObjects::k2TagHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define k2TagHolder_imp}
 _k2TagHolder_ = {mixin} class(_k2TagHolder_Parent_)
 private
 // private fields
   f_Redirect : Tl3Variant;
    {* Поле для свойства Redirect}
 protected
 // property methods
   procedure pm_SetRedirect(aValue: Tl3Variant); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected properties
   property Redirect: Tl3Variant
     read f_Redirect
     write pm_SetRedirect;
 end;//_k2TagHolder_

{$Else k2TagHolder_imp}

// start class _k2TagHolder_

procedure _k2TagHolder_.pm_SetRedirect(aValue: Tl3Variant);
//#UC START# *533ED10E0160_4A573C5F01FFset_var*
//#UC END# *533ED10E0160_4A573C5F01FFset_var*
begin
//#UC START# *533ED10E0160_4A573C5F01FFset_impl*
 aValue.SetRef(f_Redirect);
//#UC END# *533ED10E0160_4A573C5F01FFset_impl*
end;//_k2TagHolder_.pm_SetRedirect

procedure _k2TagHolder_.Cleanup;
//#UC START# *479731C50290_4A573C5F01FF_var*
//#UC END# *479731C50290_4A573C5F01FF_var*
begin
//#UC START# *479731C50290_4A573C5F01FF_impl*
 Redirect := nil;
 inherited;
//#UC END# *479731C50290_4A573C5F01FF_impl*
end;//_k2TagHolder_.Cleanup

{$EndIf k2TagHolder_imp}
