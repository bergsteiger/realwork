unit NOT_COMPLETED_NemesisMain_Form;
 {* Главная форма }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_COMPLETED_NemesisMain_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "NemesisMain" MUID: (4958D2EA00CC)
// Имя типа: "TNemesisMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ShellAndMonitoringsMain_Form
 , Search_Strange_Controls
 , F1_Without_Usecases_System_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUnderControlNotificationManager
 , l3Interfaces
 , MainWindowInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , eeInterfaces
 , nsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerForm
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _nsUserSettingsListener_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _nsUserSettingsEditListener_Parent_ = _nsUserSettingsListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}
 _StatusBarItems_Parent_ = _nsUserSettingsEditListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _vcmContainedForm_Parent_ = _StatusBarItems_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}
 TNemesisMainForm = class(_vcmContainedForm_, InsUnderControlNotificationListener)
  {* Главная форма }
  private
   f_CarrierLostHint: Il3CString;
   f_CantReceiveAnswer: Boolean;
   f_InternetDisconnected: Boolean;
   f_ConnectionWasLost: Boolean;
   f_sdsMainWindow: IsdsMainWindow;
  protected
   f_IsControlledObjectsChanging: Boolean;
  private
   procedure UpdateCarrierHint;
   function OpenNewMainForm(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean;
    const aOpenAfter: IvcmEntityForm = nil): TvcmMainForm;
  protected
   procedure CheckConsultationConnection;
   procedure ChangeDefaultFontSize(aInc: Boolean = True);
   procedure LogSystemInfo;
   function CanChangeDefaultFontSize(aInc: Boolean = True): Boolean;
   procedure CheckInternetConnection;
   procedure ResetControlledObjectsChanging;
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* Заполняет список операций. Для перекрытия в потомках }
   procedure UnderControlNotificationChanged;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedsStatusBarItems: Boolean; override;
    {* Определяет, что операции в статусной строке таки надо публиковать }
   {$If NOT Defined(NoVCM)}
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function NeedUseTabs: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   function NeedAskMayExit: Boolean; override;
   function OpenNewMainWindow: TvcmMainForm; override;
   {$If NOT Defined(NoVCM)}
   function LimitOpenedWindowsCount: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoCascadeWindows; override;
   procedure DoTileWindowsHorizontal; override;
   procedure DoTileWindowsVertical; override;
   function GetCanCloseAllWindows: Boolean; override;
   procedure DoCloseAllWindows; override;
   function DoGetNextMainForm: IvcmEntityForm; override;
   {$If NOT Defined(NoVCM)}
   function DoGetCaptionForSaving: AnsiString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   procedure DoOnContainerIsClosing; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   function GetCurrentActiveWindow: IvcmEntityForm; override;
   function GetCurrentOpenedWindowsCount: Integer; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
    aOpenLast: Boolean;
    const aOpenAfter: IvcmEntityForm = nil): IvcmContainedForm; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
    {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParamsPrim);
    {* Коллеги, кто может описать этот метод? }
   procedure System_CantReceiveLegalServiceAnswer_Test(const aParams: IvcmTestParamsPrim);
    {* Статус связи с ППО }
   procedure System_CantReceiveLegalServiceAnswer_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Статус связи с ППО }
   procedure System_CantReceiveLegalServiceAnswer_GetState(var State: TvcmOperationStateIndex);
    {* Статус связи с ППО }
 end;//TNemesisMainForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , DataAdapter
 , resWarnImages
 , BaseTypesUnit
 , nsNodes
 , BaseTreeSupportUnit
 , nsForwardEvent
 , nsBackEvent
 , Search_ScalingSupport_Controls
 , sdsMainWindow
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , l3TabbedContainersDispatcher
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , afwFacade
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsChangeFontSizeEvent
 , evStyleInterface
 , nsSettingsUtils
 , evStyleTableTools
 , nsPrimaryMonitorResolutionEvent
 , nsDPIEvent
 , nsFontSizeEvent
 , NemesisMain_utMainWindow_UserType
;

