unit PrimMonitorings_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/PrimMonitorings_Module.pas"
// Начат: 21.08.2009 20:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimMonitorings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  MonitoringUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  AutoreferatInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  NewsLine_Form,
  DocumentUserTypes_dftAutoreferatAfterSearch_UserType,
  DocumentUserTypes_dftAutoreferat_UserType,
  nsLogEvent,
  l3StringIDEx,
  PrimNewsLine_nltMain_UserType,
  Common_FormDefinitions_Controls,
  PrimNewsLineOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewForNewsLine,
  f1StartupCompletedService
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  fsAutoreferat,
  fsAutoreferatAfterSearch
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  NewsLineKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsOpenNewsLineEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log;
 end;//TnsOpenNewsLineEvent

 Tf1StartupCompletedServiceImpl = {final} class(Tl3ProtoObject, If1StartupCompletedService)
 public
 // realized methods
   procedure StartupComplete;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tf1StartupCompletedServiceImpl;
    {- возвращает экземпляр синглетона. }
 end;//Tf1StartupCompletedServiceImpl

 TPrimMonitoringsModule = {abstract formspack} class(TvcmModule)
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenNewsLineTest(const aParams: IvcmTestParamsPrim);
     {* Новостная лента }
   procedure opOpenNewsLine(const aParams: IvcmExecuteParamsPrim);
     {* Новостная лента }
   procedure opOpenLegislationReviewTest(const aParams: IvcmTestParamsPrim);
     {* Обзор изменений законодательства }
   procedure opOpenLegislationReview(const aParams: IvcmExecuteParamsPrim);
     {* Обзор изменений законодательства }
 public
 // public methods
   class procedure OpenAutoreferat(const aDoc: IDocument;
     const aContainer: IvcmContainer);
     {* Открывает автореферат }
   class procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
     const aContainer: IvcmContainer);
   class function OpenNewsLine: IvcmEntityForm;
   class procedure OpenNewsLinePrim;
     {* Сигнатура метода OpenNewsLinePrim }
 end;//TPrimMonitoringsModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  SysUtils,
  sdsAutoreferat,
  deDocInfo,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  PrimNewsLine_Form,
  CommonPost_Module
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  Autoreferat_InternalOperations_Controls,
  nsOpenUtils,
  nsConst,
  afwFacade
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  nsPostingsTreeSingle,
  PostingOrder_Strange_Controls
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Monitorings_opOpenNewsLine
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Monitorings_opOpenLegislationReview
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  StdRes {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Варианты выбора для диалога StartupInitPrime }
  str_StartupInitPrime_Choice_Init : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_Init'; rValue : 'Настроить ленту ПРАЙМ');
   { 'Настроить ленту ПРАЙМ' }
  str_StartupInitPrime_Choice_NoThanks : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime_Choice_NoThanks'; rValue : 'Начать работу с системой');
   { 'Начать работу с системой' }

var
   { Локализуемые строки Messages For User }
  str_StartupInitPrime : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'StartupInitPrime'; rValue : 'Уважаемый пользователь!'#13#10 + 
'В новой версии системы ГАРАНТ вы можете самостоятельно настраивать и редактировать индивидуальную новостную ленту ПРАЙМ.' + 
' Потратив несколько минут на настройку, вы всегда будете в курсе последних новостей законодательства, касающихся ваших профессиональных интересов.');
   { 'Уважаемый пользователь!'#13#10 + 
'В новой версии системы ГАРАНТ вы можете самостоятельно настраивать и редактировать индивидуальную новостную ленту ПРАЙМ.' + 
' Потратив несколько минут на настройку, вы всегда будете в курсе последних новостей законодательства, касающихся ваших профессиональных интересов.' }
  str_DefaultSetttingsWereChanged : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DefaultSetttingsWereChanged'; rValue : 'В новой версии изменена используемая по умолчанию конфигурация пользовательского интерфейса. Новые настройки упрощают работу с системой, организуя ее более удобным образом.'#13#10 + 
'Конфигурация, с которой Вы работали раньше, сохранена. Для обращения к ней выберите в разделе командного меню «Файл» пункт «Выбор конфигурации».');
   { 'В новой версии изменена используемая по умолчанию конфигурация пользовательского интерфейса. Новые настройки упрощают работу с системой, организуя ее более удобным образом.'#13#10 + 
'Конфигурация, с которой Вы работали раньше, сохранена. Для обращения к ней выберите в разделе командного меню «Файл» пункт «Выбор конфигурации».' }

// start class TPrimMonitoringsModule

