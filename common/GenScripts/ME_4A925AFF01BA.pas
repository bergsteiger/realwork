unit PrimNemesisRes;
 {* ѕриложение Nemesis }

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimNemesisRes.pas"
// —тереотип: "VCMApplication"
// Ёлемент модели: "PrimNemesis" MUID: (4A925AFF01BA)
// »м€ типа: "TPrimNemesisRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ShellAndMonitoringsRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsQueryInterfaces
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimNemesisRes = {abstract} class(TShellAndMonitoringsRes)
  {* ѕриложение Nemesis }
  private
   class procedure BeforeCorrectDate(const aDate: AnsiString);
  protected
   class function RunOtherProcesses: Boolean; override;
   class function DoGlobalInit(aLogo: TCustomForm;
    var theSplash: IUnknown): Boolean; override;
   class procedure DoRun(var theSplash: IUnknown); override;
  public
   class procedure OpenQuery(aQueryType: TlgQueryType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer); override;
 end;//TPrimNemesisRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsStartupSupport
 , Windows
 , GblAdapter
 , l3Base
 , StartUnit
 , SysUtils
 , MedicMainMenuRes
 , MainMenuNewRes
 , nsHooks
 , BaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DebugStr
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , MainWindow_Form
 , TabbedContainerRes
 , nsNotificationManager
 {$If NOT Defined(NoVGScene)}
 , vgRemindersLineTabbedContainerNotificationProxy
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
 , ChromeLikeInterfaces
 {$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)
 , vtDateEditRes
;

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
   // здесь нужно именно так, чтобы выполнились все секции финализации (в частности те, которые удал€ют временные файлы)
  end;//on EAbort
  on EInvalidBase do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверна€ часть (котора€ жива)
  end;//on EInvalidBase
  on EMorphoNotExists do
  begin
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы в десктопе завершила работу с настройками серверна€ часть (котора€ жива)
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
