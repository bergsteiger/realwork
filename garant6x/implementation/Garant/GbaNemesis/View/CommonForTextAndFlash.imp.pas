{$IfNDef CommonForTextAndFlash_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "CommonForTextAndFlash" MUID: (4986C5B30130)
// Имя типа: "_CommonForTextAndFlash_"

{$Define CommonForTextAndFlash_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlashAndMedicFirmList_Parent_ = _CommonForTextAndFlash_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CommonForTextAndFlashAndMedicFirmList.imp.pas}
 _StatusBarDocumentItems_Parent_ = _CommonForTextAndFlashAndMedicFirmList_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas}
 _UnderControlResetter_Parent_ = _StatusBarDocumentItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControlResetter.imp.pas}
 _HyperlinkToDocumentProducer_Parent_ = _UnderControlResetter_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}
 _CommonForTextAndFlash_ = {abstract} class(_HyperlinkToDocumentProducer_)
  {* Общее для документов и флеш-схем }
  protected
   sdsDocInfo: IsdsDocInfo;
   dsDocument: IdsDocument;
    {* Документ (контроллер области ввода) в виде IdsDocument. Может быть nil }
   DocumentSet: IsdsDocument;
    {* Прецедент IsdsDocument }
  private
   function GetControllable(var aDoc: IDocument): IControllable;
  protected
   procedure OpenCRListOpTest(const aParams: IvcmTestParamsPrim;
    aCRType: TlstCRType;
    aTyped: Boolean = True);
    {* Пользовательские СКР. Тестирование }
   procedure OpenUserCRListOpGetState(var State: TvcmOperationStateIndex;
    aType: TnsUserCRListId);
    {* Пользовательские СКР. Получение состояния }
   procedure OpenUserCRListOpTest(const aParams: IvcmTestParamsPrim;
    aType: TnsUserCRListId);
    {* Открыть типизированый СКР. Тестирование }
   procedure OpenCRListOpExecute(aType: TlstCRType;
    const aValue: Il3SimpleNode);
    {* Открыть типизированый СКР. Выполнение }
   procedure OpenRelatedDocOpTest(const aParams: IvcmTestParamsPrim);
   function CanAddToControl: Boolean; virtual;
    {* Можно ли поставить на контроль }
   procedure SetBookmark; virtual; abstract;
    {* Устанавливает закладку на текущее место текущего документа }
   function CanAddBookmark: Boolean; virtual; abstract;
    {* Можно ли сейчас добавлять закладку }
   function FormIsMainInDocumentSet: Boolean;
   function CanUnControl: Boolean; override;
   function pm_GetHyperlinkDocID: Integer; override;
   function pm_GetHyperlinkDocumentName: Il3CString; override;
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
    {* Поставить на контроль }
   procedure Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Поставить на контроль }
   procedure Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
    {* Поставить на контроль }
   procedure Document_UserCR1_Test(const aParams: IvcmTestParamsPrim);
    {* Коллеги, это что? }
   procedure Document_UserCR1_GetState(var State: TvcmOperationStateIndex);
    {* Коллеги, это что? }
   procedure Document_UserCR2_Test(const aParams: IvcmTestParamsPrim);
    {* Коллеги, это что? }
   procedure Document_UserCR2_GetState(var State: TvcmOperationStateIndex);
    {* Коллеги, это что? }
   procedure Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
    {* Добавить закладку }
   procedure Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Добавить закладку }
 end;//_CommonForTextAndFlash_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlashAndMedicFirmList_Parent_ = _CommonForTextAndFlash_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CommonForTextAndFlashAndMedicFirmList.imp.pas}
_StatusBarDocumentItems_Parent_ = _CommonForTextAndFlashAndMedicFirmList_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas}
_UnderControlResetter_Parent_ = _StatusBarDocumentItems_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControlResetter.imp.pas}
_HyperlinkToDocumentProducer_Parent_ = _UnderControlResetter_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}
_CommonForTextAndFlash_ = _HyperlinkToDocumentProducer_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlash_imp}

