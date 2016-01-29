unit vgRemindersLineTabbedContainerNotificationProxy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLineTabbedContainerNotificationProxy.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLineTabbedContainerNotificationProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoObject,
  l3TabbedContainersDispatcher
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgRemindersLineTabbedContainerNotificationProxy = class(Tl3ProtoObject, Il3TabbedContainersListener)
 protected
 // realized methods
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgRemindersLineTabbedContainerNotificationProxy;
    {- возвращает экземпляр синглетона. }
 end;//TvgRemindersLineTabbedContainerNotificationProxy
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base {a},
  vgRemindersLineManager
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


// start class TvgRemindersLineTabbedContainerNotificationProxy

var g_TvgRemindersLineTabbedContainerNotificationProxy : TvgRemindersLineTabbedContainerNotificationProxy = nil;

procedure TvgRemindersLineTabbedContainerNotificationProxyFree;
begin
 l3Free(g_TvgRemindersLineTabbedContainerNotificationProxy);
end;

class function TvgRemindersLineTabbedContainerNotificationProxy.Instance: TvgRemindersLineTabbedContainerNotificationProxy;
begin
 if (g_TvgRemindersLineTabbedContainerNotificationProxy = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineTabbedContainerNotificationProxyFree);
  g_TvgRemindersLineTabbedContainerNotificationProxy := Create;
 end;
 Result := g_TvgRemindersLineTabbedContainerNotificationProxy;
end;


class function TvgRemindersLineTabbedContainerNotificationProxy.Exists: Boolean;
 {-}
begin
 Result := g_TvgRemindersLineTabbedContainerNotificationProxy <> nil;
end;//TvgRemindersLineTabbedContainerNotificationProxy.Exists

procedure TvgRemindersLineTabbedContainerNotificationProxy.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_5417C7F502CD_var*
//#UC END# *55321ADE02E9_5417C7F502CD_var*
begin
//#UC START# *55321ADE02E9_5417C7F502CD_impl*
 case aNotification of
  tcnNewContainerMakingStarted, tcnNewTabOrWindowOpeningStarted:
   TvgRemindersLineManager.LockActivateProcessing;
  tcnNewContainerMakingFinished, tcnNewTabOrWindowOpeningFinished:
   TvgRemindersLineManager.UnlockActivateProcessing
 end;
//#UC END# *55321ADE02E9_5417C7F502CD_impl*
end;//TvgRemindersLineTabbedContainerNotificationProxy.NotifyContainersChanged

procedure TvgRemindersLineTabbedContainerNotificationProxy.Cleanup;
//#UC START# *479731C50290_5417C7F502CD_var*
//#UC END# *479731C50290_5417C7F502CD_var*
begin
//#UC START# *479731C50290_5417C7F502CD_impl*
 {$IfNDef noTabs}
 Tl3TabbedContainersDispatcher.Instance.Unsubscribe(Self);
 {$EndIf  noTabs}
 inherited;
//#UC END# *479731C50290_5417C7F502CD_impl*
end;//TvgRemindersLineTabbedContainerNotificationProxy.Cleanup

procedure TvgRemindersLineTabbedContainerNotificationProxy.InitFields;
//#UC START# *47A042E100E2_5417C7F502CD_var*
//#UC END# *47A042E100E2_5417C7F502CD_var*
begin
//#UC START# *47A042E100E2_5417C7F502CD_impl*
 inherited;
 {$IfNDef noTabs}
 Tl3TabbedContainersDispatcher.Instance.Subscribe(Self);
 {$EndIf  noTabs}
//#UC END# *47A042E100E2_5417C7F502CD_impl*
end;//TvgRemindersLineTabbedContainerNotificationProxy.InitFields

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoVGScene)}
//#UC START# *5417C85D011D*
 //TvgRemindersLineTabbedContainerNotificationProxy.Instance;
//#UC END# *5417C85D011D*
{$IfEnd} //not NoVGScene

end.