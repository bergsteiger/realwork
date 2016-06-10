unit PrimNemesisRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimNemesisRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::PrimNemesis
//
// Приложение Nemesis
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  Messages
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainForm
  {$IfEnd} //not NoVCM
  ,
  NemesisMain_Form,
  L10nInterfaces,
  l3ProtoObject
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  F1_Without_Usecases_System_Controls,
  Main_Form,
  BaseSearchInterfaces,
  MainWindow_Form,
  ShellAndMonitoringsRes,
  ShellAndMonitoringsMain_Form,
  Search_Strange_Controls,
  MainOptions_Form,
  PrimBaseSearchInterfaces,
  MainWindowInterfaces,
  MainWithReminders_Form,
  nsIntegrationSupport
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  ,
  nsNotificationManager,
  l3TabbedContainersDispatcher,
  nsUnderControlNotificationManager
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  SearchUnit,
  nsQueryInterfaces,
  Classes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
TPrimNemesisRes = {abstract} class(TShellAndMonitoringsRes)
 {* Приложение Nemesis }
protected
   procedure RegisterFormSetFactories; override;
   procedure Loaded; override;
private
// private methods
   class procedure BeforeCorrectDate(const aDate: AnsiString);
     {* Глобальный обработчик сообщения о корректировке даты }
protected
// overridden protected methods
   class function RunOtherProcesses: Boolean; override;
   class function DoGlobalInit(aLogo: TCustomForm;
   var theSplash: IUnknown): Boolean; override;
   class procedure DoRun(var theSplash: IUnknown); override;
public
// overridden public methods
   class procedure OpenQuery(aQueryType: TlgQueryType;
   const aQuery: IQuery;
   const aContainer: IvcmContainer); override;

 public
 // operations codes
   class function opcode_Loadable_Load : TvcmOpID;
     { Это первый кандидат на превращение в Facet. Который нужно вызвать вот тут:
f_RequestingForm.Entity.Operation(op_Loadable_Load, l_Params).Done -> Коллеги, кто может описать этот метод? }
   class function opcode_System_CantReceiveLegalServiceAnswer : TvcmOpID;
     { Система -> Статус связи с ППО }
   class function opcode_Scalable_ChangeScale : TvcmOpID;
     { Масштабируемый объект -> Изменить масштаб }
   class function opcode_Scalable_CanChangeScale : TvcmOpID;
     { Масштабируемый объект -> Масштабирование запрещено }
   class function opcode_Result_Cancel : TvcmOpID;
     { Результат диалога -> Отмена }
   class function opcode_Rubricator_SetListRoot : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_InitListRoot : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_Synchronize : TvcmOpID;
     {  ->  }
   class function opcode_Rubricator_GetRoot : TvcmOpID;
     {  ->  }
