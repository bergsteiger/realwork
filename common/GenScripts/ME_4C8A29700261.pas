unit MainOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainOptions_Form.pas"
// Стереотип: "VCMMainForm"

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
    {* Поле для свойства RemindersLine }
   f_ControlledChangingWarning: TnscReminder;
    {* Поле для свойства ControlledChangingWarning }
   f_remUnreadConsultations: TnscReminder;
    {* Поле для свойства remUnreadConsultations }
   f_IsRemUnreadConsultationsVisible: Boolean;
    {* Поле для свойства IsRemUnreadConsultationsVisible }
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
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure DoInitContainedForm(aForm: TvcmMainForm); override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure IncreaseFont; override;
   procedure DecreaseFont; override;
   procedure HotInformation; override;
   procedure HelpShortCuts; override;
   procedure HelpNewFeatures; override;
   procedure ContactInformation; override;
   procedure ReplyBook; override;
   procedure GarantInternet; override;
   procedure About; override;
   procedure BookmarkList; override;
   procedure BuildControlledList; override;
    {* Построить список изменившихся документов на контроле }
   procedure OpenUnderControlTree; override;
    {* Открыть вкладку "Документы на контроле" }
   procedure HideReminder; override;
    {* Скрыть предупреждающий знак }
   {$If NOT Defined(NoVCM)}
   procedure Back; override;
    {* Назад }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Forward; override;
    {* Вперёд }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OpenNewWindowByUser; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure GetWindowList; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CascadeWindows; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure TileWindowsHorizontal; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure TileWindowsVertical; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CloseAllWindows; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property IsRemUnreadConsultationsVisible: Boolean
    read f_IsRemUnreadConsultationsVisible
    write f_IsRemUnreadConsultationsVisible;
  public
   property RemindersLine: TnscRemindersLine
    read f_RemindersLine;
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
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
procedure TMainOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C8A29700261_var*
//#UC END# *4C762C910358_4C8A29700261_var*
begin
//#UC START# *4C762C910358_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C8A29700261_impl*
end;//TMainOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TMainOptionsForm.IncreaseFont;
//#UC START# *4C8A2A5C03E4_4C8A29700261_var*
//#UC END# *4C8A2A5C03E4_4C8A29700261_var*
begin
//#UC START# *4C8A2A5C03E4_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A2A5C03E4_4C8A29700261_impl*
end;//TMainOptionsForm.IncreaseFont

procedure TMainOptionsForm.DecreaseFont;
//#UC START# *4C8A2A72034C_4C8A29700261_var*
//#UC END# *4C8A2A72034C_4C8A29700261_var*
begin
//#UC START# *4C8A2A72034C_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A2A72034C_4C8A29700261_impl*
end;//TMainOptionsForm.DecreaseFont

procedure TMainOptionsForm.HotInformation;
//#UC START# *4C8A43B3015E_4C8A29700261_var*
//#UC END# *4C8A43B3015E_4C8A29700261_var*
begin
//#UC START# *4C8A43B3015E_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43B3015E_4C8A29700261_impl*
end;//TMainOptionsForm.HotInformation

procedure TMainOptionsForm.HelpShortCuts;
//#UC START# *4C8A43C40120_4C8A29700261_var*
//#UC END# *4C8A43C40120_4C8A29700261_var*
begin
//#UC START# *4C8A43C40120_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43C40120_4C8A29700261_impl*
end;//TMainOptionsForm.HelpShortCuts

procedure TMainOptionsForm.HelpNewFeatures;
//#UC START# *4C8A43E30011_4C8A29700261_var*
//#UC END# *4C8A43E30011_4C8A29700261_var*
begin
//#UC START# *4C8A43E30011_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43E30011_4C8A29700261_impl*
end;//TMainOptionsForm.HelpNewFeatures

procedure TMainOptionsForm.ContactInformation;
//#UC START# *4C8A43FE01BD_4C8A29700261_var*
//#UC END# *4C8A43FE01BD_4C8A29700261_var*
begin
//#UC START# *4C8A43FE01BD_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A43FE01BD_4C8A29700261_impl*
end;//TMainOptionsForm.ContactInformation

procedure TMainOptionsForm.ReplyBook;
//#UC START# *4C8A440F025D_4C8A29700261_var*
//#UC END# *4C8A440F025D_4C8A29700261_var*
begin
//#UC START# *4C8A440F025D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A440F025D_4C8A29700261_impl*
end;//TMainOptionsForm.ReplyBook

procedure TMainOptionsForm.GarantInternet;
//#UC START# *4C8A4428006F_4C8A29700261_var*
//#UC END# *4C8A4428006F_4C8A29700261_var*
begin
//#UC START# *4C8A4428006F_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4428006F_4C8A29700261_impl*
end;//TMainOptionsForm.GarantInternet

