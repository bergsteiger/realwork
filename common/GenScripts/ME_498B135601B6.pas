unit Document_Module;
 {* Работа с документом }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Document_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Document" MUID: (498B135601B6)
// Имя типа: "TDocumentModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , DocumentDomainInterfaces
 , NavigationInterfaces
 , PresentationInterfaces
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TDocumentModule = class(TvcmModule)
  {* Работа с документом }
  protected
   procedure OpenDocOnNumber;
    {* Открыть документ по номеру }
  public
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает документ }
   function OpenEntityAsDocument(const anEntity: IUnknown;
    const aContainer: IvcmContainer): IDocument;
   function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
   procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenExternalObject(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData);
   procedure OpenPicture(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData);
   procedure OpenPictureInfo(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectDescription);
   procedure OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine);
   procedure OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
    const anAggregate: IvcmAggregate);
   procedure MakeBaloonForm(aCaller: TvcmContainerForm;
    aUserType: TvcmEffectiveUserType;
    const aWarning: IdsWarning);
   class function DocumentShowChangesInfoSetting: Boolean;
    {* Метод для получения значения настройки "Показывать историю изменений в документе" }
   class procedure WriteDocumentShowChangesInfoSetting(aValue: Boolean);
    {* Метод для записи значения настройки "Показывать историю изменений в документе" }
 end;//TDocumentModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentShowChangesInfoSettingRes
 , stDocumentShowChangesInfoItem
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsManagers
 , sdsDocument
 , sdsDocumentWithFlash
 , BaseTypesUnit
 , deDocInfo
 , SysUtils
 , bsTypesNew
 , nsExternalObjectPrim
 , ExternalObjectUnit
 , nsConst
 , nsUtils
 , afwFacade
 , nsOpenDocOnNumberData
 , nsTypes
 , LoggingUnit
;

{$If NOT Defined(NoVCM)}
type
 TnsOpenDocumentByNumber = {final} class(TnsLogEvent)
  public
   class procedure Log(aDocID: Integer);
 end;//TnsOpenDocumentByNumber

class procedure TnsOpenDocumentByNumber.Log(aDocID: Integer);
//#UC START# *4B150AAA0334_4B150A890212_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150AAA0334_4B150A890212_var*
begin
//#UC START# *4B150AAA0334_4B150A890212_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aDocID);
 GetLogger.AddEvent(LE_OPEN_DOCUMENT_BY_NUMBER, l_Data);
//#UC END# *4B150AAA0334_4B150A890212_impl*
end;//TnsOpenDocumentByNumber.Log

procedure TDocumentModule.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает документ }

 procedure CheckAlive;
 //#UC START# *4AA118F20394__var*
 //#UC END# *4AA118F20394__var*
 begin
 //#UC START# *4AA118F20394__impl*
  if Assigned(aDocInfo.Doc) and not aDocInfo.Doc.IsAlive then
   raise ETryOpenMissingDocument.Create('');
 //#UC END# *4AA118F20394__impl*
 end;//CheckAlive