{$IfNDef CommonForTextAndFlash_imp_impl}

{$Define CommonForTextAndFlash_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CommonForTextAndFlashAndMedicFirmList.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarDocumentItems.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControlResetter.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}

function _CommonForTextAndFlash_.GetControllable(var aDoc: IDocument): IControllable;
//#UC START# *4A1FEF7C0243_4986C5B30130_var*
//#UC END# *4A1FEF7C0243_4986C5B30130_var*
begin
//#UC START# *4A1FEF7C0243_4986C5B30130_impl*
 if (sdsBaseDocument <> nil) and
    (sdsBaseDocument.DocInfo <> nil) and
    (sdsBaseDocument.DocInfo.Doc <> nil) then
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565841079
 begin
  aDoc := sdsBaseDocument.DocInfo.Doc;
  Supports(aDoc, IControllable, Result);
  if Assigned(Result) and not Result.GetCanSetToControl then
   Result := nil;
 end//sdsBaseDocument <> nil
 else
  Result := nil;
//#UC END# *4A1FEF7C0243_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.GetControllable

procedure _CommonForTextAndFlash_.OpenCRListOpTest(const aParams: IvcmTestParamsPrim;
 aCRType: TlstCRType;
 aTyped: Boolean = True);
 {* Пользовательские СКР. Тестирование }
var l_List: IvcmNodes;
var l_Strings: IvcmStrings;
//#UC START# *4A1FEFB30146_4986C5B30130_var*
//#UC END# *4A1FEFB30146_4986C5B30130_var*
begin
//#UC START# *4A1FEFB30146_4986C5B30130_impl*
 if (sdsDocInfo <> nil)then
  case aCRType of
   crtRespondents:
    aParams.Op.Flag[vcm_ofEnabled] := sdsDocInfo.HasRespondents;
   crtCorrespondents:
    aParams.Op.Flag[vcm_ofEnabled] := sdsDocInfo.HasCorrespondents;
  end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
 if aTyped and aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_Strings := aParams.Op.SubItems;
  if (l_Strings <> nil) then
  begin
   l_Strings.Clear;
   l_List := aParams.Op.SubNodes;
   if (l_List <> nil) then
    with l_List do
    begin
     Clear;
     PlainLevel := 2;
    end;//with l_List
  end;//l_Strings <> nil
 end;//aTyped and aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4A1FEFB30146_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.OpenCRListOpTest

procedure _CommonForTextAndFlash_.OpenUserCRListOpGetState(var State: TvcmOperationStateIndex;
 aType: TnsUserCRListId);
 {* Пользовательские СКР. Получение состояния }
//#UC START# *4A1FF27B0152_4986C5B30130_var*
//#UC END# *4A1FF27B0152_4986C5B30130_var*
begin
//#UC START# *4A1FF27B0152_4986C5B30130_impl*
 if (sdsDocInfo <> nil) then
 begin
  if (sdsDocInfo.UserCRListInfo[aType].ListType = crtCorrespondents) then
   case aType of
    ulFirst:
     State := st_user_Document_UserCR1_Corr;
    ulSecond:
     State := st_user_Document_UserCR2_Corr;
   end
  else
   State := vcm_DefaultOperationState;
 end//CurrentDS <> nil
 else
  State := vcm_DefaultOperationState;
//#UC END# *4A1FF27B0152_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.OpenUserCRListOpGetState

procedure _CommonForTextAndFlash_.OpenUserCRListOpTest(const aParams: IvcmTestParamsPrim;
 aType: TnsUserCRListId);
 {* Открыть типизированый СКР. Тестирование }
//#UC START# *4A1FF47600B8_4986C5B30130_var*
//#UC END# *4A1FF47600B8_4986C5B30130_var*
begin
//#UC START# *4A1FF47600B8_4986C5B30130_impl*
 if (sdsDocInfo <> nil) then
  with sdsDocInfo.UserCRListInfo[aType] do
  begin
   aParams.Op.Flag[vcm_ofEnabled] := Has;
   if Has then
   begin
    aParams.Op.Caption := Caption;
    aParams.Op.Hint := Caption;
   end//if Has then
   else
    aParams.Op.Hint := nil;
  end//with UserCRListInfo[ulFirst] do
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4A1FF47600B8_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.OpenUserCRListOpTest

