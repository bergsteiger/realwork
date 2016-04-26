unit PrimQueryCard_Form;
 {* Карточка запросов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimQueryCard" MUID: (497EBA4301CA)
// Имя типа: "TPrimQueryCardForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , Search_Strange_Controls
 , QueryCardInterfaces
 , nsQueryInterfaces
 , evQueryCardInt
 , evQueryCardEditor
 , evTextSource
 , afwInterfaces
 , nevBase
 , l3Variant
 , afwNavigation
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogEvent
;

type
 TnsSendTestRequestToLegalAdviceEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsSendTestRequestToLegalAdviceEvent

 TPrimQueryCardForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Карточка запросов }
  private
   f_IsFilter: Boolean;
   f_Update: Boolean;
   f_QueryCard: IevQueryCard;
   f_Editor: TevQueryCardEditor;
    {* Поле для свойства Editor }
   f_TextSource: TevTextSource;
    {* Поле для свойства TextSource }
   f_CanWriteMgrSettings: Boolean;
    {* Поле для свойства CanWriteMgrSettings }
  protected
   dsQuery: IdsQuery;
    {* Запрос }
   f_MgrSearch: IqaMgrSearch;
  private
   procedure TextSourceGetControlItemImg(aSender: TObject;
    const aControl: TnevControlInfo;
    out theImageInfo: TnevControlImageInfo);
   procedure TextSourceDocumentChanged(aSender: TObject;
    anOldDocument: Tl3Tag;
    aNewDocument: Tl3Tag);
   procedure EditorAfterFirstPaint(Sender: TObject);
   function EditorJumpTo(Sender: TObject;
    anEffects: TafwJumpToEffects;
    const aMoniker: IevMoniker): Boolean;
   function IsQueryCardSupportFormSets: Boolean;
    {* Поддерживает ли форма сборки }
   function GetQueryType: TlgQueryType;
    {* В зависимости от UserType возвращаем тип запроса }
   procedure ReadDocument;
   procedure HandleException(anException: EqaException);
   procedure SaveConsultationCreditnails;
   procedure LoadConsultationCreditnails;
   function CalcUserNameSettings: TafwSettingId;
   function CalcUserPhoneCodeSettings: TafwSettingId;
   function CalcUserPhoneNumberSettings: TafwSettingId;
   function CalcEMailSettings: TafwSettingId;
   procedure vcmEntityFormSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    var Saved: Boolean);
    {* надо понять, зачем тут нужен Saved, и заменить на DoSaveState. }
  protected
   function CheckQuery: Boolean;
    {* Проверяет запрос на корректность и в случае ошибки выводит сообщение }
   function MakePreview: IafwDocumentPreview;
   procedure WriteMgrSettings;
   procedure MakeSearchManager(const aQuery: IQuery);
   procedure OnDateQuery(const aValue: IqaDateReqDataHolder);
   procedure OnNeedExecQuery(Sender: TObject);
   procedure OnModifiedChanged(Sender: TObject);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceStart; override;
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
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure CleanDependencies; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeHistoryNavigate; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeSingleChild(aIsFilter: Boolean); reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   function SearchParameters_IsQueryEmpty_Execute: Boolean;
   procedure SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParamsPrim);
   function SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
   procedure SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
   function SearchParameters_IsQuerySaved_Execute: Boolean;
   procedure SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_SetQuery_Execute(const aQuery: IQuery);
   procedure SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_ClearQuery_Execute;
   procedure SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameter_QueryNotSaved_Execute;
   procedure SearchParameter_QueryNotSaved(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameter_ClearMistakes_Execute;
   procedure SearchParameter_ClearMistakes(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameter_QuerySaved_Execute;
   procedure SearchParameter_QuerySaved(const aParams: IvcmExecuteParamsPrim);
   procedure CardOperation_ExpandCollapse_Test(const aParams: IvcmTestParamsPrim);
   procedure CardOperation_ExpandCollapse_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure CardOperation_DeleteAll_Test(const aParams: IvcmTestParamsPrim);
   procedure CardOperation_DeleteAll_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure CardOperation_CreateAttr_Test(const aParams: IvcmTestParamsPrim);
   procedure CardOperation_CreateAttr_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure CardOperation_OpenTreeSelection_Test(const aParams: IvcmTestParamsPrim);
   procedure CardOperation_OpenTreeSelection_Execute(const aParams: IvcmExecuteParamsPrim);
  public
   property Editor: TevQueryCardEditor
    read f_Editor;
   property TextSource: TevTextSource
    read f_TextSource;
   property CanWriteMgrSettings: Boolean
    read f_CanWriteMgrSettings
    write f_CanWriteMgrSettings;
    {* Можно ли писать состояние карточки в настройки
http://mdp.garant.ru/pages/viewpage.action?pageId=349114873&focusedCommentId=349116523#comment-349116523 }
 end;//TPrimQueryCardForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , PrimQueryCard_utqcSendConsultation_UserType
 , PrimQueryCard_utqcAttributeSearch_UserType
 , PrimQueryCard_utqcLegislationReview_UserType
 , PrimQueryCard_utqcInpharmSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , evControlParaTools
 , evdTypes
 , vtF1InterfaceConst
 , evControlContainerEX
 , ControlsBlock_Const
 , k2Tags
 , vtUtils
 , SearchRes
 , MainMenuNewRes
 , nsManagers
 , nevNavigation
 , ExternalOperationUnit
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsConst
 , ReqRow_Const
 , nsQuery
 , ConsultingUnit
 , f1QueryDocumentContainer
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
 , BaseSearchInterfaces
 , nsContextHistory
 , LoggingUnit
 , k2Base
 , nsQueryAttribute
 , nsQueryUtils
 , ContextHistoryInterfaces
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PrimQueryCardWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , ActiveX
 , l3Memory
 , l3Interfaces
 , DataAdapter
 , nsDocumentPreview
 , evEvdDataObject
 , Printers
 , nsPostingsTreeSingle
 , Classes
 , nsHAFPainter
 , nsFixedHAFMacroReplacer
 , PrimeUnit
 {$If Defined(Nemesis)}
 , eeDocumentContainer
 {$IfEnd} // Defined(Nemesis)
 , evTypes
 , ComObj
 , l3Types
 , nevTools
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evSearch
 , IOUnit
 , l3String
 , PrimQueryCard_utqcPostingOrder_UserType
;

{$If NOT Defined(NoVCM)}
type
 // ExcludeForSendConsultation

 // ExcludeForAllExceptPostingOrder

const
 cOldUserTypes = [utqcAttributeSearch, utqcPostingOrder, utqcLegislationReview, utqcInpharmSearch];
 {* Локализуемые строки utqcAttributeSearchLocalConstants }
 str_utqcAttributeSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcAttributeSearchCaption'; rValue : 'Поиск по реквизитам');
  {* Заголовок пользовательского типа "Поиск по реквизитам" }
 {* Локализуемые строки utqcPostingOrderLocalConstants }
 str_utqcPostingOrderCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcPostingOrderCaption'; rValue : 'Создание индивидуальной ленты');
  {* Заголовок пользовательского типа "Создание индивидуальной ленты" }
 {* Локализуемые строки utqcLegislationReviewLocalConstants }
 str_utqcLegislationReviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcLegislationReviewCaption'; rValue : 'Обзор изменений законодательства');
  {* Заголовок пользовательского типа "Обзор изменений законодательства" }
 {* Локализуемые строки utqcSendConsultationLocalConstants }
 str_utqcSendConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcSendConsultationCaption'; rValue : 'Правовая поддержка онлайн');
  {* Заголовок пользовательского типа "Правовая поддержка онлайн" }
 {* Локализуемые строки utqcInpharmSearchLocalConstants }
 str_utqcInpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcInpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
  {* Заголовок пользовательского типа "Поиск лекарственных средств" }

class procedure TnsSendTestRequestToLegalAdviceEvent.Log;
//#UC START# *5255425502CE_525542460297_var*
//#UC END# *5255425502CE_525542460297_var*
begin
//#UC START# *5255425502CE_525542460297_impl*
 GetLogger.AddEvent(LE_SEND_TEST_REQUEST_TO_LEGAL_ADVISE, MakeParamsList);
//#UC END# *5255425502CE_525542460297_impl*
end;//TnsSendTestRequestToLegalAdviceEvent.Log

function TPrimQueryCardForm.CheckQuery: Boolean;
 {* Проверяет запрос на корректность и в случае ошибки выводит сообщение }
//#UC START# *4C2E199E00BE_497EBA4301CA_var*
//#UC END# *4C2E199E00BE_497EBA4301CA_var*
begin
//#UC START# *4C2E199E00BE_497EBA4301CA_impl*
 if (f_MgrSearch = nil) then
  Result := False
 else
  try
   f_MgrSearch.Check;
   Result := True;
  except
   on E: EqaException do
   begin
    Result := False;
    with E.ErrorControl do
    begin
     with Req.Group do
      if not Expanded then
       Expanded := True;
     Req.SetFocus(E.ErrorControl, True);
    end;
    HandleException(E);
   end;//EqaException
  end//try..except
//#UC END# *4C2E199E00BE_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CheckQuery

function TPrimQueryCardForm.MakePreview: IafwDocumentPreview;
//#UC START# *4C2E19C50385_497EBA4301CA_var*

var
 l_PCD  : IPrimeContractData;
 l_Text : InevObject;

 procedure FillFields;

 var
  l_Para : InevPara;
  
  procedure FillField(const aMask : String; const aValue : IString);
  const
   cOpt = [ev_soGlobal, ev_soReplace, ev_soReplaceAll];
  begin//FillField
   evReplaceInPara(l_Para,
                   TevBMTextSearcher.Make(aMask, cOpt),
                   TevTextReplacer.Make(l3Str(nsCStr(aValue)), cOpt));
  end;//FillField

 var
  l_S : IString;
 begin//FillFields
  if not l_Text.QT(InevPara, l_Para) then
   Assert(false);
  l_PCD.GetArea(l_S);
  FillField('%AREA%', l_S);
  l_PCD.GetClientName(l_S);
  FillField('%USER%', l_S);
  l_PCD.GetEmail(l_S);
  FillField('%EMAIL%', l_S);
  l_PCD.GetInfoKind(l_S);
  FillField('%INFO_KIND%', l_S);
  l_PCD.GetOrganisationType(l_S);
  FillField('%ORGANISATION_TYPE%', l_S);
  l_PCD.GetProfession(l_S);
  FillField('%PROFESSION%', l_S);
  l_PCD.GetTaxes(l_S);
  FillField('%TAXES%', l_S);
  l_PCD.GetThemesName(l_S);
  FillField('%NAME%', l_S);
 end;//FillFields

var
 l_AdStream  : IStream;
 l_Name      : Il3CString;
 l_Cont      : TeeDocumentContainer;
 l_Res       : Int64;
//#UC END# *4C2E19C50385_497EBA4301CA_var*
begin
//#UC START# *4C2E19C50385_497EBA4301CA_impl*
 try
  f_MgrSearch.Save;
 except
  on E: EqaException do
  begin
   HandleException(E);
   Assert(False, 'Некорректные параметры запроса!');
  end;//EqaException
 end;//try..except
 l_PCD := DefDataAdapter.NativeAdapter.GetContractDataPrimeContractData(f_MgrSearch.Query);
 l_PCD.GetContractEvdForm(l_AdStream);
 OleCheck(l_AdStream.Seek(0, STREAM_SEEK_SET, l_Res));
 l_Cont := TeeDocumentContainer.Create;
 try
  InevTagWriter(l_Cont).WriteTag(nil, cf_EverestBin, l_AdStream, nil);
  l_Name := vcmFmt(str_PrivateNewLinePrintTitle, [f_MgrSearch.GetName4Query]);
  l_Text := InevObjectHolder(l_Cont).Obj;
  FillFields;
  Result := TnsDocumentPreview.Make(
              l_Text.AsObject,
              evDefaultPreviewCacheKey,
              TnsHAFPainter.Make(TnsFixedHAFMacroReplacer.Make(nil, l_Name, l_Name)));
 finally
  FreeAndNil(l_Cont);
 end;//try..finally
//#UC END# *4C2E19C50385_497EBA4301CA_impl*
end;//TPrimQueryCardForm.MakePreview

class function TPrimQueryCardForm.MakeSingleChild(aIsFilter: Boolean);
var
 l_Inst : TPrimQueryCardForm;
begin
 l_Inst := Create(aIsFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimQueryCardForm.MakeSingleChild

procedure TPrimQueryCardForm.WriteMgrSettings;
//#UC START# *4F69A6310375_497EBA4301CA_var*
//#UC END# *4F69A6310375_497EBA4301CA_var*
begin
//#UC START# *4F69A6310375_497EBA4301CA_impl*
 if f_CanWriteMgrSettings then
  if Assigned(f_MgrSearch) then
   f_MgrSearch.WriteSettings;
//#UC END# *4F69A6310375_497EBA4301CA_impl*
end;//TPrimQueryCardForm.WriteMgrSettings

procedure TPrimQueryCardForm.TextSourceGetControlItemImg(aSender: TObject;
 const aControl: TnevControlInfo;
 out theImageInfo: TnevControlImageInfo);
//#UC START# *52543D9F0041_497EBA4301CA_var*
var
 l_ControlType : TevControlType;
//#UC END# *52543D9F0041_497EBA4301CA_var*
begin
//#UC START# *52543D9F0041_497EBA4301CA_impl*
 if aControl.rControl.AsObject.IsKindOf(k2_typControlsBlock) then
  l_ControlType := ev_ctCollapsedPanel
 else
  l_ControlType := TevControlType(aControl.rControl.AsObject.IntA[k2_tiType]);
 Case l_ControlType of
  ev_ctCalEdit:
  begin
   theImageInfo.rImageList := vtMakeImageListWrapper(nsSearchRes.ImageList16x16);
   theImageInfo.rFirstIndex := 1;
  end;//ev_ctCalEdit
  ev_ctPictureLabel:
  begin
   theImageInfo.rImageList := vtMakeImageListWrapper(nsSearchRes.ImageList);
   if l3Same(aControl.rControl.AsObject.Owner.Owner.PCharLenA[k2_tiReqID],
             'AT_CHECK_LAW_SUPPORT_AVAILABLE', true) then
    theImageInfo.rFirstIndex := 2
   else
    theImageInfo.rFirstIndex := 0;
  end;//ev_ctPictureLabel
  ev_ctCollapsedPanel:
  begin
   if (dmMainMenuNew <> nil) then
   begin
    theImageInfo.rImageList := vtMakeImageListWrapper(dmMainMenuNew.ilSmallIcons);
    theImageInfo.rFirstIndex := -1;
   end;//dmMainMenuNew <> nil
  end;//ev_ctCollapsedPanel
  else
  begin
   theImageInfo.rImageList := vtMakeImageListWrapper(dmStdRes.SmallImageList);
   theImageInfo.rFirstIndex := -1;
  end;//else
 end;//Case l_ControlType
//#UC END# *52543D9F0041_497EBA4301CA_impl*
end;//TPrimQueryCardForm.TextSourceGetControlItemImg

procedure TPrimQueryCardForm.TextSourceDocumentChanged(aSender: TObject;
 anOldDocument: Tl3Tag;
 aNewDocument: Tl3Tag);
//#UC START# *52543DC1034A_497EBA4301CA_var*
var
 l_QueryContainer : InevQueryDocumentContainer;
//#UC END# *52543DC1034A_497EBA4301CA_var*
begin
//#UC START# *52543DC1034A_497EBA4301CA_impl*
 if (Editor <> nil) then
 begin
  IevQueryCardEditor(Editor).ClearCardCache;
  if l3IOk(Editor.TextSource.DocumentContainer.
   QueryInterface(InevQueryDocumentContainer, l_QueryContainer)) then
    l_QueryContainer.ReleaseListeners;
  if (aNewDocument <> nil) AND aNewDocument.IsValid then
  begin
   f_QueryCard := TevControlContainerEX.Make;
   f_QueryCard.LinkListener(f_MgrSearch As IevAdapterModel);
   f_QueryCard.LinkView(l_QueryContainer);
   if (f_MgrSearch <> nil) then
   begin
    f_MgrSearch.CreateTree(f_QueryCard);
    f_MgrSearch.ReadSettings;
   end;
  end; //(aNewDocument <> nil)...
 end;//Editor <> nil
//#UC END# *52543DC1034A_497EBA4301CA_impl*
end;//TPrimQueryCardForm.TextSourceDocumentChanged

procedure TPrimQueryCardForm.EditorAfterFirstPaint(Sender: TObject);
//#UC START# *52543E860039_497EBA4301CA_var*
//#UC END# *52543E860039_497EBA4301CA_var*
begin
//#UC START# *52543E860039_497EBA4301CA_impl*
 {$IfDef vcmUseProfilers}
 ProfilersManager.QueryCard.Finish;
 {$EndIf vcmUseProfilers}
//#UC END# *52543E860039_497EBA4301CA_impl*
end;//TPrimQueryCardForm.EditorAfterFirstPaint

function TPrimQueryCardForm.EditorJumpTo(Sender: TObject;
 anEffects: TafwJumpToEffects;
 const aMoniker: IevMoniker): Boolean;
//#UC START# *52543F180277_497EBA4301CA_var*
var
 l_HyperLink: IevHyperlink;
 l_Control: IevEditorControl;
 l_Req: IevComboReq;
 l_Para: InevPara;
 l_DescReq: Tl3Variant;
 l_Desc: IevDescriptionReq;
 l_DocID: LongWord;
 l_Modified: Boolean;
 l_QueryToSend: IQuery;
//#UC END# *52543F180277_497EBA4301CA_var*
begin
//#UC START# *52543F180277_497EBA4301CA_impl*
 Result := False;
 if Supports(aMoniker, IevHyperlink, l_HyperLink) then
  try
   if l_HyperLink.Exists then
   begin
    Assert(l_HyperLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = CI_ExternalOperation,'Wrong hyperlink type');
    if l_HyperLink.Para.AsObject.QT(InevPara, l_Para) then
    try
     l_DocID := l_HyperLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID;
     if (l_DocID = EOI_OPEN_ATTRIBUTE_CARD) then
     begin
      if l_Para.AsObject.QT(IevEditorControl, l_Control) then
       try
        if Supports(l_Control.Req, IevComboReq, l_Req) then
         try
          if l_Control.Enabled then
           l_Req.HyperLinkClick;
          Result := True;
         finally
          l_Req := nil;
         end;//try..finally
       finally
        l_Control := nil;
       end;//try..finally
     end//l_DocID = EOI_OPEN_ATTRIBUTE_CARD
     else
      if l_DocID = EOI_SHOW_HELP_TOPIC then
       with f_MgrSearch.QueryCard, Application.HelpSystem do
        case CardType of
         ev_qtConsultations:
          ShowTopicHelp(cHelpConsultingRules, '');
         ev_qtAttributeSearch:
          ShowTopicHelp(cHelpAttributeRules, '');
         ev_qtInpharm:
          ShowTopicHelp(cHelpSearchInpharm, '');
         else
          Assert(False);
        end//case CardType of
     else
      if l_DocID = EOI_SHOW_LC_HELP then
       Application.HelpSystem.ShowTopicHelp('page-man-search-req-fields.htm#law_calendar', '')
      else
       if l_DocID = EOI_CHANGE_COLLAPSED then
       begin
        if evInPara(l_Para.AsObject, k2_typReqRow, l_DescReq) and l_DescReq.IsValid then
         with l_DescReq.Attr[k2_tiReqID] do
          if IsValid then
          begin
           l_Desc := f_MgrSearch.QueryCard.FindDescriptionReq(AsWStr);
           if Assigned(l_Desc) then
            l_Desc.Collapsed := not l_Desc.Collapsed;
           Result := True;
          end;
       end
       else
        if (l_DocID = EOI_CHECK_LEGAL_ADVISE_AVAILABLE) and
           (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) and
           Ask(qr_CheckLegalAdviseAvailable) then
        begin
         if not defDataAdapter.ConsultationManager.CheckConsultingAvailable then
          Say(war_NoSubscription, [defDataAdapter.GetDealerInfo])
         else
         begin
          l_Modified := f_MgrSearch.Modified;
          try
           f_MgrSearch.Save(True);
           f_MgrSearch.Query.Clone(l_QueryToSend);
           try
            SaveContextNew(l_QueryToSend,
                           nsCStr(AT_LAW_SUPPORT_TEXT),
                           vcmCStr(str_CheckLegalAdviseAvailable),
                           True);
            try
             {$If not defined(Admin) AND not defined(Monitorings)}
             TnsSendTestRequestToLegalAdviceEvent.Log;
             {$IfEnd}
             l_QueryToSend.SendQuery;
             Say(inf_ConsultationSuccessCheck);
            except
             on ENoConnection do
              Say(war_NoConnectionOnSend, [defDataAdapter.GetDealerInfo]);
             on ENoSubscription do
              Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
            end;//try..except
           finally
            l_QueryToSend := nil
           end;
          finally
           f_MgrSearch.Modified := l_Modified;
          end;
         end;//if not defDataAdapter.ConsultationManager.CheckConsultingAvailable
        end;//if (l_DocID = 7) and (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) and...
    finally
     l_Para := nil;
    end;//try..finally
   end;//l_HyperLink.Exists
  finally
   l_HyperLink := nil;
  end;//try..finally
//#UC END# *52543F180277_497EBA4301CA_impl*
end;//TPrimQueryCardForm.EditorJumpTo

function TPrimQueryCardForm.IsQueryCardSupportFormSets: Boolean;
 {* Поддерживает ли форма сборки }
//#UC START# *52543FBB00E1_497EBA4301CA_var*
//#UC END# *52543FBB00E1_497EBA4301CA_var*
begin
//#UC START# *52543FBB00E1_497EBA4301CA_impl*
 Result := not (UserType in cOldUserTypes);
//#UC END# *52543FBB00E1_497EBA4301CA_impl*
end;//TPrimQueryCardForm.IsQueryCardSupportFormSets

function TPrimQueryCardForm.GetQueryType: TlgQueryType;
 {* В зависимости от UserType возвращаем тип запроса }
//#UC START# *5254400500F5_497EBA4301CA_var*
//#UC END# *5254400500F5_497EBA4301CA_var*
begin
//#UC START# *5254400500F5_497EBA4301CA_impl*
 Result := lg_qtNone;
 case UserType of
  utqcAttributeSearch: Result := lg_qtAttribute;
  utqcPostingOrder: Result := lg_qtPostingOrder;
  utqcLegislationReview: Result := lg_qtLegislationReview;
  utqcSendConsultation: Result := lg_qtSendConsultation;
  utqcInpharmSearch: Result := lg_qtInpharmSearch;
 end;
//#UC END# *5254400500F5_497EBA4301CA_impl*
end;//TPrimQueryCardForm.GetQueryType

procedure TPrimQueryCardForm.ReadDocument;
//#UC START# *525440440050_497EBA4301CA_var*
//#UC END# *525440440050_497EBA4301CA_var*
begin
//#UC START# *525440440050_497EBA4301CA_impl*
 if f_Update then
  TextSource.DocumentContainer := nil; //Пока приходится "грохать" DocumentContainer.
 TextSource.DocumentContainer := Tf1QueryDocumentContainer.Make(GetQueryType, f_MgrSearch As IevAdapterModel);
 if not Tk2Type(TextSource.Document.TagType).Prop[k2_tiBackColor].ReadOnly then
  TextSource.Document.AttrW[k2_tiBackColor, nil] := nil;
 if f_MgrSearch.QueryCard.CardType = ev_qtConsultations then
  LoadConsultationCreditnails;
//#UC END# *525440440050_497EBA4301CA_impl*
end;//TPrimQueryCardForm.ReadDocument

procedure TPrimQueryCardForm.HandleException(anException: EqaException);
//#UC START# *525440E8004E_497EBA4301CA_var*
var
 l_CardType: TevQueryType;
 l_ReqName: Il3CString;
//#UC END# *525440E8004E_497EBA4301CA_var*
begin
//#UC START# *525440E8004E_497EBA4301CA_impl*
 l_CardType := f_MgrSearch.QueryCard.CardType;
 if ((l_CardType = ev_qtConsultations) or
  (l_CardType = ev_qtSearchWithLawSupport)) and (anException is EqaRequiredValue) then
 begin
  l_ReqName := anException.ErrorControl.Req.ReqName;
  if (l3Same(l_ReqName, AT_CONSULTATION_TEXT)) or
     (l3Same(l_ReqName, AT_LAW_SUPPORT_TEXT)) then
   Say(inf_QueryTextIsEmpy)
  else
  if (l3Same(l_ReqName, AT_USER_NAME)) or
     (l3Same(l_ReqName, AT_USER_PHONE)) then
   Say(err_UserCredinailsIsEmpy)
  else
   MessageDlg(nsCStr(StringReplace(anException.Message,'&&','&',[rfReplaceAll])), 'TenQueryCard.HandleException', mtError);
 end//l_CardType = ev_qtConsultations..
 else
 if not (anException is EqaSilentAbort) then
  MessageDlg(nsCStr(StringReplace(anException.Message,'&&','&',[rfReplaceAll])), 'TenQueryCard.HandleException', mtError);
//#UC END# *525440E8004E_497EBA4301CA_impl*
end;//TPrimQueryCardForm.HandleException

procedure TPrimQueryCardForm.SaveConsultationCreditnails;
//#UC START# *5254410600C5_497EBA4301CA_var*
var
 l_Req: IqaReq;
 l_PhoneReq: IqaPhoneReq;
//#UC END# *5254410600C5_497EBA4301CA_var*
begin
//#UC START# *5254410600C5_497EBA4301CA_impl*
 with afw.Application.PermanentSettings do
 begin
  l_Req := f_MgrSearch.FindAttr(nsCStr(AT_USER_NAME));
  if Assigned(l_Req) then
   SaveString(CalcUserNameSettings, l_Req.GetReqAsString(nil));
  l_Req := f_MgrSearch.FindAttr(nsCStr(AT_USER_PHONE));
  if Assigned(l_Req) and Supports(l_Req, IqaPhoneReq, l_PhoneReq) then
  begin
   SaveString(CalcUserPhoneCodeSettings, l_PhoneReq.Code);
   SaveString(CalcUserPhoneNumberSettings, l_PhoneReq.Number);
  end;//Assigned(l_Req)
  l_Req := f_MgrSearch.FindAttr(nsCStr(AT_EMAIL));
  if Assigned(l_Req) then
   SaveString(CalcEMailSettings, l_Req.GetReqAsString(nil));
 end;//with afw.Application.Settings
//#UC END# *5254410600C5_497EBA4301CA_impl*
end;//TPrimQueryCardForm.SaveConsultationCreditnails

procedure TPrimQueryCardForm.LoadConsultationCreditnails;
//#UC START# *5254410F01DF_497EBA4301CA_var*
var
 l_Req: IqaReq;
 l_PhoneReq: IqaPhoneReq;
 l_FocusControl: IevEditorControlField;
 l_S: Il3CString;
 l_Pack: InevOp;
//#UC END# *5254410F01DF_497EBA4301CA_var*
begin
//#UC START# *5254410F01DF_497EBA4301CA_impl*
 l_FocusControl := nil;
 l_Pack := Editor.Processor.StartOp(0, True);
 try
  l_Pack.SaveUndo := False;
  with afw.Application.PermanentSettings do
  begin
   l_Req := f_MgrSearch.FindAttr(nsCStr(AT_USER_NAME));
   if (l_Req <> nil) then
   begin
    l_S := LoadString(CalcUserNameSettings);
    l_Req.EditorReq.FirstField.Text := l_S;
    if l3IsNil(l_S) then
     l_FocusControl := l_Req.EditorReq.FirstField;
   end;//l_Req <> nil
   l_Req := f_MgrSearch.FindAttr(nsCStr(AT_USER_PHONE));
   if (l_Req <> nil) and Supports(l_Req, IqaPhoneReq, l_PhoneReq) then
   begin
    l_S := LoadString(CalcUserPhoneCodeSettings);
    l_PhoneReq.Code := l_S;
    if l3IsNil(l_S) and (l_FocusControl = nil) then
     l_FocusControl := l_Req.EditorReq.FirstField;
    l_S := LoadString(CalcUserPhoneNumberSettings);
    l_PhoneReq.Number := l_S;
    if l3IsNil(l_S) and (l_FocusControl = nil) then
     l_FocusControl := (l_Req.EditorReq.FirstField as IevEditorPhoneField).GetOtherField;
   end;//l_Req <> nil
   l_Req := f_MgrSearch.FindAttr(nsCStr(AT_EMAIL));
   if (l_Req <> nil) then
   begin
    l_S := LoadString(CalcEMailSettings);
    l_Req.EditorReq.FirstField.Text := l_S;
    if l3IsNil(l_S) and (l_FocusControl = nil) then
     l_FocusControl := l_Req.EditorReq.FirstField;
   end;//l_Req <> nil
  end;//afw.Application.Settings
 finally
  l_Pack := nil;
 end;//try..finally
 if l_FocusControl = nil then
  l_FocusControl := f_MgrSearch.FindAttr(nsCStr(AT_LAW_SUPPORT_TEXT)).EditorReq.FirstField;
 l_FocusControl.Req.SetFocus(l_FocusControl, True);
//#UC END# *5254410F01DF_497EBA4301CA_impl*
end;//TPrimQueryCardForm.LoadConsultationCreditnails

function TPrimQueryCardForm.CalcUserNameSettings: TafwSettingId;
//#UC START# *5254411B0011_497EBA4301CA_var*
//#UC END# *5254411B0011_497EBA4301CA_var*
begin
//#UC START# *5254411B0011_497EBA4301CA_impl*
 Result := pi_ConsultationAttributes + '/' + AT_USER_NAME;
//#UC END# *5254411B0011_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CalcUserNameSettings

function TPrimQueryCardForm.CalcUserPhoneCodeSettings: TafwSettingId;
//#UC START# *52544150007C_497EBA4301CA_var*
//#UC END# *52544150007C_497EBA4301CA_var*
begin
//#UC START# *52544150007C_497EBA4301CA_impl*
 Result := pi_ConsultationAttributes + '/' + AT_USER_PHONE + '/Code';
//#UC END# *52544150007C_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CalcUserPhoneCodeSettings

function TPrimQueryCardForm.CalcUserPhoneNumberSettings: TafwSettingId;
//#UC START# *525441630018_497EBA4301CA_var*
//#UC END# *525441630018_497EBA4301CA_var*
begin
//#UC START# *525441630018_497EBA4301CA_impl*
 Result := pi_ConsultationAttributes + '/' + AT_USER_PHONE + '/Number';
//#UC END# *525441630018_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CalcUserPhoneNumberSettings

function TPrimQueryCardForm.CalcEMailSettings: TafwSettingId;
//#UC START# *5254418700A5_497EBA4301CA_var*
//#UC END# *5254418700A5_497EBA4301CA_var*
begin
//#UC START# *5254418700A5_497EBA4301CA_impl*
 Result := pi_ConsultationAttributes + '/' + AT_EMAIL;
//#UC END# *5254418700A5_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CalcEMailSettings

procedure TPrimQueryCardForm.MakeSearchManager(const aQuery: IQuery);
//#UC START# *5254449B030E_497EBA4301CA_var*
{$If not Defined(Admin) AND not Defined(Monitorings)}
var
 l_ContextHistory: InsContextSearchHistory;
{$IfEnd}
//#UC END# *5254449B030E_497EBA4301CA_var*
begin
//#UC START# *5254449B030E_497EBA4301CA_impl*
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 if UserType = utqcInpharmSearch then
  l_ContextHistory := nsGetContextHistory(ns_chkInpharm)
 else
  l_ContextHistory := nsGetContextHistory(ns_chkDocument);
 {$IfEnd}
 if UserType = utqcPostingOrder then
  f_MgrSearch := TqaMgrSearchForNewsLine.Make(aQuery, GetQueryType, nsCStr(CurUserType.Name),
    OnDateQuery, OnNeedExecQuery, OnModifiedChanged
    {$If not Defined(Admin) AND not Defined(Monitorings)}
    , l_ContextHistory
    {$IfEnd}
    )
 else
  f_MgrSearch := TqaMgrSearch.Make(aQuery, GetQueryType, nsCStr(CurUserType.Name),
    OnDateQuery, OnNeedExecQuery, OnModifiedChanged
    {$If not Defined(Admin) AND not Defined(Monitorings)}
    , l_ContextHistory
    {$IfEnd}
    );
//#UC END# *5254449B030E_497EBA4301CA_impl*
end;//TPrimQueryCardForm.MakeSearchManager

procedure TPrimQueryCardForm.OnDateQuery(const aValue: IqaDateReqDataHolder);
//#UC START# *525444D40315_497EBA4301CA_var*
//#UC END# *525444D40315_497EBA4301CA_var*
begin
//#UC START# *525444D40315_497EBA4301CA_impl*
{$IFDEF Monitorings}
 Assert(false);
{$ELSE}
 TdmStdRes.DateQuery(Self.As_IvcmEntityForm, aValue);
{$ENDIF Monitorings}
//#UC END# *525444D40315_497EBA4301CA_impl*
end;//TPrimQueryCardForm.OnDateQuery

procedure TPrimQueryCardForm.OnNeedExecQuery(Sender: TObject);
//#UC START# *5254451903D6_497EBA4301CA_var*
//#UC END# *5254451903D6_497EBA4301CA_var*
begin
//#UC START# *5254451903D6_497EBA4301CA_impl*
 if Assigned(Aggregate) then
  Aggregate.Operation(TdmStdRes.opcode_Result_OkExt);
//#UC END# *5254451903D6_497EBA4301CA_impl*
end;//TPrimQueryCardForm.OnNeedExecQuery

procedure TPrimQueryCardForm.OnModifiedChanged(Sender: TObject);
//#UC START# *525445250272_497EBA4301CA_var*
//#UC END# *525445250272_497EBA4301CA_var*
begin
//#UC START# *525445250272_497EBA4301CA_impl*
 if (dsQuery <> nil) then
  dsQuery.IsQuerySaved := not f_MgrSearch.Modified;
//#UC END# *525445250272_497EBA4301CA_impl*
end;//TPrimQueryCardForm.OnModifiedChanged

procedure TPrimQueryCardForm.vcmEntityFormSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 var Saved: Boolean);
 {* надо понять, зачем тут нужен Saved, и заменить на DoSaveState. }
//#UC START# *52554DFA0270_497EBA4301CA_var*
var
 l_IHistory : IqaHistory;
 l_THistory : TqaHistory;
//#UC END# *52554DFA0270_497EBA4301CA_var*
begin
//#UC START# *52554DFA0270_497EBA4301CA_impl*
 // Закроем все открытые комбобоксы.
 if (f_MgrSearch.QueryCard <> nil) then
  (f_MgrSearch.QueryCard As InevControlListener).HideDroppedControl(True);
 if not IsQueryCardSupportFormSets and (aStateType = vcm_stContent) then
 begin
  { Запишем настройки "Развернутости групп" по умолчанию }
  Self.WriteMgrSettings;
  l_THistory := TqaHistory.Create{(Self)};
  try
   if Supports(l_THistory, IqaHistory, l_IHistory) then
    try
     if f_MgrSearch.Modified then
      Saved := f_MgrSearch.Save(True)
     else
      Saved := True;
     if Saved then
     begin
      l_IHistory.Query := f_MgrSearch.Query;
      if (f_MgrSearch.QueryCard <> nil) AND
         (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) then
       l_IHistory.ConsultationSended := not f_MgrSearch.Modified;
      theState := l_IHistory as IvcmBase;
     end;
    finally
     l_IHistory := nil;
    end;
  finally
   vcmFree(l_THistory);
  end;
 end;
//#UC END# *52554DFA0270_497EBA4301CA_impl*
end;//TPrimQueryCardForm.vcmEntityFormSaveState

procedure TPrimQueryCardForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_497EBA4301CAtest_var*
//#UC END# *495220DE0298_497EBA4301CAtest_var*
begin
//#UC START# *495220DE0298_497EBA4301CAtest_impl*
 File_PrintPreview_Test(aParams);
 {$IFNDEF Admin}
 if UserType = utqcPostingOrder then
  if aParams.Op.Flag[vcm_ofEnabled] then
   if (afw.Application = nil) OR (afw.Application.PrintManager = nil) OR
      not afw.Application.PrintManager.CanPrint then
    aParams.Op.Flag[vcm_ofEnabled] := false;
 {$ENDIF Admin}
//#UC END# *495220DE0298_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.File_PrintDialog_Test

procedure TPrimQueryCardForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_497EBA4301CAexec_var*
//#UC END# *495220DE0298_497EBA4301CAexec_var*
begin
//#UC START# *495220DE0298_497EBA4301CAexec_impl*
 {$IFNDEF Admin}
 if CheckQuery then
  if (afw.Application <> nil) and (afw.Application.PrintManager <> nil) then
   afw.Application.PrintManager.PrintDialog(MakePreview);
 {$ENDIF Admin}
//#UC END# *495220DE0298_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.File_PrintDialog_Execute

procedure TPrimQueryCardForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_497EBA4301CAtest_var*
//#UC END# *495220F2033A_497EBA4301CAtest_var*
begin
//#UC START# *495220F2033A_497EBA4301CAtest_impl*
 {$IFNDEF Admin}
 if UserType = utqcPostingOrder then
 begin
  if aParams.Op.Flag[vcm_ofEnabled] then
   aParams.Op.Flag[vcm_ofEnabled] := (UserType = utqcPostingOrder) and
    (Printer.Printers.Count > 0);
 end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
 {$ELSE Admin}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 {$ENDIF Admin}
//#UC END# *495220F2033A_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.File_PrintPreview_Test

procedure TPrimQueryCardForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_497EBA4301CAexec_var*
//#UC END# *495220F2033A_497EBA4301CAexec_var*
begin
//#UC START# *495220F2033A_497EBA4301CAexec_impl*
 {$IFNDEF Admin}
 if CheckQuery then
  if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  begin
   TnsPostingsTreeSingle.Instance.OldModifed := f_MgrSearch.Modified;
   afw.Application.PrintManager.ShowPreview(MakePreview);
  end;
 {$ENDIF Admin}
//#UC END# *495220F2033A_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.File_PrintPreview_Execute

function TPrimQueryCardForm.SearchParameters_IsQueryEmpty_Execute: Boolean;
//#UC START# *4AE879D00143_497EBA4301CAexec_var*
//#UC END# *4AE879D00143_497EBA4301CAexec_var*
begin
//#UC START# *4AE879D00143_497EBA4301CAexec_impl*
 Result := not f_MgrSearch.IsSomeFieldFilled(True);
//#UC END# *4AE879D00143_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameters_IsQueryEmpty_Execute

procedure TPrimQueryCardForm.SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_IsQueryEmpty_Params) do
  ResultValue := Self.SearchParameters_IsQueryEmpty_Execute;
end;//TPrimQueryCardForm.SearchParameters_IsQueryEmpty

function TPrimQueryCardForm.SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
//#UC START# *4AE884E803AA_497EBA4301CAexec_var*
//#UC END# *4AE884E803AA_497EBA4301CAexec_var*
begin
//#UC START# *4AE884E803AA_497EBA4301CAexec_impl*
 l3FillChar(Result, SizeOf(Result));
 try
  Result.rIsQueryForFilter := f_IsFilter;
  f_MgrSearch.Save(aIgnoreError);
  if (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) then
  begin
   SaveConsultationCreditnails;
   if (dsQuery <> nil) then
    dsQuery.IsQuerySaved := True;
   f_MgrSearch.Modified := False;
  end;//f_MgrSearch.QueryCard.CardType = ev_qtConsultations
 except
  on E: EqaException do
  begin
   HandleException(E);
   Result.rHasErrors := true;
  end;//on E: EqaException
 end;//try..except

 if not Result.rHasErrors then
 begin
  Result.rQuery := f_MgrSearch.Query;
  afw.ProcessMessages;
 end;//not Result.rHasErrors
 
 Result.rAskFilters := true;
//#UC END# *4AE884E803AA_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameters_GetQuery_Execute

procedure TPrimQueryCardForm.SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_GetQuery_Params) do
  ResultValue := Self.SearchParameters_GetQuery_Execute(IgnoreError);
end;//TPrimQueryCardForm.SearchParameters_GetQuery

function TPrimQueryCardForm.SearchParameters_IsQuerySaved_Execute: Boolean;
//#UC START# *4AE8A577027D_497EBA4301CAexec_var*
//#UC END# *4AE8A577027D_497EBA4301CAexec_var*
begin
//#UC START# *4AE8A577027D_497EBA4301CAexec_impl*
 if Assigned(f_MgrSearch) then
  Result := nsIsQuerySaved(f_MgrSearch.Query)
 else
  Result := false; 
//#UC END# *4AE8A577027D_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameters_IsQuerySaved_Execute

procedure TPrimQueryCardForm.SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_IsQuerySaved_Params) do
  ResultValue := Self.SearchParameters_IsQuerySaved_Execute;
