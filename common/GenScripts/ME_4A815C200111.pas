{$IfNDef HyperlinkProcessor_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessor.imp.pas"
// Стереотип: "VCMForm"

{$Define HyperlinkProcessor_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _HyperlinkProcessor_ = {abstract} class(_HyperlinkProcessor_Parent_, IbsHyperLinkProcessorHelper)
  {* Обработчик гиперссылок }
  protected
   function pm_GetHyperlinkText: TevCustomEditorWindow; virtual; abstract;
   function JumpTo(Sender: TObject;
    anEffects: TafwJumpToEffects;
    const aMoniker: IevMoniker): Boolean;
    {* Обработчик гиперссылки }
   procedure GetHotSpotInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo);
    {* Обработчик события OnGetHotSpotInfo }
   procedure DoSetHyperlinkCallStatus(aValue: Boolean); virtual;
    {* Выставляет флаг, определяющий произведенный переход по ссылке }
   function NeedJumpTo(const aHyperlink: IevHyperlink): Boolean; virtual;
   function GetBehaviourFromEffects(anEffects: TafwJumpToEffects): TbsProcessHyperLinkBehaviour; virtual;
   function MakeContainerForBehaviour(aBehaviour: TbsProcessHyperLinkBehaviour): IvcmContainer;
   function DoProcessExternalOperation(const anOperation: IExternalOperation): Boolean; virtual; abstract;
    {* Обработчик внешней операции }
   function DoMakeLinkDocInfo(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal): IdeDocInfo; virtual;
   function DoProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; virtual;
    {* Обработка локальных ссылок }
   function DoProcessGlobalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; virtual;
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub); virtual; abstract;
    {* Переход на точку в документе }
   procedure OpenRedactionLocalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); virtual; abstract;
    {* Открывает локальную ссылку на другую редакцию }
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); virtual; abstract;
   function HyperlinkDocument: IDocument; virtual; abstract;
    {* Документ ИЗ которого ведёт ссылка }
   procedure GetNonHyperlinkInfo(Sender: TObject;
    const aHotSpot: IevHotSpot;
    const aKeys: TafwCursorState;
    var theInfo: TafwCursorInfo); virtual;
    {* Возвращает информацию о курсоре НЕ НАД ССЫЛКОЙ }
   function IsFloating: Boolean; virtual; abstract;
    {* Форма плавающая }
   procedure DoCheckLinkInfo(const aLink: IevHyperlink); virtual;
   function MakeContainer: IvcmContainer;
    {* Создать параметры на которых будут делаться вызовы операций }
   function MakeNewMainWindow: IvcmContainer;
    {* Открыть новое главное окно и вернуть параметры для него }
   function ProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
   procedure CheckLinkInfo(const aLink: IevHyperlink);
   function MakeLinkDocInfo(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal): IdeDocInfo;
   function ProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
   function ProcessGlobalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
   function MakeTabbedContainer(aNeedActivate: Boolean): IvcmContainer;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property HyperlinkText: TevCustomEditorWindow
    read pm_GetHyperlinkText;
    {* Текст, содержащий гиперссылку }
 end;//_HyperlinkProcessor_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_HyperlinkProcessor_ = _HyperlinkProcessor_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else HyperlinkProcessor_imp}

{$IfNDef HyperlinkProcessor_imp_impl}

