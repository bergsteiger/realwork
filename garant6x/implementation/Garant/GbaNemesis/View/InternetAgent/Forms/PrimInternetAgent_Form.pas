unit PrimInternetAgent_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/Forms/PrimInternetAgent_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::InternetAgent::View::InternetAgent::PrimInternetAgent
//
// Базаовая форма для [Интернет-агента|$124453728]
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  InternetAgentInterfaces,
  nsWebBrowser,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  Search_ScalingSupport_Controls
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimInternetAgent_utInternetAgent_UserType
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimInternetAgentForm = {form} class(_vcmChromeLikeTabIconUpdater_)
  {* Базаовая форма для [Интернет-агента|$124453728] }
 private
 // private fields
   f_Browser : TnsWebBrowser;
   f_InInit : Boolean;
   f_URL : WideString;
   f_CanBack : Boolean;
   f_CanForward : Boolean;
   f_NavigateErrorPass : Boolean;
    {* Признак, что мы "прошли" через обработчик ошибки навигации.}
   f_NavigateErrorCode : HResult;
    {* Содержит код ошибки, если мы "прошли" через обработчик ошибки навигации.}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
    {$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
   procedure BeforeNavigate(Sender: TObject;
     const pDisp: IDispatch;
     var URL: OleVariant;
     var Flags: OleVariant;
     var TargetFrameName: OleVariant;
     var PostData: OleVariant;
     var Headers: OleVariant;
     var Cancel: WordBool);
     {* Обработчик события навигации }
    {$IfEnd} //not Admin AND not Monitorings AND not XE
   procedure TitleChange(Sender: TObject;
     const Text: WideString);
    {$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
   procedure NavigateComplete(Sender: TObject;
     const pDisp: IDispatch;
     var URL: OleVariant);
    {$IfEnd} //not Admin AND not Monitorings AND not XE
   procedure Navigate(const anURL: WideString);
     {* Навигация на заданный адрес }
   procedure CommandStateChange(Sender: TObject;
     Command: Integer;
     Enable: WordBool);
     {* Реакция на смену доступности команды }
    {$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
   procedure NavigateError(Sender: TObject;
     const pDisp: IDispatch;
     var URL: OleVariant;
     var Frame: OleVariant;
     var StatusCode: OleVariant;
     var Cancel: WordBool);
     {* Обработчик события ошибка навигации }
    {$IfEnd} //not Admin AND not Monitorings AND not XE
   procedure BeforeNavigateXE(Sender: TObject;
     const pDisp: IDispatch;
     const URL: OleVariant;
     const Flags: OleVariant;
     const TargetFrameName: OleVariant;
     const PostData: OleVariant;
     const Headers: OleVariant;
     var Cancel: WordBool);
   procedure NavigateCompleteXE(Sender: TObject;
     const pDisp: IDispatch;
     const URL: OleVariant);
   procedure NavigateErrorXE(Sender: TObject;
     const pDisp: IDispatch;
     const URL: OleVariant;
     const Frame: OleVariant;
     const StatusCode: OleVariant;
     var Cancel: WordBool);
   procedure MakeBrowser;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Cut_Test(const aParams: IvcmTestParamsPrim);
     {* Вырезать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Cut_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Вырезать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
     {* Поиск }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Поиск }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
     {* Найти далее }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Найти далее }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
     {* Вставка }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Paste_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Вставка }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
     {* Возврат }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Возврат }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
     {* Выделить всё }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Выделить всё }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
     {* Снять выделение }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Снять выделение }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} //not NoVCM
   function Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
     {* Изменить масштаб }
   procedure Scalable_ChangeScale(const aParams: IvcmExecuteParams);
     {* Изменить масштаб }
   function Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
     {* Масштабирование запрещено }
   procedure Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
     {* Масштабирование запрещено }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetTabImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 protected
 // protected fields
   ViewArea : IdsInternetAgent;
 end;//TPrimInternetAgentForm

 TvcmEntityFormRef = TPrimInternetAgentForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If defined(Nemesis)}
  ,
  nsInternetUtils
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsExternalObjectPrim,
  l3Base
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  ComObj,
  shdocvw,
  UrlMon
  {$If not defined(NoVCL)}
  ,
  OleCtrls
  {$IfEnd} //not NoVCL
  ,
  Windows,
  afwFacade,
  nsConst,
  nsUtils,
  bsTypesNew,
  nsSettingsConst,
  nsQuestionsWithChoices,
  nsTabbedInterfaceTypes,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimInternetAgentForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