procedure _CommonForTextAndFlash_.OpenCRListOpExecute(aType: TlstCRType;
 const aValue: Il3SimpleNode);
 {* Открыть типизированый СКР. Выполнение }
//#UC START# *4986E7110341_4986C5B30130_var*
var
 l_Node : INodeBase;
//#UC END# *4986E7110341_4986C5B30130_var*
begin
//#UC START# *4986E7110341_4986C5B30130_impl*
 if (sdsDocInfo <> nil)then
 begin
  if (aValue = nil) then
   l_Node := DefDataAdapter.CRSimpleListTypeRootNode.Child As INodeBase
   // http://mdp.garant.ru/pages/viewpage.action?pageId=268345098&focusedCommentId=268347311#comment-268347311
   //l_Node := bsGetAllDocumentsCRNode.Value
  else
   Supports(aValue, INodeBase, l_Node);
  sdsDocInfo.ChangeCRType(l_Node, aType);
 end;//sdsDocInfo <> nil
//#UC END# *4986E7110341_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.OpenCRListOpExecute

procedure _CommonForTextAndFlash_.OpenRelatedDocOpTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4986FC3B02D2_4986C5B30130_var*
//#UC END# *4986FC3B02D2_4986C5B30130_var*
begin
//#UC START# *4986FC3B02D2_4986C5B30130_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (sdsDocInfo <> nil) and sdsDocInfo.HasRelatedDoc;
//#UC END# *4986FC3B02D2_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.OpenRelatedDocOpTest

function _CommonForTextAndFlash_.CanAddToControl: Boolean;
 {* Можно ли поставить на контроль }
//#UC START# *4988675A0308_4986C5B30130_var*
//#UC END# *4988675A0308_4986C5B30130_var*
begin
//#UC START# *4988675A0308_4986C5B30130_impl*
 Result := true;
//#UC END# *4988675A0308_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.CanAddToControl

function _CommonForTextAndFlash_.FormIsMainInDocumentSet: Boolean;
//#UC START# *4BA1D3CA02EB_4986C5B30130_var*
//#UC END# *4BA1D3CA02EB_4986C5B30130_var*
begin
//#UC START# *4BA1D3CA02EB_4986C5B30130_impl*
 Result := Assigned(dsDocument) and Assigned(sdsDocInfo) and
  Assigned(sdsDocInfo.FormSet) and         
  sdsDocInfo.FormSet.Factory.IsMainInFormSet(Self.as_IvcmENtityForm);
//#UC END# *4BA1D3CA02EB_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.FormIsMainInDocumentSet

procedure _CommonForTextAndFlash_.Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
 {* Поставить на контроль }
//#UC START# *498863B203D0_4986C5B30130test_var*
var
 l_Controllable : IControllable;
 l_Doc          : IDocument;
//#UC END# *498863B203D0_4986C5B30130test_var*
begin
//#UC START# *498863B203D0_4986C5B30130test_impl*
 if CanAddToControl then
 begin
  l_Controllable := GetControllable(l_Doc);
  aParams.Op.Flag[vcm_ofEnabled] := TdmStdRes.IsCurEditionActual(l_Doc) and
                                    (l_Controllable <> nil);
 end//CanAddToControl
 else
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *498863B203D0_4986C5B30130test_impl*
end;//_CommonForTextAndFlash_.Document_AddToControl_Test

procedure _CommonForTextAndFlash_.Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Поставить на контроль }
//#UC START# *498863B203D0_4986C5B30130exec_var*
var
 l_Controllable : IControllable;
 l_Doc          : IDocument;