//#UC START# *4AA11788033F_498B135601B6_var*
//#UC END# *4AA11788033F_498B135601B6_var*
begin
//#UC START# *4AA11788033F_498B135601B6_impl*
 {$IfDef vcmUseProfilers}
 ProfilersManager.Document.Start;
 try
 {$EndIf vcmUseProfilers}
  case aDocInfo.DocType of
   // http://mdp.garant.ru/pages/viewpage.action?pageId=482247952
   DT_DOCUMENT, DT_BOOK, DT_REF:
    Tfs_Document.Make(TsdsDocument.Make(aDocInfo),
                      CheckContainer(aContainer));
   DT_EXPLANATORY:
   begin
    CheckAlive;
    TdmStdRes.OpenDictionary(aDocInfo, CheckContainer(aContainer));
   end;//DT_EXPLANATORY
   DT_TIP:
   begin
    CheckAlive;
    TdmStdRes.OpenTip(aDocInfo, CheckContainer(aContainer));
   end;//DT_TIP
   DT_MEDICAL_EXPLANATORY:
   begin
    CheckAlive;
    TdmStdRes.OpenMedicDiction(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_EXPLANATORY
   DT_MEDICAL_FIRM:
   begin
    CheckAlive;
    TdmStdRes.OpenMedicFirmDocument(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_FIRM
   DT_MEDICAL_DOCUMENT:
   begin
    TdmStdRes.OpenDrugDocument(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_DOCUMENT
   DT_FLASH:
    Tfs_DocumentWithFlash.Make(TsdsDocumentWithFlash.Make(aDocInfo),
                               CheckContainer(aContainer));
   DT_ACTUAL_ANALYTICS:
    TdmStdRes.MakeAAC(aDocInfo, CheckContainer(aContainer));
   DT_ACTUAL_ANALYTICS_CONTENTS:
    TdmStdRes.MakeAACContents(aDocInfo, CheckContainer(aContainer));
   else
    Assert(false);
  end//case l_DocInfo.Doc.GetDocType of
 {$IfDef vcmUseProfilers}
 finally
  ProfilersManager.Document.FormSetCreated;
 end;//try..finally
 {$EndIf vcmUseProfilers}
//#UC END# *4AA11788033F_498B135601B6_impl*
end;//TDocumentModule.OpenDocument

function TDocumentModule.OpenEntityAsDocument(const anEntity: IUnknown;
 const aContainer: IvcmContainer): IDocument;
var l_Bookmark: IBookmark;
var l_JBookmark: IJournalBookmark;
var l_DocInfo: IdeDocInfo;
//#UC START# *4AA1327E0334_498B135601B6_var*
var
 l_Para : TParaId;
//#UC END# *4AA1327E0334_498B135601B6_var*
begin
//#UC START# *4AA1327E0334_498B135601B6_impl*
 Result := nil;
 if Supports(anEntity, IBookmark, l_Bookmark) then
 begin
  try
   l_Bookmark.GetDocument(Result);
  except
   on ECanNotFindData do ;
  end;//try..except
  try
   if (Result <> nil) then
    l_Para := l_Bookmark.GetParagraph
   else
    l_Para := 0;
   if (l_Para <> 0) then
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_Para))
   else
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_C(dptBookmark, l_Bookmark.GetEid));
  except
   on ENotSaved do
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_Bookmark.GetParagraph));
  end;//try..except
 end//if Supports(anEntity, IBookmark, l_Bookmark) then
 else
 if Supports(anEntity, IJournalBookmark, l_JBookmark) then
 begin
  try
   l_JBookmark.GetDocument(Result);
  except
   on ECanNotFindData do ;
  end;//try..except
  l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_JBookMark.GetParaID));
 end//if Supports(anEntity, IBookmark, l_Bookmark) then
 else
 if Supports(anEntity, IDocument, Result) then
  l_DocInfo := TdeDocInfo.Make(Result);
 if Assigned(Result) then
  OpenDocument(l_DocInfo, aContainer);
//#UC END# *4AA1327E0334_498B135601B6_impl*
end;//TDocumentModule.OpenEntityAsDocument

function TDocumentModule.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
//#UC START# *4AA13F010182_498B135601B6_var*
//#UC END# *4AA13F010182_498B135601B6_var*
begin
//#UC START# *4AA13F010182_498B135601B6_impl*
 Result := OpenEntityAsDocument(aBaseEntity, nil);
 if (Result = nil) then
  vcmAsk(err_BookmarkHasNoDocument);
//#UC END# *4AA13F010182_498B135601B6_impl*
end;//TDocumentModule.SafeOpenDocument

procedure TDocumentModule.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA4C6090157_498B135601B6_var*
//#UC END# *4AA4C6090157_498B135601B6_var*
begin
//#UC START# *4AA4C6090157_498B135601B6_impl*
 if (aDocInfo.Doc.GetDocType <> DT_FLASH) then
  OpenDocument(aDocInfo, aContainer);
//#UC END# *4AA4C6090157_498B135601B6_impl*
end;//TDocumentModule.OpenDocumentWithCheck

procedure TDocumentModule.OpenExternalObject(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData);
//#UC START# *4AAFCF8001A8_498B135601B6_var*
//#UC END# *4AAFCF8001A8_498B135601B6_var*
begin
//#UC START# *4AAFCF8001A8_498B135601B6_impl*
 Result := nil;
 if aData.IsPicture then
 begin
  vcmDispatcher.FormDispatcher.Lock;
  try
   Result := OpenPicture(aContainer, aData);
  finally
   vcmDispatcher.FormDispatcher.UnLock;
  end;//try..finally
 end//aData.IsPicture
 else
 begin
  if vcmAsk(qr_OpenExternalQuery, [aData.ObjectTitle]) then
   nsExecuteExternalObject(aData as IExternalObject);
 end;//aData.IsPicture
