{$IfNDef vcmTabbedContainersListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmTabbedContainersListener.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmTabbedContainersListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmTabbedContainersListener_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmTabbedContainersListener_ = {mixin} class(_vcmTabbedContainersListener_Parent_, Il3TabbedContainersListener)
 protected
 // realized methods
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType); virtual; abstract;
 end;//_vcmTabbedContainersListener_
{$Else}

 _vcmTabbedContainersListener_ = _vcmTabbedContainersListener_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmTabbedContainersListener_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmTabbedContainersListener_

procedure _vcmTabbedContainersListener_.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_53DF40230056_var*
//#UC END# *55321ADE02E9_53DF40230056_var*
begin
//#UC START# *55321ADE02E9_53DF40230056_impl*
 ContainersChanged(aNotification);
//#UC END# *55321ADE02E9_53DF40230056_impl*
end;//_vcmTabbedContainersListener_.NotifyContainersChanged

procedure _vcmTabbedContainersListener_.Cleanup;
//#UC START# *479731C50290_53DF40230056_var*
//#UC END# *479731C50290_53DF40230056_var*
begin
//#UC START# *479731C50290_53DF40230056_impl*
 inherited;
//#UC END# *479731C50290_53DF40230056_impl*
end;//_vcmTabbedContainersListener_.Cleanup

procedure _vcmTabbedContainersListener_.InitFields;
//#UC START# *47A042E100E2_53DF40230056_var*
//#UC END# *47A042E100E2_53DF40230056_var*
begin
//#UC START# *47A042E100E2_53DF40230056_impl*
 inherited;
 TvcmTabbedContainerFormDispatcher.Instance.Subscribe(Self As Il3TabbedContainersListener);
//#UC END# *47A042E100E2_53DF40230056_impl*
end;//_vcmTabbedContainersListener_.InitFields

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmTabbedContainersListener_imp}