end;//TPrimNemesisRes
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsChangeFontSizeEvent,
  evStyleInterface,
  nsSettingsUtils,
  evStyleTableTools,
  nsPrimaryMonitorResolutionEvent,
  nsDPIEvent,
  nsFontSizeEvent,
  resWarnImages,
  BaseTypesUnit,
  nsNodes,
  BaseTreeSupportUnit,
  nsForwardEvent,
  nsBackEvent,
  Search_ScalingSupport_Controls,
  sdsMainWindow,
  WarningUserTypes_Warning_UserType,
  BaloonWarningUserTypes_Fake_UserType,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  BaloonWarningUserTypes_remUnreadConsultations_UserType,
  BaloonWarningUserTypes_remOnlineDead_UserType,
  BaloonWarningUserTypes_TrialModeWarning_UserType,
  BaloonWarningUserTypes_OldBaseWarning_UserType,
  BaloonWarningUserTypes_ControlledChangingWarning_UserType,
  nsConst,
  SysUtils,
  afwFacade
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Windows,
  l3Base {a}
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLikeAppInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  nsWindowsList
  {$IfEnd} //not NoVCM
  ,
  l3String,
  nsExternalObjectPrim,
  nsFolderFilterInfo,
  nsBaseMainMenuTree,
  nsOpenUtils,
  nsTypes,
  FoldersDomainInterfaces,
  DynamicTreeUnit,
  Common_FormDefinitions_Controls,
  Common_Rubricator_Controls,
  nsUtils,
  DocumentUnit
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  IOUnit,
  bsTypes,
  nsManagers,
  nsBaseSearcher,
  nsQueryUtils,
  nsContextHistory,
  MemoryUsage_Form,
  l3AsincMessageWindow,
  l3SysUtils,
  IntegrationProjectUnit
  {$If not defined(NoVCM)}
  ,
  vcmMenuManager
  {$IfEnd} //not NoVCM
  ,
  l3ListenersManager,
  HelpIntfs,
  vtVerInf,
  SettingsUnit,
  nsConfiguration,
  nsValueMaps,
  nsValueMapsIDs,
  ContextHistoryInterfaces,
  nsBaseSearchService,
  l3Chars,
  nsStartupSupport,
  GblAdapter,
  StartUnit,
  MedicMainMenuRes,
  MainMenuNewRes,
  nsHooks,
  DebugStr,
  TabbedContainerRes
  {$If not defined(NoVGScene)}
  ,
  vgRemindersLineTabbedContainerNotificationProxy
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ChromeLikeInterfaces
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  vtDateEditRes
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  F1_Without_Usecases_DocumentsCacheOperations_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimNemesisRes

class procedure TPrimNemesisRes.BeforeCorrectDate(const aDate: AnsiString);
//#UC START# *4AA8AC090381_4A925AFF01BA_var*
//#UC END# *4AA8AC090381_4A925AFF01BA_var*
begin
//#UC START# *4AA8AC090381_4A925AFF01BA_impl*
 vcmAsk(err_DateWillBeCorrectF, [aDate]);
//#UC END# *4AA8AC090381_4A925AFF01BA_impl*
end;//TPrimNemesisRes.BeforeCorrectDate

class function TPrimNemesisRes.RunOtherProcesses: Boolean;
//#UC START# *4AA7C28A0113_4A925AFF01BA_var*
//#UC END# *4AA7C28A0113_4A925AFF01BA_var*
begin
//#UC START# *4AA7C28A0113_4A925AFF01BA_impl*
 Result := true;
 with TnsStartupSupport do
 begin
  repeat
   StartupPendingNotify;
   if IsRunDataInstallerParamExist then
   begin
    if TryRunDataInstaller then
    begin
     StartupCompletedNotify;
     WaitForDataInstallerExit;
     Result := false;
     Exit;
    end;//TryRunDataInstaller
   end//IsRunDataInstallerParamExist
   else
   if IsRunDataUpdaterParamExist then
   begin
    if TryRunDataUpdater then
    begin
     StartupCompletedNotify;
     WaitForDataUpdaterExit;
     Result := false;
     Exit;
    end;//TryRunDataUpdater
   end//IsRunDataUpdaterParamExist
   else
   if IsRunDownloaderParamExist then
   begin
    if TryRunDownloader then
    begin
     StartupCompletedNotify;
     WaitForDownloaderExit;
     Result := false;
     Exit;
    end;//TryRunDownloader
   end//IsRunDownloaderParamExist
   else
   if (TryUnlockLogin or TrySwitchToOtherRunningCopy) then
   begin
    TrySendOpenByNumer;
    //
    StartupCompletedNotify;
    Result := false;
    Exit;
   end;//TryUnlockLogin or TrySwitchToOtherRunningCopy
   StartupCompletedNotify;
  until (CheckAndCreateRunningCopyMutex);
  StartupPendingNotify;
 end;//TnsStartupSupport
//#UC END# *4AA7C28A0113_4A925AFF01BA_impl*
end;//TPrimNemesisRes.RunOtherProcesses