{$Define HyperlinkProcessor_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _HyperlinkProcessor_.JumpTo(Sender: TObject;
 anEffects: TafwJumpToEffects;
 const aMoniker: IevMoniker): Boolean;
 {* Обработчик гиперссылки }
//#UC START# *4A8199EE00F2_4A815C200111_var*
//#UC END# *4A8199EE00F2_4A815C200111_var*
begin
//#UC START# *4A8199EE00F2_4A815C200111_impl*
 Result := false;
 if Supports(aMoniker, IevHyperlink, l_HyperLink) then
  try
   HyperlinkText.SetFocus;

   // http://mdp.garant.ru/pages/viewpage.action?pageId=460286108
   if not NeedJumpTo(l_Hyperlink) then
   begin
    Result := True;
    Exit;
   end;

   // http://mdp.garant.ru/pages/viewpage.action?pageId=352452629
   DoSetHyperlinkCallStatus(True);

   Result := nsProcessHyperLink(l_HyperLink, GetBehaviourFromEffects(anEffects),
    Self, Aggregate, HyperlinkDocument);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=340174500

  (* Result := nsProcessHyperLink(l_HyperLink, (afw_jteRequestNewWindow in anEffects) or
                               afw.Settings.LoadBoolean(pi_Document_OpenInNewWindow,
                                          dv_Document_OpenInNewWindow), Self, Aggregate, HyperlinkDocument);
  *)
   if not Result then
    DoSetHyperlinkCallStatus(False);
  finally
   l_HyperLink := nil;
  end;//try..finally
//#UC END# *4A8199EE00F2_4A815C200111_impl*
end;//_HyperlinkProcessor_.JumpTo

procedure _HyperlinkProcessor_.GetHotSpotInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
 {* Обработчик события OnGetHotSpotInfo }
//#UC START# *4A82C02701E4_4A815C200111_var*
//#UC END# *4A82C02701E4_4A815C200111_var*
begin
//#UC START# *4A82C02701E4_4A815C200111_impl*
 if Supports(aHotSpot, IevHyperlink, l_Hyperlink) then
  nsCheckHyperLinkInfo(l_Hyperlink, Self, theInfo, HyperlinkDocument)
 else
  GetNonHyperlinkInfo(Sender, aHotSpot, aKeys, theInfo); 
//#UC END# *4A82C02701E4_4A815C200111_impl*
end;//_HyperlinkProcessor_.GetHotSpotInfo

procedure _HyperlinkProcessor_.DoSetHyperlinkCallStatus(aValue: Boolean);
 {* Выставляет флаг, определяющий произведенный переход по ссылке }
//#UC START# *4F382E2D01C1_4A815C200111_var*
//#UC END# *4F382E2D01C1_4A815C200111_var*
begin
//#UC START# *4F382E2D01C1_4A815C200111_impl*
 // - ничего, не делаем, пусть потомки перекрывают, если хотят
//#UC END# *4F382E2D01C1_4A815C200111_impl*
end;//_HyperlinkProcessor_.DoSetHyperlinkCallStatus

function _HyperlinkProcessor_.NeedJumpTo(const aHyperlink: IevHyperlink): Boolean;
//#UC START# *520234BD015B_4A815C200111_var*
//#UC END# *520234BD015B_4A815C200111_var*
begin
//#UC START# *520234BD015B_4A815C200111_impl*
 Result := True;
//#UC END# *520234BD015B_4A815C200111_impl*
end;//_HyperlinkProcessor_.NeedJumpTo

function _HyperlinkProcessor_.GetBehaviourFromEffects(anEffects: TafwJumpToEffects): TbsProcessHyperLinkBehaviour;
//#UC START# *53A95A1A0073_4A815C200111_var*

 function lp_CorrectBehaviour(aBehaviour: TnsProcessHyperLinkBehaviour): TnsProcessHyperLinkBehaviour;
 var
  l_OpenKind: TvcmMainFormOpenKind;
 begin
  Result := aBehaviour;
  l_OpenKind := nsLinksFromDocumentOpenKind;
  if (aBehaviour = phbInSameContainer) then
  begin
   case l_OpenKind of
    vcm_okInCurrentTab:
     Result := phbInSameContainer;
    vcm_okInNewTab:
     if (anEffects = []) then
      Result := phbInNewTabActivate
     else
     if (anEffects = [afw_jteRequestNewTab]) then
      Result := phbInNewTabNoActivate;
    vcm_okInNewWindow:
     Result := phbInNewWindow;
   end;
  end
  else
  if (aBehaviour = phbInNewTabNoActivate) then
   Result := aBehaviour;
 end;//lp_CorrectBehaviour

const
 cBehaviourToEffectsArr: array[TnsProcessHyperLinkBehaviour] of TafwJumpToEffects =
  ([], //phbInSameContainer
   [afw_jteRequestNewTab, afw_jteRequestNoActivate], //phbInNewTabNoActivate
   [afw_jteRequestNewTab], //phbInNewTabActivate
   [afw_jteRequestNewWindow]);//phpInNewWindow
var
 l_Index: TnsProcessHyperLinkBehaviour;
 l_BehaviourFromEffects: TnsProcessHyperLinkBehaviour;
//#UC END# *53A95A1A0073_4A815C200111_var*
begin
//#UC START# *53A95A1A0073_4A815C200111_impl*
 l_BehaviourFromEffects := phbInSameContainer;
 for l_Index := Low(TnsProcessHyperLinkBehaviour) to High(TnsProcessHyperLinkBehaviour) do
  if (cBehaviourToEffectsArr[l_Index] = anEffects) then
  begin
   l_BehaviourFromEffects := l_Index;
   Break;
  end;
 Result := lp_CorrectBehaviour(l_BehaviourFromEffects);
//#UC END# *53A95A1A0073_4A815C200111_impl*
end;//_HyperlinkProcessor_.GetBehaviourFromEffects

function _HyperlinkProcessor_.MakeContainerForBehaviour(aBehaviour: TbsProcessHyperLinkBehaviour): IvcmContainer;
//#UC START# *54D3144F0227_4A815C200111_var*
//#UC END# *54D3144F0227_4A815C200111_var*
begin
//#UC START# *54D3144F0227_4A815C200111_impl*
 case aBehaviour of
  phbInSameContainer:
   Result := nil;
  phbInNewTabNoActivate:
   Result := MakeTabbedContainer(False);
  phbInNewTabActivate:
   Result := MakeTabbedContainer(True);
  phbInNewWindow:
   Result := MakeNewMainWindow;
 else
  Assert(False);
 end;//case aBehaviour
//#UC END# *54D3144F0227_4A815C200111_impl*
end;//_HyperlinkProcessor_.MakeContainerForBehaviour

function _HyperlinkProcessor_.DoMakeLinkDocInfo(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal): IdeDocInfo;
//#UC START# *4A815FB3005D_4A815C200111_var*
//#UC END# *4A815FB3005D_4A815C200111_var*
begin
//#UC START# *4A815FB3005D_4A815C200111_impl*
 Result := TdeDocInfo.Make(aDocument, TbsDocPos_C(aPointType, aSub));
//#UC END# *4A815FB3005D_4A815C200111_impl*
end;//_HyperlinkProcessor_.DoMakeLinkDocInfo

function _HyperlinkProcessor_.DoProcessLocalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Обработка локальных ссылок }
//#UC START# *4A8160720125_4A815C200111_var*
//#UC END# *4A8160720125_4A815C200111_var*
begin
//#UC START# *4A8160720125_4A815C200111_impl*
 Result := true;
 if aDocument.IsSameRedaction(HyperlinkDocument) then
 begin
  // Переход по локальной ссылке в текущей редакции документа
  if (aBehaviour = phbInSameContainer) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=569213206
  begin
   Dispatcher.History.SaveState(Self.As_IvcmEntityForm, vcm_stPosition);
   GoToPoint(aSub);
  end
  else
   Result := False;
 end//aDocument.IsSameRedaction(HyperlinkDocument) 
 else
  // Переход по локальной ссылке на другую редакцию документа
  OpenRedactionLocalLink(aDocument, aSub, aBehaviour);
