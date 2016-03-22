unit Document_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Document_Module.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document
//
// Работа с документом
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
  DocumentUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  DocumentAndListInterfaces
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  PresentationInterfaces,
  DocumentWithFlash_Form,
  DocumentDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  Text_Form,
  vtPanel,
  Redactions_Form,
  Contents_Form,
  Picture_Form,
  PictureInfo_Form,
  DocNumberQuery_Form,
  Warning_Form,
  Attributes_Form,
  SynchroView_Form,
  TurnOnTimeMachine_Form,
  eeMemoWithEditOperations,
  vtDblClickDateEdit
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  {$If not defined(NoImageEn)}
  ,
  imageenio
  {$IfEnd} //not NoImageEn
  ,
  NavigationInterfaces,
  vtLabel,
  DocumentUserTypes_dftDocument_UserType,
  nsLogEvent,
  DocumentInterfaces,
  l3StringIDEx,
  DocumentWithFlashUserTypes_dwftMain_UserType,
  Common_FormDefinitions_Controls,
  ExTextOptions_Form,
  eeSubPanel,
  PrimSynchroViewOptions_Form,
  PrimRedactionsOptions_Form,
  PrimPictureInfoOptions_Form,
  PrimDocNumberQueryOptions_Form,
  PrimAttributesOptions_Form,
  PrimPictureOptions_Form
  {$If not defined(NoImageEn)}
  ,
  imageenproc
  {$IfEnd} //not NoImageEn
  ,
  PrimDocumentWithFlashOptions_Form,
  PrimContentsOptions_Form,
  PrimTurnOnTimeMachineOptions_Form,
  vtLister,
  WorkWithDocumentInterfaces,
  DocInfoInterfaces
  {$If defined(Nemesis)}
  ,
  nscTasksPanelView
  {$IfEnd} //Nemesis
  ,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnTimeMachineOn_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_WarnTimeMachineWarning_UserType,
  BaloonWarningUserTypes_WarnTimeMachineException_UserType
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  WarningBaloon_Form,
  PrimWarningBaloonOptions_Form,
  PrimDockedWarning_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  SynchroView_WarningBaloon_Form,
  Translation_WarningBaloon_Form,
  UserCR1_WarningBaloon_Form,
  UserCR2_WarningBaloon_Form
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  fsAbstractDocument,
  vtScrollBar
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtButton,
  vtCheckBox,
  vtRadioButton,
  nscTreeViewWithAdapterDragDrop
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  fsDocument,
  fsDocumentWithFlash
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocumentWithFlashKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TextKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RedactionsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ContentsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  PictureKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  PictureInfoKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  DocNumberQueryKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WarningKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  AttributesKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SynchroViewKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TurnOnTimeMachineKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  WarningBaloonKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  SynchroView_WarningBaloonKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  Translation_WarningBaloonKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UserCR1_WarningBaloonKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  UserCR2_WarningBaloonKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TDocumentModule = {formspack} class(TvcmModule)
  {* Работа с документом }
 protected
  procedure Loaded; override;
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   procedure opOpenDocOnNumberTest(const aParams: IvcmTestParamsPrim);
     {* Открыть документ по номеру }
   procedure opOpenDocOnNumber(const aParams: IvcmExecuteParamsPrim);
     {* Открыть документ по номеру }
 public
 // public methods
   class procedure OpenDocument(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
     {* Открывает документ }
   class function OpenEntityAsDocument(const anEntity: IUnknown;
     const aContainer: IvcmContainer): IDocument;
   class function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
   class procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
     const aContainer: IvcmContainer);
   class function OpenExternalObject(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectData): IvcmEntityForm;
   class function OpenPicture(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectData): IvcmEntityForm;
   class function OpenPictureInfo(const aContainer: IvcmContainer;
     const aData: InsLinkedObjectDescription): IvcmEntityForm;
   class function OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
   class function OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
     const anAggregate: IvcmAggregate): IvcmEntityForm;
   class function MakeBaloonForm(aCaller: TvcmContainerForm;
     aUserType: TvcmEffectiveUserType;
     const aWarning: IdsWarning): IvcmEntityForm;
   class function DocumentShowChangesInfoSetting: Boolean;
     {* Метод для получения значения настройки "Показывать историю изменений в документе" }
   class procedure WriteDocumentShowChangesInfoSetting(aValue: Boolean);
     {* Метод для записи значения настройки "Показывать историю изменений в документе" }
 end;//TDocumentModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  nsTypes,
  nsManagers,
  sdsDocument,
  sdsDocumentWithFlash,
  l3Base {a},
  bsUtils,
  l3MessageID,
  SysUtils,
  BaseTypesUnit,
  deDocInfo,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  nsExternalObjectPrim,
  ExternalObjectUnit,
  nsConst,
  nsUtils,
  afwFacade,
  nsOpenDocOnNumberData,
  WarningConst,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls,
  DocumentShowChangesInfoSettingRes,
  stDocumentShowChangesInfoItem
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  kw_Document_opOpenDocOnNumber
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  ,
  vcmFormSetFactory {a},
  vcmModuleDef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type
  TnsOpenDocumentByNumber = {final} class(TnsLogEvent)
  public
  // public methods
   class procedure Log(aDocID: Integer);
  end;//TnsOpenDocumentByNumber