const
   { Идентификаторы настроек }
  pi_InternetAgent_Scale = gi_Internal + '/Новости онлайн/Масштаб';
   { Идентификатор натройки "Масштаб" }

var
   { Локализуемые строки utInternetAgentLocalConstants }
  str_utInternetAgentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utInternetAgentCaption'; rValue : 'Новости онлайн');
   { Заголовок пользовательского типа "Новости онлайн" }

type
 InsInternetAgentState = interface(IUnknown{, IvcmBase})
  {* Состояние Интернет-агента }
   ['{D4ACF593-E6B2-403E-BF8B-88C3E553312B}']
   function Get_URL: WideString;
   procedure SetParams(const anURL: WideString);
     {* Устанавливает новые параметры состояния Интернет-агента }
   property URL: WideString
     read Get_URL;
     {* Путь к странице }
  // Методы преобразования к реализуемым интерфейсам
   function As_IvcmBase: IvcmBase;
 end;//InsInternetAgentState

  TnsInternetAgentState = class(Tl3ProtoObject, InsInternetAgentState, IvcmBase {from InsInternetAgentState})
  private
  // private fields
   f_URL : WideString;
  protected
  // realized methods
   function Get_URL: WideString;
   procedure SetParams(const anURL: WideString);
     {* Устанавливает новые параметры состояния Интернет-агента }
  public
  // public methods
   class function Make(const anURL: WideString): InsInternetAgentState; reintroduce;
   constructor Create(const anURL: WideString); reintroduce;
  protected
  // Методы преобразования к реализуемым интерфейсам
   function As_IvcmBase: IvcmBase;
  end;//TnsInternetAgentState

// start class TnsInternetAgentState

class function TnsInternetAgentState.Make(const anURL: WideString): InsInternetAgentState;
var
 l_Inst : TnsInternetAgentState;
begin
 l_Inst := Create(anURL);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsInternetAgentState.Create(const anURL: WideString);
//#UC START# *49EDAB3802C8_49EDAA740295_var*
//#UC END# *49EDAB3802C8_49EDAA740295_var*
begin
//#UC START# *49EDAB3802C8_49EDAA740295_impl*
 inherited Create;
 f_URL := anURL;
//#UC END# *49EDAB3802C8_49EDAA740295_impl*
end;//TnsInternetAgentState.Create

function TnsInternetAgentState.Get_URL: WideString;
//#UC START# *49EDAAF403C0_49EDAA740295get_var*
//#UC END# *49EDAAF403C0_49EDAA740295get_var*
begin
//#UC START# *49EDAAF403C0_49EDAA740295get_impl*
 Result := f_URL;
//#UC END# *49EDAAF403C0_49EDAA740295get_impl*
end;//TnsInternetAgentState.Get_URL

procedure TnsInternetAgentState.SetParams(const anURL: WideString);
//#UC START# *49EDDC9F007A_49EDAA740295_var*
//#UC END# *49EDDC9F007A_49EDAA740295_var*
begin
//#UC START# *49EDDC9F007A_49EDAA740295_impl*
 f_URL := anURL;
//#UC END# *49EDDC9F007A_49EDAA740295_impl*
end;//TnsInternetAgentState.SetParams

// Методы преобразования к реализуемым интерфейсам

function TnsInternetAgentState.As_IvcmBase: IvcmBase;
begin
 Result := Self;
end;

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
procedure TPrimInternetAgentForm.BeforeNavigate(Sender: TObject;
  const pDisp: IDispatch;
  var URL: OleVariant;
  var Flags: OleVariant;
  var TargetFrameName: OleVariant;
  var PostData: OleVariant;
  var Headers: OleVariant;
  var Cancel: WordBool);
//#UC START# *49ED882F0024_49EC746B01E5_var*
//#UC END# *49ED882F0024_49EC746B01E5_var*
begin
//#UC START# *49ED882F0024_49EC746B01E5_impl*
 BeforeNavigateXE(Sender, pDisp, URL, Flags, TargetFrameName, PostData, Headers, Cancel);
