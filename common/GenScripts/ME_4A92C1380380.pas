unit PrimF1Common_Module;
 {* "Общий" только для F1 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\PrimF1Common_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , SearchInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 , l3PrinterInterfaces
 , DynamicTreeUnit
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 , UnderControlUnit
 , DocumentUnit
 , AdapterFacade
 , PresentationInterfaces
 , PrimRememberPassword_Form
 , l3StringIDEx
 , PrimProgressIndicator_Form
 , PrimEULA_Form
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtGroupBox
 , vtButton
 , PrimCompInfo_Form
 , Common_FormDefinitions_Controls
 , PrimRegistration_Form
 , PrimTasksPanel_Form
 , PrimNavigatorOptions_Form
 , PrimTurnOffTimeMachineOptions_Form
;

const
 fm_RememberPasswordForm: TvcmFormDescriptor = (rFormID : (rName : 'RememberPasswordForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TRememberPasswordForm }

const
 fm_efProgressIndicator: TvcmFormDescriptor = (rFormID : (rName : 'efProgressIndicator'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefProgressIndicator }

const
 fm_efEULA: TvcmFormDescriptor = (rFormID : (rName : 'efEULA'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefEULA }

const
 fm_efAbout: TvcmFormDescriptor = (rFormID : (rName : 'efAbout'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefAbout }

const
 fm_nsRegistrationForm: TvcmFormDescriptor = (rFormID : (rName : 'nsRegistrationForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TnsRegistrationForm }

const
 fm_en_TurnOffTimeMachine: TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOffTimeMachine'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_TurnOffTimeMachine }

type
 RememberPasswordFormDef = interface
  {* Идентификатор формы RememberPassword }
  ['{332C1743-EA95-4386-9F6E-677BF58FAE7D}']
 end;//RememberPasswordFormDef

 TRememberPasswordForm = {final} class(TPrimRememberPasswordForm, RememberPasswordFormDef)
  {* Забыли пароль? }
 end;//TRememberPasswordForm

 ProgressIndicatorFormDef = interface
  {* Идентификатор формы ProgressIndicator }
  ['{83193317-8438-475F-9F0C-1C44F08B2DA4}']
 end;//ProgressIndicatorFormDef

 TefProgressIndicator = {final} class(TPrimProgressIndicatorForm, ProgressIndicatorFormDef)
 end;//TefProgressIndicator

 EULAFormDef = interface
  {* Идентификатор формы EULA }
  ['{DF5FBE77-74EC-44AD-8636-CBFDE4947FC7}']
 end;//EULAFormDef

 TefEULA = {final} class(TPrimEULAForm, EULAFormDef)
  {* Условия использования }
 end;//TefEULA

 AboutFormDef = interface
  {* Идентификатор формы About }
  ['{F678B4F8-60D5-4B4F-AE77-F61D6A29D2F9}']
 end;//AboutFormDef

 TefAbout = {final} class(AboutFormDef)
  {* О программе }
  private
   f_pbLogo: TPaintBox;
    {* Поле для свойства pbLogo }
   f_ShellInfoLabel: TvtLabel;
    {* Поле для свойства ShellInfoLabel }
   f_AdapterInfoLabel: TvtLabel;
    {* Поле для свойства AdapterInfoLabel }
   f_UserCountLabel: TvtLabel;
    {* Поле для свойства UserCountLabel }
   f_OwnerLabel: TvtLabel;
    {* Поле для свойства OwnerLabel }
   f_ShellCaptionLabel: TvtLabel;
    {* Поле для свойства ShellCaptionLabel }
   f_OwnerCaptionLabel: TvtLabel;
    {* Поле для свойства OwnerCaptionLabel }
   f_UserInfoGroupBox: TvtGroupBox;
    {* Поле для свойства UserInfoGroupBox }
   f_EMailCaptionLabel: TvtLabel;
    {* Поле для свойства EMailCaptionLabel }
   f_EMailLabel: TvtLabel;
    {* Поле для свойства EMailLabel }
   f_LoginCaptionLabel: TvtLabel;
    {* Поле для свойства LoginCaptionLabel }
   f_UserCaptionLabel: TvtLabel;
    {* Поле для свойства UserCaptionLabel }
   f_UserNameLabel: TvtLabel;
    {* Поле для свойства UserNameLabel }
   f_LoginLabel: TvtLabel;
    {* Поле для свойства LoginLabel }
   f_CopyrightCaptionLabel: TvtLabel;
    {* Поле для свойства CopyrightCaptionLabel }
   f_OkButton: TvtButton;
    {* Поле для свойства OkButton }
   f_UserCountCaptionLabel: TvtLabel;
    {* Поле для свойства UserCountCaptionLabel }
   f_AdapterCaptionLabel: TvtLabel;
    {* Поле для свойства AdapterCaptionLabel }
  private
   procedure UpdateInfoOnForm;
   procedure GetCurrentUserInfo;
   procedure GetCurrentOwnerInfo;
   procedure pbLogoPaint(Sender: TObject);
  protected
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property pbLogo: TPaintBox
    read f_pbLogo;
   property ShellInfoLabel: TvtLabel
    read f_ShellInfoLabel;
   property AdapterInfoLabel: TvtLabel
    read f_AdapterInfoLabel;
   property UserCountLabel: TvtLabel
    read f_UserCountLabel;
   property OwnerLabel: TvtLabel
    read f_OwnerLabel;
   property ShellCaptionLabel: TvtLabel
    read f_ShellCaptionLabel;
    {* Версия }
   property OwnerCaptionLabel: TvtLabel
    read f_OwnerCaptionLabel;
    {* Зарегистрированный пользователь копии }
   property UserInfoGroupBox: TvtGroupBox
    read f_UserInfoGroupBox;
    {* Учетная запись }
   property CopyrightCaptionLabel: TvtLabel
    read f_CopyrightCaptionLabel;
    {* (C) ООО НПП "ГАРАНТ-СЕРВИС-УНИВЕРСИТЕТ", 1990-2016 }
   property OkButton: TvtButton
    read f_OkButton;
   property UserCountCaptionLabel: TvtLabel
    read f_UserCountCaptionLabel;
   property AdapterCaptionLabel: TvtLabel
    read f_AdapterCaptionLabel;
 end;//TefAbout

 TenCompInfo = {final} class(TPrimCompInfoForm, CompInfoFormDef)
  {* Информация о комплекте }
 end;//TenCompInfo

 RegistrationFormFormDef = interface
  {* Идентификатор формы RegistrationForm }
  ['{1C7CFA67-8415-4312-BA10-BF18AAF522CF}']
 end;//RegistrationFormFormDef

 TnsRegistrationForm = {final} class(TPrimRegistrationForm, RegistrationFormFormDef)
  {* Регистрация }
 end;//TnsRegistrationForm

 Ten_TasksPanel = {final} class(TPrimTasksPanelForm, TasksPanelFormDef)
  {* Панель задач }
 end;//Ten_TasksPanel

 Ten_Navigator = {final} class(TPrimNavigatorOptionsForm, NavigatorFormDef)
  {* Меню }
 end;//Ten_Navigator

 TurnOffTimeMachineFormDef = interface
  {* Идентификатор формы TurnOffTimeMachine }
  ['{3FDF45B7-4023-4D87-A4CB-A153EBA91B78}']
 end;//TurnOffTimeMachineFormDef

 Ten_TurnOffTimeMachine = {final} class(TPrimTurnOffTimeMachineOptionsForm, TurnOffTimeMachineFormDef)
  {* Выключить Машину времени / Изменить дату }
 end;//Ten_TurnOffTimeMachine

 TPrimF1CommonModule = {abstract} class
  {* "Общий" только для F1 }
  protected
   procedure ComplectInfo;
    {* Информация о комплекте }
   procedure PageSetup;
    {* Настройка страницы... }
   procedure ShowEULA;
    {* Условия использования }
   function GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
   procedure SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
    aType: TNavigatorMenuItemType);
   procedure OpenMainMenuByButton;
    {* Основное меню системы ГАРАНТ }
   procedure OpenMainMenuNew;
    {* Основное меню }
   procedure TasksPanel;
    {* Панель задач }
   procedure LetterToDevelopers;
    {* Письмо разработчикам }
   procedure OpenRubricator;
    {* Правовой навигатор }
   procedure OpenInformation;
    {* Справочная информация }
   procedure get_navigator;
    {* Меню (вкладка) }
   procedure OpenIntranet;
  public
   procedure MakeProgressIndicator(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer);
   procedure CloseNavigator(const aContainer: IvcmContainer);
   procedure CloseTasksPanel(const aContainer: IvcmContainer);
   procedure FromPrinterSettings(const aPrinter: Il3Printer);
    {* Считать настройки из принтера }
   procedure ToPrinterSettings(const aPrinter: Il3Printer);
    {* Записать настройки в принтер }
   procedure About;
    {* Выводит диалог "О программе" }
   procedure ApplicationActivate;
   procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   procedure OpenNewDocs(const aContainer: IvcmContainer);
   procedure GetNavigator(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
    {* Меню (вкладка) }
   procedure OpenTasksPanel(const aContainer: IvcmContainer);
   procedure AddDocumentToControl(const aDocument: IDocument);
    {* Поставить документ на контроль }
   procedure AddToControl(const aControllable: IControllable);
    {* Поставить объект на контроль }
   procedure DeleteDocumentFromControl(const aDocument: IDocument);
    {* Снять документ с контроля }
   procedure DeleteFromControl(const aControllable: IControllable);
    {* Снять объект с контроля }
   function IsUnderControl(const aDoc: IDocument): Boolean;
    {* Находится ли документ на контроле }
   function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   procedure OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine);
 end;//TPrimF1CommonModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Search_Strange_Controls
 , Common_Rubricator_Controls
 , PrimTasksPanel_tpMain_UserType
 , NavigatorUtils
 , GblAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , RememberPasswordKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ProgressIndicatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , EULAKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , StartUnit
 , l3String
 , vtVerInf
 , DataAdapter
 , ComplectUnit
 , IOUnit
 , nsTypes
 , nsUtils
 , l3MinMax
 , vtDialogsRes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SecurityUnit
 {$If NOT Defined(NoScripts)}
 , AboutKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CompInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RegistrationFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TasksPanelKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , NavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TurnOffTimeMachineKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , afwFacade
 , nsPageSetup
 , nsNewCachableNode
 , nsNodes
 , SysUtils
 , nsExternalObjectPrim
 , bsUtils
 , l3Base
 , nsConst
;

const
 {* Локализуемые строки ut_RememberPasswordLocalConstants }
 str_ut_RememberPasswordCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RememberPasswordCaption'; rValue : 'Забыли пароль?');
  {* Заголовок пользовательского типа "Забыли пароль?" }

const
 {* Локализуемые строки ut_EULALocalConstants }
 str_ut_EULACaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : 'Условия использования');
  {* Заголовок пользовательского типа "Условия использования" }

const
 {* Локализуемые строки ut_AboutLocalConstants }
 str_ut_AboutCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_AboutCaption'; rValue : 'О программе');
  {* Заголовок пользовательского типа "О программе" }

const
 {* Локализуемые строки ut_CompInfoLocalConstants }
 str_ut_CompInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CompInfoCaption'; rValue : 'Информация о комплекте');
  {* Заголовок пользовательского типа "Информация о комплекте" }

const
 {* Локализуемые строки ut_RegistrationFormLocalConstants }
 str_ut_RegistrationFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RegistrationFormCaption'; rValue : 'Регистрация');
  {* Заголовок пользовательского типа "Регистрация" }

const
 {* Локализуемые строки ut_TurnOffTimeMachineLocalConstants }
 str_ut_TurnOffTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOffTimeMachineCaption'; rValue : 'Выключить Машину времени / Изменить дату');
  {* Заголовок пользовательского типа "Выключить Машину времени / Изменить дату" }

procedure TefAbout.UpdateInfoOnForm;
//#UC START# *5006D2A60192_4ABB6F3F001B_var*
//#UC END# *5006D2A60192_4ABB6F3F001B_var*
begin
//#UC START# *5006D2A60192_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006D2A60192_4ABB6F3F001B_impl*
end;//TefAbout.UpdateInfoOnForm

procedure TefAbout.GetCurrentUserInfo;
//#UC START# *5006D2BC03C1_4ABB6F3F001B_var*
//#UC END# *5006D2BC03C1_4ABB6F3F001B_var*
begin
//#UC START# *5006D2BC03C1_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006D2BC03C1_4ABB6F3F001B_impl*
end;//TefAbout.GetCurrentUserInfo

procedure TefAbout.GetCurrentOwnerInfo;
//#UC START# *5006D2D20048_4ABB6F3F001B_var*
//#UC END# *5006D2D20048_4ABB6F3F001B_var*
begin
//#UC START# *5006D2D20048_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006D2D20048_4ABB6F3F001B_impl*
end;//TefAbout.GetCurrentOwnerInfo

procedure TefAbout.pbLogoPaint(Sender: TObject);
//#UC START# *5006D77F038F_4ABB6F3F001B_var*
//#UC END# *5006D77F038F_4ABB6F3F001B_var*
begin
//#UC START# *5006D77F038F_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006D77F038F_4ABB6F3F001B_impl*
end;//TefAbout.pbLogoPaint

procedure TefAbout.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4ABB6F3F001B_var*
//#UC END# *47EA4E9002C6_4ABB6F3F001B_var*
begin
//#UC START# *47EA4E9002C6_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47EA4E9002C6_4ABB6F3F001B_impl*
end;//TefAbout.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TefAbout.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4ABB6F3F001B_var*
//#UC END# *4A8E8F2E0195_4ABB6F3F001B_var*
begin
//#UC START# *4A8E8F2E0195_4ABB6F3F001B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E8F2E0195_4ABB6F3F001B_impl*
end;//TefAbout.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimF1CommonModule.MakeProgressIndicator(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer);
//#UC START# *4A93F1F200B0_4A92C1380380_var*
//#UC END# *4A93F1F200B0_4A92C1380380_var*
begin
//#UC START# *4A93F1F200B0_4A92C1380380_impl*
 Result := TefProgressIndicator.Make(aProgress, aCaption, aMaxCount);
 try
  Assert((Result <> nil) AND (Result.VCLWinControl <> nil));
  Result.VCLWinControl.Repaint;
  // иначе не отрисовывается кнопка на форме прогресс бара
  {$IfDef InsiderTest}
  Inc((Result.VCLWinControl As TvcmEntityForm).g_AllowModal);
  try
  {$EndIf InsiderTest}
   Result.ShowModal;
   afw.ProcessMessages; //http://mdp.garant.ru/pages/viewpage.action?pageId=564992569
  {$IfDef InsiderTest}
  finally
   Dec((Result.VCLWinControl As TvcmEntityForm).g_AllowModal);
  end;//try..finally
  {$EndIf InsiderTest}
 except
  Result := nil;
 end;//try..except
//#UC END# *4A93F1F200B0_4A92C1380380_impl*
end;//TPrimF1CommonModule.MakeProgressIndicator

procedure TPrimF1CommonModule.CloseNavigator(const aContainer: IvcmContainer);
//#UC START# *4AAFCA2D03D0_4A92C1380380_var*
//#UC END# *4AAFCA2D03D0_4A92C1380380_var*
begin
//#UC START# *4AAFCA2D03D0_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_Navigator.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCA2D03D0_4A92C1380380_impl*
end;//TPrimF1CommonModule.CloseNavigator

procedure TPrimF1CommonModule.CloseTasksPanel(const aContainer: IvcmContainer);
//#UC START# *4AAFCCD00301_4A92C1380380_var*
//#UC END# *4AAFCCD00301_4A92C1380380_var*
begin
//#UC START# *4AAFCCD00301_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_TasksPanel.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCCD00301_4A92C1380380_impl*
end;//TPrimF1CommonModule.CloseTasksPanel

procedure TPrimF1CommonModule.FromPrinterSettings(const aPrinter: Il3Printer);
 {* Считать настройки из принтера }
//#UC START# *4ABB68C603CE_4A92C1380380_var*
//#UC END# *4ABB68C603CE_4A92C1380380_var*
begin
//#UC START# *4ABB68C603CE_4A92C1380380_impl*
 l_PageSetup := TnsPageSetup.Make(nil, aPrinter);
 try
  if l_PageSetup.LoadPageFormatFromPrinter then
   if l_PageSetup.Modified then
    l_PageSetup.SavePageFormatToSettings;
 finally
  l_PageSetup := nil;
 end;//try..finally
//#UC END# *4ABB68C603CE_4A92C1380380_impl*
end;//TPrimF1CommonModule.FromPrinterSettings

procedure TPrimF1CommonModule.ToPrinterSettings(const aPrinter: Il3Printer);
 {* Записать настройки в принтер }
//#UC START# *4ABB691803C2_4A92C1380380_var*
//#UC END# *4ABB691803C2_4A92C1380380_var*
begin
//#UC START# *4ABB691803C2_4A92C1380380_impl*
 l_PageSetup := TnsPageSetup.Make(nil, aPrinter);
 try
  l_PageSetup.SaveToPrinter;
 finally
  l_PageSetup := nil;
 end;//try..finally
//#UC END# *4ABB691803C2_4A92C1380380_impl*
end;//TPrimF1CommonModule.ToPrinterSettings

procedure TPrimF1CommonModule.About;
 {* Выводит диалог "О программе" }
//#UC START# *4ABB6F5D0397_4A92C1380380_var*
//#UC END# *4ABB6F5D0397_4A92C1380380_var*
begin
//#UC START# *4ABB6F5D0397_4A92C1380380_impl*
 TefAbout.Make(vcmMakeParams);
//#UC END# *4ABB6F5D0397_4A92C1380380_impl*
end;//TPrimF1CommonModule.About

procedure TPrimF1CommonModule.ApplicationActivate;
//#UC START# *4ABB74D80287_4A92C1380380_var*
//#UC END# *4ABB74D80287_4A92C1380380_var*
begin
//#UC START# *4ABB74D80287_4A92C1380380_impl*
 op_PrintParams_UpdatePrinter.Broadcast;
//#UC END# *4ABB74D80287_4A92C1380380_impl*
end;//TPrimF1CommonModule.ApplicationActivate

procedure TPrimF1CommonModule.ComplectInfo;
 {* Информация о комплекте }
//#UC START# *4ABB7615007A_4A92C1380380_var*
//#UC END# *4ABB7615007A_4A92C1380380_var*
begin
//#UC START# *4ABB7615007A_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB7615007A_4A92C1380380_impl*
end;//TPrimF1CommonModule.ComplectInfo

procedure TPrimF1CommonModule.PageSetup;
 {* Настройка страницы... }
//#UC START# *4ABB76520183_4A92C1380380_var*
//#UC END# *4ABB76520183_4A92C1380380_var*
begin
//#UC START# *4ABB76520183_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB76520183_4A92C1380380_impl*
end;//TPrimF1CommonModule.PageSetup

procedure TPrimF1CommonModule.ShowEULA;
 {* Условия использования }
//#UC START# *4ABB792C0164_4A92C1380380_var*
//#UC END# *4ABB792C0164_4A92C1380380_var*
begin
//#UC START# *4ABB792C0164_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB792C0164_4A92C1380380_impl*
end;//TPrimF1CommonModule.ShowEULA

function TPrimF1CommonModule.GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
//#UC START# *4ABB884103D3_4A92C1380380_var*
//#UC END# *4ABB884103D3_4A92C1380380_var*
begin
//#UC START# *4ABB884103D3_4A92C1380380_impl*
 Result := nil;
 l_Root := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MainMenu_NodeClass));
 try
  l_Root.GetFirstChild(l_Child);
  while l_Child <> nil do
  begin
   if TNavigatorMenuItemType(l_Child.GetType) = aType then
   begin
    Result := l_Child;
    break;
   end;

   l_Child.GetNext(l_Node);
   l_Child := l_Node;
  end;

 finally
  l_Root := nil;
 end;
//#UC END# *4ABB884103D3_4A92C1380380_impl*
end;//TPrimF1CommonModule.GetMenuTypedItem

procedure TPrimF1CommonModule.SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
 aType: TNavigatorMenuItemType);
//#UC START# *4ABB8A470126_4A92C1380380_var*
//#UC END# *4ABB8A470126_4A92C1380380_var*
begin
//#UC START# *4ABB8A470126_4A92C1380380_impl*
 if not (aType in defDataAdapter.MenuTypeCache) then
  with aParams do
  begin
   Op.Flag[vcm_ofEnabled] := true;
   defDataAdapter.MenuTypeCache := defDataAdapter.MenuTypeCache + [aType];
   l_List := Op.SubNodes;
   if (l_List <> nil) then
    with l_List do
    begin
     ShowRoot := False;
     l_List.Clear;
     l_AdapterNode := GetMenuTypedItem(aType);
     if (l_AdapterNode = nil) then
      Op.Flag[vcm_ofEnabled] := False
     else
     begin
      l_Node := TnsNewCachableNode.Make(l_AdapterNode);
      if l_Node <> nil then
       try
        nsMakeTreeLevel(l_Node, l_AdapterNode);
        Add(l_Node);
       finally
        l_Node := nil;
       end;//try..finally
     end;//l_AdapterNode = nil
    end;//with l_List
  end;//with aParams
//#UC END# *4ABB8A470126_4A92C1380380_impl*
end;//TPrimF1CommonModule.SetParamsForNavigatorElements

procedure TPrimF1CommonModule.OpenRubricatorOnStart(const aContainer: IvcmContainer);
//#UC START# *4ABB8D6B0041_4A92C1380380_var*
//#UC END# *4ABB8D6B0041_4A92C1380380_var*
begin
//#UC START# *4ABB8D6B0041_4A92C1380380_impl*
 l_Node := GetMenuTypedItem(NM_LAW_NAVIGATOR_FOLDER);
 if (l_Node <> nil) then
 begin
  l_Node.GetFirstChild(l_Child);
  if l_Child <> nil then
   TdmStdRes.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABB8D6B0041_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenRubricatorOnStart

procedure TPrimF1CommonModule.OpenNewDocs(const aContainer: IvcmContainer);
//#UC START# *4ABBA74F03DA_4A92C1380380_var*
//#UC END# *4ABBA74F03DA_4A92C1380380_var*
begin
//#UC START# *4ABBA74F03DA_4A92C1380380_impl*
 l_Node := GetMenuTypedItem(NM_BUSINESS_INFO_FOLDER);
 if (l_Node <> nil) then
 begin
  l_Node.GetFirstChild(l_Child);
  while (l_Child <> nil) do
  begin
   if (TNavigatorMenuItemType(l_Child.GetType) = NM_NEW_DOCS) then
    break;
   l_Child.GetNext(l_Node);
   l_Child := l_Node;
  end;//l_Child <> nil
  if (l_Child <> nil) then
   TdmStdRes.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABBA74F03DA_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenNewDocs

procedure TPrimF1CommonModule.OpenMainMenuByButton;
 {* Основное меню системы ГАРАНТ }
//#UC START# *4ABBAAE40176_4A92C1380380_var*
//#UC END# *4ABBAAE40176_4A92C1380380_var*
begin
//#UC START# *4ABBAAE40176_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAAE40176_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenMainMenuByButton

procedure TPrimF1CommonModule.OpenMainMenuNew;
 {* Основное меню }
//#UC START# *4ABBAB14034B_4A92C1380380_var*
//#UC END# *4ABBAB14034B_4A92C1380380_var*
begin
//#UC START# *4ABBAB14034B_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAB14034B_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenMainMenuNew

procedure TPrimF1CommonModule.TasksPanel;
 {* Панель задач }
//#UC START# *4ABBAC7D003B_4A92C1380380_var*
//#UC END# *4ABBAC7D003B_4A92C1380380_var*
begin
//#UC START# *4ABBAC7D003B_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAC7D003B_4A92C1380380_impl*
end;//TPrimF1CommonModule.TasksPanel

procedure TPrimF1CommonModule.LetterToDevelopers;
 {* Письмо разработчикам }
//#UC START# *4ABBB19B030A_4A92C1380380_var*
//#UC END# *4ABBB19B030A_4A92C1380380_var*
begin
//#UC START# *4ABBB19B030A_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBB19B030A_4A92C1380380_impl*
end;//TPrimF1CommonModule.LetterToDevelopers

procedure TPrimF1CommonModule.OpenRubricator;
 {* Правовой навигатор }
//#UC START# *4ABC827B010F_4A92C1380380_var*
//#UC END# *4ABC827B010F_4A92C1380380_var*
begin
//#UC START# *4ABC827B010F_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABC827B010F_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenRubricator

procedure TPrimF1CommonModule.OpenInformation;
 {* Справочная информация }
//#UC START# *4ABC82A70238_4A92C1380380_var*
//#UC END# *4ABC82A70238_4A92C1380380_var*
begin
//#UC START# *4ABC82A70238_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABC82A70238_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenInformation

procedure TPrimF1CommonModule.GetNavigator(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
 {* Меню (вкладка) }
//#UC START# *4ABCA68B0155_4A92C1380380_var*
//#UC END# *4ABCA68B0155_4A92C1380380_var*
begin
//#UC START# *4ABCA68B0155_4A92C1380380_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  if CheckContainer(aContainer).NativeMainForm.HasForm(fm_efRubricator.rFormID,
                                                       vcm_ztParent,
                                                       True,
                                                       @l_RubList) then
  begin
   l_Aggregate := l_RubList.Aggregate;
   if (l_Aggregate = nil) then
   begin
    l_RubList.MakeAggregate;
    l_Aggregate := l_RubList.Aggregate;
   end;//l_Aggregate = nil
   l_Params := vcmSetAggregate(l_Aggregate,
                               vcmMakeParams(l_Aggregate,
                                         CheckContainer(aContainer)));   
  end//CheckContainer(aContainer).NativeMainForm.HasForm..
  else
   l_Params := vcmCheckAggregate(vcmMakeParams(anAggregate,
                                           CheckContainer(aContainer)));
  l_Navigator := Ten_Navigator.MakeSingleChild(l_Params.Container.NativeMainForm,
                                               l_Params,
                                               vcm_ztNavigator);
  afw.ProcessMessages;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=566789558
  l_Navigator.SetActiveInParent;
 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally
 op_Rubricator_Synchronize.Call(l_RubList);
//#UC END# *4ABCA68B0155_4A92C1380380_impl*
end;//TPrimF1CommonModule.GetNavigator

procedure TPrimF1CommonModule.get_navigator;
 {* Меню (вкладка) }
//#UC START# *4AC0FBFE0095_4A92C1380380_var*
//#UC END# *4AC0FBFE0095_4A92C1380380_var*
begin
//#UC START# *4AC0FBFE0095_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC0FBFE0095_4A92C1380380_impl*
end;//TPrimF1CommonModule.get_navigator

procedure TPrimF1CommonModule.OpenTasksPanel(const aContainer: IvcmContainer);
//#UC START# *4AC1000A0176_4A92C1380380_var*
//#UC END# *4AC1000A0176_4A92C1380380_var*
begin
//#UC START# *4AC1000A0176_4A92C1380380_impl*
 {$If not (defined(Monitorings) or defined(Admin))}
 // заменяем Make --> MakeSingleChild
 // http://mdp.garant.ru/pages/viewpage.action?pageId=342864296&focusedCommentId=342868675#comment-342868675
 Ten_TasksPanel.MakeSingleChild(CheckContainer(aContainer), vcmMakeParams(nil,
                               CheckContainer(aContainer)),
                     vcm_ztNavigator,
                     Ord(tpMain));
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
//#UC END# *4AC1000A0176_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenTasksPanel

procedure TPrimF1CommonModule.AddDocumentToControl(const aDocument: IDocument);
 {* Поставить документ на контроль }
//#UC START# *4AC1F3770062_4A92C1380380_var*
//#UC END# *4AC1F3770062_4A92C1380380_var*
begin
//#UC START# *4AC1F3770062_4A92C1380380_impl*
 Assert(IsCurEditionActual(aDocument),'Can''t flag unactual redation');
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  AddToControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3770062_4A92C1380380_impl*
end;//TPrimF1CommonModule.AddDocumentToControl

procedure TPrimF1CommonModule.AddToControl(const aControllable: IControllable);
 {* Поставить объект на контроль }
//#UC START# *4AC1F3A700BE_4A92C1380380_var*
//#UC END# *4AC1F3A700BE_4A92C1380380_var*
begin
//#UC START# *4AC1F3A700BE_4A92C1380380_impl*
 if Assigned(aControllable) and aControllable.GetCanSetToControl then
 begin
  aControllable.SetControlled(True);
  TdmStdRes.AddControlledObject(aControllable);
 end;//Assigned(aControllable) and aControllable.GetCanSetToControl
//#UC END# *4AC1F3A700BE_4A92C1380380_impl*
end;//TPrimF1CommonModule.AddToControl

procedure TPrimF1CommonModule.DeleteDocumentFromControl(const aDocument: IDocument);
 {* Снять документ с контроля }
//#UC START# *4AC1F3D702D2_4A92C1380380_var*
//#UC END# *4AC1F3D702D2_4A92C1380380_var*
begin
//#UC START# *4AC1F3D702D2_4A92C1380380_impl*
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  DeleteFromControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3D702D2_4A92C1380380_impl*
end;//TPrimF1CommonModule.DeleteDocumentFromControl

procedure TPrimF1CommonModule.DeleteFromControl(const aControllable: IControllable);
 {* Снять объект с контроля }
//#UC START# *4AC1F40900DE_4A92C1380380_var*
//#UC END# *4AC1F40900DE_4A92C1380380_var*
begin
//#UC START# *4AC1F40900DE_4A92C1380380_impl*
 if Assigned(aControllable) then
 begin
  aControllable.SetControlled(False);
  TdmStdRes.DeleteControlledObject(aControllable);
 end;//Assigned(aControllable)
//#UC END# *4AC1F40900DE_4A92C1380380_impl*
end;//TPrimF1CommonModule.DeleteFromControl

function TPrimF1CommonModule.IsUnderControl(const aDoc: IDocument): Boolean;
 {* Находится ли документ на контроле }
//#UC START# *4AC1F483035F_4A92C1380380_var*
//#UC END# *4AC1F483035F_4A92C1380380_var*
begin
//#UC START# *4AC1F483035F_4A92C1380380_impl*
 Result := False;
 if Supports(aDoc, IControllable, l_Controllable) then
 try
  Result := l_Controllable.GetControlled;
 finally
  l_Controllable := nil;
 end;
//#UC END# *4AC1F483035F_4A92C1380380_impl*
end;//TPrimF1CommonModule.IsUnderControl

function TPrimF1CommonModule.IsCurEditionActual(const aState: IDocumentState): Boolean;
//#UC START# *4AC1F6E802E5_4A92C1380380_var*
//#UC END# *4AC1F6E802E5_4A92C1380380_var*
begin
//#UC START# *4AC1F6E802E5_4A92C1380380_impl*
  Result := True;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=296096137&focusedCommentId=326777595#comment-326777595 
  if (aState <> nil) and (not DefDataAdapter.InTerminateProcess) then
   try
    Result := aState.IsActual;
   except
    on ECorbaException do
    ;
   end;//try..except
//#UC END# *4AC1F6E802E5_4A92C1380380_impl*
end;//TPrimF1CommonModule.IsCurEditionActual

function TPrimF1CommonModule.IsCurEditionActual(const aDocument: IDocument): Boolean;
//#UC START# *4AC1F71B0366_4A92C1380380_var*
//#UC END# *4AC1F71B0366_4A92C1380380_var*
begin
//#UC START# *4AC1F71B0366_4A92C1380380_impl*
 Result := True;
 if (aDocument <> nil) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   Result := IsCurEditionActual(l_State);
  finally
   l_State := nil;
  end;//try..finally
 end;//aDocument <> nil
//#UC END# *4AC1F71B0366_4A92C1380380_impl*
end;//TPrimF1CommonModule.IsCurEditionActual

function TPrimF1CommonModule.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
//#UC START# *4AC203EB01AE_4A92C1380380_var*
//#UC END# *4AC203EB01AE_4A92C1380380_var*
begin
//#UC START# *4AC203EB01AE_4A92C1380380_impl*
 Result := cNullDate;
 if (aDocument <> nil) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   if (l_State <> nil) then
   begin
    l3FillChar(l_Info, SizeOf(l_Info));
    l_State.GetCurrentRedaction(l_Info);
    Result := l_Info.rTimeMachineDate;
   end;//l_State <> nil
  finally
   l_State := nil;
  end;//try..finally
 end;//aDocument <> nil
//#UC END# *4AC203EB01AE_4A92C1380380_impl*
end;//TPrimF1CommonModule.GetCurEditionDate

procedure TPrimF1CommonModule.OpenIntranet;
//#UC START# *4BD162890088_4A92C1380380_var*
//#UC END# *4BD162890088_4A92C1380380_var*
begin
//#UC START# *4BD162890088_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BD162890088_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenIntranet

procedure TPrimF1CommonModule.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine);
//#UC START# *4B2624ED010D_4A92C1380380_var*
//#UC END# *4B2624ED010D_4A92C1380380_var*
begin
//#UC START# *4B2624ED010D_4A92C1380380_impl*
 Result := Ten_TurnOffTimeMachine.Make(anIntf);
//#UC END# *4B2624ED010D_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenTurnOffTimeMachine

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRememberPasswordForm);
 {* Регистрация RememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_RememberPasswordCaption.Init;
 {* Инициализация str_ut_RememberPasswordCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefProgressIndicator);
 {* Регистрация ProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefEULA);
 {* Регистрация EULA }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efEULA.SetFactory(TefEULA.Make);
 {* Регистрация фабрики формы EULA }
 str_ut_EULACaption.Init;
 {* Инициализация str_ut_EULACaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefAbout);
 {* Регистрация About }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efAbout.SetFactory(TefAbout.Make);
 {* Регистрация фабрики формы About }
 str_ut_AboutCaption.Init;
 {* Инициализация str_ut_AboutCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenCompInfo);
 {* Регистрация CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enCompInfo.SetFactory(TenCompInfo.Make);
 {* Регистрация фабрики формы CompInfo }
 str_ut_CompInfoCaption.Init;
 {* Инициализация str_ut_CompInfoCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsRegistrationForm);
 {* Регистрация RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_RegistrationFormCaption.Init;
 {* Инициализация str_ut_RegistrationFormCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TasksPanel);
 {* Регистрация TasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_TasksPanel.SetFactory(Ten_TasksPanel.Make);
 {* Регистрация фабрики формы TasksPanel }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_Navigator);
 {* Регистрация Navigator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_Navigator.SetFactory(Ten_Navigator.Make);
 {* Регистрация фабрики формы Navigator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TurnOffTimeMachine);
 {* Регистрация TurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_TurnOffTimeMachineCaption.Init;
 {* Инициализация str_ut_TurnOffTimeMachineCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