end;//TPrimQueryCardForm.SearchParameters_IsQuerySaved

procedure TPrimQueryCardForm.SearchParameters_SetQuery_Execute(const aQuery: IQuery);
//#UC START# *4AEF213001F0_497EBA4301CAexec_var*
//#UC END# *4AEF213001F0_497EBA4301CAexec_var*
begin
//#UC START# *4AEF213001F0_497EBA4301CAexec_impl*
 Editor.TextSource.Lock(Self);
 try
  if (aQuery <> nil) then
  begin
   f_MgrSearch.Query := aQuery;
   {$IFDEF Monitorings}
   f_MgrSearch.Modified := False;
   CCaption := vcmCStr(str_ChangePrivateNewsLine);
   {$ENDIF Monitorings}
  end//aQuery <> nil
  else
  begin
   {$IFDEF Monitorings}
   f_MgrSearch.Modified := False;
   CCaption := vcmCStr(str_CreatePrivateNewsLine);
   {$ENDIF Monitorings}
  end;//aQuery <> nil
 finally
  Editor.TextSource.UnLock(Self); 
 end;//try..finally 
//#UC END# *4AEF213001F0_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameters_SetQuery_Execute

procedure TPrimQueryCardForm.SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_SetQuery_Params) do
  Self.SearchParameters_SetQuery_Execute(Query);