//#UC END# *49ED882F0024_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.BeforeNavigate
{$IfEnd} //not Admin AND not Monitorings AND not XE

procedure TPrimInternetAgentForm.TitleChange(Sender: TObject;
  const Text: WideString);
//#UC START# *49ED8A6F01AE_49EC746B01E5_var*
//#UC END# *49ED8A6F01AE_49EC746B01E5_var*
begin
//#UC START# *49ED8A6F01AE_49EC746B01E5_impl*
 Caption := Text;
//#UC END# *49ED8A6F01AE_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.TitleChange

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
procedure TPrimInternetAgentForm.NavigateComplete(Sender: TObject;
  const pDisp: IDispatch;
  var URL: OleVariant);
//#UC START# *49ED8AA0026E_49EC746B01E5_var*
//#UC END# *49ED8AA0026E_49EC746B01E5_var*
begin
//#UC START# *49ED8AA0026E_49EC746B01E5_impl*
 NavigateCompleteXE(Sender, pDisp, URL);
//#UC END# *49ED8AA0026E_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NavigateComplete
{$IfEnd} //not Admin AND not Monitorings AND not XE

procedure TPrimInternetAgentForm.Navigate(const anURL: WideString);
//#UC START# *49EDE0FF002C_49EC746B01E5_var*
//#UC END# *49EDE0FF002C_49EC746B01E5_var*
begin
//#UC START# *49EDE0FF002C_49EC746B01E5_impl*
 f_URL := anURL;
 f_NavigateErrorPass := False;
 f_Browser.Navigate(anURL);
//#UC END# *49EDE0FF002C_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Navigate

procedure TPrimInternetAgentForm.CommandStateChange(Sender: TObject;
  Command: Integer;
  Enable: WordBool);
//#UC START# *49EDEDCE0015_49EC746B01E5_var*
//#UC END# *49EDEDCE0015_49EC746B01E5_var*
begin
//#UC START# *49EDEDCE0015_49EC746B01E5_impl*
 case Command of
   CSC_NAVIGATEBACK:
    f_CanBack := Enable;
   CSC_NAVIGATEFORWARD:
    f_CanForward := Enable;
   //CSC_UPDATECOMMANDS: ButtonCancel.Enabled := Enable;
 end;
//#UC END# *49EDEDCE0015_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.CommandStateChange

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(XE)}
procedure TPrimInternetAgentForm.NavigateError(Sender: TObject;
  const pDisp: IDispatch;
  var URL: OleVariant;
  var Frame: OleVariant;
  var StatusCode: OleVariant;
  var Cancel: WordBool);
//#UC START# *4A1133EF0284_49EC746B01E5_var*
//#UC END# *4A1133EF0284_49EC746B01E5_var*
begin
//#UC START# *4A1133EF0284_49EC746B01E5_impl*
 NavigateErrorXE(Sender, pDisp, URL, Frame, StatusCode, Cancel);
//#UC END# *4A1133EF0284_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NavigateError
{$IfEnd} //not Admin AND not Monitorings AND not XE

procedure TPrimInternetAgentForm.BeforeNavigateXE(Sender: TObject;
  const pDisp: IDispatch;
  const URL: OleVariant;
  const Flags: OleVariant;
  const TargetFrameName: OleVariant;
  const PostData: OleVariant;
  const Headers: OleVariant;
  var Cancel: WordBool);
//#UC START# *5175422C03AF_49EC746B01E5_var*
const
 c_GarantUserAgent: string = 'GarantF1';
var
 l_UserAgent: string;
 l_UserAgentSize: DWORD;
 //
 l_Position: Integer;
 l_DocID: Integer;
 l_SubID: Integer;