// start class TnsOpenDocumentByNumber

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

class procedure TDocumentModule.OpenDocument(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);

 procedure CheckAlive;
 //#UC START# *4AA118F20394__var*
//#UC END# *4AA118F20394__var*
 begin
 //#UC START# *4AA118F20394__impl*
  if Assigned(aDocInfo.Doc) and not aDocInfo.Doc.IsAlive then
   raise ETryOpenMissingDocument.Create('');
 //#UC END# *4AA118F20394__impl*
 end;//CheckAlive

var
 __WasEnter : Boolean;
//#UC START# *4AA11788033F_498B135601B6_var*
//#UC END# *4AA11788033F_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenDocument

class function TDocumentModule.OpenEntityAsDocument(const anEntity: IUnknown;
  const aContainer: IvcmContainer): IDocument;
var
 __WasEnter : Boolean;
//#UC START# *4AA1327E0334_498B135601B6_var*
var
 l_Para : TParaId;
//#UC END# *4AA1327E0334_498B135601B6_var*
var
 l_Bookmark : IBookmark;
 l_JBookmark : IJournalBookmark;
 l_DocInfo : IdeDocInfo;
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenEntityAsDocument

class function TDocumentModule.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
var
 __WasEnter : Boolean;
//#UC START# *4AA13F010182_498B135601B6_var*
//#UC END# *4AA13F010182_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA13F010182_498B135601B6_impl*
 Result := OpenEntityAsDocument(aBaseEntity, nil);
 if (Result = nil) then
  vcmAsk(err_BookmarkHasNoDocument);
//#UC END# *4AA13F010182_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.SafeOpenDocument

class procedure TDocumentModule.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4C6090157_498B135601B6_var*
//#UC END# *4AA4C6090157_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4C6090157_498B135601B6_impl*
 if (aDocInfo.Doc.GetDocType <> DT_FLASH) then
  OpenDocument(aDocInfo, aContainer);
//#UC END# *4AA4C6090157_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenDocumentWithCheck

class function TDocumentModule.OpenExternalObject(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectData): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAFCF8001A8_498B135601B6_var*
//#UC END# *4AAFCF8001A8_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
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
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenExternalObject

class function TDocumentModule.OpenPicture(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectData): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB12B14001A_498B135601B6_var*
var
 l_Params: IvcmMakeParams;
//#UC END# *4AB12B14001A_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB12B14001A_498B135601B6_impl*
 l_Params := vcmCheckAggregate(vcmMakeParams(nil,
                                             CheckContainer(aContainer)));
 Result := TPictureForm.Make(l_Params);
 if (aData <> nil) then
  op_Picture_InitNewContent.Call(Result, aData);
//#UC END# *4AB12B14001A_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenPicture

class function TDocumentModule.OpenPictureInfo(const aContainer: IvcmContainer;
  const aData: InsLinkedObjectDescription): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB12F3700CB_498B135601B6_var*
//#UC END# *4AB12F3700CB_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB12F3700CB_498B135601B6_impl*
 Result := Ten_PictureInfo.Make(aData, vcmMakeParams(nil, CheckContainer(aContainer)));
//#UC END# *4AB12F3700CB_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenPictureInfo

procedure TDocumentModule.opOpenDocOnNumberTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB133720122_498B135601B6test_var*
//#UC END# *4AB133720122_498B135601B6test_var*
var
 l_Data : InsOpenDocOnNumberData;
begin
//#UC START# *4AB133720122_498B135601B6test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4AB133720122_498B135601B6test_impl*
end;//TDocumentModule.opOpenDocOnNumberTest