//#UC END# *498863B203D0_4986C5B30130exec_var*
begin
//#UC START# *498863B203D0_4986C5B30130exec_impl*
 if CanAddToControl then
 begin
  l_Controllable := GetControllable(l_Doc);
  if l_Controllable <> nil then
  try
   if not l_Controllable.GetControlled then
   begin
    TdmStdRes.AddToControl(l_Controllable);
    Say(inf_SetDocToControl);
   end//not l_Controllable.GetControlled
   else
   if Ask(qr_RemoveDocumentFromControl) then
    TdmStdRes.DeleteFromControl(l_Controllable);
  finally
   l_Controllable := nil;
  end;//try..finally
 end;//CanAddToControl
//#UC END# *498863B203D0_4986C5B30130exec_impl*
end;//_CommonForTextAndFlash_.Document_AddToControl_Execute

procedure _CommonForTextAndFlash_.Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
 {* Поставить на контроль }
//#UC START# *498863B203D0_4986C5B30130getstate_var*
var
 l_Controllable : IControllable;
 l_Doc          : IDocument;
//#UC END# *498863B203D0_4986C5B30130getstate_var*
begin
//#UC START# *498863B203D0_4986C5B30130getstate_impl*
 l_Controllable := GetControllable(l_Doc);
 if (l_Controllable <> nil) then
 try
  if TdmStdRes.IsCurEditionActual(l_Doc) and l_Controllable.GetControlled then
   State := st_user_Document_AddToControl_RemoveFromControl
  else
   State := vcm_DefaultOperationState;
 finally
  l_Controllable := nil;
 end;//try..finally
//#UC END# *498863B203D0_4986C5B30130getstate_impl*
end;//_CommonForTextAndFlash_.Document_AddToControl_GetState

procedure _CommonForTextAndFlash_.Document_UserCR1_Test(const aParams: IvcmTestParamsPrim);
 {* Коллеги, это что? }
//#UC START# *4989C7D30219_4986C5B30130test_var*
//#UC END# *4989C7D30219_4986C5B30130test_var*
begin
//#UC START# *4989C7D30219_4986C5B30130test_impl*
 OpenUserCRListOpTest(aParams, ulFirst);
//#UC END# *4989C7D30219_4986C5B30130test_impl*
end;//_CommonForTextAndFlash_.Document_UserCR1_Test

procedure _CommonForTextAndFlash_.Document_UserCR1_GetState(var State: TvcmOperationStateIndex);
 {* Коллеги, это что? }
//#UC START# *4989C7D30219_4986C5B30130getstate_var*
//#UC END# *4989C7D30219_4986C5B30130getstate_var*
begin
//#UC START# *4989C7D30219_4986C5B30130getstate_impl*
 OpenUserCRListOpGetState(State, ulFirst);
//#UC END# *4989C7D30219_4986C5B30130getstate_impl*
end;//_CommonForTextAndFlash_.Document_UserCR1_GetState

procedure _CommonForTextAndFlash_.Document_UserCR2_Test(const aParams: IvcmTestParamsPrim);
 {* Коллеги, это что? }
//#UC START# *4989C96003C4_4986C5B30130test_var*
//#UC END# *4989C96003C4_4986C5B30130test_var*
begin
//#UC START# *4989C96003C4_4986C5B30130test_impl*
 OpenUserCRListOpTest(aParams, ulSecond);
//#UC END# *4989C96003C4_4986C5B30130test_impl*
end;//_CommonForTextAndFlash_.Document_UserCR2_Test

procedure _CommonForTextAndFlash_.Document_UserCR2_GetState(var State: TvcmOperationStateIndex);
 {* Коллеги, это что? }
//#UC START# *4989C96003C4_4986C5B30130getstate_var*
//#UC END# *4989C96003C4_4986C5B30130getstate_var*
begin
//#UC START# *4989C96003C4_4986C5B30130getstate_impl*
 OpenUserCRListOpGetState(State, ulSecond);
//#UC END# *4989C96003C4_4986C5B30130getstate_impl*
end;//_CommonForTextAndFlash_.Document_UserCR2_GetState