//#UC END# *5175422C03AF_49EC746B01E5_var*
begin
//#UC START# *5175422C03AF_49EC746B01E5_impl*
 if not nsIsGarantURL(URL) then
 begin
  Cancel := true;
  case MessageDlg(str_mtNotGarantDomain) of
    -1:
     nsDoShellExecute(l3CStr(URL));
    -2:
     ;
    mrCancel:
     ;
  end;//MessageDlg(inf_mtNotGarantDomain)
  Exit;
 end;//not IsGarantURL(URL)
 if nsParseLocalDocumentURL(URL, l_DocID, l_SubID) then
 begin
  Cancel := true;
  nsOpenDocumentByNumber(l_DocID, l_SubID, dptSub);
  Exit;
 end;

 if f_InInit then
  f_InInit := false
 else
  Dispatcher.History.SaveState(Self.As_IvcmEntityForm, vcm_stPosition);
 //
 l_UserAgent := '';
 //
 UrlMkGetSessionOption(URLMON_OPTION_USERAGENT, nil, 0, l_UserAgentSize, 0);
 SetLength(l_UserAgent, Pred(l_UserAgentSize));
 UrlMkGetSessionOption(URLMON_OPTION_USERAGENT, PChar(l_UserAgent), l_UserAgentSize, l_UserAgentSize, 0);
 //
 if (l_UserAgent = '') then
  l_UserAgent := 'Mozilla/4.0 (compatible)';
 //
 l_Position := Pos (Format('; %s', [c_GarantUserAgent]), l_UserAgent);
 if (l_Position < 1) then
 begin
  l_Position := Pos (Format('(%s)', [c_GarantUserAgent]), l_UserAgent);
  if (l_Position < 1) then
  begin
   l_Position := Length(l_UserAgent);
   //
   while (l_Position > 0) and (l_UserAgent [l_Position] <> ')') do
    Dec (l_Position);
   //
   if (l_Position = 0) then
    l_UserAgent := Format('%s (%s)', [l_UserAgent, c_GarantUserAgent])
   else
    Insert(Format('; %s', [c_GarantUserAgent]), l_UserAgent, l_Position);
   //
   UrlMkSetSessionOption(URLMON_OPTION_USERAGENT, PChar(l_UserAgent), Length(l_UserAgent), 0);
  end;
 end;
//#UC END# *5175422C03AF_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.BeforeNavigateXE

procedure TPrimInternetAgentForm.NavigateCompleteXE(Sender: TObject;
  const pDisp: IDispatch;
  const URL: OleVariant);
//#UC START# *517544400331_49EC746B01E5_var*
const
 c_PageNotFoundError: HResult = 404;
//#UC END# *517544400331_49EC746B01E5_var*
begin
//#UC START# *517544400331_49EC746B01E5_impl*
 f_URL := f_Browser.LocationURL;
 //
 if f_NavigateErrorPass then
 begin
  f_NavigateErrorPass := False;
  //
  if (f_NavigateErrorCode <> c_PageNotFoundError) then
  begin
   Say(err_InternetAgentNavigateError, [IntToHex(f_NavigateErrorCode, 8)]);
   //
   // Если прошли через обработчик ошибок и попали на страницу из ресурса (префикс: `res://`),
   // делаем дополнительный шаг по истории назад (в этом случае код ошибки будет меньше или равен нулю).
   if (Integer(f_NavigateErrorCode) <= 0) then
    Dispatcher.History.Back;
   //
   Dispatcher.History.Back(True); // history back and truncate
  end;
 end;
//#UC END# *517544400331_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NavigateCompleteXE

procedure TPrimInternetAgentForm.NavigateErrorXE(Sender: TObject;
  const pDisp: IDispatch;
  const URL: OleVariant;
  const Frame: OleVariant;
  const StatusCode: OleVariant;
  var Cancel: WordBool);
//#UC START# *517544E2036E_49EC746B01E5_var*
const
 c_HTTP_OK: HResult = 200;
//#UC END# *517544E2036E_49EC746B01E5_var*
begin
//#UC START# *517544E2036E_49EC746B01E5_impl*
 if (StatusCode <> c_HTTP_OK) then
 begin
  f_NavigateErrorPass := True;
  f_NavigateErrorCode := StatusCode;
 end;//StatusCode <> c_HTTP_OK
//#UC END# *517544E2036E_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NavigateErrorXE