const
 {* Локализуемые строки Local }
 str_CarrierLost: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CarrierLost'; rValue : 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_InternetAbsent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InternetAbsent'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_TotalFailure: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TotalFailure'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
  {* 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
 str_CaptionForSaving: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CaptionForSaving'; rValue : 'ГАРАНТ аэро');
  {* 'ГАРАНТ аэро' }
 {* Локализуемые строки utMainWindowLocalConstants }
 str_utMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowCaption'; rValue : 'Главное окно');
  {* Заголовок пользовательского типа "Главное окно" }
 str_utMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
  {* Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}

type _Instance_R_ = TNemesisMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}

procedure TNemesisMainForm.CheckConsultationConnection;
//#UC START# *4A8E7A6E0379_4958D2EA00CC_var*
//#UC END# *4A8E7A6E0379_4958D2EA00CC_var*
begin
//#UC START# *4A8E7A6E0379_4958D2EA00CC_impl*
 f_CantReceiveAnswer := defDataAdapter.ConsultationManager.CantReceiveAnswer;
 if f_CantReceiveAnswer then
  f_ConnectionWasLost := True;
 f_InternetDisconnected := False;
 UpdateCarrierHint;
//#UC END# *4A8E7A6E0379_4958D2EA00CC_impl*
end;//TNemesisMainForm.CheckConsultationConnection

procedure TNemesisMainForm.ChangeDefaultFontSize(aInc: Boolean = True);
//#UC START# *4B0BAF65023E_4958D2EA00CC_var*
var
 l_Font: TFont;
 l_Form : IvcmEntityForm;
 l_Cont : IvcmContainer;
//#UC END# *4B0BAF65023E_4958D2EA00CC_var*
begin
//#UC START# *4B0BAF65023E_4958D2EA00CC_impl*
 if HasForm(vcm_ztParent, false, @l_Form) then
 begin
  l_Cont := l_Form.AsContainer;
  if (l_Cont <> nil) AND
     l_Cont.HasForm(vcm_ztParent, false, @l_Form) then
   if Op_Scalable_ChangeScale.Call(l_Form, aInc) then
    Exit;
 end;//HasForm(vcm_ztParent, false, @l_Form)
 with TevStyleInterface.Make do
 try
  if aInc then
   IncAllFontSize
  else
   DecAllFontSize;
  l_Font := TFont.Create;
  try
   evGetDefaultFont(l_Font);
  TnsChangeFontSizeEvent.Log(aInc, Cardinal(l_Font.Size));
  finally
   FreeAndNil(l_Font);
  end;//try..finaly
 finally
  Free;
 end;//try..finally
 SaveStyleTableToSettings;
//#UC END# *4B0BAF65023E_4958D2EA00CC_impl*
end;//TNemesisMainForm.ChangeDefaultFontSize

procedure TNemesisMainForm.LogSystemInfo;
//#UC START# *4B0BAF8E03D0_4958D2EA00CC_var*
var
 l_Index : Integer;
 l_Font  : TFont;
//#UC END# *4B0BAF8E03D0_4958D2EA00CC_var*
begin
//#UC START# *4B0BAF8E03D0_4958D2EA00CC_impl*
  if (Dispatcher.FormDispatcher.MainFormsCount > 1) then
   Exit;
  // Разрешение монитора:
  for l_Index := 0 to Pred(Screen.MonitorCount) do
   with Screen.Monitors[l_Index] do
    if Primary then
    begin
     TnsPrimaryMonitorResolutionEvent.Log(Cardinal(Width), Cardinal(Height));
     Break;
    end;//if Screen.Monitors[l_Index].Primary then
  // Точек на дюйм:
  TnsDPIEvent.Log(Cardinal(Screen.PixelsPerInch));
  // Размер основного шрифта:
  l_Font := TFont.Create;
  try
   evGetDefaultFont(l_Font);
   TnsFontSizeEvent.Log(Cardinal(l_Font.Size));
  finally
   FreeAndNil(l_Font);
  end;//try..finally
//#UC END# *4B0BAF8E03D0_4958D2EA00CC_impl*
end;//TNemesisMainForm.LogSystemInfo

function TNemesisMainForm.CanChangeDefaultFontSize(aInc: Boolean = True): Boolean;
//#UC START# *4BB3637402F5_4958D2EA00CC_var*
const  
 c_MinFontSize = 8;
 c_MaxFontSize = 30;
var
 l_Form : IvcmEntityForm;
 l_Cont : IvcmContainer;
