unit NemesisMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/NemesisMain_Form.pas"
// Начат: 29.12.2008 16:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::PrimNemesis::NemesisMain
//
// Главная форма
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  F1_Without_Usecases_System_Controls,
  ShellAndMonitoringsMain_Form,
  Search_Strange_Controls,
  l3StringIDEx,
  MainWindowInterfaces
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nsUnderControlNotificationManager,
  bsInterfaces,
  afwInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerForm
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  NemesisMain_utMainWindow_UserType,
  eeInterfaces,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _nsUserSettingsListener_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _nsUserSettingsEditListener_Parent_ = _nsUserSettingsListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}
 _StatusBarItems_Parent_ = _nsUserSettingsEditListener_;
 {$Include ..\View\StatusBarItems.imp.pas}
 _vcmContainedForm_Parent_ = _StatusBarItems_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}
 TNemesisMainForm = {form} class(_vcmContainedForm_, InsUnderControlNotificationListener)
  {* Главная форма }
 private
 // private fields
   f_CarrierLostHint : Il3CString;
   f_CantReceiveAnswer : Boolean;
   f_InternetDisconnected : Boolean;
   f_ConnectionWasLost : Boolean;
   f_sdsMainWindow : IsdsMainWindow;
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure UpdateCarrierHint;
   function OpenNewMainForm(aOpenKind: TvcmMainFormOpenKind;
     aOpenLast: Boolean;
     const aOpenAfter: IvcmEntityForm = nil): TvcmMainForm;
 protected
 // realized methods
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
     {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
     {* Коллеги, кто может описать этот метод? }
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
     {* Заполняет список операций. Для перекрытия в потомках }
   procedure System_CantReceiveLegalServiceAnswer_Test(const aParams: IvcmTestParamsPrim);
     {* Статус связи с ППО }
   procedure System_CantReceiveLegalServiceAnswer_GetState(var State: TvcmOperationStateIndex);
     {* Статус связи с ППО }
   procedure System_CantReceiveLegalServiceAnswer_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Статус связи с ППО }
   procedure UnderControlNotificationChanged;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   function NeedsStatusBarItems: Boolean; override;
     {* Определяет, что операции в статусной строке таки надо публиковать }
   {$If not defined(NoVCM)}
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); override;
    {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function NeedUseTabs: Boolean; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
   function NeedAskMayExit: Boolean; override;
   function OpenNewMainWindow: TvcmMainForm; override;
    {$If not defined(NoVCM)}
   function LimitOpenedWindowsCount: Boolean; override;
    {$IfEnd} //not NoVCM
   procedure DoCascadeWindows; override;
   procedure DoTileWindowsHorizontal; override;
   procedure DoTileWindowsVertical; override;
   function GetCanCloseAllWindows: Boolean; override;
   procedure DoCloseAllWindows; override;
   function DoGetNextMainForm: IvcmEntityForm; override;
    {$If not defined(NoVCM)}
   function DoGetCaptionForSaving: AnsiString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   procedure DoOnContainerIsClosing; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
   function GetCurrentActiveWindow: IvcmEntityForm; override;
   function GetCurrentOpenedWindowsCount: Integer; override;
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoOpenNew(aOpenKind: TvcmMainFormOpenKind;
     aOpenLast: Boolean;
     const aOpenAfter: IvcmEntityForm = nil): IvcmContainedForm; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 protected
 // protected fields
   f_IsControlledObjectsChanging : Boolean;
 protected
 // protected methods
   procedure CheckConsultationConnection;
   procedure ChangeDefaultFontSize(aInc: Boolean = True);
   procedure LogSystemInfo;
   function CanChangeDefaultFontSize(aInc: Boolean = true): Boolean;
   procedure CheckInternetConnection;
   procedure ResetControlledObjectsChanging;
     {* Сигнатура метода ResetControlledObjectsChanging }
 end;//TNemesisMainForm
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
  l3TabbedContainersDispatcher,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
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
  ,
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsEditListener.imp.pas}

type _Instance_R_ = TNemesisMainForm;

{$Include ..\View\StatusBarItems.imp.pas}


{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmContainedForm.imp.pas}