procedure TPrimInternetAgentForm.MakeBrowser;
//#UC START# *5411790D0297_49EC746B01E5_var*
//#UC END# *5411790D0297_49EC746B01E5_var*
begin
//#UC START# *5411790D0297_49EC746B01E5_impl*
 f_Browser := TnsWebBrowser.Create(Self);
 f_Browser.Align := alClient;
 TControl(f_Browser).Parent := Self;
 f_Browser.OnBeforeNavigate2 := {$IfDef XE}Self.BeforeNavigateXE{$Else}Self.BeforeNavigate{$EndIf};
 f_Browser.OnNavigateComplete2 := {$IfDef XE}Self.NavigateCompleteXE{$Else}Self.NavigateComplete{$EndIf};
 f_Browser.OnNavigateError := {$IfDef XE}Self.NavigateErrorXE{$Else}Self.NavigateError{$EndIf};
 f_Browser.OnTitleChange := Self.TitleChange;
 f_Browser.OnCommandStateChange := Self.CommandStateChange;
 f_Browser.Scale := afw.Settings.LoadInteger(pi_InternetAgent_Scale, 100);
 SetFocusedControl(f_Browser);
//#UC END# *5411790D0297_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.MakeBrowser

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_49EC746B01E5test_var*
//#UC END# *494F89C30197_49EC746B01E5test_var*
begin
//#UC START# *494F89C30197_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_DELETE) AND OLECMDF_ENABLED) <> 0);
//#UC END# *494F89C30197_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_49EC746B01E5getstate_var*
//#UC END# *494F89C30197_49EC746B01E5getstate_var*
begin
//#UC START# *494F89C30197_49EC746B01E5getstate_impl*
 // - ничего не делаем
//#UC END# *494F89C30197_49EC746B01E5getstate_impl*
end;//TPrimInternetAgentForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_49EC746B01E5exec_var*
//#UC END# *494F89C30197_49EC746B01E5exec_var*
begin
//#UC START# *494F89C30197_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_DELETE, OLECMDEXECOPT_DODEFAULT);
//#UC END# *494F89C30197_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4951284902BD_49EC746B01E5test_var*
//#UC END# *4951284902BD_49EC746B01E5test_var*
begin
//#UC START# *4951284902BD_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_COPY) AND OLECMDF_ENABLED) <> 0);
//#UC END# *4951284902BD_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4951284902BD_49EC746B01E5exec_var*
//#UC END# *4951284902BD_49EC746B01E5exec_var*
begin
//#UC START# *4951284902BD_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT);
//#UC END# *4951284902BD_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Cut_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4951285702E1_49EC746B01E5test_var*
//#UC END# *4951285702E1_49EC746B01E5test_var*
begin
//#UC START# *4951285702E1_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_CUT) AND OLECMDF_ENABLED) <> 0);
//#UC END# *4951285702E1_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Cut_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Cut_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4951285702E1_49EC746B01E5exec_var*
//#UC END# *4951285702E1_49EC746B01E5exec_var*
begin
//#UC START# *4951285702E1_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT);
//#UC END# *4951285702E1_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Cut_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49512B5D0009_49EC746B01E5test_var*
//#UC END# *49512B5D0009_49EC746B01E5test_var*
begin
//#UC START# *49512B5D0009_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_FIND) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49512B5D0009_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_FindContext_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49512B5D0009_49EC746B01E5exec_var*
//#UC END# *49512B5D0009_49EC746B01E5exec_var*
begin
//#UC START# *49512B5D0009_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_FIND, OLECMDEXECOPT_PROMPTUSER);
//#UC END# *49512B5D0009_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_FindContext_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495130C40123_49EC746B01E5test_var*
//#UC END# *495130C40123_49EC746B01E5test_var*
begin
//#UC START# *495130C40123_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_FIND) AND OLECMDF_ENABLED) <> 0);
//#UC END# *495130C40123_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_FindNext_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495130C40123_49EC746B01E5exec_var*
//#UC END# *495130C40123_49EC746B01E5exec_var*
begin
//#UC START# *495130C40123_49EC746B01E5exec_impl*
 try
  f_Browser.ExecWB(OLECMDID_FIND, OLECMDEXECOPT_DODEFAULT);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *495130C40123_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_FindNext_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_49EC746B01E5test_var*
