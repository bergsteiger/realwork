unit MainOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainOptions_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "MainOptions" MUID: (4C8A29700261)
// Имя типа: "TMainOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , NemesisMain_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , F1_Without_Usecases_System_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , L10nInterfaces
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 , nsIntegrationSupport
;

type
 TMainOptionsForm = class;

 InsIntegrationProcessor = interface
  ['{C3E4F420-4422-4607-9F30-25BB208269A6}']
  function ProcessCommand(aCommand: Integer;
   InNewWindow: Boolean;
   const aContainer: IvcmContainer): Boolean;
  function ProcessLink(aLink: PnsLinkDataArray): Boolean;
  function CheckKey(aKey: PnsLinkDataArray): Boolean;
  procedure CheckInconic;
 end;//InsIntegrationProcessor

 TMainOptionsForm = class(TNemesisMainForm)
  private
   f_RemindersLine: TnscRemindersLine;
   f_IsRemUnreadConsultationsVisible: Boolean;
   f_ControlledChangingWarning: TnscReminder;
   f_remUnreadConsultations: TnscReminder;
  protected
   f_InternetMap: InsStringValueMap;
   f_WindowInitialized: Boolean;
  protected
   procedure LoadStartState(const aParams: IvcmMakeParams);
   procedure OpenUnderControl;
   procedure ShowWhatsNewHelpPage;
   function ConvertOpenOnStartSetting: Integer;
   procedure InitClone(aForm: TvcmMainForm); override;
   procedure vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm); override;
   procedure DropChangeStatusToOpened; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure DoInitContainedForm(aForm: TvcmMainForm); override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Fonts_IncreaseFont_Test(const aParams: IvcmTestParamsPrim);
   procedure Fonts_IncreaseFont_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Fonts_DecreaseFont_Test(const aParams: IvcmTestParamsPrim);
   procedure Fonts_DecreaseFont_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_HotInformation_Test(const aParams: IvcmTestParamsPrim);
   procedure Help_HotInformation_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_HelpShortCuts_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_HelpNewFeatures_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_ContactInformation_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_ReplyBook_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_GarantInternet_Test(const aParams: IvcmTestParamsPrim);
   procedure Help_GarantInternet_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Help_About_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure System_BookmarkList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure WarnOnControl_BuildControlledList_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Построить список изменившихся документов на контроле }
   procedure WarnOnControl_OpenUnderControlTree_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Открыть вкладку "Документы на контроле" }
   procedure WarnOnControl_HideReminder_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Скрыть предупреждающий знак }
  protected
   property IsRemUnreadConsultationsVisible: Boolean
    read f_IsRemUnreadConsultationsVisible
    write f_IsRemUnreadConsultationsVisible;
  public
   property RemindersLine: TnscRemindersLine
    read f_RemindersLine;
   property ControlledChangingWarning: TnscReminder
    read f_ControlledChangingWarning;
   property remUnreadConsultations: TnscReminder
    read f_remUnreadConsultations;
 end;//TMainOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLikeAppInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , nsWindowsList
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , Windows
 , l3String
 , nsExternalObjectPrim
 , nsFolderFilterInfo
 , nsBaseMainMenuTree
 , nsOpenUtils
 , nsTypes
 , FoldersDomainInterfaces
 , DynamicTreeUnit
 , nsConst
 , DataAdapter
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Common_FormDefinitions_Controls
 , Common_Rubricator_Controls
 , nsUtils
 , DocumentUnit
 , l3Base
 , afwFacade
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_System_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C8A29700261impl_uses*
 //#UC END# *4C8A29700261impl_uses*
;

var g_InternerMapStrings: IvcmStrings = nil;