var
   { Локализуемые строки Local }
  str_CarrierLost : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CarrierLost'; rValue : 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
   { 'Произошла ошибка связи при получении ответов службы Правовой поддержки онлайн. В связи с этим ответы на ранее заданные Вами вопросы не могут быть доставлены.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
  str_InternetAbsent : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InternetAbsent'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
   { 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Возможности онлайн-проверки актуальности документов будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
  str_TotalFailure : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TotalFailure'; rValue : 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s');
   { 'Не удалось установить связь с Интернет. Возможно, отсутствует активное соединение или сетевые настройки препятствуют обращению системы ГАРАНТ к интернет-ресурсам.'+' Онлайн-проверка актуальности документов и работа со службой Правовой поддержки онлайн будут временно недоступны.'+#13#10#13#10'Для решения технических вопросов обратитесь к Вашему системному администратору. Если проблемы с интернет-соединением возникают только для системы ГАРАНТ, обратитесь в обслуживающую Вас организацию:'#13#10'%s' }
  str_CaptionForSaving : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CaptionForSaving'; rValue : 'ГАРАНТ аэро');
   { 'ГАРАНТ аэро' }

var
   { Локализуемые строки utMainWindowLocalConstants }
  str_utMainWindowCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowCaption'; rValue : 'Главное окно');
   { Заголовок пользовательского типа "Главное окно" }
  str_utMainWindowSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
   { Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

// start class TNemesisMainForm

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

function TNemesisMainForm.CanChangeDefaultFontSize(aInc: Boolean = true): Boolean;
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
  anOp: TListLogicOperation = LLO_NONE): Boolean;
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

procedure TNemesisMainForm.Loadable_Load(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Loadable_Load_Execute(Node, Data, nOp);
end;

procedure TNemesisMainForm.FillList(const aList: InscStatusBarItemDefsList);
//#UC START# *4A8E5E4702C6_4958D2EA00CC_var*
//#UC END# *4A8E5E4702C6_4958D2EA00CC_var*
begin
//#UC START# *4A8E5E4702C6_4958D2EA00CC_impl*
 aList.Add(TnscStatusBarOperationDef.MakeSNoCaption(TdmStdRes.opcode_System_CantReceiveLegalServiceAnswer, True, True, 10000, nsc_ttkWarning));
//#UC END# *4A8E5E4702C6_4958D2EA00CC_impl*
end;//TNemesisMainForm.FillList

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Test(const aParams: IvcmTestParamsPrim);
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

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_GetState(var State: TvcmOperationStateIndex);
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

procedure TNemesisMainForm.System_CantReceiveLegalServiceAnswer_Execute(const aParams: IvcmExecuteParamsPrim);
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

procedure TNemesisMainForm.UnderControlNotificationChanged;
//#UC START# *55D42A4A0031_4958D2EA00CC_var*
//#UC END# *55D42A4A0031_4958D2EA00CC_var*
begin
//#UC START# *55D42A4A0031_4958D2EA00CC_impl*
 f_IsControlledObjectsChanging := TnsUnderControlNotificationManager.Instance.HasChanged;
//#UC END# *55D42A4A0031_4958D2EA00CC_impl*
end;//TNemesisMainForm.UnderControlNotificationChanged

procedure TNemesisMainForm.Cleanup;
//#UC START# *479731C50290_4958D2EA00CC_var*
//#UC END# *479731C50290_4958D2EA00CC_var*
begin
//#UC START# *479731C50290_4958D2EA00CC_impl*
 TnsUnderControlNotificationManager.Instance.Unsubscribe(Self);
 f_CarrierLostHint := nil;
 inherited;
//#UC END# *479731C50290_4958D2EA00CC_impl*
end;//TNemesisMainForm.Cleanup

{$If not defined(NoVCM)}
procedure TNemesisMainForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4958D2EA00CC_var*
//#UC END# *49803F5503AA_4958D2EA00CC_var*
begin
//#UC START# *49803F5503AA_4958D2EA00CC_impl*
 inherited;
 TnsUnderControlNotificationManager.Instance.Subscribe(Self);
 f_IsControlledObjectsChanging := TnsUnderControlNotificationManager.Instance.HasChanged;
//#UC END# *49803F5503AA_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoInit
{$IfEnd} //not NoVCM

function TNemesisMainForm.NeedsStatusBarItems: Boolean;
//#UC START# *4A8E5CEC021F_4958D2EA00CC_var*
//#UC END# *4A8E5CEC021F_4958D2EA00CC_var*
begin
//#UC START# *4A8E5CEC021F_4958D2EA00CC_impl*
 CheckConsultationConnection;
 Result := f_CantReceiveAnswer or f_InternetDisconnected or defDataAdapter.RevisionCheckEnabled;
//#UC END# *4A8E5CEC021F_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedsStatusBarItems

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TNemesisMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_var*
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_var*
begin
//#UC START# *4C8DDE6B01A6_4958D2EA00CC_impl*
 inherited;
 TnsBackEvent.Log;
//#UC END# *4C8DDE6B01A6_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoBack
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TNemesisMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4958D2EA00CC_var*
//#UC END# *4C8DDEA5007E_4958D2EA00CC_var*
begin
//#UC START# *4C8DDEA5007E_4958D2EA00CC_impl*
 inherited;
 TnsForwardEvent.Log;
//#UC END# *4C8DDEA5007E_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoForward
{$IfEnd} //not NoVCM

procedure TNemesisMainForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CarrierLostHint := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_sdsMainWindow := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TNemesisMainForm.ClearFields

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TNemesisMainForm.NeedUseTabs: Boolean;
//#UC START# *537DB22C0249_4958D2EA00CC_var*
//#UC END# *537DB22C0249_4958D2EA00CC_var*
begin
//#UC START# *537DB22C0249_4958D2EA00CC_impl*
 Result := inherited NeedUseTabs;
//#UC END# *537DB22C0249_4958D2EA00CC_impl*
end;//TNemesisMainForm.NeedUseTabs
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

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

{$If not defined(NoVCM)}
function TNemesisMainForm.LimitOpenedWindowsCount: Boolean;
//#UC START# *53AD2E740057_4958D2EA00CC_var*
//#UC END# *53AD2E740057_4958D2EA00CC_var*
begin
//#UC START# *53AD2E740057_4958D2EA00CC_impl*
 Result := not NeedUseTabs;
//#UC END# *53AD2E740057_4958D2EA00CC_impl*
end;//TNemesisMainForm.LimitOpenedWindowsCount
{$IfEnd} //not NoVCM

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

{$If not defined(NoVCM)}
function TNemesisMainForm.DoGetCaptionForSaving: AnsiString;
//#UC START# *540953180034_4958D2EA00CC_var*
//#UC END# *540953180034_4958D2EA00CC_var*
begin
//#UC START# *540953180034_4958D2EA00CC_impl*
 Result := str_CaptionForSaving.AsStr;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564737453
//#UC END# *540953180034_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoGetCaptionForSaving
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
procedure TNemesisMainForm.DoOnContainerIsClosing;
//#UC START# *54363DD90183_4958D2EA00CC_var*
//#UC END# *54363DD90183_4958D2EA00CC_var*
begin
//#UC START# *54363DD90183_4958D2EA00CC_impl*
 inherited;
 DropChangeStatusToOpened;
//#UC END# *54363DD90183_4958D2EA00CC_impl*
end;//TNemesisMainForm.DoOnContainerIsClosing
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

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

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
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
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TNemesisMainForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_System, nil);
  PublishFormEntity(en_Common, nil);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOp(en_System, op_CantReceiveLegalServiceAnswer, System_CantReceiveLegalServiceAnswer_Execute, System_CantReceiveLegalServiceAnswer_Test, System_CantReceiveLegalServiceAnswer_GetState);
  ShowInContextMenu(en_System, op_CantReceiveLegalServiceAnswer, false);
  ShowInToolbar(en_System, op_CantReceiveLegalServiceAnswer, false);
 end;//with Entities.Entities
end;

procedure TNemesisMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(utMainWindowName,
  str_utMainWindowCaption,
  str_utMainWindowSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utMainWindowName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_CarrierLost
 str_CarrierLost.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_InternetAbsent
 str_InternetAbsent.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_TotalFailure
 str_TotalFailure.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_CaptionForSaving
 str_CaptionForSaving.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utMainWindowCaption
 str_utMainWindowCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utMainWindowSettingsCaption
 str_utMainWindowSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация NemesisMain
 TtfwClassRef.Register(TNemesisMainForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.