end;//TPrimQueryCardForm.SearchParameters_SetQuery

procedure TPrimQueryCardForm.SearchParameters_ClearQuery_Execute;
//#UC START# *4AF92B09017F_497EBA4301CAexec_var*
//#UC END# *4AF92B09017F_497EBA4301CAexec_var*
begin
//#UC START# *4AF92B09017F_497EBA4301CAexec_impl*
 Editor.TextSource.Lock(Self);
 try
  if Assigned(f_MgrSearch) then
  begin
   f_MgrSearch.Clear;
   // Заплатка - "контролы модели" деражет ссылку на Para, которому при очистке
   // текста пытаются сказать InvalidateShape. Но он похоже отвязан от View
   // И мапы во вью не перестраиваются => появляется мусор.
   // 1. "контролы модели" НЕ ДОЛЖНЫ ДЕРЖАТь PARA. А сами должны быть PARA
   // 2. Манипулировать с текстом должен курсор и никакой прямой записи в k2_tiText!
   Editor.View.ClearShapes;
   if (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) then
   begin
    LoadConsultationCreditnails;
    f_MgrSearch.Modified := False;
   end//f_MgrSearch.QueryCard.CardType = ev_qtConsultations
  end;//Assigned(f_MgrSearch)
  Editor.Invalidate;
 finally
  Editor.TextSource.UnLock(Self);
 end;//try..finally