procedure TMainOptionsForm.LoadStartState(const aParams: IvcmMakeParams);
//#UC START# *4C8A33C301CA_4C8A29700261_var*

 function lp_CheckCommandLine: Boolean;
 var
  l_Document             : IDocument;
  l_Idx                  : Integer;
  l_DocPos               : String;
  l_NeedSilentRunAndExit : Boolean;
  l_CanCloseApp          : Boolean;
 const
  c_OpenByNumberParamName = '-OpenByNumber';
  c_ShellSilentRunAndExitParam = '-SilentRunAndExit';
 begin//lp_CheckCommandLine
  Result := false;
  //http://mdp.garant.ru/pages/viewpage.action?pageId=481813781
  l_NeedSilentRunAndExit := False;
  for l_Idx := 1 to ParamCount do
   if (ANSICompareText(ParamStr(l_Idx), c_ShellSilentRunAndExitParam) = 0) then
   begin
    l_NeedSilentRunAndExit := True;
    Break;
   end;
  for l_Idx := 1 to ParamCount do
   if (ANSICompareText(ParamStr(l_Idx),c_OpenByNumberParamName) = 0) then
   begin
    if (l_Idx < ParamCount) then
    begin
     l_DocPos := ParamStr(l_Idx + 1);
     // http://mdp.garant.ru/pages/viewpage.action?pageId=483399976
     Result := nsOpenDocumentByNumber(l_DocPos, True, False);
     //http://mdp.garant.ru/pages/viewpage.action?pageId=480833251
     if not Result then
      Result := nsOpenLink(l_DocPos, True, (not l_NeedSilentRunAndExit),
       (not l_NeedSilentRunAndExit));
    end;//l_Idx < ParamCount
    Break;
   end;//ANSICompareText(ParamStr(l_Idx),c_OpenByNumberParamName)
 end;//lp_CheckCommandLine

//#UC END# *4C8A33C301CA_4C8A29700261_var*
begin
//#UC START# *4C8A33C301CA_4C8A29700261_impl*
 if not defDataAdapter.AdministratorLogin then
 begin
  if (g_Dispatcher.FormDispatcher.MainFormsCount > 1) or
     not lp_CheckCommandLine then
   (Self As InsIntegrationProcessor).ProcessCommand(ConvertOpenOnStartSetting, False, aParams.Container);
 end//not defDataAdapter.AdministratorLogin
 else
  Assert(false);       
(*  Dispatcher._ModuleOperation(mop_Admin_OpenUserList,
                             vcmCleanUserParams(aParams));*)
//#UC END# *4C8A33C301CA_4C8A29700261_impl*
end;//TMainOptionsForm.LoadStartState

procedure TMainOptionsForm.OpenUnderControl;
//#UC START# *4C8A4B95003E_4C8A29700261_var*
//#UC END# *4C8A4B95003E_4C8A29700261_var*
begin
//#UC START# *4C8A4B95003E_4C8A29700261_impl*
 // Открываем форму с документами на контроле
 TdmStdRes.OpenUnderControl(Self);
 // Выдадим сообщение:
 MessageDlg(l3Cat(ControlledChangingWarning.Hint, '.'),
            'TnsMainWindow.OpenUnderControl', mtInformation);
 // Убираем значок предупреждения
 f_IsControlledObjectsChanging := False;
//#UC END# *4C8A4B95003E_4C8A29700261_impl*
end;//TMainOptionsForm.OpenUnderControl

procedure TMainOptionsForm.ShowWhatsNewHelpPage;
//#UC START# *4C8A4C9B00F9_4C8A29700261_var*
const
 c_HelpWhatsNewPage ='page-whatsnew.htm';
//#UC END# *4C8A4C9B00F9_4C8A29700261_var*
begin
//#UC START# *4C8A4C9B00F9_4C8A29700261_impl*
 Application.HelpSystem.ShowTopicHelp(c_HelpWhatsNewPage, '');
//#UC END# *4C8A4C9B00F9_4C8A29700261_impl*
end;//TMainOptionsForm.ShowWhatsNewHelpPage

function TMainOptionsForm.ConvertOpenOnStartSetting: Integer;
//#UC START# *4F86CBED00E7_4C8A29700261_var*
var
 l_Str : Il3CString;