//#UC END# *4A8160720125_4A815C200111_impl*
end;//_HyperlinkProcessor_.DoProcessLocalLink

function _HyperlinkProcessor_.DoProcessGlobalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
//#UC START# *53A2F4B30119_4A815C200111_var*
//#UC END# *53A2F4B30119_4A815C200111_var*
begin
//#UC START# *53A2F4B30119_4A815C200111_impl*
 Result := //(aBehaviour = phbInNewWindow) and // это сделано для открытия СР в новом окне
           aDocument.IsSameDocument(HyperlinkDocument) and
           not aDocument.IsSameRedaction(HyperlinkDocument);
 if Result then
  OpenRedactionGlobalLink(aDocument, aSub, aBehaviour);
//#UC END# *53A2F4B30119_4A815C200111_impl*
end;//_HyperlinkProcessor_.DoProcessGlobalLink

procedure _HyperlinkProcessor_.GetNonHyperlinkInfo(Sender: TObject;
 const aHotSpot: IevHotSpot;
 const aKeys: TafwCursorState;
 var theInfo: TafwCursorInfo);
 {* Возвращает информацию о курсоре НЕ НАД ССЫЛКОЙ }
//#UC START# *4A890E81030B_4A815C200111_var*
//#UC END# *4A890E81030B_4A815C200111_var*
begin
//#UC START# *4A890E81030B_4A815C200111_impl*
 // - ничего не делаем
//#UC END# *4A890E81030B_4A815C200111_impl*
end;//_HyperlinkProcessor_.GetNonHyperlinkInfo

procedure _HyperlinkProcessor_.DoCheckLinkInfo(const aLink: IevHyperlink);
//#UC START# *4A8A9E2A004F_4A815C200111_var*
//#UC END# *4A8A9E2A004F_4A815C200111_var*
begin
//#UC START# *4A8A9E2A004F_4A815C200111_impl*
 // - ничего не делаем
//#UC END# *4A8A9E2A004F_4A815C200111_impl*
end;//_HyperlinkProcessor_.DoCheckLinkInfo

function _HyperlinkProcessor_.MakeContainer: IvcmContainer;
 {* Создать параметры на которых будут делаться вызовы операций }
//#UC START# *4A7687C702C8_4A815C200111_var*
//#UC END# *4A7687C702C8_4A815C200111_var*
begin
//#UC START# *4A7687C702C8_4A815C200111_impl*
 if IsFloating then
  Result := vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer
 else
  Result := NativeMainForm;
