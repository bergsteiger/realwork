unit PrimMonitorings_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimMonitorings_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimMonitorings" MUID: (4A8ECF3001D2)
// Имя типа: "TPrimMonitoringsModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , MonitoringUnit
 , nsLogEvent
 , l3ProtoObject
 , f1StartupCompletedService
;

type
 TnsOpenNewsLineEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenNewsLineEvent

 Tf1StartupCompletedServiceImpl = {final} class(Tl3ProtoObject, If1StartupCompletedService)
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure StartupComplete;
   class function Instance: Tf1StartupCompletedServiceImpl;
    {* Метод получения экземпляра синглетона Tf1StartupCompletedServiceImpl }
 end;//Tf1StartupCompletedServiceImpl

 TPrimMonitoringsModule = {abstract} class(TvcmModule)
  protected
   procedure OpenNewsLine; overload;
    {* Новостная лента }
   procedure OpenLegislationReview;
    {* Обзор изменений законодательства }
  public
   procedure OpenAutoreferat(const aDoc: IDocument;
    const aContainer: IvcmContainer);
   procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
    const aContainer: IvcmContainer);
   procedure OpenNewsLine(aDenyNewTab: Boolean); overload;
   procedure OpenNewsLinePrim;
 end;//TPrimMonitoringsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , Autoreferat_InternalOperations_Controls
 , nsOpenUtils
 , nsConst
 , afwFacade
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsPostingsTreeSingle
 , PostingOrder_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , sdsAutoreferat
 , deDocInfo
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimNewsLine_Form
 , CommonPost_Module
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , LoggingUnit
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tf1StartupCompletedServiceImpl: Tf1StartupCompletedServiceImpl = nil;
 {* Экземпляр синглетона Tf1StartupCompletedServiceImpl }

const
 {* Варианты выбора для диалога StartupInitPrime }
 str_StartupInitPrime_Choice_Init: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_Init'; rValue : 'Настроить ленту ПРАЙМ');
  {* 'Настроить ленту ПРАЙМ' }
 str_StartupInitPrime_Choice_NoThanks: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_NoThanks'; rValue : 'Начать работу с системой');
  {* 'Начать работу с системой' }
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

procedure Tf1StartupCompletedServiceImplFree;
 {* Метод освобождения экземпляра синглетона Tf1StartupCompletedServiceImpl }
begin
 l3Free(g_Tf1StartupCompletedServiceImpl);
end;//Tf1StartupCompletedServiceImplFree

class procedure TnsOpenNewsLineEvent.Log;
//#UC START# *4B14ED2F033E_4B14ED130233_var*
//#UC END# *4B14ED2F033E_4B14ED130233_var*
begin
//#UC START# *4B14ED2F033E_4B14ED130233_impl*
 GetLogger.AddEvent(LE_OPEN_NEWS_LINE, MakeParamsList);
//#UC END# *4B14ED2F033E_4B14ED130233_impl*
end;//TnsOpenNewsLineEvent.Log

class function Tf1StartupCompletedServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tf1StartupCompletedServiceImpl <> nil;
end;//Tf1StartupCompletedServiceImpl.Exists

procedure Tf1StartupCompletedServiceImpl.StartupComplete;
//#UC START# *2627E933260B_55B0CF2803D7_var*
//#UC END# *2627E933260B_55B0CF2803D7_var*
begin
//#UC START# *2627E933260B_55B0CF2803D7_impl*
 if dmStdRes.NeedAskToFillPrimeAtStartup then
 begin
  dmStdRes.NeedAskToFillPrimeAtStartup := False;
  if vcmAsk(str_StartupInitPrime, []) then
   TPrimMonitoringsModule.OpenNewsLinePrim;
 end;

 if dmStdRes.NeedShowSettingsDialog then
 begin
  dmStdRes.NeedShowSettingsDialog := False;
  vcmAsk(str_DefaultSetttingsWereChanged, []);
 end;
//#UC END# *2627E933260B_55B0CF2803D7_impl*
end;//Tf1StartupCompletedServiceImpl.StartupComplete

class function Tf1StartupCompletedServiceImpl.Instance: Tf1StartupCompletedServiceImpl;
 {* Метод получения экземпляра синглетона Tf1StartupCompletedServiceImpl }
begin
 if (g_Tf1StartupCompletedServiceImpl = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompletedServiceImplFree);
  g_Tf1StartupCompletedServiceImpl := Create;
 end;
 Result := g_Tf1StartupCompletedServiceImpl;
