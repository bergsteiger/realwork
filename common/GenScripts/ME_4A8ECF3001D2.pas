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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , MonitoringUnit
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsOpenNewsLineEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenNewsLineEvent

 TPrimMonitoringsModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure opOpenNewsLineTest(const aParams: IvcmTestParamsPrim);
    {* Новостная лента }
   procedure opOpenNewsLineExecute(const aParams: IvcmExecuteParamsPrim);
    {* Новостная лента }
   procedure opOpenLegislationReviewTest(const aParams: IvcmTestParamsPrim);
    {* Обзор изменений законодательства }
   procedure opOpenLegislationReviewExecute(const aParams: IvcmExecuteParamsPrim);
    {* Обзор изменений законодательства }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class procedure OpenAutoreferat(const aDoc: IDocument;
    const aContainer: IvcmContainer);
   class procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
    const aContainer: IvcmContainer);
   class function OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
   class procedure OpenNewsLinePrim;
 end;//TPrimMonitoringsModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwAxiomaticsResNameGetter
 {$IfEnd} // NOT Defined(NoScripts)
 , Autoreferat_InternalOperations_Controls
 , nsOpenUtils
 , nsConst
 , afwFacade
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsPostingsTreeSingle
 , PostingOrder_Strange_Controls
 , f1StartupCompletedServiceImpl
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
 , PrimNewsLine_nltMain_UserType
 , NewsLine_Form
 , fsAutoreferat
 , fsAutoreferatAfterSearch
 , Common_FormDefinitions_Controls
 //#UC START# *4A8ECF3001D2impl_uses*
 , SysUtils
 , StdRes
 //#UC END# *4A8ECF3001D2impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TPrimMonitorings_ModuleResNameGetter = {final} class({$If NOT Defined(NoScripts)}
 TtfwAxiomaticsResNameGetter
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* Регистрация скриптованой аксиоматики }
  public
   {$If NOT Defined(NoScripts)}
   class function ResName: AnsiString; override;
   {$IfEnd} // NOT Defined(NoScripts)
 end;//TPrimMonitorings_ModuleResNameGetter

class procedure TnsOpenNewsLineEvent.Log;
//#UC START# *4B14ED2F033E_4B14ED130233_var*
//#UC END# *4B14ED2F033E_4B14ED130233_var*
begin
//#UC START# *4B14ED2F033E_4B14ED130233_impl*
 GetLogger.AddEvent(LE_OPEN_NEWS_LINE, MakeParamsList);
//#UC END# *4B14ED2F033E_4B14ED130233_impl*
end;//TnsOpenNewsLineEvent.Log

{$If NOT Defined(NoScripts)}
class function TPrimMonitorings_ModuleResNameGetter.ResName: AnsiString;
begin
 Result := 'PrimMonitorings_Module';
end;//TPrimMonitorings_ModuleResNameGetter.ResName
{$IfEnd} // NOT Defined(NoScripts)

{$R PrimMonitorings_Module.res}

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
var l_Document: IDocument;
var
 __WasEnter : Boolean;
//#UC START# *4AA4C0C500AA_4A8ECF3001D2_var*
//#UC END# *4AA4C0C500AA_4A8ECF3001D2_var*
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

class function TPrimMonitoringsModule.OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB76AD20100_4A8ECF3001D2_var*
 l_Container: IvcmContainer;

 l_IsDefined: Boolean;
 l_FillFormAnswer: TModalResult;
 l_IsOnline: Boolean;
 l_HasConnection: Boolean;

 function lp_IsContainerEmpty(const aContainer: IvcmContainer): Boolean;
 var
  l_ContainedForm: IvcmContainedForm;
 begin
  if Supports(aContainer, IvcmContainedForm, l_ContainedForm) then
  try
   Result := l_ContainedForm.IsEmpty;
  finally
   l_ContainedForm := nil; 
  end
  else
   Assert(False);
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
    UpdateWindow(l_ContainerForMainMenu.AsForm.VCLWinControl.Handle);
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
var
 l_NeedShowMainMenu: Boolean;