//#UC END# *4A7687C702C8_4A815C200111_impl*
end;//_HyperlinkProcessor_.MakeContainer

function _HyperlinkProcessor_.MakeNewMainWindow: IvcmContainer;
 {* Открыть новое главное окно и вернуть параметры для него }
//#UC START# *4A7687F0016D_4A815C200111_var*
//#UC END# *4A7687F0016D_4A815C200111_var*
begin
//#UC START# *4A7687F0016D_4A815C200111_impl*
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  Result := nsOpenNewWindowTabbed(MakeContainer, vcm_okInNewWindow)
 else
 if IsFloating then
  Result := nsOpenNewWindowParams(vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer)
 else
  Result := nsOpenNewWindowParams(NativeMainForm);
//#UC END# *4A7687F0016D_4A815C200111_impl*
end;//_HyperlinkProcessor_.MakeNewMainWindow

function _HyperlinkProcessor_.ProcessExternalOperation(const anOperation: IExternalOperation): Boolean;
//#UC START# *4A76CDFA014B_4A815C200111_var*
//#UC END# *4A76CDFA014B_4A815C200111_var*
begin
//#UC START# *4A76CDFA014B_4A815C200111_impl*
 Result := DoProcessExternalOperation(anOperation);
//#UC END# *4A76CDFA014B_4A815C200111_impl*
end;//_HyperlinkProcessor_.ProcessExternalOperation

procedure _HyperlinkProcessor_.CheckLinkInfo(const aLink: IevHyperlink);
//#UC START# *4A780EBF00CD_4A815C200111_var*
//#UC END# *4A780EBF00CD_4A815C200111_var*
begin
//#UC START# *4A780EBF00CD_4A815C200111_impl*
 DoCheckLinkInfo(aLink);
//#UC END# *4A780EBF00CD_4A815C200111_impl*
end;//_HyperlinkProcessor_.CheckLinkInfo

function _HyperlinkProcessor_.MakeLinkDocInfo(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal): IdeDocInfo;
//#UC START# *4A79216102C6_4A815C200111_var*
//#UC END# *4A79216102C6_4A815C200111_var*
begin
//#UC START# *4A79216102C6_4A815C200111_impl*
 Result := DoMakeLinkDocInfo(aDocument, aPointType, aSub);
//#UC END# *4A79216102C6_4A815C200111_impl*
end;//_HyperlinkProcessor_.MakeLinkDocInfo

function _HyperlinkProcessor_.ProcessLocalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
//#UC START# *4A7928E80375_4A815C200111_var*
//#UC END# *4A7928E80375_4A815C200111_var*
begin
//#UC START# *4A7928E80375_4A815C200111_impl*
 Result := DoProcessLocalLink(aDocument, aPointType, aSub, aBehaviour);
//#UC END# *4A7928E80375_4A815C200111_impl*
end;//_HyperlinkProcessor_.ProcessLocalLink

function _HyperlinkProcessor_.ProcessGlobalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
//#UC START# *53A2EF1B036C_4A815C200111_var*
//#UC END# *53A2EF1B036C_4A815C200111_var*
begin
//#UC START# *53A2EF1B036C_4A815C200111_impl*
 Result := DoProcessGlobalLink(aDocument, aPointType, aSub, aBehaviour);
//#UC END# *53A2EF1B036C_4A815C200111_impl*
end;//_HyperlinkProcessor_.ProcessGlobalLink

function _HyperlinkProcessor_.MakeTabbedContainer(aNeedActivate: Boolean): IvcmContainer;
//#UC START# *53A812BE013E_4A815C200111_var*
//#UC END# *53A812BE013E_4A815C200111_var*
begin
//#UC START# *53A812BE013E_4A815C200111_impl*
 Result := nsOpenNewWindowTabbed(MakeContainer, vcm_okInNewTab, aNeedActivate);
//#UC END# *53A812BE013E_4A815C200111_impl*
end;//_HyperlinkProcessor_.MakeTabbedContainer

{$If NOT Defined(NoVCM)}
procedure _HyperlinkProcessor_.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A815C200111_var*
//#UC END# *4A8E8F2E0195_4A815C200111_var*
begin
//#UC START# *4A8E8F2E0195_4A815C200111_impl*
 inherited;
 with HyperlinkText do
 begin
  OnJumpTo := Self.JumpTo;
  OnGetHotSpotInfo := Self.GetHotSpotInfo;
 end;//with HyperlinkText
//#UC END# *4A8E8F2E0195_4A815C200111_impl*
end;//_HyperlinkProcessor_.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf HyperlinkProcessor_imp_impl}

{$EndIf HyperlinkProcessor_imp}