//#UC END# *4F86CBED00E7_4C8A29700261_var*
begin
//#UC START# *4F86CBED00E7_4C8A29700261_impl*
 l_Str := afw.Settings.LoadString(pi_OpenOnStart, dv_OpenOnStart);
 if l3Same(l_Str, li_OpenOnStartAttributeSearch) then
  Result := GC_ATTRIBUTES_SEARCH
 else
 if l3Same(l_Str, li_OpenOnStartSituationSearch) then
  Result := GC_SITUATION_SEARCH
 else
 if l3Same(l_Str, li_OpenOnStartMainMenu) then
  Result := GC_MAIN_MENU
 else
 if l3Same(l_Str, li_OpenOnStartNavigator) then
  Result := GC_NAVIGATOR
 else
 if l3Same(l_Str, li_OpenOnStartInpharmSearch) then
  Result := GC_INPHARM_SEARCH
 else
 if l3Same(l_Str, li_OpenOnStartFullDrugList) then
  Result := GC_DRUG_LIST
 else
 if l3Same(l_Str, li_OpenOnStartInpharmMainMenu) then
  Result := GC_INPHARM_MAIN_MENU
 else
  Result := GC_LAST + 1;
//#UC END# *4F86CBED00E7_4C8A29700261_impl*
end;//TMainOptionsForm.ConvertOpenOnStartSetting

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C8A29700261test_var*
//#UC END# *4C762C910358_4C8A29700261test_var*
begin
//#UC START# *4C762C910358_4C8A29700261test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4C762C910358_4C8A29700261test_impl*
end;//TMainOptionsForm.Result_Cancel_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C8A29700261exec_var*
//#UC END# *4C762C910358_4C8A29700261exec_var*
begin
//#UC START# *4C762C910358_4C8A29700261exec_impl*
 Dispatcher.History.Back;
//#UC END# *4C762C910358_4C8A29700261exec_impl*
end;//TMainOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainOptionsForm.Fonts_IncreaseFont_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A2A5C03E4_4C8A29700261test_var*
//#UC END# *4C8A2A5C03E4_4C8A29700261test_var*
begin
//#UC START# *4C8A2A5C03E4_4C8A29700261test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanChangeDefaultFontSize;
//#UC END# *4C8A2A5C03E4_4C8A29700261test_impl*
end;//TMainOptionsForm.Fonts_IncreaseFont_Test

procedure TMainOptionsForm.Fonts_IncreaseFont_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A2A5C03E4_4C8A29700261exec_var*
//#UC END# *4C8A2A5C03E4_4C8A29700261exec_var*
begin
//#UC START# *4C8A2A5C03E4_4C8A29700261exec_impl*
 ChangeDefaultFontSize;
//#UC END# *4C8A2A5C03E4_4C8A29700261exec_impl*
end;//TMainOptionsForm.Fonts_IncreaseFont_Execute

procedure TMainOptionsForm.Fonts_DecreaseFont_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A2A72034C_4C8A29700261test_var*
//#UC END# *4C8A2A72034C_4C8A29700261test_var*
begin
//#UC START# *4C8A2A72034C_4C8A29700261test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanChangeDefaultFontSize(False);
//#UC END# *4C8A2A72034C_4C8A29700261test_impl*
end;//TMainOptionsForm.Fonts_DecreaseFont_Test

procedure TMainOptionsForm.Fonts_DecreaseFont_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A2A72034C_4C8A29700261exec_var*
//#UC END# *4C8A2A72034C_4C8A29700261exec_var*
begin
//#UC START# *4C8A2A72034C_4C8A29700261exec_impl*
 ChangeDefaultFontSize(False);
//#UC END# *4C8A2A72034C_4C8A29700261exec_impl*
end;//TMainOptionsForm.Fonts_DecreaseFont_Execute

procedure TMainOptionsForm.Help_HotInformation_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A43B3015E_4C8A29700261test_var*
var
 l_HotInformation: INodeBase;

 function lp_IsAlreadyShow: Boolean;
 {* Да, если на экране форма рубрикатора с горячей информацией. }
 var
  l_Form : IvcmEntityForm;
  l_Node : INodeBase;
 begin
  HasForm(fm_efRubricator.rFormID, vcm_ztParent, True, @l_Form);
  if l_Form <> nil then
   Result := Supports(Op_Rubricator_GetRoot.Call(l_Form), INodeBase, l_Node) and
             l_Node.IsSameNode(l_HotInformation)
  else
   Result := False;
 end;//lp_IsAlreadyShow