//#UC END# *4BB3637402F5_4958D2EA00CC_var*
begin
//#UC START# *4BB3637402F5_4958D2EA00CC_impl*
 if HasForm(vcm_ztParent, false, @l_Form) then
 begin
  l_Cont := l_Form.AsContainer;
  if (l_Cont <> nil) AND
     l_Cont.HasForm(vcm_ztParent, false, @l_Form) then
   Case Op_Scalable_CanChangeScale.Call(l_Form, aInc) of
    ccsNo :
    begin
     Result := false;
     Exit;
    end;//ccsNo
    ccsYes :
    begin
     Result := true;
     Exit;
    end;//ccsYes
    // http://mdp.garant.ru/pages/viewpage.action?pageId=502333442
    ccsYesIfPossible:
     Result := true;
   end;//Case Op_Scalable_CanChangeScale.Call(l_Form, aInc)
 end;//HasForm(vcm_ztParent, false, @l_Form)
 with TevStyleInterface.Make do
  try
   if aInc then
    Result := (Font.Size < c_MaxFontSize)
   else
    Result := (Font.Size > c_MinFontSize);            
  finally
   Free;
  end;//try..finally
//#UC END# *4BB3637402F5_4958D2EA00CC_impl*
end;//TNemesisMainForm.CanChangeDefaultFontSize

procedure TNemesisMainForm.CheckInternetConnection;
//#UC START# *4BCDAB6F00D2_4958D2EA00CC_var*
//#UC END# *4BCDAB6F00D2_4958D2EA00CC_var*
begin
//#UC START# *4BCDAB6F00D2_4958D2EA00CC_impl*
 f_InternetDisconnected := True;
 f_ConnectionWasLost := True;
 UpdateCarrierHint;
//#UC END# *4BCDAB6F00D2_4958D2EA00CC_impl*
end;//TNemesisMainForm.CheckInternetConnection

procedure TNemesisMainForm.UpdateCarrierHint;
//#UC START# *4BCDABAC037C_4958D2EA00CC_var*
//#UC END# *4BCDABAC037C_4958D2EA00CC_var*
begin
//#UC START# *4BCDABAC037C_4958D2EA00CC_impl*
 if f_CantReceiveAnswer then
  if f_InternetDisconnected then
   f_CarrierLostHint := vcmFmt(str_TotalFailure.AsCStr,[defDataAdapter.GetDealerInfo])
  else
   f_CarrierLostHint := vcmFmt(str_CarrierLost.AsCStr,[defDataAdapter.GetDealerInfo])
 else
  if f_InternetDisconnected then
   f_CarrierLostHint := vcmFmt(str_InternetAbsent.AsCStr,[defDataAdapter.GetDealerInfo])
  else
   f_CarrierLostHint := nil;
//#UC END# *4BCDABAC037C_4958D2EA00CC_impl*
end;//TNemesisMainForm.UpdateCarrierHint

function TNemesisMainForm.OpenNewMainForm(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean;
 const aOpenAfter: IvcmEntityForm = nil): TvcmMainForm;
//#UC START# *5566B0FA013A_4958D2EA00CC_var*
var
 l_TabCont: TvcmTabbedContainerForm;
 l_Cont: IvcmContainer;
 l_OpenAfter: TvcmEntityForm;
//#UC END# *5566B0FA013A_4958D2EA00CC_var*
begin
//#UC START# *5566B0FA013A_4958D2EA00CC_impl*
 Result := nil;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=600654481
 if (aOpenAfter = nil) then
  l_OpenAfter := nil
 else
  l_OpenAfter := TvcmEntityForm(aOpenAfter.VCLWinControl);
 l_Cont := TvcmTabbedContainerFormDispatcher.Instance.MakeAndPlaceVCMContainer(Self As IvcmContainerMaker,
  Self as IvcmContainer, aOpenKind, True, aOpenLast, l_OpenAfter);
 if (l_Cont <> nil) then
 begin
  Result := l_Cont.AsForm.VCLWinControl as TvcmMainForm;
  InitClone(Result);
  if (aOpenKind = vcm_okInNewWindow) then
  begin
   l_TabCont := TvcmTabbedContainerFormDispatcher.Instance.GetFormContainer(Result);
   if (l_TabCont <> nil) then
   begin
    if (GetForegroundWindow <> l_TabCont.Handle) then
     SetForegroundWindow(l_TabCont.Handle)
   end
   else
    if (GetForegroundWindow <> Result.Handle) then
     SetForegroundWindow(Result.Handle);
  end;
 end;