//#UC END# *4AF92B09017F_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameters_ClearQuery_Execute

procedure TPrimQueryCardForm.SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameters_ClearQuery_Execute;
end;//TPrimQueryCardForm.SearchParameters_ClearQuery

procedure TPrimQueryCardForm.SearchParameter_QueryNotSaved_Execute;
//#UC START# *4AF9370C012B_497EBA4301CAexec_var*
//#UC END# *4AF9370C012B_497EBA4301CAexec_var*
begin
//#UC START# *4AF9370C012B_497EBA4301CAexec_impl*
 f_MgrSearch.Modified := True;
//#UC END# *4AF9370C012B_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameter_QueryNotSaved_Execute

procedure TPrimQueryCardForm.SearchParameter_QueryNotSaved(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameter_QueryNotSaved_Execute;
end;//TPrimQueryCardForm.SearchParameter_QueryNotSaved

procedure TPrimQueryCardForm.SearchParameter_ClearMistakes_Execute;
//#UC START# *4AF9373C02B6_497EBA4301CAexec_var*
//#UC END# *4AF9373C02B6_497EBA4301CAexec_var*
begin
//#UC START# *4AF9373C02B6_497EBA4301CAexec_impl*
 f_MgrSearch.ClearContextMistakes;
//#UC END# *4AF9373C02B6_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameter_ClearMistakes_Execute

procedure TPrimQueryCardForm.SearchParameter_ClearMistakes(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameter_ClearMistakes_Execute;
end;//TPrimQueryCardForm.SearchParameter_ClearMistakes

procedure TPrimQueryCardForm.SearchParameter_QuerySaved_Execute;
//#UC START# *4AF9393802B0_497EBA4301CAexec_var*
//#UC END# *4AF9393802B0_497EBA4301CAexec_var*
begin
//#UC START# *4AF9393802B0_497EBA4301CAexec_impl*
 {$IFDEF Monitorings}
 CCaption := vcmCStr(str_ChangePrivateNewsLine);
 {$ENDIF Monitorings}
//#UC END# *4AF9393802B0_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.SearchParameter_QuerySaved_Execute

procedure TPrimQueryCardForm.SearchParameter_QuerySaved(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameter_QuerySaved_Execute;
end;//TPrimQueryCardForm.SearchParameter_QuerySaved

procedure TPrimQueryCardForm.CardOperation_ExpandCollapse_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2E116E0315_497EBA4301CAtest_var*
var
 l_Control : IevCustomEditorControl;
//#UC END# *4C2E116E0315_497EBA4301CAtest_var*
begin
//#UC START# *4C2E116E0315_497EBA4301CAtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 if f_MgrSearch <> nil then
 begin
  l_Control := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  if (l_Control <> nil) then
   aParams.Op.Flag[vcm_ofEnabled] := l_Control.ControlType = ev_ctCollapsedPanel;
 end;
//#UC END# *4C2E116E0315_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.CardOperation_ExpandCollapse_Test

procedure TPrimQueryCardForm.CardOperation_ExpandCollapse_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2E116E0315_497EBA4301CAexec_var*
var
 l_Group   : IevQueryGroup; 
 l_Control : IevCustomEditorControl;
//#UC END# *4C2E116E0315_497EBA4301CAexec_var*
begin
//#UC START# *4C2E116E0315_497EBA4301CAexec_impl*
 if f_MgrSearch <> nil then
 begin
  l_Control := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  if (l_Control <> nil) then   
   if Supports(l_Control, IevQueryGroup, l_Group) then
    if l_Group.CanCollapsed then
     l_Group.Expanded := not l_Group.Expanded;
 end;
//#UC END# *4C2E116E0315_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.CardOperation_ExpandCollapse_Execute

procedure TPrimQueryCardForm.CardOperation_DeleteAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2E117F022C_497EBA4301CAtest_var*
var
 l_Req: IqaReq; 
//#UC END# *4C2E117F022C_497EBA4301CAtest_var*
begin
//#UC START# *4C2E117F022C_497EBA4301CAtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 if f_MgrSearch <> nil then
 begin
  l_Req := f_MgrSearch.GetCurrentReq;
  if l_Req <> nil then
   aParams.Op.Flag[vcm_ofEnabled] := l_Req.Multi and l_Req.IsSet;
 end;//if f_MgrSearch <> nil then
//#UC END# *4C2E117F022C_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.CardOperation_DeleteAll_Test

procedure TPrimQueryCardForm.CardOperation_DeleteAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2E117F022C_497EBA4301CAexec_var*
//#UC END# *4C2E117F022C_497EBA4301CAexec_var*
begin
//#UC START# *4C2E117F022C_497EBA4301CAexec_impl*
 Editor.TextSource.Lock(Self);
 try
  if Assigned(f_MgrSearch) then
   f_MgrSearch.DeleteAll;
 finally
  Editor.TextSource.UnLock(Self);
 end; 
//#UC END# *4C2E117F022C_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.CardOperation_DeleteAll_Execute

procedure TPrimQueryCardForm.CardOperation_CreateAttr_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2E118B010B_497EBA4301CAtest_var*
var
 l_Req : IqaReq;
 l_BTN : IevEditorControlButton;
//#UC END# *4C2E118B010B_497EBA4301CAtest_var*
begin
//#UC START# *4C2E118B010B_497EBA4301CAtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 if Assigned(f_MgrSearch) then
 begin
  l_Req := f_MgrSearch.GetCurrentReq;
  if (l_Req <> nil) and l_Req.Multi then
  begin
   l_BTN := f_MgrSearch.GetCurrentField.FindButton(ev_btLogical);
   aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_BTN) and l_BTN.Visible;
  end;//if (l_Req <> nil) and l_Req.Multi then
 end;//if Assigned(f_MgrSearch) then
//#UC END# *4C2E118B010B_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.CardOperation_CreateAttr_Test

procedure TPrimQueryCardForm.CardOperation_CreateAttr_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2E118B010B_497EBA4301CAexec_var*
//#UC END# *4C2E118B010B_497EBA4301CAexec_var*
begin
//#UC START# *4C2E118B010B_497EBA4301CAexec_impl*
 if Assigned(f_MgrSearch) then
  f_MgrSearch.AddValue(Editor.View);
//#UC END# *4C2E118B010B_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.CardOperation_CreateAttr_Execute

procedure TPrimQueryCardForm.CardOperation_OpenTreeSelection_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2E11960124_497EBA4301CAtest_var*
var
 l_Req : IqaReq; 
//#UC END# *4C2E11960124_497EBA4301CAtest_var*
begin
//#UC START# *4C2E11960124_497EBA4301CAtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 if Assigned(f_MgrSearch) then
 begin
  l_Req := f_MgrSearch.GetCurrentReq; 
  if l_Req <> nil then 
   aParams.Op.Flag[vcm_ofEnabled] := l_Req.Multi and l_Req.CanOpenTree;
 end;//if Assigned(f_MgrSearch) then
//#UC END# *4C2E11960124_497EBA4301CAtest_impl*
end;//TPrimQueryCardForm.CardOperation_OpenTreeSelection_Test

procedure TPrimQueryCardForm.CardOperation_OpenTreeSelection_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2E11960124_497EBA4301CAexec_var*
//#UC END# *4C2E11960124_497EBA4301CAexec_var*
begin
//#UC START# *4C2E11960124_497EBA4301CAexec_impl*
 if Assigned(f_MgrSearch) then
  f_MgrSearch.OpenSelectWindow;
//#UC END# *4C2E11960124_497EBA4301CAexec_impl*
end;//TPrimQueryCardForm.CardOperation_OpenTreeSelection_Execute

procedure TPrimQueryCardForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_497EBA4301CA_var*
//#UC END# *479731C50290_497EBA4301CA_var*
begin
//#UC START# *479731C50290_497EBA4301CA_impl*
 if Assigned(f_MgrSearch) then
 begin
  { Свернутость/Развернутость узлов }
  Self.WriteMgrSettings;
  if l3SystemDown then // <K: 138547857>
   f_MgrSearch.Clear; // <К: 131793204> 
  {$IFDEF Monitorings}
  TnsPostingsTreeSingle.Instance.MgrSearch := nil;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=294589844
  {$ENDIF Monitorings}
  f_MgrSearch := nil;
  f_QueryCard := nil;
 end;//if Assigned(f_MgrSearch) then
 inherited;
//#UC END# *479731C50290_497EBA4301CA_impl*
end;//TPrimQueryCardForm.Cleanup

procedure TPrimQueryCardForm.InitFields;
//#UC START# *47A042E100E2_497EBA4301CA_var*
//#UC END# *47A042E100E2_497EBA4301CA_var*
begin
//#UC START# *47A042E100E2_497EBA4301CA_impl*
 inherited;
 f_CanWriteMgrSettings := true;
//#UC END# *47A042E100E2_497EBA4301CA_impl*
end;//TPrimQueryCardForm.InitFields

procedure TPrimQueryCardForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497EBA4301CA_var*
//#UC END# *47EA4E9002C6_497EBA4301CA_var*
begin
//#UC START# *47EA4E9002C6_497EBA4301CA_impl*
 inherited;
 Editor.TextSource.Lock(Self);
 try
  if Assigned(f_MgrSearch) then
  begin
   f_Update := True;
   try
    f_QueryCard := nil;
    Self.WriteMgrSettings;
    f_MgrSearch.InitUpdate;
    ReadDocument;
   finally
    f_Update := False;
   end;//try..finally
  end;//Assigned(f_MgrSearch)
 finally
  Editor.TextSource.UnLock(Self);
 end;//try..finally
//#UC END# *47EA4E9002C6_497EBA4301CA_impl*
end;//TPrimQueryCardForm.FinishDataUpdate

procedure TPrimQueryCardForm.SettingsReplaceStart;
//#UC START# *47EA8B8C03CB_497EBA4301CA_var*
//#UC END# *47EA8B8C03CB_497EBA4301CA_var*
begin
//#UC START# *47EA8B8C03CB_497EBA4301CA_impl*
 Self.WriteMgrSettings;
//#UC END# *47EA8B8C03CB_497EBA4301CA_impl*
end;//TPrimQueryCardForm.SettingsReplaceStart

procedure TPrimQueryCardForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497EBA4301CA_var*
//#UC END# *497469C90140_497EBA4301CA_var*
begin
//#UC START# *497469C90140_497EBA4301CA_impl*
 if (dsQuery <> nil) then
 begin
  Editor.TextSource.Lock(Self);
  try
   f_MgrSearch := nil;
   MakeSearchManager(dsQuery.Query);
   if not Dispatcher.History.InBF then
    ReadDocument
   else
   begin
    if (f_QueryCard <> nil) then
    begin
     f_MgrSearch.CreateTree(f_QueryCard);
     if (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) then
      f_MgrSearch.Modified := not dsQuery.IsQuerySaved;
    end;//f_QueryCard <> nil
   end;//not aFromHistory
  finally
   Editor.TextSource.UnLock(Self);
  end;//try..finally
 end;//dsQuery <> nil
//#UC END# *497469C90140_497EBA4301CA_impl*
end;//TPrimQueryCardForm.NotifyDataSourceChanged

procedure TPrimQueryCardForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_497EBA4301CA_var*
//#UC END# *49803F5503AA_497EBA4301CA_var*
begin
//#UC START# *49803F5503AA_497EBA4301CA_impl*
 inherited;
 f_Update := False;
 if not IsQueryCardSupportFormSets then
 begin
  MakeSearchManager(nil);
  if (UserType = utqcPostingOrder) then
  begin
   Assert(not (Assigned(f_MgrSearch) and Assigned(TnsPostingsTreeSingle.Instance.MgrSearch)));
   TnsPostingsTreeSingle.Instance.MgrSearch := f_MgrSearch;
  end;
  if not aFromHistory then
   ReadDocument;
 end;//not IsQueryCardSupportFormSets
//#UC END# *49803F5503AA_497EBA4301CA_impl*
end;//TPrimQueryCardForm.DoInit

function TPrimQueryCardForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_497EBA4301CA_var*
var
 l_History : IqaHistory;
//#UC END# *49807428008C_497EBA4301CA_var*
begin
//#UC START# *49807428008C_497EBA4301CA_impl*
 if (aStateType = vcm_stContent) and not IsQueryCardSupportFormSets then
  { История присутствует }
  if Supports(aState, IqaHistory, l_History) then
  try
   { Если было обновление данных, то ничего не делаем }
   if not l_History.DataReset then
   begin
    f_MgrSearch.FromHistory := True; //Чтобы не грузить лишнее
    f_MgrSearch.Query := l_History.Query;
    f_MgrSearch.FromHistory := False;
    if (f_MgrSearch.QueryCard.CardType = ev_qtConsultations) then
     f_MgrSearch.Modified := l_History.ConsultationSended
    {$IFDEF Monitorings}
    else
     f_MgrSearch.Modified := TnsPostingsTreeSingle.Instance.OldModifed;
    {$ELSE Monitorings}
     ;
    {$ENDIF Monitorings}
   end//if not l_History.DataReset then
   { Открываем форму как последную открытую }
   else
    FinishDataUpdate;
  finally
   l_History := nil;
  end//if Supports(aState, IasHistory, l_History) then
  { История отсутствует читаем настройки по "Развернутости групп" по умолчанию }
  else
  if Assigned(f_MgrSearch) then
   f_MgrSearch.ReadSettings;
//#UC END# *49807428008C_497EBA4301CA_impl*
end;//TPrimQueryCardForm.DoLoadState

procedure TPrimQueryCardForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497EBA4301CA_var*
//#UC END# *4A8E8F2E0195_497EBA4301CA_var*
begin
//#UC START# *4A8E8F2E0195_497EBA4301CA_impl*
 inherited;

 HorzScrollBar.Visible := False;
 VertScrollBar.Visible := False;
 ActiveControl := Editor;

 OnSaveState := VcmEntityFormSaveState;

 with TextSource do
 begin
  OnGetControlItemImg := TextSourceGetControlItemImg;
  OnDocumentChanged := TextSourceDocumentChanged;
 end;

 with Editor do
 begin
  TextSource := Self.TextSource;
  Color := cGarant2011BackColor;
  Cursor := crArrow;
  Align := alClient;
  ScrollStyle := ssVertical;
  OnJumpTo := EditorJumpTo;
  OnAfterFirstPaint := EditorAfterFirstPaint;
  TabOrder := 0;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_497EBA4301CA_impl*
end;//TPrimQueryCardForm.InitControls

procedure TPrimQueryCardForm.ClearFields;
begin
 f_MgrSearch := nil;
 inherited;
end;//TPrimQueryCardForm.ClearFields

procedure TPrimQueryCardForm.CleanDependencies;
//#UC START# *52544597027B_497EBA4301CA_var*
//#UC END# *52544597027B_497EBA4301CA_var*
begin
//#UC START# *52544597027B_497EBA4301CA_impl*
 inherited;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=515857991
 if UserType = utqcPostingOrder then
  if TnsPostingsTreeSingle.Instance.MgrSearch = f_MgrSearch then
   TnsPostingsTreeSingle.Instance.MgrSearch := nil;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=429695931
 f_MgrSearch := nil;
 f_QueryCard := nil;
//#UC END# *52544597027B_497EBA4301CA_impl*
end;//TPrimQueryCardForm.CleanDependencies

procedure TPrimQueryCardForm.DoBeforeHistoryNavigate;
//#UC START# *562E15F20132_497EBA4301CA_var*
//#UC END# *562E15F20132_497EBA4301CA_var*
begin
//#UC START# *562E15F20132_497EBA4301CA_impl*
 TnsPostingsTreeSingle.Instance.MgrSearch := nil;
 inherited;
//#UC END# *562E15F20132_497EBA4301CA_impl*
end;//TPrimQueryCardForm.DoBeforeHistoryNavigate

initialization
 str_utqcAttributeSearchCaption.Init;
 {* Инициализация str_utqcAttributeSearchCaption }
 str_utqcPostingOrderCaption.Init;
 {* Инициализация str_utqcPostingOrderCaption }
 str_utqcLegislationReviewCaption.Init;
 {* Инициализация str_utqcLegislationReviewCaption }
 str_utqcSendConsultationCaption.Init;
 {* Инициализация str_utqcSendConsultationCaption }
 str_utqcInpharmSearchCaption.Init;
 {* Инициализация str_utqcInpharmSearchCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimQueryCardForm);
 {* Регистрация PrimQueryCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
