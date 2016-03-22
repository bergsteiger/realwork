{$IfNDef vcmTabbedContainersListener_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmTabbedContainersListener.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "vcmTabbedContainersListener" MUID: (53DF40230056)
// Имя типа: "_vcmTabbedContainersListener_"

{$Define vcmTabbedContainersListener_imp}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 _vcmTabbedContainersListener_ = class(_vcmTabbedContainersListener_Parent_, Il3TabbedContainersListener)
  protected
   procedure ContainersChanged(aNotification: Tl3TabbedContainerNotificationType); virtual; abstract;
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//_vcmTabbedContainersListener_

{$Else NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}

_vcmTabbedContainersListener_ = _vcmTabbedContainersListener_Parent_;

{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
{$Else vcmTabbedContainersListener_imp}

{$IfNDef vcmTabbedContainersListener_imp_impl}

{$Define vcmTabbedContainersListener_imp_impl}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure _vcmTabbedContainersListener_.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_53DF40230056_var*
//#UC END# *55321ADE02E9_53DF40230056_var*
begin
//#UC START# *55321ADE02E9_53DF40230056_impl*
 ContainersChanged(aNotification);
//#UC END# *55321ADE02E9_53DF40230056_impl*
end;//_vcmTabbedContainersListener_.NotifyContainersChanged

procedure _vcmTabbedContainersListener_.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$EndIf vcmTabbedContainersListener_imp_impl}

{$EndIf vcmTabbedContainersListener_imp}