//#UC END# *5566B0FA013A_4958D2EA00CC_impl*
end;//TNemesisMainForm.OpenNewMainForm

procedure TNemesisMainForm.ResetControlledObjectsChanging;
//#UC START# *55D450020396_4958D2EA00CC_var*
//#UC END# *55D450020396_4958D2EA00CC_var*
begin
//#UC START# *55D450020396_4958D2EA00CC_impl*
 TnsUnderControlNotificationManager.Instance.ResetChangedNotification;
//#UC END# *55D450020396_4958D2EA00CC_impl*
end;//TNemesisMainForm.ResetControlledObjectsChanging

function TNemesisMainForm.Loadable_Load_Execute(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_4958D2EA00CCexec_var*
var
 l_FolderNode  : INode;
 l_BaseEntity  : IUnknown;
//#UC END# *49895A2102E8_4958D2EA00CCexec_var*
begin
//#UC START# *49895A2102E8_4958D2EA00CCexec_impl*
 Result := false;
 if Supports(aNode, INode, l_FolderNode) then
  try
   try
    l_FolderNode.Open(l_BaseEntity);
   except
    on ECanNotFindData do
    begin
     Say(inf_BookmarkedDocumentMissing, [nsGetCaption(l_FolderNode)]);
     Result := false;
     exit;
    end;//on ECanNotFindData
   end;//try..except
   try
    TdmStdRes.OpenEntityAsDocument(l_BaseEntity, nil);
    Result := true;
   finally
    l_BaseEntity := nil;
   end;//try..finally
  finally
   l_FolderNode := nil;
  end;//try..finally
//#UC END# *49895A2102E8_4958D2EA00CCexec_impl*
end;//TNemesisMainForm.Loadable_Load_Execute

procedure TNemesisMainForm.Loadable_Load(const aParams: IvcmExecuteParamsPrim);
 {* Коллеги, кто может описать этот метод? }
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Self.Loadable_Load_Execute(Node, Data, nOp);
end;//TNemesisMainForm.Loadable_Load

procedure TNemesisMainForm.FillList(const aList: InscStatusBarItemDefsList);
 {* Заполняет список операций. Для перекрытия в потомках }
//#UC START# *4A8E5E4702C6_4958D2EA00CC_var*
//#UC END# *4A8E5E4702C6_4958D2EA00CC_var*
begin
//#UC START# *4A8E5E4702C6_4958D2EA00CC_impl*
 aList.Add(TnscStatusBarOperationDef.MakeSNoCaption(TdmStdRes.opcode_System_CantReceiveLegalServiceAnswer, True, True, 10000, nsc_ttkWarning));
//#UC END# *4A8E5E4702C6_4958D2EA00CC_impl*
end;//TNemesisMainForm.FillList

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Test(const aParams: IvcmTestParamsPrim);
 {* Статус связи с ППО }
//#UC START# *4C7D38560348_4958D2EA00CCtest_var*
//#UC END# *4C7D38560348_4958D2EA00CCtest_var*
begin
//#UC START# *4C7D38560348_4958D2EA00CCtest_impl*
 with aParams.Op do
 begin
  Hint := f_CarrierLostHint;
  LongHint := f_CarrierLostHint;
 end;
//#UC END# *4C7D38560348_4958D2EA00CCtest_impl*
end;//TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Test

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Статус связи с ППО }
//#UC START# *4C7D38560348_4958D2EA00CCexec_var*
//#UC END# *4C7D38560348_4958D2EA00CCexec_var*
begin
//#UC START# *4C7D38560348_4958D2EA00CCexec_impl*
 if f_CantReceiveAnswer or f_InternetDisconnected then
  Say(war_CarierLost, [f_CarrierLostHint])
 else
  Say(inf_CarrierFound);
//#UC END# *4C7D38560348_4958D2EA00CCexec_impl*
end;//TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Execute

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_GetState(var State: TvcmOperationStateIndex);
 {* Статус связи с ППО }