//#UC END# *49521D8E0295_49EC746B01E5test_var*
begin
//#UC START# *49521D8E0295_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_PRINT) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49521D8E0295_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49521D8E0295_49EC746B01E5exec_var*
//#UC END# *49521D8E0295_49EC746B01E5exec_var*
begin
//#UC START# *49521D8E0295_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER);
//#UC END# *49521D8E0295_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.File_Print_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_49EC746B01E5test_var*
//#UC END# *495220DE0298_49EC746B01E5test_var*
begin
//#UC START# *495220DE0298_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_PRINT) AND OLECMDF_ENABLED) <> 0);
//#UC END# *495220DE0298_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_49EC746B01E5exec_var*
//#UC END# *495220DE0298_49EC746B01E5exec_var*
begin
//#UC START# *495220DE0298_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER);
//#UC END# *495220DE0298_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220F2033A_49EC746B01E5test_var*
//#UC END# *495220F2033A_49EC746B01E5test_var*
begin
//#UC START# *495220F2033A_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_PRINTPREVIEW) AND OLECMDF_ENABLED) <> 0);
//#UC END# *495220F2033A_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.File_PrintPreview_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_49EC746B01E5exec_var*
//#UC END# *495220F2033A_49EC746B01E5exec_var*
begin
//#UC START# *495220F2033A_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT);
//#UC END# *495220F2033A_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495235F401C0_49EC746B01E5test_var*
//#UC END# *495235F401C0_49EC746B01E5test_var*
begin
//#UC START# *495235F401C0_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_SAVEAS) AND OLECMDF_ENABLED) <> 0);
//#UC END# *495235F401C0_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.File_Save_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495235F401C0_49EC746B01E5exec_var*
//#UC END# *495235F401C0_49EC746B01E5exec_var*
begin
//#UC START# *495235F401C0_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_PROMPTUSER);
//#UC END# *495235F401C0_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.File_Save_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EDFA3701B0_49EC746B01E5test_var*
//#UC END# *49EDFA3701B0_49EC746B01E5test_var*
begin
//#UC START# *49EDFA3701B0_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_PASTE) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49EDFA3701B0_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Paste_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Paste_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EDFA3701B0_49EC746B01E5exec_var*
//#UC END# *49EDFA3701B0_49EC746B01E5exec_var*
begin
//#UC START# *49EDFA3701B0_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT);
//#UC END# *49EDFA3701B0_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Paste_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EDFCA2006D_49EC746B01E5test_var*
//#UC END# *49EDFCA2006D_49EC746B01E5test_var*
begin
//#UC START# *49EDFCA2006D_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_UNDO) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49EDFCA2006D_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Undo_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EDFCA2006D_49EC746B01E5exec_var*
//#UC END# *49EDFCA2006D_49EC746B01E5exec_var*
begin
//#UC START# *49EDFCA2006D_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_UNDO, OLECMDEXECOPT_DODEFAULT);
//#UC END# *49EDFCA2006D_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Undo_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EDFCB100BC_49EC746B01E5test_var*
//#UC END# *49EDFCB100BC_49EC746B01E5test_var*
begin
//#UC START# *49EDFCB100BC_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_REDO) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49EDFCB100BC_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Redo_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EDFCB100BC_49EC746B01E5exec_var*
//#UC END# *49EDFCB100BC_49EC746B01E5exec_var*
begin
//#UC START# *49EDFCB100BC_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_REDO, OLECMDEXECOPT_DODEFAULT);
//#UC END# *49EDFCB100BC_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Redo_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EE01AA02BE_49EC746B01E5test_var*
//#UC END# *49EE01AA02BE_49EC746B01E5test_var*
begin
//#UC START# *49EE01AA02BE_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_SELECTALL) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49EE01AA02BE_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_SelectAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EE01AA02BE_49EC746B01E5exec_var*
//#UC END# *49EE01AA02BE_49EC746B01E5exec_var*
begin
//#UC START# *49EE01AA02BE_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT);
//#UC END# *49EE01AA02BE_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_SelectAll_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EE01BC022E_49EC746B01E5test_var*
//#UC END# *49EE01BC022E_49EC746B01E5test_var*
begin
//#UC START# *49EE01BC022E_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Browser <> nil) AND ((f_Browser.QueryStatusWB(OLECMDID_CLEARSELECTION) AND OLECMDF_ENABLED) <> 0);
//#UC END# *49EE01BC022E_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_Deselect_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EE01BC022E_49EC746B01E5exec_var*
//#UC END# *49EE01BC022E_49EC746B01E5exec_var*
begin
//#UC START# *49EE01BC022E_49EC746B01E5exec_impl*
 f_Browser.ExecWB(OLECMDID_CLEARSELECTION, OLECMDEXECOPT_DODEFAULT);
