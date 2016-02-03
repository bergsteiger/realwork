{$IfNDef CommonForTextAndFlash_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas"
// Стереотип: "VCMForm"

{$Define CommonForTextAndFlash_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlashAndMedicFirmList_Parent_ = _CommonForTextAndFlash_Parent_;
 {$Include CommonForTextAndFlashAndMedicFirmList.imp.pas}
 _StatusBarDocumentItems_Parent_ = _CommonForTextAndFlashAndMedicFirmList_;
 {$Include StatusBarDocumentItems.imp.pas}
 _UnderControlResetter_Parent_ = _StatusBarDocumentItems_;
 {$Include UnderControlResetter.imp.pas}
 _HyperlinkToDocumentProducer_Parent_ = _UnderControlResetter_;
 {$Include HyperlinkToDocumentProducer.imp.pas}
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
  public
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure UserCR1; override;
    {* Коллеги, это что? }
   procedure UserCR2; override;
    {* Коллеги, это что? }
   procedure AddBookmark; override;
    {* Добавить закладку }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure UserCR1; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 1 }
   procedure UserCR2; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 2 }
 end;//_CommonForTextAndFlash_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlashAndMedicFirmList_Parent_ = _CommonForTextAndFlash_Parent_;
{$Include CommonForTextAndFlashAndMedicFirmList.imp.pas}
_StatusBarDocumentItems_Parent_ = _CommonForTextAndFlashAndMedicFirmList_;
{$Include StatusBarDocumentItems.imp.pas}
_UnderControlResetter_Parent_ = _StatusBarDocumentItems_;
{$Include UnderControlResetter.imp.pas}
_HyperlinkToDocumentProducer_Parent_ = _UnderControlResetter_;
{$Include HyperlinkToDocumentProducer.imp.pas}
_CommonForTextAndFlash_ = _HyperlinkToDocumentProducer_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlash_imp}

{$IfNDef CommonForTextAndFlash_imp_impl}

{$Define CommonForTextAndFlash_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include CommonForTextAndFlashAndMedicFirmList.imp.pas}

{$Include StatusBarDocumentItems.imp.pas}

{$Include UnderControlResetter.imp.pas}

{$Include HyperlinkToDocumentProducer.imp.pas}

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

procedure _CommonForTextAndFlash_.AddToControl;
 {* Поставить на контроль }
//#UC START# *498863B203D0_4986C5B30130_var*
//#UC END# *498863B203D0_4986C5B30130_var*
begin
//#UC START# *498863B203D0_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *498863B203D0_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.AddToControl

procedure _CommonForTextAndFlash_.UserCR1;
 {* Коллеги, это что? }
//#UC START# *4989C7D30219_4986C5B30130_var*
//#UC END# *4989C7D30219_4986C5B30130_var*
begin
//#UC START# *4989C7D30219_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989C7D30219_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.UserCR1

procedure _CommonForTextAndFlash_.UserCR2;
 {* Коллеги, это что? }
//#UC START# *4989C96003C4_4986C5B30130_var*
//#UC END# *4989C96003C4_4986C5B30130_var*
begin
//#UC START# *4989C96003C4_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989C96003C4_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.UserCR2

procedure _CommonForTextAndFlash_.AddBookmark;
 {* Добавить закладку }
//#UC START# *4989D06D014E_4986C5B30130_var*
//#UC END# *4989D06D014E_4986C5B30130_var*
begin
//#UC START# *4989D06D014E_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.AddBookmark

function _CommonForTextAndFlash_.CanUnControl: Boolean;
//#UC START# *4BA0ACB501DA_4986C5B30130_var*
//#UC END# *4BA0ACB501DA_4986C5B30130_var*
begin
//#UC START# *4BA0ACB501DA_4986C5B30130_impl*
 Result := Assigned(DocumentSet) and FormIsMainInDocumentSet;
//#UC END# *4BA0ACB501DA_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.CanUnControl

procedure _CommonForTextAndFlash_.AddToControl;
 {* Поставить на контроль }
//#UC START# *4C7BABCE03C0_4986C5B30130_var*
//#UC END# *4C7BABCE03C0_4986C5B30130_var*
begin
//#UC START# *4C7BABCE03C0_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BABCE03C0_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.AddToControl

procedure _CommonForTextAndFlash_.UserCR1;
 {* Пользовательские ссылки на документ (ссылки из документа) 1 }
//#UC START# *4C7BAC1902F5_4986C5B30130_var*
//#UC END# *4C7BAC1902F5_4986C5B30130_var*
begin
//#UC START# *4C7BAC1902F5_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC1902F5_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.UserCR1

procedure _CommonForTextAndFlash_.UserCR2;
 {* Пользовательские ссылки на документ (ссылки из документа) 2 }
//#UC START# *4C7BAC5101CA_4986C5B30130_var*
//#UC END# *4C7BAC5101CA_4986C5B30130_var*
begin
//#UC START# *4C7BAC5101CA_4986C5B30130_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC5101CA_4986C5B30130_impl*
end;//_CommonForTextAndFlash_.UserCR2

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf CommonForTextAndFlash_imp_impl}

{$EndIf CommonForTextAndFlash_imp}