//#UC START# *4C7D38560348_4958D2EA00CCgetstate_var*
//#UC END# *4C7D38560348_4958D2EA00CCgetstate_var*
begin
//#UC START# *4C7D38560348_4958D2EA00CCgetstate_impl*
 if f_CantReceiveAnswer or f_InternetDisconnected then
  State := st_user_System_CantReceiveLegalServiceAnswer_On
 else
 if f_ConnectionWasLost then
  State := st_user_System_CantReceiveLegalServiceAnswer_Off
 else
  State := st_user_System_CantReceiveLegalServiceAnswer_Disabled;
//#UC END# *4C7D38560348_4958D2EA00CCgetstate_impl*
end;//TNemesisMainForm.System_CantReceiveLegalServiceAnswer_GetState

procedure TNemesisMainForm.UnderControlNotificationChanged;
//#UC START# *55D42A4A0031_4958D2EA00CC_var*
//#UC END# *55D42A4A0031_4958D2EA00CC_var*
begin
//#UC START# *55D42A4A0031_4958D2EA00CC_impl*
 f_IsControlledObjectsChanging := TnsUnderControlNotificationManager.Instance.HasChanged;
//#UC END# *55D42A4A0031_4958D2EA00CC_impl*
end;//TNemesisMainForm.UnderControlNotificationChanged

procedure TNemesisMainForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4958D2EA00CC_var*
//#UC END# *479731C50290_4958D2EA00CC_var*
begin
//#UC START# *479731C50290_4958D2EA00CC_impl*
 TnsUnderControlNotificationManager.Instance.Unsubscribe(Self);
 f_CarrierLostHint := nil;
 inherited;
//#UC END# *479731C50290_4958D2EA00CC_impl*
end;//TNemesisMainForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4958D2EA00CC_var*
//#UC END# *49803F5503AA_4958D2EA00CC_var*
begin
//#UC START# *49803F5503AA_4958D2EA00CC_impl*
 inherited;
 TnsUnderControlNotificationManager.Instance.Subscribe(Self);
 f_IsControlledObjectsChanging := TnsUnderControlNotificationManager.Instance.HasChanged;
//#UC END# *49803F5503AA_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

function TNemesisMainForm.NeedsStatusBarItems: Boolean;
 {* Определяет, что операции в статусной строке таки надо публиковать }
//#UC START# *4A8E5CEC021F_4958D2EA00CC_var*
//#UC END# *4A8E5CEC021F_4958D2EA00CC_var*
begin
//#UC START# *4A8E5CEC021F_4958D2EA00CC_impl*
 CheckConsultationConnection;
 Result := f_CantReceiveAnswer or f_InternetDisconnected or defDataAdapter.RevisionCheckEnabled;
//#UC END# *4A8E5CEC021F_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedsStatusBarItems

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_4958D2EA00CC_var*
//#UC END# *4AD44CA20001_4958D2EA00CC_var*
begin
//#UC START# *4AD44CA20001_4958D2EA00CC_impl*
 Result := inherited InsertForm(aForm);
 if (f_sdsMainWindow = nil) then
 begin
  f_sdsMainWindow := TsdsMainWindow.Make;
  TdmStdRes.MakeBaloonForm(Self,
                    remUnreadConsultations,
                    f_sdsMainWindow.dsBaloonWarning);
  TdmStdRes.MakeBaloonForm(Self,
                    OldBaseWarning,
                    f_sdsMainWindow.dsBaloonWarning);
  TdmStdRes.MakeBaloonForm(Self,
                    remOnlineDead,
                    f_sdsMainWindow.dsBaloonWarning);
  TdmStdRes.MakeBaloonForm(Self,
                    TrialModeWarning,
                    f_sdsMainWindow.dsBaloonWarning);
  TdmStdRes.MakeBaloonForm(Self,
                    ControlledChangingWarning,
                    f_sdsMainWindow.dsBaloonWarning);
 end;//f_sdsMainWindow = nil
//#UC END# *4AD44CA20001_4958D2EA00CC_impl*
end;//TNemesisMainForm.InsertForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_var*
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_var*
begin
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_impl*
 inherited;
 TnsBackEvent.Log;
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoBack
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TNemesisMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4958D2EA00CC_var*
//#UC END# *4C8DDEA5007E_4958D2EA00CC_var*
begin
//#UC START# *4C8DDEA5007E_4958D2EA00CC_impl*
 inherited;
 TnsForwardEvent.Log;