//#UC END# *49EE01BC022E_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_Deselect_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49FEDE4703B8_49EC746B01E5test_var*
//#UC END# *49FEDE4703B8_49EC746B01E5test_var*
begin
//#UC START# *49FEDE4703B8_49EC746B01E5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49FEDE4703B8_49EC746B01E5test_impl*
end;//TPrimInternetAgentForm.Edit_FindPrev_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49FEDE4703B8_49EC746B01E5exec_var*
//#UC END# *49FEDE4703B8_49EC746B01E5exec_var*
begin
//#UC START# *49FEDE4703B8_49EC746B01E5exec_impl*
 aParams.DoneStatus := vcm_dsDisabled;
//#UC END# *49FEDE4703B8_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Edit_FindPrev_Execute
{$IfEnd} //not NoVCM

function TPrimInternetAgentForm.Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
//#UC START# *4BB32C1401C0_49EC746B01E5exec_var*
//#UC END# *4BB32C1401C0_49EC746B01E5exec_var*
begin
//#UC START# *4BB32C1401C0_49EC746B01E5exec_impl*
 Result := False;
 if (f_Browser <> nil) then
 begin
  with f_Browser do
  begin
   if aInc then
    Scale := Scale + 10
   else
    Scale := Scale - 10;
   afw.Settings.SaveInteger(pi_InternetAgent_Scale, Scale);
  end;// f_Browser
  Result := True;
 end;//f_Browser <> nil
//#UC END# *4BB32C1401C0_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Scalable_ChangeScale_Execute

procedure TPrimInternetAgentForm.Scalable_ChangeScale(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IScalable_ChangeScale_Params) do
  ResultValue := Scalable_ChangeScale_Execute(Inc);
end;

function TPrimInternetAgentForm.Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
//#UC START# *4BB366A901D7_49EC746B01E5exec_var*
//#UC END# *4BB366A901D7_49EC746B01E5exec_var*
begin
//#UC START# *4BB366A901D7_49EC746B01E5exec_impl*
 if (f_Browser = nil) then
  Result := ccsUnknown
 else
 if f_Browser.ScaleDisabled then
  Result := ccsNo
 else
 begin
  if anInc then
  begin
   if (f_Browser.Scale < 500) then
    Result := ccsYes
   else
    Result := ccsNo;
  end//anInc
  else
  begin
   if (f_Browser.Scale > 30) then
    Result := ccsYes
   else
    Result := ccsNo;
  end;//anInc
 end;//f_Browser.ScaleDisabled
//#UC END# *4BB366A901D7_49EC746B01E5exec_impl*
end;//TPrimInternetAgentForm.Scalable_CanChangeScale_Execute

procedure TPrimInternetAgentForm.Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IScalable_CanChangeScale_Params) do
  ResultValue := Scalable_CanChangeScale_Execute(nInc);
end;

procedure TPrimInternetAgentForm.Cleanup;
//#UC START# *479731C50290_49EC746B01E5_var*
//#UC END# *479731C50290_49EC746B01E5_var*
begin
//#UC START# *479731C50290_49EC746B01E5_impl*
(* if (f_Browser <> nil) then
  f_Browser.Stop;*)
 FreeAndNil(f_Browser);
 f_InInit := false;
 inherited;
//#UC END# *479731C50290_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_49EC746B01E5_var*
//#UC END# *497469C90140_49EC746B01E5_var*
begin
//#UC START# *497469C90140_49EC746B01E5_impl*
 inherited;
 if (aNew <> nil) then
 begin
  if not Dispatcher.History.InBF then
  begin
   f_InInit := true;
   Navigate(ViewArea.URL);
  end;//not Dispatcher.History.InBF
 end;//aNew <> nil
