unit vgRemindersLineTabbedContainerNotificationProxy;

// ������: "w:\common\components\gui\Garant\VT\vgRemindersLineTabbedContainerNotificationProxy.pas"
// ���������: "SimpleClass"
// ������� ������: "TvgRemindersLineTabbedContainerNotificationProxy" MUID: (5417C7F502CD)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3TabbedContainersDispatcher
;

type
 TvgRemindersLineTabbedContainerNotificationProxy = class(Tl3ProtoObject, Il3TabbedContainersListener)
  protected
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TvgRemindersLineTabbedContainerNotificationProxy;
    {* ����� ��������� ���������� ���������� TvgRemindersLineTabbedContainerNotificationProxy }
 end;//TvgRemindersLineTabbedContainerNotificationProxy
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vgRemindersLineManager
 , SysUtils
 , l3Base
;

var g_TvgRemindersLineTabbedContainerNotificationProxy: TvgRemindersLineTabbedContainerNotificationProxy = nil;
 {* ��������� ���������� TvgRemindersLineTabbedContainerNotificationProxy }

procedure TvgRemindersLineTabbedContainerNotificationProxyFree;
 {* ����� ������������ ���������� ���������� TvgRemindersLineTabbedContainerNotificationProxy }
begin
 l3Free(g_TvgRemindersLineTabbedContainerNotificationProxy);
end;//TvgRemindersLineTabbedContainerNotificationProxyFree

class function TvgRemindersLineTabbedContainerNotificationProxy.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
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

class function TvgRemindersLineTabbedContainerNotificationProxy.Instance: TvgRemindersLineTabbedContainerNotificationProxy;
 {* ����� ��������� ���������� ���������� TvgRemindersLineTabbedContainerNotificationProxy }
begin
 if (g_TvgRemindersLineTabbedContainerNotificationProxy = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineTabbedContainerNotificationProxyFree);
  g_TvgRemindersLineTabbedContainerNotificationProxy := Create;
 end;
 Result := g_TvgRemindersLineTabbedContainerNotificationProxy;
end;//TvgRemindersLineTabbedContainerNotificationProxy.Instance

procedure TvgRemindersLineTabbedContainerNotificationProxy.Cleanup;
 {* ������� ������� ����� �������. }
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

initialization
//#UC START# *5417C85D011D*
 //TvgRemindersLineTabbedContainerNotificationProxy.Instance;
//#UC END# *5417C85D011D*
{$IfEnd} // NOT Defined(NoVGScene)

end.