procedure TDocumentModule.opOpenDocOnNumber(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB133720122_498B135601B6exec_var*
//#UC END# *4AB133720122_498B135601B6exec_var*
var
 l_Data : InsOpenDocOnNumberData;
begin
//#UC START# *4AB133720122_498B135601B6exec_impl*
 { Чтение настроек }
 l_Data := TnsOpenDocOnNumberData.Make(
  afw.Settings.LoadInteger(pi_Document_LastOpen_DocNumber,
                           dv_Document_LastOpen_DocNumber),
  afw.Settings.LoadInteger(pi_Document_LastOpen_Position,
                           dv_Document_LastOpen_Position),
  TDocumentPositionType(afw.Settings.LoadInteger(pi_Document_LastOpen_PosType,
                                                 dv_Document_LastOpen_PosType)),
  afw.Settings.LoadBoolean(pi_Document_LastOpen_IsInternal,
                           dv_Document_LastOpen_IsInternal),
  afw.Settings.LoadString(pi_Document_LastOpen_DocHistory,
                          dv_Document_LastOpen_DocHistory));

 try
  { Показываем форму }
  TDocNumberQueryForm.Make(l_Data);

  if not l_Data.Done then
   Exit;

  { Сохранение настроек }
  afw.Settings.SaveBoolean(pi_Document_LastOpen_IsInternal, l_Data.Internal);
  afw.Settings.SaveInteger(pi_Document_LastOpen_DocNumber, l_Data.DocID);
  afw.Settings.SaveInteger(pi_Document_LastOpen_Position, l_Data.PosID);
  afw.Settings.SaveInteger(pi_Document_LastOpen_PosType, Integer(l_Data.PosType));
  afw.Settings.SaveString(pi_Document_LastOpen_DocHistory, l_Data.History);

  { Поиск документа }
  if l_Data.Internal then
   l_Data.DocID := l_Data.DocID + c_InternalDocShift;

  TnsOpenDocumentByNumber.Log(l_Data.DocID);
  //http://mdp.garant.ru/pages/viewpage.action?pageId=482247952
  nsOpenDocumentByNumber(l_Data.DocID, l_Data.PosID, l_Data.PosType, True, True);
 finally
  l_Data := nil;
 end;//try..finally
//#UC END# *4AB133720122_498B135601B6exec_impl*
end;//TDocumentModule.opOpenDocOnNumber

class function TDocumentModule.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4B26253C0205_498B135601B6_var*
//#UC END# *4B26253C0205_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4B26253C0205_498B135601B6_impl*
 Result := Ten_TurnOnTimeMachine.Make(anIntf);
//#UC END# *4B26253C0205_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenTurnOnTimeMachine

class function TDocumentModule.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
  const anAggregate: IvcmAggregate): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4ED90DDC00A5_498B135601B6_var*
//#UC END# *4ED90DDC00A5_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ED90DDC00A5_498B135601B6_impl*
 Result := TRedactionsForm.Make(vcmMakeParams(anAggregate, CheckContainer(nil)),
                                vcm_ztModal,
                                0,
                                nil,
                                anEditionsHolder.EditionsList);
//#UC END# *4ED90DDC00A5_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.OpenEditionsListModal

class function TDocumentModule.MakeBaloonForm(aCaller: TvcmContainerForm;
  aUserType: TvcmEffectiveUserType;
  const aWarning: IdsWarning): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4F7D90530076_498B135601B6_var*
//#UC END# *4F7D90530076_498B135601B6_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F7D90530076_498B135601B6_impl*
  Result := TWarningBaloonForm.Make(vcmMakeParams(nil{f_sdsMainWindow{?}, aCaller, aCaller),
                                    vcm_ztReminder,
                                    aUserType,
                                    nil,
                                    aWarning);
//#UC END# *4F7D90530076_498B135601B6_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TDocumentModule.MakeBaloonForm

class function TDocumentModule.DocumentShowChangesInfoSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := dv_Document_ShowChangesInfo
 else
  Result := afw.Settings.LoadBoolean(pi_Document_ShowChangesInfo, dv_Document_ShowChangesInfo);
end;//TDocumentModule.DocumentShowChangesInfoSetting

class procedure TDocumentModule.WriteDocumentShowChangesInfoSetting(aValue: Boolean);
 {-}
begin
 if (afw.Settings <> nil) then
  afw.Settings.SaveBoolean(pi_Document_ShowChangesInfo, aValue);
end;//TDocumentModule.WriteDocumentShowChangesInfoSetting

procedure TDocumentModule.Loaded;
begin
 inherited;
 PublishOp('opOpenDocOnNumber', opOpenDocOnNumber, opOpenDocOnNumberTest);
end;

class procedure TDocumentModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TDocumentWithFlashForm);
 aList.Add(TTextForm);
 aList.Add(TRedactionsForm);
 aList.Add(TContentsForm);
 aList.Add(TPictureForm);
 aList.Add(Ten_PictureInfo);
 aList.Add(TDocNumberQueryForm);
 aList.Add(TWarningForm);
 aList.Add(TAttributesForm);
 aList.Add(TfcSynchroView);
 aList.Add(Ten_TurnOnTimeMachine);
 aList.Add(TWarningBaloonForm);
 aList.Add(TSynchroView_WarningBaloonForm);
 aList.Add(TTranslation_WarningBaloonForm);
 aList.Add(TUserCR1_WarningBaloonForm);
 aList.Add(TUserCR2_WarningBaloonForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.