//#UC END# *4C8A43B3015E_4C8A29700261test_var*
begin
//#UC START# *4C8A43B3015E_4C8A29700261test_impl*
 l_HotInformation := TnsBaseMainMenuTree.nsFindNavigatorItem(ns_nipHotInformation);
 try
  aParams.Op.Flag[vcm_ofEnabled] := (l_HotInformation <> nil) and
   not lp_IsAlreadyShow;
 finally
  l_HotInformation := nil;
 end;//try..finally
//#UC END# *4C8A43B3015E_4C8A29700261test_impl*
end;//TMainOptionsForm.Help_HotInformation_Test

procedure TMainOptionsForm.Help_HotInformation_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A43B3015E_4C8A29700261exec_var*
var
 l_HotInformation: INodeBase;
//#UC END# *4C8A43B3015E_4C8A29700261exec_var*
begin
//#UC START# *4C8A43B3015E_4C8A29700261exec_impl*
 l_HotInformation := TnsBaseMainMenuTree.nsFindNavigatorItem(ns_nipHotInformation);
 try
  Assert(l_HotInformation <> nil);
  nsOpenNavigatorItem(l_HotInformation, Self, l_HotInformation, nil);
 finally
  l_HotInformation := nil;
 end;//try..finally
//#UC END# *4C8A43B3015E_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_HotInformation_Execute

procedure TMainOptionsForm.Help_HelpShortCuts_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A43C40120_4C8A29700261exec_var*
//#UC END# *4C8A43C40120_4C8A29700261exec_var*
begin
//#UC START# *4C8A43C40120_4C8A29700261exec_impl*
 Application.HelpSystem.ShowTopicHelp(cHelpShortcutPage, '');
//#UC END# *4C8A43C40120_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_HelpShortCuts_Execute

procedure TMainOptionsForm.Help_HelpNewFeatures_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A43E30011_4C8A29700261exec_var*
//#UC END# *4C8A43E30011_4C8A29700261exec_var*
begin
//#UC START# *4C8A43E30011_4C8A29700261exec_impl*
 ShowWhatsNewHelpPage;
//#UC END# *4C8A43E30011_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_HelpNewFeatures_Execute

procedure TMainOptionsForm.Help_ContactInformation_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A43FE01BD_4C8A29700261exec_var*
//#UC END# *4C8A43FE01BD_4C8A29700261exec_var*
begin
//#UC START# *4C8A43FE01BD_4C8A29700261exec_impl*
 Say(inf_AnyInformation, [DefDataAdapter.GetDealerInfo]);
//#UC END# *4C8A43FE01BD_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_ContactInformation_Execute

procedure TMainOptionsForm.Help_ReplyBook_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A440F025D_4C8A29700261exec_var*
//#UC END# *4C8A440F025D_4C8A29700261exec_var*
begin
//#UC START# *4C8A440F025D_4C8A29700261exec_impl*
 nsDoShellExecute(nsCStr(cInternetReplyBook));
//#UC END# *4C8A440F025D_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_ReplyBook_Execute

procedure TMainOptionsForm.Help_GarantInternet_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A4428006F_4C8A29700261test_var*
var
 l_Strings      : IvcmItems;
 l_StringSource : InsStringsSource;
//#UC END# *4C8A4428006F_4C8A29700261test_var*
begin
//#UC START# *4C8A4428006F_4C8A29700261test_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := true;
  l_Strings := Op.SubItems;
  if (l_Strings <> nil) and
     (l_Strings.Count = 0) then
  begin
   if Supports(f_InternetMap, InsStringsSource, l_StringSource) then
    l_StringSource.FillStrings(l_Strings);
   l_Strings.AddOp(TdmStdRes.mod_opcode_Common_LetterToDevelopers);
   g_InternerMapStrings := l_Strings;
  end;//l_Strings <> nil
 end;
//#UC END# *4C8A4428006F_4C8A29700261test_impl*
end;//TMainOptionsForm.Help_GarantInternet_Test

procedure TMainOptionsForm.Help_GarantInternet_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A4428006F_4C8A29700261exec_var*
var
 l_CurOpIndex : Integer;
 l_Container: IvcmContainer;
 l_Maker: IvcmContainerMaker;