end;//Tf1StartupCompletedServiceImpl.Instance

procedure TPrimMonitoringsModule.OpenAutoreferat(const aDoc: IDocument;
 const aContainer: IvcmContainer);
//#UC START# *4AA4B45E0101_4A8ECF3001D2_var*
//#UC END# *4AA4B45E0101_4A8ECF3001D2_var*
begin
//#UC START# *4AA4B45E0101_4A8ECF3001D2_impl*
 if (aDoc <> nil) then
  Tfs_Autoreferat.Make(TsdsAutoreferat.Make(TdeDocInfo.Make(aDoc)),
                       CheckContainer(aContainer),
                       True,
                       True);
//#UC END# *4AA4B45E0101_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenAutoreferat

procedure TPrimMonitoringsModule.OpenAutoreferatAfterSearch(const aList: IMonitoringList;
 const aContainer: IvcmContainer);
var l_Document: IDocument;
//#UC START# *4AA4C0C500AA_4A8ECF3001D2_var*
//#UC END# *4AA4C0C500AA_4A8ECF3001D2_var*
begin
//#UC START# *4AA4C0C500AA_4A8ECF3001D2_impl*
 aList.GetSummary(l_Document);
 if (l_Document <> nil) then
  Tfs_AutoreferatAfterSearch.Make(TsdsAutoreferat.Make(TdeDocInfo.Make(l_Document)),
                                  CheckContainer(aContainer));
//#UC END# *4AA4C0C500AA_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenAutoreferatAfterSearch

procedure TPrimMonitoringsModule.OpenNewsLine(aDenyNewTab: Boolean);
//#UC START# *4AB76AD20100_4A8ECF3001D2_var*
 l_Container: IvcmContainer;

 l_IsDefined: Boolean;
 l_FillFormAnswer: TModalResult;
 l_IsOnline: Boolean;
 l_HasConnection: Boolean;

 function lp_IsContainerEmpty(const aContainer: IvcmContainer): Boolean;
 begin
  with TvcmTabbedContainerFormDispatcher.Instance do
   Result := IsTabEmpty(GetFormTab(TForm(aContainer.AsForm.VCLWinControl)));
 end;//lp_IsContainerEmpty

 procedure lp_OpenMainMenuIfNeeded;
 var
  l_ContainerForMainMenu: IvcmContainer;
 begin
  l_ContainerForMainMenu := CheckContainer(nil);
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUsetabs and
     lp_IsContainerEmpty(l_ContainerForMainMenu) then
  begin
   try
    dmStdRes.OpenMainMenuIfNeeded(l_ContainerForMainMenu);
    afw.ProcessMessages;
   finally
    l_ContainerForMainMenu := nil;
   end;
  end
 end;

 procedure lp_CreateContainer(aNewTab: Boolean);
 var
  l_IsEmpty: Boolean;
  l_ContainedForm: IvcmContainedForm;
 begin
  l_Container := CheckContainer(nil);
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  begin
   l_IsEmpty := lp_IsContainerEmpty(l_Container);
   if aNewTab and (not l_IsEmpty) then
    l_Container := nsOpenNewWindowTabbed(l_Container, vcm_okInNewTab)
   else
    l_Container := nsOpenNewWindowTabbed(l_Container, vcm_okInCurrentTab);
  end;
 end;
//#UC END# *4AB76AD20100_4A8ECF3001D2_var*
begin
//#UC START# *4AB76AD20100_4A8ECF3001D2_impl*
  l_IsDefined := defDataAdapter.Monitoring.IsNewsLineDefined;
  l_IsOnline := defDataAdapter.PrimeManager.GetHasOnlineAccess;
  l_HasConnection := l_IsOnline and defDataAdapter.PrimeManager.CheckConnectionToOnlineServer;
  if (not l_IsDefined) and l_HasConnection then
  begin
   lp_OpenMainMenuIfNeeded;
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565016076,
   // http://mdp.garant.ru/pages/viewpage.action?pageId=568141568
   l_FillFormAnswer := vcmMessageDlg(str_NewsLineIsNotSetup, [])
  end
  else
   l_FillFormAnswer := -2;

  if l_FillFormAnswer = mrCancel then
   Exit;

  if l_IsOnline and (l_FillFormAnswer = -1) then
  begin
   if l_HasConnection then
   begin
    if not Assigned(TnsPostingsTreeSingle.Instance.MgrSearch) then
    begin
     lp_CreateContainer(False);
     TCommonPostModule.StartOpen(l_Container, False);
    end else
     Op_SearchSupport_ActivatePostingsListForm.Broadcast;
   end else
   begin
    lp_OpenMainMenuIfNeeded;
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=565016076,
    // http://mdp.garant.ru/pages/viewpage.action?pageId=568141568
    if vcmAsk(str_PrimeIsOffline, []) then
     // ничего не делаем
    else
     Application.HelpSystem.ShowHelp('man-nav-prime-questionnaire', '');
   end;
  end else
  begin
   lp_CreateContainer(not aDenyNewTab);
   if (l_Container <> nil) then
   begin
    Result := TenNewsLine.MakeSingleChild(l_Container,
                                vcmCheckAggregate(vcmMakeParams(nil, l_Container)),
                                vcm_ztNavigator);
    op_DateInterval_OpenInt.Call(Result);
    Result.SetActiveAndShowInParent;
   end;
  end;