//#UC END# *4AB76AD20100_4A8ECF3001D2_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB76AD20100_4A8ECF3001D2_impl*
  l_NeedShowMainMenu := lp_IsContainerEmpty(TvcmTabbedContainerFormDispatcher.Instance.ActiveVCMContainer);

  if l_NeedShowMainMenu then
  begin
   lp_CreateContainer(not aDenyNewTab);
   lp_OpenMainMenuIfNeeded;
  end;
  
  l_FillFormAnswer := -2;
  l_IsDefined := defDataAdapter.Monitoring.IsNewsLineDefined;
  l_IsOnline := False;
  l_HasConnection := False;

  afw.ProcessMessages;

  if not l_IsDefined then
  begin
   l_IsOnline := defDataAdapter.PrimeManager.GetHasOnlineAccess;
   l_HasConnection := l_IsOnline and defDataAdapter.PrimeManager.CheckConnectionToOnlineServer;
   if l_HasConnection then
   begin
    l_FillFormAnswer := vcmMessageDlg(str_NewsLineIsNotSetup, []);
    if l_FillFormAnswer = mrCancel then
     Exit;
   end
  end;

  if l_IsOnline and (l_FillFormAnswer = -1) then
  begin
   if l_HasConnection then
   begin
    if not Assigned(TnsPostingsTreeSingle.Instance.MgrSearch) then
    begin
     if (l_Container = nil) then
      lp_CreateContainer(False);
     TCommonPostModule.StartOpen(l_Container, False);
    end else
     Op_SearchSupport_ActivatePostingsListForm.Broadcast;
   end else
   begin
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TPrimMonitoringsModule.OpenNewsLine

procedure TPrimMonitoringsModule.opOpenNewsLineTest(const aParams: IvcmTestParamsPrim);
 {* Новостная лента }
//#UC START# *4AB775AA0314_4A8ECF3001D2test_var*
//#UC END# *4AB775AA0314_4A8ECF3001D2test_var*
begin
//#UC START# *4AB775AA0314_4A8ECF3001D2test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not defDataAdapter.AdministratorLogin and
                                  defDataAdapter.Monitoring.IsExist;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB775AA0314_4A8ECF3001D2test_impl*
end;//TPrimMonitoringsModule.opOpenNewsLineTest

procedure TPrimMonitoringsModule.opOpenNewsLineExecute(const aParams: IvcmExecuteParamsPrim);
 {* Новостная лента }
//#UC START# *4AB775AA0314_4A8ECF3001D2exec_var*
//#UC END# *4AB775AA0314_4A8ECF3001D2exec_var*
begin
//#UC START# *4AB775AA0314_4A8ECF3001D2exec_impl*
 OpenNewsLine(False);
 TnsOpenNewsLineEvent.Log;
//#UC END# *4AB775AA0314_4A8ECF3001D2exec_impl*
end;//TPrimMonitoringsModule.opOpenNewsLineExecute

procedure TPrimMonitoringsModule.opOpenLegislationReviewTest(const aParams: IvcmTestParamsPrim);
 {* Обзор изменений законодательства }
//#UC START# *4AB77A0E0276_4A8ECF3001D2test_var*
//#UC END# *4AB77A0E0276_4A8ECF3001D2test_var*
begin
//#UC START# *4AB77A0E0276_4A8ECF3001D2test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.LegislationReviewAvailable;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB77A0E0276_4A8ECF3001D2test_impl*
end;//TPrimMonitoringsModule.opOpenLegislationReviewTest

procedure TPrimMonitoringsModule.opOpenLegislationReviewExecute(const aParams: IvcmExecuteParamsPrim);
 {* Обзор изменений законодательства }
//#UC START# *4AB77A0E0276_4A8ECF3001D2exec_var*
//#UC END# *4AB77A0E0276_4A8ECF3001D2exec_var*
begin
//#UC START# *4AB77A0E0276_4A8ECF3001D2exec_impl*
 // Построение обзора законодателоьства
 TdmStdRes.OpenLegislationReview(nil);
//#UC END# *4AB77A0E0276_4A8ECF3001D2exec_impl*
end;//TPrimMonitoringsModule.opOpenLegislationReviewExecute

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

procedure TPrimMonitoringsModule.Loaded;
begin
 inherited;
 PublishOp('opOpenNewsLine', opOpenNewsLineExecute, opOpenNewsLineTest);
 PublishOp('opOpenLegislationReview', opOpenLegislationReviewExecute, opOpenLegislationReviewTest);
end;//TPrimMonitoringsModule.Loaded

class procedure TPrimMonitoringsModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TenNewsLine);
end;//TPrimMonitoringsModule.GetEntityForms

initialization
 TPrimMonitorings_ModuleResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