//#UC END# *4C8A4428006F_4C8A29700261exec_var*
begin
//#UC START# *4C8A4428006F_4C8A29700261exec_impl*
 l_CurOpIndex := aParams.ItemIndex;
 if (l_CurOpIndex <= 0) then
  Exit
 else
  Dec(l_CurOpIndex);
 // - индекс первого элемента в меню 1, поэтому подкорректируем индекс:
 l_Container := Self As IvcmContainer;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=598934256
 Assert(l_Container <> nil);
 nsDoShellExecute(f_InternetMap.DisplayNameToValue(g_InternerMapStrings.ItemC[l_CurOpIndex]),
  False, l_Container);
//#UC END# *4C8A4428006F_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_GarantInternet_Execute

procedure TMainOptionsForm.Help_About_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A4442036F_4C8A29700261exec_var*
//#UC END# *4C8A4442036F_4C8A29700261exec_var*
begin
//#UC START# *4C8A4442036F_4C8A29700261exec_impl*
 TdmStdRes.About;
//#UC END# *4C8A4442036F_4C8A29700261exec_impl*
end;//TMainOptionsForm.Help_About_Execute

procedure TMainOptionsForm.System_BookmarkList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A44DD0291_4C8A29700261exec_var*
//#UC END# *4C8A44DD0291_4C8A29700261exec_var*
begin
//#UC START# *4C8A44DD0291_4C8A29700261exec_impl*
 TdmStdRes.SelectOpen(Self.As_IvcmEntityForm,
                      TnsFolderFilterInfo.Make(ffBookmark, ns_ffNone),
                      str_OpenBookmark);
//#UC END# *4C8A44DD0291_4C8A29700261exec_impl*
end;//TMainOptionsForm.System_BookmarkList_Execute

procedure TMainOptionsForm.WarnOnControl_BuildControlledList_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Построить список изменившихся документов на контроле }
//#UC START# *4C8A454E0063_4C8A29700261exec_var*
//#UC END# *4C8A454E0063_4C8A29700261exec_var*
begin
//#UC START# *4C8A454E0063_4C8A29700261exec_impl*
 TdmStdRes.BuildUnderControlList((aParams As IvcmExecuteParams).Container);
//#UC END# *4C8A454E0063_4C8A29700261exec_impl*
end;//TMainOptionsForm.WarnOnControl_BuildControlledList_Execute

procedure TMainOptionsForm.WarnOnControl_OpenUnderControlTree_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Открыть вкладку "Документы на контроле" }
//#UC START# *4C8A456A0188_4C8A29700261exec_var*
//#UC END# *4C8A456A0188_4C8A29700261exec_var*
begin
//#UC START# *4C8A456A0188_4C8A29700261exec_impl*
 OpenUnderControl;
//#UC END# *4C8A456A0188_4C8A29700261exec_impl*
end;//TMainOptionsForm.WarnOnControl_OpenUnderControlTree_Execute

procedure TMainOptionsForm.WarnOnControl_HideReminder_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Скрыть предупреждающий знак }
//#UC START# *4C8A4584039B_4C8A29700261exec_var*
//#UC END# *4C8A4584039B_4C8A29700261exec_var*
begin
//#UC START# *4C8A4584039B_4C8A29700261exec_impl*
 f_IsControlledObjectsChanging := False;
//#UC END# *4C8A4584039B_4C8A29700261exec_impl*
end;//TMainOptionsForm.WarnOnControl_HideReminder_Execute

procedure TMainOptionsForm.InitClone(aForm: TvcmMainForm);
//#UC START# *4F7AE85E01EF_4C8A29700261_var*
//#UC END# *4F7AE85E01EF_4C8A29700261_var*
begin
//#UC START# *4F7AE85E01EF_4C8A29700261_impl*
 inherited;
 DoInitContainedForm(aForm);
//#UC END# *4F7AE85E01EF_4C8A29700261_impl*
end;//TMainOptionsForm.InitClone

procedure TMainOptionsForm.vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7AEC7F03CB_4C8A29700261_var*
const
 cBSHeight = 107;
 // - так в dfm написано