class function TPrimNemesisRes.DoGlobalInit(aLogo: TCustomForm;
  var theSplash: IUnknown): Boolean;
//#UC START# *4AA7D7CA00FE_4A925AFF01BA_var*
//#UC END# *4AA7D7CA00FE_4A925AFF01BA_var*
begin
//#UC START# *4AA7D7CA00FE_4A925AFF01BA_impl*
 Result := true;
 try
  theSplash := DataAdapter.GlobalInit(aLogo, afw.Application.LocaleInfo.Name,
   False, TnsStartupSupport.IsSilentRunAndExitParamExist);
 except
  on EAbort do
  begin
   l3System.CheckClipboard;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=121145106
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы выполнились все секции финализации (в частности те, которые удаляют временные файлы)
  end;//on EAbort
  on EInvalidBase do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверная часть (которая жива)
  end;//on EInvalidBase
  on EMorphoNotExists do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверная часть (которая жива)
  end;//on EMorphoNotExists
  on ECorbaException do
  begin
   aLogo.Hide;
   Application.HandleException(nil);
   TerminateProcess(GetCurrentProcess, 255);
  end;//on ECorbaException
  else
  begin
   aLogo.Hide;
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
 end;//try..except
//#UC END# *4AA7D7CA00FE_4A925AFF01BA_impl*
end;//TPrimNemesisRes.DoGlobalInit

class procedure TPrimNemesisRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4A925AFF01BA_var*

 //http://mdp.garant.ru/pages/viewpage.action?pageId=481813781
 function lp_SilentRunAndExit: Boolean;
 const
  c_OpenByNumberParamName = '-OpenByNumber';
 var
  l_ArgIdx: Integer;
  l_ArgCnt: Integer;
  l_SilentProcessCommand: Boolean;
  l_DocNumberStr: String;
  l_WrongLink: Boolean;
 begin
  Result := False;
  if TnsStartupSupport.IsSilentRunAndExitParamExist then
  begin
   Result := True;
   l_ArgCnt := ParamCount;
   for l_ArgIdx := 1 to l_ArgCnt do
    if (AnsiCompareText(ParamStr(l_ArgIdx), c_OpenByNumberParamName) = 0) then
    begin
     if (l_ArgIdx < l_ArgCnt) then
      l_DocNumberStr := ParamStr(Succ(l_ArgIdx));
     if (l_DocNumberStr <> '') then
      if (not nsNeedShellToOpenDocument(l_DocNumberStr, True, l_WrongLink)) or l_WrongLink then
      begin
       if not l_WrongLink then
        Result := nsOpenLink(l_DocNumberStr, True, False, False);
      end
      else
       Result := False;
    end;//if (AnsiCompareText(ParamStr(l_ArgIdx), c_OpenByNumberParamName) = 0)
  end;//if TnsStartupSupport.IsSilentRunAndExitParamExist
 end;//lp_SilentRunAndExit

var
 l_Main : TnsMainWindow;
 l_Cont : TvcmEntityForm;
 l_NeedSilentRunAndExit: Boolean;