//#UC END# *4C8DDEA5007E_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoForward
{$IfEnd} // NOT Defined(NoVCM)

procedure TNemesisMainForm.ClearFields;
begin
 f_CarrierLostHint := nil;
 f_sdsMainWindow := nil;
 inherited;
end;//TNemesisMainForm.ClearFields

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TNemesisMainForm.NeedUseTabs: Boolean;
//#UC START# *537DB22C0249_4958D2EA00CC_var*
//#UC END# *537DB22C0249_4958D2EA00CC_var*
begin
//#UC START# *537DB22C0249_4958D2EA00CC_impl*
 Result := inherited NeedUseTabs;
//#UC END# *537DB22C0249_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedUseTabs
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

function TNemesisMainForm.NeedAskMayExit: Boolean;
//#UC START# *53A013DF03E1_4958D2EA00CC_var*
//#UC END# *53A013DF03E1_4958D2EA00CC_var*
begin
//#UC START# *53A013DF03E1_4958D2EA00CC_impl*
 if NeedUseTabs then
  Result := TvcmTabbedContainerFormDispatcher.Instance.NeedAskMayExit(Self)
 else
  Result := inherited NeedAskMayExit;
//#UC END# *53A013DF03E1_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedAskMayExit

function TNemesisMainForm.OpenNewMainWindow: TvcmMainForm;
//#UC START# *53AD17180374_4958D2EA00CC_var*
var
 l_TabCont: TvcmTabbedContainerForm;
 l_Cont: IvcmContainer;
//#UC END# *53AD17180374_4958D2EA00CC_var*
begin
//#UC START# *53AD17180374_4958D2EA00CC_impl*
 Result := OpenNewMainForm(vcm_okInNewWindow, True);
//#UC END# *53AD17180374_4958D2EA00CC_impl*
end;//TNemesisMainForm.OpenNewMainWindow

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.LimitOpenedWindowsCount: Boolean;
//#UC START# *53AD2E740057_4958D2EA00CC_var*
//#UC END# *53AD2E740057_4958D2EA00CC_var*
begin
//#UC START# *53AD2E740057_4958D2EA00CC_impl*
 Result := not NeedUseTabs;
//#UC END# *53AD2E740057_4958D2EA00CC_impl*
end;//TNemesisMainForm.LimitOpenedWindowsCount
{$IfEnd} // NOT Defined(NoVCM)

procedure TNemesisMainForm.DoCascadeWindows;
//#UC START# *53D0E77003DD_4958D2EA00CC_var*
//#UC END# *53D0E77003DD_4958D2EA00CC_var*
begin
//#UC START# *53D0E77003DD_4958D2EA00CC_impl*
 Tl3TabbedContainersDispatcher.Instance.CascadeWindows;
//#UC END# *53D0E77003DD_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoCascadeWindows

procedure TNemesisMainForm.DoTileWindowsHorizontal;
//#UC START# *53D0ECFB035D_4958D2EA00CC_var*
//#UC END# *53D0ECFB035D_4958D2EA00CC_var*
begin
//#UC START# *53D0ECFB035D_4958D2EA00CC_impl*
 Tl3TabbedContainersDispatcher.Instance.TileWindowsHorizontal;
//#UC END# *53D0ECFB035D_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoTileWindowsHorizontal

procedure TNemesisMainForm.DoTileWindowsVertical;
//#UC START# *53D0ED410163_4958D2EA00CC_var*
//#UC END# *53D0ED410163_4958D2EA00CC_var*
begin
//#UC START# *53D0ED410163_4958D2EA00CC_impl*
 Tl3TabbedContainersDispatcher.Instance.TileWindowsVertical;
//#UC END# *53D0ED410163_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoTileWindowsVertical

function TNemesisMainForm.GetCanCloseAllWindows: Boolean;
//#UC START# *53D20CE2034C_4958D2EA00CC_var*
//#UC END# *53D20CE2034C_4958D2EA00CC_var*
begin
//#UC START# *53D20CE2034C_4958D2EA00CC_impl*
 Result := TvcmTabbedContainerFormDispatcher.Instance.CanCloseAllWindows;