//#UC END# *4F7AEC7F03CB_4C8A29700261_var*
begin
//#UC START# *4F7AEC7F03CB_4C8A29700261_impl*
 inherited;
 if aForm.SameName(fm_NewBaseSearchForm.rFormID) then
 begin
  if (aForm.VCLWinControl.Height <= 0) then
  // костыль для http://mdp.garant.ru/pages/viewpage.action?pageId=333552196
  begin
   aForm.VCLWinControl.Parent.Height := cBSHeight;
   aForm.VCLWinControl.Height := cBSHeight;
  end;//aForm.VCLWinControl.Height <= 0
 end;//aForm.SameName(fm_NewBaseSearchForm)
//#UC END# *4F7AEC7F03CB_4C8A29700261_impl*
end;//TMainOptionsForm.vcmMainFormAfterInsertForm

procedure TMainOptionsForm.DropChangeStatusToOpened;
//#UC START# *4F7AED150304_4C8A29700261_var*
//#UC END# *4F7AED150304_4C8A29700261_var*
begin
//#UC START# *4F7AED150304_4C8A29700261_impl*
 inherited;
 TdmStdRes.DropChangeStatusToOpened(Self.as_IvcmEntityForm);
//#UC END# *4F7AED150304_4C8A29700261_impl*
end;//TMainOptionsForm.DropChangeStatusToOpened

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.ReleaseResources;
//#UC START# *538C374A00B7_4C8A29700261_var*
var
 l_RH: IvcmResourceHolder;
//#UC END# *538C374A00B7_4C8A29700261_var*
begin
//#UC START# *538C374A00B7_4C8A29700261_impl*
 inherited;
 if Supports(f_RemindersLine, IvcmResourceHolder, l_RH) then
  l_RH.ReleaseResources;
//#UC END# *538C374A00B7_4C8A29700261_impl*
end;//TMainOptionsForm.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure TMainOptionsForm.DoInitContainedForm(aForm: TvcmMainForm);
//#UC START# *546464260137_4C8A29700261_var*
//#UC END# *546464260137_4C8A29700261_var*
begin
//#UC START# *546464260137_4C8A29700261_impl*
 LoadStartState(vcmMakeParams(nil, aForm, aForm));
//#UC END# *546464260137_4C8A29700261_impl*
end;//TMainOptionsForm.DoInitContainedForm
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TMainOptionsForm.ClearFields;
begin
 f_InternetMap := nil;
 inherited;
