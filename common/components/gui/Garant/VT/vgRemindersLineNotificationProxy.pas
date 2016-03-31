unit vgRemindersLineNotificationProxy;

// Модуль: "w:\common\components\gui\Garant\VT\vgRemindersLineNotificationProxy.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgRemindersLineNotificationProxy" MUID: (5376118F03C8)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoObject
 , spHelpNotifyManager
;

type
 TvgRemindersLineNotificationProxy = class(Tl3ProtoObject, IspHelpNotifyListener)
  protected
   procedure HelpShown;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Instance: TvgRemindersLineNotificationProxy;
    {* Метод получения экземпляра синглетона TvgRemindersLineNotificationProxy }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvgRemindersLineNotificationProxy
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vgRemindersLineManager
 , SysUtils
 , l3Base
;

var g_TvgRemindersLineNotificationProxy: TvgRemindersLineNotificationProxy = nil;
 {* Экземпляр синглетона TvgRemindersLineNotificationProxy }

procedure TvgRemindersLineNotificationProxyFree;
 {* Метод освобождения экземпляра синглетона TvgRemindersLineNotificationProxy }
begin
 l3Free(g_TvgRemindersLineNotificationProxy);
end;//TvgRemindersLineNotificationProxyFree

procedure TvgRemindersLineNotificationProxy.HelpShown;
//#UC START# *53760DC000EE_5376118F03C8_var*
//#UC END# *53760DC000EE_5376118F03C8_var*
begin
//#UC START# *53760DC000EE_5376118F03C8_impl*
 TvgRemindersLineManager.CheckZOrder;
//#UC END# *53760DC000EE_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.HelpShown

class function TvgRemindersLineNotificationProxy.Instance: TvgRemindersLineNotificationProxy;
 {* Метод получения экземпляра синглетона TvgRemindersLineNotificationProxy }
begin
 if (g_TvgRemindersLineNotificationProxy = nil) then
 begin
  l3System.AddExitProc(TvgRemindersLineNotificationProxyFree);
  g_TvgRemindersLineNotificationProxy := Create;
 end;
 Result := g_TvgRemindersLineNotificationProxy;
end;//TvgRemindersLineNotificationProxy.Instance

class function TvgRemindersLineNotificationProxy.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgRemindersLineNotificationProxy <> nil;
end;//TvgRemindersLineNotificationProxy.Exists

procedure TvgRemindersLineNotificationProxy.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5376118F03C8_var*
//#UC END# *479731C50290_5376118F03C8_var*
begin
//#UC START# *479731C50290_5376118F03C8_impl*
 TspHelpNotifyManager.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.Cleanup

procedure TvgRemindersLineNotificationProxy.InitFields;
//#UC START# *47A042E100E2_5376118F03C8_var*
//#UC END# *47A042E100E2_5376118F03C8_var*
begin
//#UC START# *47A042E100E2_5376118F03C8_impl*
 inherited;
 TspHelpNotifyManager.AddListener(Self);
//#UC END# *47A042E100E2_5376118F03C8_impl*
end;//TvgRemindersLineNotificationProxy.InitFields

initialization
//#UC START# *53763C3A0170*
 TvgRemindersLineNotificationProxy.Instance;
//#UC END# *53763C3A0170*
{$IfEnd} // NOT Defined(NoVGScene)

end.