procedure _CommonForTextAndFlash_.Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
 {* Добавить закладку }
//#UC START# *4989D06D014E_4986C5B30130test_var*
//#UC END# *4989D06D014E_4986C5B30130test_var*
begin
//#UC START# *4989D06D014E_4986C5B30130test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanAddBookmark;
//#UC END# *4989D06D014E_4986C5B30130test_impl*
end;//_CommonForTextAndFlash_.Document_AddBookmark_Test

procedure _CommonForTextAndFlash_.Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Добавить закладку }
//#UC START# *4989D06D014E_4986C5B30130exec_var*
//#UC END# *4989D06D014E_4986C5B30130exec_var*
begin
//#UC START# *4989D06D014E_4986C5B30130exec_impl*
 SetBookMark;
//#UC END# *4989D06D014E_4986C5B30130exec_impl*
end;//_CommonForTextAndFlash_.Document_AddBookmark_Execute

function _CommonForTextAndFlash_.CanUnControl: Boolean;
//#UC START# *4BA0ACB501DA_4986C5B30130_var*
//#UC END# *4BA0ACB501DA_4986C5B30130_var*
begin
//#UC START# *4BA0ACB501DA_4986C5B30130_impl*
 Result := Assigned(DocumentSet) and FormIsMainInDocumentSet;
//#UC END# *4BA0ACB501DA_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.CanUnControl

function _CommonForTextAndFlash_.pm_GetHyperlinkDocID: Integer;
//#UC START# *4CDD19B503B1_4986C5B30130get_var*
//#UC END# *4CDD19B503B1_4986C5B30130get_var*
begin
//#UC START# *4CDD19B503B1_4986C5B30130get_impl*
 if (dsDocument = nil) or
    (dsDocument.DocInfo.Doc = nil) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=565841079
  Result := 0
 else
  try
   Result := dsDocument.DocInfo.Doc.GetInternalId + c_InternalDocShift;
  except
   on ECanNotFindData do
    Result := 0;
  end;//try..except
//#UC END# *4CDD19B503B1_4986C5B30130get_impl*
end;//_CommonForTextAndFlash_.pm_GetHyperlinkDocID

function _CommonForTextAndFlash_.pm_GetHyperlinkDocumentName: Il3CString;
//#UC START# *4CDD1A02013D_4986C5B30130get_var*
//#UC END# *4CDD1A02013D_4986C5B30130get_var*
begin
//#UC START# *4CDD1A02013D_4986C5B30130get_impl*
 if (dsDocument = nil) then
  Result := nil
 else
  Result := dsDocument.DocInfo.DocName;
//#UC END# *4CDD1A02013D_4986C5B30130get_impl*
end;//_CommonForTextAndFlash_.pm_GetHyperlinkDocumentName

{$If NOT Defined(NoVCM)}
procedure _CommonForTextAndFlash_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  sdsDocInfo := nil;
  dsDocument := nil;
  DocumentSet := nil;
 end//aNew = nil
 else
 begin
  aNew.CastUCC(IsdsDocInfo, sdsDocInfo);
  Supports(aNew, IdsDocument, dsDocument);
  aNew.CastUCC(IsdsDocument, DocumentSet);
 end;//aNew = nil
end;//_CommonForTextAndFlash_.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _CommonForTextAndFlash_.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Document, nil);
  PublishOp(en_Document, op_AddToControl, Document_AddToControl_Execute, Document_AddToControl_Test, Document_AddToControl_GetState);
  PublishOp(en_Document, op_UserCR1, nil, Document_UserCR1_Test, Document_UserCR1_GetState);
  PublishOp(en_Document, op_UserCR2, nil, Document_UserCR2_Test, Document_UserCR2_GetState);
  PublishOp(en_Document, op_AddBookmark, Document_AddBookmark_Execute, Document_AddBookmark_Test, nil);
 end;//with Entities.Entities
end;//_CommonForTextAndFlash_.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf CommonForTextAndFlash_imp_impl}

{$EndIf CommonForTextAndFlash_imp}