//#UC END# *4AB76AD20100_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenNewsLine

procedure TPrimMonitoringsModule.OpenNewsLine;
 {* Новостная лента }
//#UC START# *4AB775AA0314_4A8ECF3001D2_var*
//#UC END# *4AB775AA0314_4A8ECF3001D2_var*
begin
//#UC START# *4AB775AA0314_4A8ECF3001D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB775AA0314_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenNewsLine

procedure TPrimMonitoringsModule.OpenLegislationReview;
 {* Обзор изменений законодательства }
//#UC START# *4AB77A0E0276_4A8ECF3001D2_var*
//#UC END# *4AB77A0E0276_4A8ECF3001D2_var*
begin
//#UC START# *4AB77A0E0276_4A8ECF3001D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB77A0E0276_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenLegislationReview

procedure TPrimMonitoringsModule.OpenNewsLinePrim;
//#UC START# *542950E801C0_4A8ECF3001D2_var*
 procedure lp_OpenMainMenuIfNeeded;
 var
  l_ContainerForMainMenu: IvcmContainer;
 begin
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs and
     (not TvcmTabbedContainerFormDispatcher.Instance.HasAnyDockedForms) then
  begin
   l_ContainerForMainMenu := CheckContainer(nil);
   try
    dmStdRes.OpenMainMenuIfNeeded(l_ContainerForMainMenu);
   finally
    l_ContainerForMainMenu := nil;
   end;
  end
 end;

var
 __WasEnter: Boolean;
 l_Cont: IvcmContainer;
 l_Res: IvcmEntityForm;
 l_IsOnline, l_HasConnection: Boolean;
//#UC END# *542950E801C0_4A8ECF3001D2_var*
begin
//#UC START# *542950E801C0_4A8ECF3001D2_impl*
 __WasEnter := vcmEnterFactory;
 try
  l_IsOnline := defDataAdapter.PrimeManager.GetHasOnlineAccess;
  l_HasConnection := l_IsOnline and defDataAdapter.PrimeManager.CheckConnectionToOnlineServer;

  if l_HasConnection then
  begin
   l_Cont := nsOpenNewWindowTabbed(CheckContainer(nil), vcm_okInCurrentTab);
   TCommonPostModule.StartOpen(l_Cont, False);
  end else
  begin
   //lp_OpenMainMenuIfNeeded;
   if vcmAsk(str_PrimeIsOffline, []) then
    // ничего не делаем
   else
    Application.HelpSystem.ShowHelp('man-nav-prime-questionnaire', '');
  end;
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
//#UC END# *542950E801C0_4A8ECF3001D2_impl*
end;//TPrimMonitoringsModule.OpenNewsLinePrim

initialization
 Tf1StartupCompletedService.Instance.Alien := Tf1StartupCompletedServiceImpl.Instance;
 {* Регистрация Tf1StartupCompletedServiceImpl }
 str_StartupInitPrime_Choice_Init.Init;
 {* Инициализация str_StartupInitPrime_Choice_Init }
 str_StartupInitPrime_Choice_NoThanks.Init;
 {* Инициализация str_StartupInitPrime_Choice_NoThanks }
 str_StartupInitPrime.Init;
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_NoThanks);
 str_StartupInitPrime.AddDefaultChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.SetDlgType(mtInformation);
 {* Инициализация str_StartupInitPrime }
 str_DefaultSetttingsWereChanged.Init;
 str_DefaultSetttingsWereChanged.SetDlgType(mtInformation);
 {* Инициализация str_DefaultSetttingsWereChanged }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