//#UC END# *497469C90140_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimInternetAgentForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_49EC746B01E5_var*
//#UC END# *49803F5503AA_49EC746B01E5_var*
begin
//#UC START# *49803F5503AA_49EC746B01E5_impl*
 inherited;
 MakeBrowser;
 if f_Browser.CanFocus then
  f_Browser.SetFocus;
//#UC END# *49803F5503AA_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimInternetAgentForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_49EC746B01E5_var*
//#UC END# *49806ED503D5_49EC746B01E5_var*
begin
//#UC START# *49806ED503D5_49EC746B01E5_impl*
 //if (aStateType = vcm_stPosition) then
 begin
  theState := TnsInternetAgentState.Make(f_URL).As_IvcmBase;
  Result := true;
  //inherited DoSaveState(theState, aStateType);
  Exit;
 end;//aStateType = vcm_stPosition
 Result := inherited DoSaveState(theState, aStateType, aForClone);
//#UC END# *49806ED503D5_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.DoSaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimInternetAgentForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_49EC746B01E5_var*
var
 l_State : InsInternetAgentState;
 l_URL   : WideString;
//#UC END# *49807428008C_49EC746B01E5_var*
begin
//#UC START# *49807428008C_49EC746B01E5_impl*
 //if (aStateType = vcm_stPosition) then
 begin
  if (f_Browser <> nil) then
  begin
   l_URL := f_URL;
   Supports(aState, InsInternetAgentState, l_State);
   f_InInit := true;
   if (aStateType = vcm_stPosition) then
    try
     if Dispatcher.History.InBack then
     begin
      if f_CanBack then
      begin
       f_Browser.GoBack;
       f_InInit := false;
      end;//f_CanBack
     end//Dispatcher.History.InBack
     else
     begin
      if f_CanForward then
      begin
       f_Browser.GoForward;
       f_InInit := false;
      end;//f_CanForward
     end;//Dispatcher.History.InBack
    except
     on EOleError do; // - давим отсутствие истории
    end;//try..except
   if f_InInit then
    if (l_State <> nil) then
     Navigate(l_State.URL);
   Result := true;
   //inherited DoLoadState(aState, aStateType);
   if (l_State <> nil) then
    l_State.SetParams(l_URL);
   Exit;
  end;//f_Browser <> nil
 end;//aStateType = vcm_stPosition
 Result := inherited DoLoadState(aState, aStateType);
//#UC END# *49807428008C_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.DoLoadState
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TPrimInternetAgentForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_49EC746B01E5_var*
//#UC END# *543E3AA801D0_49EC746B01E5_var*
begin
//#UC START# *543E3AA801D0_49EC746B01E5_impl*
 Result := nsTabIconIndex(titNewsOnline);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565271310
//#UC END# *543E3AA801D0_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.DoGetTabImageIndex
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TPrimInternetAgentForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  ViewArea := aDsNew As IdsInternetAgent;
 end;//aDsNew = nil
end;

procedure TPrimInternetAgentForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Scalable, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, Edit_Cut_Execute, Edit_Cut_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindContext, Edit_FindContext_Execute, Edit_FindContext_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindNext, Edit_FindNext_Execute, Edit_FindNext_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Save, File_Save_Execute, File_Save_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, Edit_Paste_Execute, Edit_Paste_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, Edit_Undo_Execute, Edit_Undo_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, Edit_Redo_Execute, Edit_Redo_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, Edit_SelectAll_Execute, Edit_SelectAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, Edit_Deselect_Execute, Edit_Deselect_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindPrev, Edit_FindPrev_Execute, Edit_FindPrev_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_Scalable, op_ChangeScale, Scalable_ChangeScale, nil, nil);
  PublishOpWithResult(en_Scalable, op_CanChangeScale, Scalable_CanChangeScale, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimInternetAgentForm.MakeControls;
begin
 inherited;
 with AddUsertype(utInternetAgentName,
  str_utInternetAgentCaption,
  str_utInternetAgentCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utInternetAgentName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utInternetAgentCaption
 str_utInternetAgentCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimInternetAgent
 TtfwClassRef.Register(TPrimInternetAgentForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.