//#UC END# *4AAFCF8001A8_498B135601B6_impl*
end;//TDocumentModule.OpenExternalObject

procedure TDocumentModule.OpenPicture(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData);
//#UC START# *4AB12B14001A_498B135601B6_var*
var
 l_Params: IvcmMakeParams;
//#UC END# *4AB12B14001A_498B135601B6_var*
begin
//#UC START# *4AB12B14001A_498B135601B6_impl*
 l_Params := vcmCheckAggregate(vcmMakeParams(nil,
                                             CheckContainer(aContainer)));
 Result := TPictureForm.Make(l_Params);
 if (aData <> nil) then
  op_Picture_InitNewContent.Call(Result, aData);
//#UC END# *4AB12B14001A_498B135601B6_impl*
end;//TDocumentModule.OpenPicture

procedure TDocumentModule.OpenPictureInfo(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectDescription);
//#UC START# *4AB12F3700CB_498B135601B6_var*
//#UC END# *4AB12F3700CB_498B135601B6_var*
begin
//#UC START# *4AB12F3700CB_498B135601B6_impl*
 Result := Ten_PictureInfo.Make(aData, vcmMakeParams(nil, CheckContainer(aContainer)));
//#UC END# *4AB12F3700CB_498B135601B6_impl*
end;//TDocumentModule.OpenPictureInfo

procedure TDocumentModule.OpenDocOnNumber;
 {* Открыть документ по номеру }
var l_Data: InsOpenDocOnNumberData;
//#UC START# *4AB133720122_498B135601B6_var*
//#UC END# *4AB133720122_498B135601B6_var*
begin
//#UC START# *4AB133720122_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB133720122_498B135601B6_impl*
end;//TDocumentModule.OpenDocOnNumber

procedure TDocumentModule.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine);
//#UC START# *4B26253C0205_498B135601B6_var*
//#UC END# *4B26253C0205_498B135601B6_var*
begin
//#UC START# *4B26253C0205_498B135601B6_impl*
 Result := Ten_TurnOnTimeMachine.Make(anIntf);
//#UC END# *4B26253C0205_498B135601B6_impl*
end;//TDocumentModule.OpenTurnOnTimeMachine

procedure TDocumentModule.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
 const anAggregate: IvcmAggregate);
//#UC START# *4ED90DDC00A5_498B135601B6_var*
//#UC END# *4ED90DDC00A5_498B135601B6_var*
begin
//#UC START# *4ED90DDC00A5_498B135601B6_impl*
 Result := TRedactionsForm.Make(vcmMakeParams(anAggregate, CheckContainer(nil)),
                                vcm_ztModal,
                                0,
                                nil,
                                anEditionsHolder.EditionsList);
//#UC END# *4ED90DDC00A5_498B135601B6_impl*
end;//TDocumentModule.OpenEditionsListModal

procedure TDocumentModule.MakeBaloonForm(aCaller: TvcmContainerForm;
 aUserType: TvcmEffectiveUserType;
 const aWarning: IdsWarning);
//#UC START# *4F7D90530076_498B135601B6_var*
//#UC END# *4F7D90530076_498B135601B6_var*
begin
//#UC START# *4F7D90530076_498B135601B6_impl*
  Result := TWarningBaloonForm.Make(vcmMakeParams(nil{f_sdsMainWindow{?}, aCaller, aCaller),
                                    vcm_ztReminder,
                                    aUserType,
                                    nil,
                                    aWarning);
//#UC END# *4F7D90530076_498B135601B6_impl*
end;//TDocumentModule.MakeBaloonForm

class function TDocumentModule.DocumentShowChangesInfoSetting: Boolean;
 {* Метод для получения значения настройки "Показывать историю изменений в документе" }
//#UC START# *F439A1EC5B50_498B135601B6_var*
//#UC END# *F439A1EC5B50_498B135601B6_var*
begin
//#UC START# *F439A1EC5B50_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *F439A1EC5B50_498B135601B6_impl*
end;//TDocumentModule.DocumentShowChangesInfoSetting

class procedure TDocumentModule.WriteDocumentShowChangesInfoSetting(aValue: Boolean);
 {* Метод для записи значения настройки "Показывать историю изменений в документе" }
//#UC START# *81ECFA778427_498B135601B6_var*
//#UC END# *81ECFA778427_498B135601B6_var*
begin
//#UC START# *81ECFA778427_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *81ECFA778427_498B135601B6_impl*
end;//TDocumentModule.WriteDocumentShowChangesInfoSetting
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