procedure TMainOptionsForm.About;
//#UC START# *4C8A4442036F_4C8A29700261_var*
//#UC END# *4C8A4442036F_4C8A29700261_var*
begin
//#UC START# *4C8A4442036F_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4442036F_4C8A29700261_impl*
end;//TMainOptionsForm.About

procedure TMainOptionsForm.BookmarkList;
//#UC START# *4C8A44DD0291_4C8A29700261_var*
//#UC END# *4C8A44DD0291_4C8A29700261_var*
begin
//#UC START# *4C8A44DD0291_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A44DD0291_4C8A29700261_impl*
end;//TMainOptionsForm.BookmarkList

procedure TMainOptionsForm.BuildControlledList;
 {* Построить список изменившихся документов на контроле }
//#UC START# *4C8A454E0063_4C8A29700261_var*
//#UC END# *4C8A454E0063_4C8A29700261_var*
begin
//#UC START# *4C8A454E0063_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A454E0063_4C8A29700261_impl*
end;//TMainOptionsForm.BuildControlledList

procedure TMainOptionsForm.OpenUnderControlTree;
 {* Открыть вкладку "Документы на контроле" }
//#UC START# *4C8A456A0188_4C8A29700261_var*
//#UC END# *4C8A456A0188_4C8A29700261_var*
begin
//#UC START# *4C8A456A0188_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A456A0188_4C8A29700261_impl*
end;//TMainOptionsForm.OpenUnderControlTree

procedure TMainOptionsForm.HideReminder;
 {* Скрыть предупреждающий знак }
//#UC START# *4C8A4584039B_4C8A29700261_var*
//#UC END# *4C8A4584039B_4C8A29700261_var*
begin
//#UC START# *4C8A4584039B_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A4584039B_4C8A29700261_impl*
end;//TMainOptionsForm.HideReminder

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Back;
 {* Назад }
//#UC START# *4ADDDC550118_4C8A29700261_var*
//#UC END# *4ADDDC550118_4C8A29700261_var*
begin
//#UC START# *4ADDDC550118_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC550118_4C8A29700261_impl*
end;//TMainOptionsForm.Back
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.Forward;
 {* Вперёд }
//#UC START# *4ADDDC630097_4C8A29700261_var*
//#UC END# *4ADDDC630097_4C8A29700261_var*
begin
//#UC START# *4ADDDC630097_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDDC630097_4C8A29700261_impl*
end;//TMainOptionsForm.Forward
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.OpenNewWindowByUser;
//#UC START# *4C8A30B60087_4C8A29700261_var*
//#UC END# *4C8A30B60087_4C8A29700261_var*
begin
//#UC START# *4C8A30B60087_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30B60087_4C8A29700261_impl*
end;//TMainOptionsForm.OpenNewWindowByUser
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.GetWindowList;
//#UC START# *4C8A30DB001D_4C8A29700261_var*
//#UC END# *4C8A30DB001D_4C8A29700261_var*
begin
//#UC START# *4C8A30DB001D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30DB001D_4C8A29700261_impl*
end;//TMainOptionsForm.GetWindowList
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.CascadeWindows;
//#UC START# *4C8A30F30115_4C8A29700261_var*
//#UC END# *4C8A30F30115_4C8A29700261_var*
begin
//#UC START# *4C8A30F30115_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A30F30115_4C8A29700261_impl*
end;//TMainOptionsForm.CascadeWindows
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.TileWindowsHorizontal;
//#UC START# *4C8A3114001E_4C8A29700261_var*
//#UC END# *4C8A3114001E_4C8A29700261_var*
begin
//#UC START# *4C8A3114001E_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A3114001E_4C8A29700261_impl*
end;//TMainOptionsForm.TileWindowsHorizontal
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.TileWindowsVertical;
//#UC START# *4C8A312F018D_4C8A29700261_var*
//#UC END# *4C8A312F018D_4C8A29700261_var*
begin
//#UC START# *4C8A312F018D_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A312F018D_4C8A29700261_impl*
end;//TMainOptionsForm.TileWindowsVertical
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TMainOptionsForm.CloseAllWindows;
//#UC START# *4C8A31770143_4C8A29700261_var*
//#UC END# *4C8A31770143_4C8A29700261_var*
begin
//#UC START# *4C8A31770143_4C8A29700261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8A31770143_4C8A29700261_impl*
end;//TMainOptionsForm.CloseAllWindows
{$IfEnd} // NOT Defined(NoVCM)

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

procedure TMainOptionsForm.ClearFields;
begin
 f_InternetMap := nil;
 inherited;
end;//TMainOptionsForm.ClearFields

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