//#UC END# *4AA7E4DC0047_4A925AFF01BA_var*
begin
//#UC START# *4AA7E4DC0047_4A925AFF01BA_impl*
 inherited;
 g_vtBeforeCorrectDate := Self.BeforeCorrectDate;
 afw.Application.LockKeyboard;
 try
  l_NeedSilentRunAndExit := lp_SilentRunAndExit;
  if not l_NeedSilentRunAndExit then
  begin
   defDataAdapter.DefineApplicationTitle;
   Application.CreateForm(TdmMedicMainMenuRes, dmMedicMainMenuRes);
   afw.ProcessMessages;
   Application.CreateForm(TdmMainMenuNew, dmMainMenuNew);
   afw.ProcessMessages;
   Application.CreateForm(TnsMainWindow, l_Main);

   {$IfDef InsiderTest}
   l_Main.DefaultMonitor := dmDesktop;
   {$EndIf InsiderTest}
   afw.ProcessMessages;
  end;
 finally
  if defDataAdapter.FatalExceptionRaised then
  begin
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
  theSplash := nil;
  defDataAdapter.InStartUpProcess := False;
  afw.Application.UnLockKeyboard;

  l_Cont := nil; 
  if (not l_NeedSilentRunAndExit) and
   TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  begin
   TvcmTabbedContainerFormDispatcher.Instance.TabImages := nsTabbedContainerRes.ilTabImages;
   TvgRemindersLineTabbedContainerNotificationProxy.Instance;
   l_Cont := TvcmTabbedContainerFormDispatcher.Instance.MakeNewtabbedContainer(l_Main);
   l_Cont.Visible := true;
  end;

  if (l_Cont <> nil) then
   if l_Cont.HandleAllocated then
    SetForegroundWindow(l_Cont.Handle)
   else
  else
  if (l_Main <> nil) then
   if l_Main.HandleAllocated then
    SetForegroundWindow(l_Main.Handle);
  TnsNotificationManager.NotifyListeners(ntMainFormBecomeTopmostAtStartup);
 end;//try..finally
//#UC END# *4AA7E4DC0047_4A925AFF01BA_impl*
end;//TPrimNemesisRes.DoRun

class procedure TPrimNemesisRes.OpenQuery(aQueryType: TlgQueryType;
  const aQuery: IQuery;
  const aContainer: IvcmContainer);
//#UC START# *4AC4A69D03B7_4A925AFF01BA_var*
//#UC END# *4AC4A69D03B7_4A925AFF01BA_var*
begin
//#UC START# *4AC4A69D03B7_4A925AFF01BA_impl*
 case aQueryType of
  lg_qtKeyWord:
   TdmStdRes.OpenKeyWord(aQuery, aContainer);
  lg_qtAttribute:
   TdmStdRes.AttributeSearch(aQuery, nil, aContainer);
  lg_qtPublishedSource:
   TdmStdRes.PublishSourceSearch(aQuery, nil);
  lg_qtLegislationReview:
   TdmStdRes.OpenLegislationReview(aQuery);
  lg_qtSendConsultation:
   vcmDispatcher.ModuleOperation(TdmStdRes.mod_opcode_Search_OpenConsult);
  lg_qtBaseSearch:
   TdmStdRes.OpenBaseSearch(ns_bsokGlobal,
                            aQuery);
  lg_qtInpharmSearch:
   TdmStdRes.InpharmSearch(aQuery, nil, aContainer);
  else
   inherited;   
 end;//case aQueryType
//#UC END# *4AC4A69D03B7_4A925AFF01BA_impl*
end;//TPrimNemesisRes.OpenQuery

procedure TPrimNemesisRes.RegisterFormSetFactories;
begin
 inherited;
end;

var
 g_opcode_Loadable_Load : TvcmOpID;
 g_opcode_System_CantReceiveLegalServiceAnswer : TvcmOpID;
 g_opcode_Scalable_ChangeScale : TvcmOpID;
 g_opcode_Scalable_CanChangeScale : TvcmOpID;
 g_opcode_Result_Cancel : TvcmOpID;
 g_opcode_Rubricator_SetListRoot : TvcmOpID;
 g_opcode_Rubricator_InitListRoot : TvcmOpID;
 g_opcode_Rubricator_Synchronize : TvcmOpID;
 g_opcode_Rubricator_GetRoot : TvcmOpID;