class procedure TPrimMonitoringsModule.OpenAutoreferat(const aDoc: IDocument;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4B45E0101_4A8ECF3001D2_var*
//#UC END# *4AA4B45E0101_4A8ECF3001D2_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4B45E0101_4A8ECF3001D2_impl*
 if (aDoc <> nil) then
  Tfs_Autoreferat.Make(TsdsAutoreferat.Make(TdeDocInfo.Make(aDoc)),
                       CheckContainer(aContainer),
                       True,
                       True);
//#UC END# *4AA4B45E0101_4A8ECF3001D2_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimMonitoringsModule.OpenAutoreferat

class procedure TPrimMonitoringsModule.OpenAutoreferatAfterSearch(const aList: IMonitoringList;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4C0C500AA_4A8ECF3001D2_var*
//#UC END# *4AA4C0C500AA_4A8ECF3001D2_var*
var
 l_Document : IDocument;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4C0C500AA_4A8ECF3001D2_impl*
 aList.GetSummary(l_Document);
 if (l_Document <> nil) then
  Tfs_AutoreferatAfterSearch.Make(TsdsAutoreferat.Make(TdeDocInfo.Make(l_Document)),
                                  CheckContainer(aContainer));
//#UC END# *4AA4C0C500AA_4A8ECF3001D2_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimMonitoringsModule.OpenAutoreferatAfterSearch

class function TPrimMonitoringsModule.OpenNewsLine: IvcmEntityForm;
var
 __WasEnter : Boolean;
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
 __WasEnter := vcmEnterFactory;
 try
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
   lp_CreateContainer(True);
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimMonitoringsModule.OpenNewsLine

procedure TPrimMonitoringsModule.opOpenNewsLineTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB775AA0314_4A8ECF3001D2test_var*
//#UC END# *4AB775AA0314_4A8ECF3001D2test_var*
begin
//#UC START# *4AB775AA0314_4A8ECF3001D2test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not defDataAdapter.AdministratorLogin and
                                  defDataAdapter.Monitoring.IsExist;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB775AA0314_4A8ECF3001D2test_impl*
end;//TPrimMonitoringsModule.opOpenNewsLineTest

procedure TPrimMonitoringsModule.opOpenNewsLine(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB775AA0314_4A8ECF3001D2exec_var*
//#UC END# *4AB775AA0314_4A8ECF3001D2exec_var*
begin
//#UC START# *4AB775AA0314_4A8ECF3001D2exec_impl*
 OpenNewsLine;
 TnsOpenNewsLineEvent.Log;
//#UC END# *4AB775AA0314_4A8ECF3001D2exec_impl*
end;//TPrimMonitoringsModule.opOpenNewsLine

procedure TPrimMonitoringsModule.opOpenLegislationReviewTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB77A0E0276_4A8ECF3001D2test_var*
//#UC END# *4AB77A0E0276_4A8ECF3001D2test_var*
begin
//#UC START# *4AB77A0E0276_4A8ECF3001D2test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.LegislationReviewAvailable;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB77A0E0276_4A8ECF3001D2test_impl*
end;//TPrimMonitoringsModule.opOpenLegislationReviewTest

procedure TPrimMonitoringsModule.opOpenLegislationReview(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB77A0E0276_4A8ECF3001D2exec_var*
//#UC END# *4AB77A0E0276_4A8ECF3001D2exec_var*
begin
//#UC START# *4AB77A0E0276_4A8ECF3001D2exec_impl*
 // Построение обзора законодателоьства
 TdmStdRes.OpenLegislationReview(nil);
//#UC END# *4AB77A0E0276_4A8ECF3001D2exec_impl*
end;//TPrimMonitoringsModule.opOpenLegislationReview

class procedure TPrimMonitoringsModule.OpenNewsLinePrim;
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
// start class TnsOpenNewsLineEvent

class procedure TnsOpenNewsLineEvent.Log;
//#UC START# *4B14ED2F033E_4B14ED130233_var*
//#UC END# *4B14ED2F033E_4B14ED130233_var*
begin
//#UC START# *4B14ED2F033E_4B14ED130233_impl*
 GetLogger.AddEvent(LE_OPEN_NEWS_LINE, MakeParamsList);
//#UC END# *4B14ED2F033E_4B14ED130233_impl*
end;//TnsOpenNewsLineEvent.Log

// start class Tf1StartupCompletedServiceImpl

var g_Tf1StartupCompletedServiceImpl : Tf1StartupCompletedServiceImpl = nil;

procedure Tf1StartupCompletedServiceImplFree;
begin
 l3Free(g_Tf1StartupCompletedServiceImpl);
end;

class function Tf1StartupCompletedServiceImpl.Instance: Tf1StartupCompletedServiceImpl;
begin
 if (g_Tf1StartupCompletedServiceImpl = nil) then
 begin
  l3System.AddExitProc(Tf1StartupCompletedServiceImplFree);
  g_Tf1StartupCompletedServiceImpl := Create;
 end;
 Result := g_Tf1StartupCompletedServiceImpl;
end;


class function Tf1StartupCompletedServiceImpl.Exists: Boolean;
 {-}
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

procedure TPrimMonitoringsModule.Loaded;
begin
 inherited;
 PublishOp('opOpenNewsLine', opOpenNewsLine, opOpenNewsLineTest);
 PublishOp('opOpenLegislationReview', opOpenLegislationReview, opOpenLegislationReviewTest);
end;

class procedure TPrimMonitoringsModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TenNewsLine);
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация Tf1StartupCompletedServiceImpl
 Tf1StartupCompletedService.Instance.Alien := Tf1StartupCompletedServiceImpl.Instance;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_StartupInitPrime_Choice_Init
 str_StartupInitPrime_Choice_Init.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_StartupInitPrime_Choice_NoThanks
 str_StartupInitPrime_Choice_NoThanks.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_StartupInitPrime
 str_StartupInitPrime.Init;
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.AddChoice(str_StartupInitPrime_Choice_NoThanks);
 str_StartupInitPrime.AddDefaultChoice(str_StartupInitPrime_Choice_Init);
 str_StartupInitPrime.SetDlgType(mtInformation);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DefaultSetttingsWereChanged
 str_DefaultSetttingsWereChanged.Init;
 str_DefaultSetttingsWereChanged.SetDlgType(mtInformation);
{$IfEnd} //not Admin AND not Monitorings

end.