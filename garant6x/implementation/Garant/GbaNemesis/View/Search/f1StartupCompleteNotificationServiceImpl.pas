unit f1StartupCompleteNotificationServiceImpl;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\f1StartupCompleteNotificationServiceImpl.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "Tf1StartupCompleteNotificationServiceImpl" MUID: (55B0CF2803D7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , f1StartupCompleteNotificationService
 //#UC START# *55B0CF2803D7intf_uses*
 //#UC END# *55B0CF2803D7intf_uses*
;

type
 //#UC START# *55B0CF2803D7ci*
 //#UC END# *55B0CF2803D7ci*
 //#UC START# *55B0CF2803D7cit*
 //#UC END# *55B0CF2803D7cit*
 Tf1StartupCompleteNotificationServiceImpl = {final} class(Tl3ProtoObject, If1StartupCompleteNotificationService)
  private
   f_NeedAskToFillPrimeAtStartup: Boolean;
   f_NeedShowSettingsDialog: Boolean;
  protected
   procedure InitFields; override;
  public
   procedure Notify;
   class function Instance: Tf1StartupCompleteNotificationServiceImpl;
    {* Метод получения экземпляра синглетона Tf1StartupCompleteNotificationServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property NeedAskToFillPrimeAtStartup: Boolean
    read f_NeedAskToFillPrimeAtStartup
    write f_NeedAskToFillPrimeAtStartup;
   property NeedShowSettingsDialog: Boolean
    read f_NeedShowSettingsDialog
    write f_NeedShowSettingsDialog;
 //#UC START# *55B0CF2803D7publ*
 //#UC END# *55B0CF2803D7publ*
 end;//Tf1StartupCompleteNotificationServiceImpl
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , PrimMonitorings_Module
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *55B0CF2803D7impl_uses*
 , StdRes
 , vcmMessagesSupport
 //#UC END# *55B0CF2803D7impl_uses*
;

var g_Tf1StartupCompleteNotificationServiceImpl: Tf1StartupCompleteNotificationServiceImpl = nil;
 {* Экземпляр синглетона Tf1StartupCompleteNotificationServiceImpl }

const
 {* Локализуемые строки Messages For User }
 str_StartupInitPrime: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime'; rValue : 'Уважаемый пользователь!'#13#10 + 
'В новой версии системы ГАРАНТ вы можете самостоятельно настраивать и редактировать индивидуальную новостную ленту ПРАЙМ.' + 
' Потратив несколько минут на настройку, вы всегда будете в курсе последних новостей законодательства, касающихся ваших профессиональных интересов.');
  {* 'Уважаемый пользователь!'#13#10 + 
'В новой версии системы ГАРАНТ вы можете самостоятельно настраивать и редактировать индивидуальную новостную ленту ПРАЙМ.' + 
' Потратив несколько минут на настройку, вы всегда будете в курсе последних новостей законодательства, касающихся ваших профессиональных интересов.' }
 str_DefaultSetttingsWereChanged: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DefaultSetttingsWereChanged'; rValue : 'В новой версии изменена используемая по умолчанию конфигурация пользовательского интерфейса. Новые настройки упрощают работу с системой, организуя ее более удобным образом.'#13#10 + 
'Конфигурация, с которой Вы работали раньше, сохранена. Для обращения к ней выберите в разделе командного меню «Файл» пункт «Выбор конфигурации».');
  {* 'В новой версии изменена используемая по умолчанию конфигурация пользовательского интерфейса. Новые настройки упрощают работу с системой, организуя ее более удобным образом.'#13#10 + 
'Конфигурация, с которой Вы работали раньше, сохранена. Для обращения к ней выберите в разделе командного меню «Файл» пункт «Выбор конфигурации».' }
 {* Варианты выбора для диалога StartupInitPrime }
 str_StartupInitPrime_Choice_Init: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_Init'; rValue : 'Настроить ленту ПРАЙМ');
  {* 'Настроить ленту ПРАЙМ' }
 str_StartupInitPrime_Choice_NoThanks: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_NoThanks'; rValue : 'Начать работу с системой');
  {* 'Начать работу с системой' }

procedure Tf1StartupCompleteNotificationServiceImplFree;
 {* Метод освобождения экземпляра синглетона Tf1StartupCompleteNotificationServiceImpl }
begin
 l3Free(g_Tf1StartupCompleteNotificationServiceImpl);
end;//Tf1StartupCompleteNotificationServiceImplFree

procedure Tf1StartupCompleteNotificationServiceImpl.Notify;
//#UC START# *2627E933260B_55B0CF2803D7_var*
//#UC END# *2627E933260B_55B0CF2803D7_var*
begin
//#UC START# *2627E933260B_55B0CF2803D7_impl*
 if NeedAskToFillPrimeAtStartup then
 begin
  NeedAskToFillPrimeAtStartup := False;
  if vcmAsk(str_StartupInitPrime, []) then
   TPrimMonitoringsModule.OpenNewsLinePrim;
 end;

 if NeedShowSettingsDialog then
 begin
  NeedShowSettingsDialog := False;
  vcmAsk(str_DefaultSetttingsWereChanged, []);
 end;
//#UC END# *2627E933260B_55B0CF2803D7_impl*
end;//Tf1StartupCompleteNotificationServiceImpl.Notify

class function Tf1StartupCompleteNotificationServiceImpl.Instance: Tf1StartupCompleteNotificationServiceImpl;
 {* Метод получения экземпляра синглетона Tf1StartupCompleteNotificationServiceImpl }
begin
 if (g_Tf1StartupCompleteNotificationServiceImpl = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompleteNotificationServiceImplFree);
  g_Tf1StartupCompleteNotificationServiceImpl := Create;
 end;
 Result := g_Tf1StartupCompleteNotificationServiceImpl;
end;//Tf1StartupCompleteNotificationServiceImpl.Instance

class function Tf1StartupCompleteNotificationServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tf1StartupCompleteNotificationServiceImpl <> nil;
end;//Tf1StartupCompleteNotificationServiceImpl.Exists

procedure Tf1StartupCompleteNotificationServiceImpl.InitFields;
//#UC START# *47A042E100E2_55B0CF2803D7_var*
//#UC END# *47A042E100E2_55B0CF2803D7_var*
begin
//#UC START# *47A042E100E2_55B0CF2803D7_impl*
 inherited;
 f_NeedAskToFillPrimeAtStartup := False;
 f_NeedShowSettingsDialog := False;
//#UC END# *47A042E100E2_55B0CF2803D7_impl*
end;//Tf1StartupCompleteNotificationServiceImpl.InitFields

//#UC START# *55B0CF2803D7impl*
//#UC END# *55B0CF2803D7impl*

initialization
 str_StartupInitPrime.Init;
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_NoThanks);
 str_StartupInitPrime.AddDefaultChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.SetDlgType(mtInformation);
 {* Инициализация str_StartupInitPrime }
 str_DefaultSetttingsWereChanged.Init;
 str_DefaultSetttingsWereChanged.SetDlgType(mtInformation);
 {* Инициализация str_DefaultSetttingsWereChanged }
 str_StartupInitPrime_Choice_Init.Init;
 {* Инициализация str_StartupInitPrime_Choice_Init }
 str_StartupInitPrime_Choice_NoThanks.Init;
 {* Инициализация str_StartupInitPrime_Choice_NoThanks }
 Tf1StartupCompleteNotificationService.Instance.Alien := Tf1StartupCompleteNotificationServiceImpl.Instance;
 {* Регистрация Tf1StartupCompleteNotificationServiceImpl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