procedure TPrimNemesisRes.Loaded;
begin
 inherited;
 g_opcode_Loadable_Load :=
  PublishInternalOperation(en_Loadable,
                    op_Load,
                    en_capLoadable,
                    op_capLoad);
 g_opcode_System_CantReceiveLegalServiceAnswer :=
  PublishOperation(en_System,
                    op_CantReceiveLegalServiceAnswer,
                    en_capSystem,
                    op_capCantReceiveLegalServiceAnswer);
  with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'On') do
  begin
   st_user_System_CantReceiveLegalServiceAnswer_On := StateIndex;
   Hint := 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. ' + 'В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.' + #13#10#13#10 + 'Для решения технических вопросов обратитесь, к Вашему системному администратору. ' + 'Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:' + #13#10 + '<текст из dealer.inf>';
   ImageIndex := 185;
  end;//with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'On')
  with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'Off') do
  begin
   st_user_System_CantReceiveLegalServiceAnswer_Off := StateIndex;
   Caption := 'Связь восстановлена';
   ImageIndex := 186;
  end;//with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'Off')
  with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'Disabled') do
  begin
   st_user_System_CantReceiveLegalServiceAnswer_Disabled := StateIndex;
   Enabled := false;
  end;//with PublishOperationState(en_System, op_CantReceiveLegalServiceAnswer, 'Disabled')
 PublishOperation(en_Common,
                    op_Exit,
                    en_capCommon,
                    op_capExit);
 g_opcode_Scalable_ChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_ChangeScale,
                    en_capScalable,
                    op_capChangeScale);
 g_opcode_Scalable_CanChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_CanChangeScale,
                    en_capScalable,
                    op_capCanChangeScale);
 g_opcode_Result_Cancel :=
  PublishOperation(en_Result,
                    op_Cancel,
                    en_capResult,
                    op_capCancel);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Cancel, 'Close') do
  begin
   st_user_Result_Cancel_Close := StateIndex;
   Caption := 'Закрыть';
  end;//with PublishOperationState(en_Result, op_Cancel, 'Close')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Fonts,
                    op_IncreaseFont,
                    en_capFonts,
                    op_capIncreaseFont);
 PublishOperation(en_Fonts,
                    op_DecreaseFont,
                    en_capFonts,
                    op_capDecreaseFont);
 PublishOperation(en_Help,
                    op_HotInformation,
                    en_capHelp,
                    op_capHotInformation);
 PublishOperation(en_Help,
                    op_HelpShortCuts,
                    en_capHelp,
                    op_capHelpShortCuts);
 PublishOperation(en_Help,
                    op_HelpNewFeatures,
                    en_capHelp,
                    op_capHelpNewFeatures);
 PublishOperation(en_Help,
                    op_ContactInformation,
                    en_capHelp,
                    op_capContactInformation);
 PublishOperation(en_Help,
                    op_ReplyBook,
                    en_capHelp,
                    op_capReplyBook);
 PublishOperation(en_Help,
                    op_GarantInternet,
                    en_capHelp,
                    op_capGarantInternet);
 PublishOperation(en_Help,
                    op_About,
                    en_capHelp,
                    op_capAbout);
 PublishOperation(en_System,
                    op_BookmarkList,
                    en_capSystem,
                    op_capBookmarkList);
 PublishOperation(en_WarnOnControl,
                    op_BuildControlledList,
                    en_capWarnOnControl,
                    op_capBuildControlledList);
 PublishOperation(en_WarnOnControl,
                    op_OpenUnderControlTree,
                    en_capWarnOnControl,
                    op_capOpenUnderControlTree);
 PublishOperation(en_WarnOnControl,
                    op_HideReminder,
                    en_capWarnOnControl,
                    op_capHideReminder);
 g_opcode_Rubricator_SetListRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_SetListRoot,
                    en_capRubricator,
                    op_capSetListRoot);
 g_opcode_Rubricator_InitListRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_InitListRoot,
                    en_capRubricator,
                    op_capInitListRoot);
 g_opcode_Rubricator_Synchronize :=
  PublishInternalOperation(en_Rubricator,
                    op_Synchronize,
                    en_capRubricator,
                    op_capSynchronize);
 g_opcode_Rubricator_GetRoot :=
  PublishInternalOperation(en_Rubricator,
                    op_GetRoot,
                    en_capRubricator,
                    op_capGetRoot);
 PublishOperation(en_Common,
                    op_MemUsage,
                    en_capCommon,
                    op_capMemUsage);
 PublishOperation(en_Result,
                    op_Ok,
                    en_capResult,
                    op_capOk);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Search') do
  begin
   st_user_Result_Ok_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_Ok, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Print') do
  begin
   st_user_Result_Ok_Print := StateIndex;
   Caption := 'Печать';
   ImageIndex := 3;
  end;//with PublishOperationState(en_Result, op_Ok, 'Print')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'AttributesSelect') do
  begin
   st_user_Result_Ok_AttributesSelect := StateIndex;
   Caption := 'Подтвердить выбор элементов';
  end;//with PublishOperationState(en_Result, op_Ok, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'ConsultationMark') do
  begin
   st_user_Result_Ok_ConsultationMark := StateIndex;
   Caption := 'Оценить';
  end;//with PublishOperationState(en_Result, op_Ok, 'ConsultationMark')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Analize') do
  begin
   st_user_Result_Ok_Analize := StateIndex;
   Caption := 'Построить';
  end;//with PublishOperationState(en_Result, op_Ok, 'Analize')
 {$IfEnd} //not NoVCM
 PublishOperation(en_DocumentsCache,
                    op_Clear,
                    en_capDocumentsCache,
                    op_capClear);
 SetOperationImageIndex(
                    en_DocumentsCache,
                    op_Clear,
                    5);
 PublishOperation(en_DocumentsCache,
                    op_Disable,
                    en_capDocumentsCache,
                    op_capDisable);
 SetOperationImageIndex(
                    en_DocumentsCache,
                    op_Disable,
                    26);
  with PublishOperationState(en_DocumentsCache, op_Disable, 'Disable') do
  begin
   st_user_DocumentsCache_Disable_Disable := StateIndex;
  end;//with PublishOperationState(en_DocumentsCache, op_Disable, 'Disable')
  with PublishOperationState(en_DocumentsCache, op_Disable, 'Enable') do
  begin
   st_user_DocumentsCache_Disable_Enable := StateIndex;
   Checked := true;
  end;//with PublishOperationState(en_DocumentsCache, op_Disable, 'Enable')
 PublishOperation(en_Reminder,
                    op_RemMWControlledChangingWarning,
                    en_capReminder,
                    op_capRemMWControlledChangingWarning);
 PublishOperation(en_Reminder,
                    op_RemMWOldBaseWarning,
                    en_capReminder,
                    op_capRemMWOldBaseWarning);
 PublishOperation(en_Reminder,
                    op_RemMWTrialModeWarning,
                    en_capReminder,
                    op_capRemMWTrialModeWarning);
 PublishOperation(en_Reminder,
                    op_RemNewChatMessages,
                    en_capReminder,
                    op_capRemNewChatMessages);
 PublishOperation(en_Reminder,
                    op_RemOnlineDead,
                    en_capReminder,
                    op_capRemOnlineDead);
 PublishOperation(en_Reminder,
                    op_remUnreadConsultations,
                    en_capReminder,
                    op_capremUnreadConsultations);
end;

// operations codes

class function TPrimNemesisRes.opcode_Loadable_Load : TvcmOpID;
begin
 Result := g_opcode_Loadable_Load;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_System_CantReceiveLegalServiceAnswer : TvcmOpID;
begin
 Result := g_opcode_System_CantReceiveLegalServiceAnswer;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Scalable_ChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_ChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Scalable_CanChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_CanChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Result_Cancel : TvcmOpID;
begin
 Result := g_opcode_Result_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Rubricator_SetListRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_SetListRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Rubricator_InitListRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_InitListRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Rubricator_Synchronize : TvcmOpID;
begin
 Result := g_opcode_Rubricator_Synchronize;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimNemesisRes.opcode_Rubricator_GetRoot : TvcmOpID;
begin
 Result := g_opcode_Rubricator_GetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimNemesis
 TtfwClassRef.Register(TPrimNemesisRes);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.