end;//TMainOptionsForm.ClearFields

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Fonts, nil);
  PublishFormEntity(en_Help, nil);
  PublishFormEntity(en_System, nil);
  PublishFormEntity(en_WarnOnControl, nil);
  MakeEntitySupportedByControl(en_WarnOnControl, ControlledChangingWarning);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, False);
  PublishOp(en_Fonts, op_IncreaseFont, Fonts_IncreaseFont_Execute, Fonts_IncreaseFont_Test, nil);
  ShowInContextMenu(en_Fonts, op_IncreaseFont, False);
  ShowInToolbar(en_Fonts, op_IncreaseFont, True);
  PublishOp(en_Fonts, op_DecreaseFont, Fonts_DecreaseFont_Execute, Fonts_DecreaseFont_Test, nil);
  ShowInContextMenu(en_Fonts, op_DecreaseFont, False);
  ShowInToolbar(en_Fonts, op_DecreaseFont, True);
  PublishOp(en_Help, op_HotInformation, Help_HotInformation_Execute, Help_HotInformation_Test, nil);
  ShowInContextMenu(en_Help, op_HotInformation, False);
  ShowInToolbar(en_Help, op_HotInformation, False);
  PublishOp(en_Help, op_HelpShortCuts, Help_HelpShortCuts_Execute, nil, nil);
  ShowInContextMenu(en_Help, op_HelpShortCuts, False);
  ShowInToolbar(en_Help, op_HelpShortCuts, False);
  PublishOp(en_Help, op_HelpNewFeatures, Help_HelpNewFeatures_Execute, nil, nil);
  ShowInContextMenu(en_Help, op_HelpNewFeatures, False);
  ShowInToolbar(en_Help, op_HelpNewFeatures, False);
  PublishOp(en_Help, op_ContactInformation, Help_ContactInformation_Execute, nil, nil);
  ShowInContextMenu(en_Help, op_ContactInformation, False);
  ShowInToolbar(en_Help, op_ContactInformation, False);
  PublishOp(en_Help, op_ReplyBook, Help_ReplyBook_Execute, nil, nil);
  ShowInContextMenu(en_Help, op_ReplyBook, False);
  ShowInToolbar(en_Help, op_ReplyBook, False);
  PublishOp(en_Help, op_GarantInternet, Help_GarantInternet_Execute, Help_GarantInternet_Test, nil);
  ShowInContextMenu(en_Help, op_GarantInternet, False);
  ShowInToolbar(en_Help, op_GarantInternet, False);
  PublishOp(en_Help, op_About, Help_About_Execute, nil, nil);
  ShowInContextMenu(en_Help, op_About, False);
  ShowInToolbar(en_Help, op_About, False);
  PublishOp(en_System, op_BookmarkList, System_BookmarkList_Execute, nil, nil);
  ShowInContextMenu(en_System, op_BookmarkList, False);
  ShowInToolbar(en_System, op_BookmarkList, False);
  PublishOp(en_WarnOnControl, op_BuildControlledList, WarnOnControl_BuildControlledList_Execute, nil, nil);
  ShowInContextMenu(en_WarnOnControl, op_BuildControlledList, True);
  ShowInToolbar(en_WarnOnControl, op_BuildControlledList, False);
  PublishOp(en_WarnOnControl, op_OpenUnderControlTree, WarnOnControl_OpenUnderControlTree_Execute, nil, nil);
  ShowInContextMenu(en_WarnOnControl, op_OpenUnderControlTree, True);
  ShowInToolbar(en_WarnOnControl, op_OpenUnderControlTree, False);
  PublishOp(en_WarnOnControl, op_HideReminder, WarnOnControl_HideReminder_Execute, nil, nil);
  ShowInContextMenu(en_WarnOnControl, op_HideReminder, True);
  ShowInToolbar(en_WarnOnControl, op_HideReminder, False);
  ShowInContextMenu(en_History, op_Back, False);
  ShowInToolbar(en_History, op_Back, True);
  ShowInContextMenu(en_History, op_Forward, False);
  ShowInToolbar(en_History, op_Forward, True);
  ShowInContextMenu(en_Common, op_OpenNewWindowByUser, False);
  ShowInToolbar(en_Common, op_OpenNewWindowByUser, False);
  ShowInContextMenu(en_Common, op_GetWindowList, False);
  ShowInToolbar(en_Common, op_GetWindowList, False);
  ShowInContextMenu(en_Common, op_CascadeWindows, False);
  ShowInToolbar(en_Common, op_CascadeWindows, False);
  ShowInContextMenu(en_Common, op_TileWindowsHorizontal, False);
  ShowInToolbar(en_Common, op_TileWindowsHorizontal, False);
  ShowInContextMenu(en_Common, op_TileWindowsVertical, False);
  ShowInToolbar(en_Common, op_TileWindowsVertical, False);
  ShowInContextMenu(en_Common, op_CloseAllWindows, False);
  ShowInToolbar(en_Common, op_CloseAllWindows, False);
 end;//with Entities.Entities
end;//TMainOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.MakeControls;
begin
 inherited;
 f_RemindersLine := TnscRemindersLine.Create(Self);
 f_RemindersLine.Name := 'RemindersLine';
 f_RemindersLine.Parent := Self;
 f_ControlledChangingWarning := TnscReminder.Create(RemindersLine);
 f_ControlledChangingWarning.Name := 'ControlledChangingWarning';
 f_remUnreadConsultations := TnscReminder.Create(RemindersLine);
 f_remUnreadConsultations.Name := 'remUnreadConsultations';
end;//TMainOptionsForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
//#UC START# *4C8A47F102D1*
//#UC END# *4C8A47F102D1*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainOptionsForm);
 {* Регистрация MainOptions }
{$IfEnd} // NOT Defined(NoScripts)

finalization
//#UC START# *4C8A47FA036C*
 g_InternerMapStrings := nil;
//#UC END# *4C8A47FA036C*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
