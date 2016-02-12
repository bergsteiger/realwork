unit PrimInternetAgent_Form;
 {* Базаовая форма для [Интернет-агента|$124453728] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\PrimInternetAgent_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_ScalingSupport_Controls
 , nsWebBrowser
 , InternetAgentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , l3ProtoObject
;

type
 InsInternetAgentState = interface
  {* Состояние Интернет-агента }
  ['{D4ACF593-E6B2-403E-BF8B-88C3E553312B}']
  function Get_URL: WideString;
  procedure SetParams(const anURL: WideString);
   {* Устанавливает новые параметры состояния Интернет-агента }
  function As_IvcmBase: IvcmBase;
   {* Метод приведения нашего интерфейса к IvcmBase }
  property URL: WideString
   read Get_URL;
   {* Путь к странице }
 end;//InsInternetAgentState

 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimInternetAgentForm = class(_vcmChromeLikeTabIconUpdater_)
  {* Базаовая форма для [Интернет-агента|$124453728] }
  private
   f_Browser: TnsWebBrowser;
   f_InInit: Boolean;
   f_URL: WideString;
   f_CanBack: Boolean;
   f_CanForward: Boolean;
   f_NavigateErrorPass: Boolean;
    {* Признак, что мы "прошли" через обработчик ошибки навигации. }
   f_NavigateErrorCode: HResult;
    {* Содержит код ошибки, если мы "прошли" через обработчик ошибки навигации. }
  protected
   : IdsInternetAgent;
  private
   {$If NOT Defined(XE)}
   procedure BeforeNavigate(Sender: TObject;
    const pDisp: IDispatch;
    var URL: OleVariant;
    var Flags: OleVariant;
    var TargetFrameName: OleVariant;
    var PostData: OleVariant;
    var Headers: OleVariant;
    var Cancel: WordBool);
    {* Обработчик события навигации }
   {$IfEnd} // NOT Defined(XE)
   procedure TitleChange(Sender: TObject;
    const Text: WideString);
   {$If NOT Defined(XE)}
   procedure NavigateComplete(Sender: TObject;
    const pDisp: IDispatch;
    var URL: OleVariant);
   {$IfEnd} // NOT Defined(XE)
   procedure Navigate(const anURL: WideString);
    {* Навигация на заданный адрес }
   procedure CommandStateChange(Sender: TObject;
    Command: Integer;
    Enable: WordBool);
    {* Реакция на смену доступности команды }
   {$If NOT Defined(XE)}
   procedure NavigateError(Sender: TObject;
    const pDisp: IDispatch;
    var URL: OleVariant;
    var Frame: OleVariant;
    var StatusCode: OleVariant;
    var Cancel: WordBool);
    {* Обработчик события ошибка навигации }
   {$IfEnd} // NOT Defined(XE)
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* Вырезать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindContext; override;
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindNext; override;
    {* Найти далее }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindPrev; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function ChangeScale: Boolean; override;
    {* Изменить масштаб }
   function CanChangeScale: TCanChangeScale; override;
    {* Масштабирование запрещено }
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimInternetAgentForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ComObj
 , shdocvw
 , UrlMon
 {$If NOT Defined(NoVCL)}
 , OleCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , afwFacade
 , nsConst
 , nsUtils
 , bsTypesNew
 , nsSettingsConst
 , nsQuestionsWithChoices
 , nsTabbedInterfaceTypes
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If Defined(Nemesis)}
 , nsInternetUtils
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsExternalObjectPrim
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsInternetAgentState = class(Tl3ProtoObject, InsInternetAgentState{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_URL: WideString;
  protected
   function As_IvcmBase: IvcmBase;
    {* Метод приведения нашего интерфейса к IvcmBase }
   function Get_URL: WideString;
   procedure SetParams(const anURL: WideString);
    {* Устанавливает новые параметры состояния Интернет-агента }
  public
   class function Make(const anURL: WideString): InsInternetAgentState; reintroduce;
   constructor Create(const anURL: WideString); reintroduce;
 end;//TnsInternetAgentState

const
 {* Идентификаторы настроек }
 pi_InternetAgent_Scale = gi_Internal + '/Новости онлайн/Масштаб';
  {* Идентификатор натройки "Масштаб" }
 {* Локализуемые строки utInternetAgentLocalConstants }
 str_utInternetAgentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utInternetAgentCaption'; rValue : 'Новости онлайн');
  {* Заголовок пользовательского типа "Новости онлайн" }

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
end;//TnsInternetAgentState.Make

constructor TnsInternetAgentState.Create(const anURL: WideString);
//#UC START# *49EDAB3802C8_49EDAA740295_var*
//#UC END# *49EDAB3802C8_49EDAA740295_var*
begin
//#UC START# *49EDAB3802C8_49EDAA740295_impl*
 inherited Create;
 f_URL := anURL;
//#UC END# *49EDAB3802C8_49EDAA740295_impl*
end;//TnsInternetAgentState.Create

function TnsInternetAgentState.As_IvcmBase: IvcmBase;
 {* Метод приведения нашего интерфейса к IvcmBase }
begin
 Result := Self;
end;//TnsInternetAgentState.As_IvcmBase

function TnsInternetAgentState.Get_URL: WideString;
//#UC START# *49EDAAF403C0_49EDAA740295get_var*
//#UC END# *49EDAAF403C0_49EDAA740295get_var*
begin
//#UC START# *49EDAAF403C0_49EDAA740295get_impl*
 Result := f_URL;
//#UC END# *49EDAAF403C0_49EDAA740295get_impl*
end;//TnsInternetAgentState.Get_URL

procedure TnsInternetAgentState.SetParams(const anURL: WideString);
 {* Устанавливает новые параметры состояния Интернет-агента }
//#UC START# *49EDDC9F007A_49EDAA740295_var*
//#UC END# *49EDDC9F007A_49EDAA740295_var*
begin
//#UC START# *49EDDC9F007A_49EDAA740295_impl*
 f_URL := anURL;
//#UC END# *49EDDC9F007A_49EDAA740295_impl*
end;//TnsInternetAgentState.SetParams

type _Instance_R_ = TPrimInternetAgentForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

{$If NOT Defined(XE)}
procedure TPrimInternetAgentForm.BeforeNavigate(Sender: TObject;
 const pDisp: IDispatch;
 var URL: OleVariant;
 var Flags: OleVariant;
 var TargetFrameName: OleVariant;
 var PostData: OleVariant;
 var Headers: OleVariant;
 var Cancel: WordBool);
 {* Обработчик события навигации }
//#UC START# *49ED882F0024_49EC746B01E5_var*
//#UC END# *49ED882F0024_49EC746B01E5_var*
begin
//#UC START# *49ED882F0024_49EC746B01E5_impl*
 BeforeNavigateXE(Sender, pDisp, URL, Flags, TargetFrameName, PostData, Headers, Cancel);
//#UC END# *49ED882F0024_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.BeforeNavigate
{$IfEnd} // NOT Defined(XE)

procedure TPrimInternetAgentForm.TitleChange(Sender: TObject;
 const Text: WideString);
//#UC START# *49ED8A6F01AE_49EC746B01E5_var*
//#UC END# *49ED8A6F01AE_49EC746B01E5_var*
begin
//#UC START# *49ED8A6F01AE_49EC746B01E5_impl*
 Caption := Text;
//#UC END# *49ED8A6F01AE_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.TitleChange

{$If NOT Defined(XE)}
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
{$IfEnd} // NOT Defined(XE)

procedure TPrimInternetAgentForm.Navigate(const anURL: WideString);
 {* Навигация на заданный адрес }
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
 {* Реакция на смену доступности команды }
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

{$If NOT Defined(XE)}
procedure TPrimInternetAgentForm.NavigateError(Sender: TObject;
 const pDisp: IDispatch;
 var URL: OleVariant;
 var Frame: OleVariant;
 var StatusCode: OleVariant;
 var Cancel: WordBool);
 {* Обработчик события ошибка навигации }
//#UC START# *4A1133EF0284_49EC746B01E5_var*
//#UC END# *4A1133EF0284_49EC746B01E5_var*
begin
//#UC START# *4A1133EF0284_49EC746B01E5_impl*
 NavigateErrorXE(Sender, pDisp, URL, Frame, StatusCode, Cancel);
//#UC END# *4A1133EF0284_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.NavigateError
{$IfEnd} // NOT Defined(XE)

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

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_49EC746B01E5_var*
//#UC END# *494F89C30197_49EC746B01E5_var*
begin
//#UC START# *494F89C30197_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Copy;
 {* Копировать }
//#UC START# *4951284902BD_49EC746B01E5_var*
//#UC END# *4951284902BD_49EC746B01E5_var*
begin
//#UC START# *4951284902BD_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Cut;
 {* Вырезать }
//#UC START# *4951285702E1_49EC746B01E5_var*
//#UC END# *4951285702E1_49EC746B01E5_var*
begin
//#UC START# *4951285702E1_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.FindContext;
 {* Поиск }
//#UC START# *49512B5D0009_49EC746B01E5_var*
//#UC END# *49512B5D0009_49EC746B01E5_var*
begin
//#UC START# *49512B5D0009_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49512B5D0009_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.FindContext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.FindNext;
 {* Найти далее }
//#UC START# *495130C40123_49EC746B01E5_var*
//#UC END# *495130C40123_49EC746B01E5_var*
begin
//#UC START# *495130C40123_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *495130C40123_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.FindNext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_49EC746B01E5_var*
//#UC END# *49521D8E0295_49EC746B01E5_var*
begin
//#UC START# *49521D8E0295_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_49EC746B01E5_var*
//#UC END# *495220DE0298_49EC746B01E5_var*
begin
//#UC START# *495220DE0298_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_49EC746B01E5_var*
//#UC END# *495220F2033A_49EC746B01E5_var*
begin
//#UC START# *495220F2033A_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Save;
 {* Сохранить }
//#UC START# *495235F401C0_49EC746B01E5_var*
//#UC END# *495235F401C0_49EC746B01E5_var*
begin
//#UC START# *495235F401C0_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Save
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_49EC746B01E5_var*
//#UC END# *49EDFA3701B0_49EC746B01E5_var*
begin
//#UC START# *49EDFA3701B0_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Undo;
 {* Отмена }
//#UC START# *49EDFCA2006D_49EC746B01E5_var*
//#UC END# *49EDFCA2006D_49EC746B01E5_var*
begin
//#UC START# *49EDFCA2006D_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Redo;
 {* Возврат }
//#UC START# *49EDFCB100BC_49EC746B01E5_var*
//#UC END# *49EDFCB100BC_49EC746B01E5_var*
begin
//#UC START# *49EDFCB100BC_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.SelectAll;
 {* Выделить всё }
//#UC START# *49EE01AA02BE_49EC746B01E5_var*
//#UC END# *49EE01AA02BE_49EC746B01E5_var*
begin
//#UC START# *49EE01AA02BE_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Deselect;
 {* Снять выделение }
//#UC START# *49EE01BC022E_49EC746B01E5_var*
//#UC END# *49EE01BC022E_49EC746B01E5_var*
begin
//#UC START# *49EE01BC022E_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.FindPrev;
//#UC START# *49FEDE4703B8_49EC746B01E5_var*
//#UC END# *49FEDE4703B8_49EC746B01E5_var*
begin
//#UC START# *49FEDE4703B8_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEDE4703B8_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.FindPrev
{$IfEnd} // NOT Defined(NoVCM)

function TPrimInternetAgentForm.ChangeScale: Boolean;
 {* Изменить масштаб }
//#UC START# *4BB32C1401C0_49EC746B01E5_var*
//#UC END# *4BB32C1401C0_49EC746B01E5_var*
begin
//#UC START# *4BB32C1401C0_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BB32C1401C0_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.ChangeScale

function TPrimInternetAgentForm.CanChangeScale: TCanChangeScale;
 {* Масштабирование запрещено }
//#UC START# *4BB366A901D7_49EC746B01E5_var*
//#UC END# *4BB366A901D7_49EC746B01E5_var*
begin
//#UC START# *4BB366A901D7_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BB366A901D7_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.CanChangeScale

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Copy;
 {* Копировать }
//#UC START# *4C7D0C7B0185_49EC746B01E5_var*
//#UC END# *4C7D0C7B0185_49EC746B01E5_var*
begin
//#UC START# *4C7D0C7B0185_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_49EC746B01E5_var*
//#UC END# *4C7D0CC90052_49EC746B01E5_var*
begin
//#UC START# *4C7D0CC90052_49EC746B01E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimInternetAgentForm.Cleanup;
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimInternetAgentForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimInternetAgentForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimInternetAgentForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimInternetAgentForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_49EC746B01E5_var*
//#UC END# *543E3AA801D0_49EC746B01E5_var*
begin
//#UC START# *543E3AA801D0_49EC746B01E5_impl*
 Result := nsTabIconIndex(titNewsOnline);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565271310
//#UC END# *543E3AA801D0_49EC746B01E5_impl*
end;//TPrimInternetAgentForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
 str_utInternetAgentCaption.Init;
 {* Инициализация str_utInternetAgentCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimInternetAgentForm);
 {* Регистрация PrimInternetAgent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