//#UC END# *53D20CE2034C_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCanCloseAllWindows

procedure TNemesisMainForm.DoCloseAllWindows;
//#UC START# *53D20D0402AC_4958D2EA00CC_var*
//#UC END# *53D20D0402AC_4958D2EA00CC_var*
begin
//#UC START# *53D20D0402AC_4958D2EA00CC_impl*
 TvcmTabbedContainerFormDispatcher.Instance.CloseAllWindows(Self.As_IvcmEntityForm);
//#UC END# *53D20D0402AC_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoCloseAllWindows

function TNemesisMainForm.DoGetNextMainForm: IvcmEntityForm;
//#UC START# *53D21DEA02A4_4958D2EA00CC_var*
//#UC END# *53D21DEA02A4_4958D2EA00CC_var*
begin
//#UC START# *53D21DEA02A4_4958D2EA00CC_impl*
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  Result := TvcmTabbedContainerFormDispatcher.Instance.GetNextMainForm(Self.As_IvcmEntityForm)
 else
  Result := inherited DoGetNextMainForm;
//#UC END# *53D21DEA02A4_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoGetNextMainForm

{$If NOT Defined(NoVCM)}
function TNemesisMainForm.DoGetCaptionForSaving: AnsiString;
//#UC START# *540953180034_4958D2EA00CC_var*
//#UC END# *540953180034_4958D2EA00CC_var*
begin
//#UC START# *540953180034_4958D2EA00CC_impl*
 Result := str_CaptionForSaving.AsStr;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564737453
//#UC END# *540953180034_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoGetCaptionForSaving
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
procedure TNemesisMainForm.DoOnContainerIsClosing;
//#UC START# *54363DD90183_4958D2EA00CC_var*
//#UC END# *54363DD90183_4958D2EA00CC_var*
begin
//#UC START# *54363DD90183_4958D2EA00CC_impl*
 inherited;
 DropChangeStatusToOpened;
//#UC END# *54363DD90183_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoOnContainerIsClosing
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

function TNemesisMainForm.GetCurrentActiveWindow: IvcmEntityForm;
//#UC START# *54607EC40295_4958D2EA00CC_var*
//#UC END# *54607EC40295_4958D2EA00CC_var*
begin
//#UC START# *54607EC40295_4958D2EA00CC_impl*
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
 begin
  if (MainFormContainer <> nil) then
   Result := MainFormContainer.As_IvcmEntityForm
  else
   Result := nil;
 end
 else
  Result := inherited GetCurrentActiveWindow;
//#UC END# *54607EC40295_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCurrentActiveWindow

function TNemesisMainForm.GetCurrentOpenedWindowsCount: Integer;
//#UC START# *54607EEF00BB_4958D2EA00CC_var*
//#UC END# *54607EEF00BB_4958D2EA00CC_var*
begin
//#UC START# *54607EEF00BB_4958D2EA00CC_impl*
 Result := TvcmTabbedContainerFormDispatcher.Instance.MainFormsCount;
//#UC END# *54607EEF00BB_4958D2EA00CC_impl*
end;//TNemesisMainForm.GetCurrentOpenedWindowsCount

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TNemesisMainForm.DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
 aOpenLast: Boolean;
 const aOpenAfter: IvcmEntityForm = nil): IvcmContainedForm;
//#UC START# *5566C7BD037F_4958D2EA00CC_var*
//#UC END# *5566C7BD037F_4958D2EA00CC_var*
begin
//#UC START# *5566C7BD037F_4958D2EA00CC_impl*
 Result := OpenNewMainForm(aOpenKind, aOpenLast, aOpenAfter) as IvcmContainedForm;
//#UC END# *5566C7BD037F_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoOpenNew
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
 str_CarrierLost.Init;
 {* Инициализация str_CarrierLost }
 str_InternetAbsent.Init;
 {* Инициализация str_InternetAbsent }
 str_TotalFailure.Init;
 {* Инициализация str_TotalFailure }
 str_CaptionForSaving.Init;
 {* Инициализация str_CaptionForSaving }
 str_utMainWindowCaption.Init;
 {* Инициализация str_utMainWindowCaption }
 str_utMainWindowSettingsCaption.Init;
 {* Инициализация str_utMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNemesisMainForm);
 {* Регистрация NemesisMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
