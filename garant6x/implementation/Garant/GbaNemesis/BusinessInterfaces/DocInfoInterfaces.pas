unit DocInfoInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\DocInfoInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "DocInfoInterfaces" MUID: (4D1B7B830045)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicDocListUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , l3Types
 , bsTypes
 , bsInterfaces
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseDocumentWithAttributesInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IbsFlash = interface
  {* Данные ролика }
  ['{A1BA80BA-19A5-4FAD-B9E4-E613FF3B9F5B}']
  function pm_GetFlashData: IExternalObject;
  property FlashData: IExternalObject
   read pm_GetFlashData;
   {* данные ролика }
 end;//IbsFlash

 IsdsDocInfo = interface(IsdsBaseDocumentWithAttributes)
  ['{BE860412-EE8F-4EE3-9949-BDB397D6BCFE}']
  function pm_GetDsRelatedDoc: IdsDocument;
  function pm_GetDsRespondents: IdsDocumentList;
  function pm_GetDsCorrespondents: IdsDocumentList;
  function pm_GetDsUserCR1: IdsDocumentList;
  function pm_GetDsUserCR2: IdsDocumentList;
  function pm_GetDsDocumentWithFlash: IdsDocumentWithFlash;
  function pm_GetDsAnnotation: IdsDocument;
  function pm_GetDsTranslation: IdsDocument;
  function pm_GetDsSimilarDocuments: IdsDocumentList;
  function pm_GetDsChronology: IdsDocument;
  function pm_GetDsSimilarDocumentsToFragment: IdsDocumentList;
  function pm_GetIsUnderControl: Boolean;
  function pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
  function pm_GetHasRelatedDoc: Boolean;
  function pm_GetHasRespondents: Boolean;
  function pm_GetHasCorrespondents: Boolean;
  function pm_GetHasAnnotation: Boolean;
  function pm_GetHasTranslation: Boolean;
  function pm_GetHasSimilarDocuments: Boolean;
  function pm_GetHasChronology: Boolean;
  function pm_GetDsRelatedDocRef: IvcmViewAreaControllerRef;
  function pm_GetDsRespondentsRef: IvcmViewAreaControllerRef;
  function pm_GetDsCorrespondentsRef: IvcmViewAreaControllerRef;
  function pm_GetDsUserCR1Ref: IvcmViewAreaControllerRef;
  function pm_GetDsUserCR2Ref: IvcmViewAreaControllerRef;
  function pm_GetDsDocumentWithFlashRef: IvcmViewAreaControllerRef;
  function pm_GetDsAnnotationRef: IvcmViewAreaControllerRef;
  function pm_GetDsTranslationRef: IvcmViewAreaControllerRef;
  function pm_GetDsSimilarDocumentsRef: IvcmViewAreaControllerRef;
  function pm_GetDsChronologyRef: IvcmViewAreaControllerRef;
  function pm_GetDsSimilarDocumentsToFragmentRef: IvcmViewAreaControllerRef;
  procedure OpenCorrespondents;
   {* корреспонденты }
  procedure OpenRespondents;
   {* респонденты }
  function ChangeCRType(const aNode: INodeBase;
   aType: TlstCRType;
   IsCRToPart: Boolean = False): Boolean;
   {* вызывается при изменении типа корреспондентов/респондентов }
  procedure AddToControl;
   {* поставить документ на контроль }
  procedure DelFromControl;
   {* снять с контроля }
  procedure ResetCacheAfterUpdate;
   {* сброс закэшированных параметров после обновления базы документов }
  function IsTypedCRSelected(aSheetNumber: TnsUserCRListId): Boolean;
   {* проверка того, что пользователь настроил соответствующую вкладку СКР }
  function HasTypedCRinBigBase(aSheetNumber: TnsUserCRListId): Boolean;
   {* проверка наличмия типизированных СКР в полной базе }
  function HasSimilarToFragment(anId: Integer): Boolean;
  function As_IbsFlash: IbsFlash;
   {* Метод приведения нашего интерфейса к IbsFlash }
  property dsRelatedDoc: IdsDocument
   read pm_GetDsRelatedDoc;
   {* справка к документу }
  property dsRespondents: IdsDocumentList
   read pm_GetDsRespondents;
   {* БОФ респонденты документа }
  property dsCorrespondents: IdsDocumentList
   read pm_GetDsCorrespondents;
   {* БОФ корреспонденты документа }
  property dsUserCR1: IdsDocumentList
   read pm_GetDsUserCR1;
   {* БОФ пользовательский СКР1 }
  property dsUserCR2: IdsDocumentList
   read pm_GetDsUserCR2;
   {* БОФ пользовательский СКР2 }
  property dsDocumentWithFlash: IdsDocumentWithFlash
   read pm_GetDsDocumentWithFlash;
   {* документ-схема }
  property dsAnnotation: IdsDocument
   read pm_GetDsAnnotation;
   {* аннотация к документу }
  property dsTranslation: IdsDocument
   read pm_GetDsTranslation;
   {* БОФ перевода документа }
  property dsSimilarDocuments: IdsDocumentList
   read pm_GetDsSimilarDocuments;
   {* БОФ похожие документы }
  property dsChronology: IdsDocument
   read pm_GetDsChronology;
   {* Хронология судебного дела }
  property dsSimilarDocumentsToFragment: IdsDocumentList
   read pm_GetDsSimilarDocumentsToFragment;
  property IsUnderControl: Boolean
   read pm_GetIsUnderControl;
   {* поставлен ли документ на контроль }
  property UserCRListInfo[aId: TnsUserCRListId]: IbsUserCRListInfo
   read pm_GetUserCRListInfo;
   {* информация о пользовательских типах списков, в том числе БОФ }
  property HasRelatedDoc: Boolean
   read pm_GetHasRelatedDoc;
   {* Определяет что есть данные для "справка к документу" }
  property HasRespondents: Boolean
   read pm_GetHasRespondents;
   {* Определяет что есть данные для "БОФ респонденты документа" }
  property HasCorrespondents: Boolean
   read pm_GetHasCorrespondents;
   {* Определяет что есть данные для "БОФ корреспонденты документа" }
  property HasAnnotation: Boolean
   read pm_GetHasAnnotation;
   {* Определяет что есть данные для "аннотация к документу" }
  property HasTranslation: Boolean
   read pm_GetHasTranslation;
   {* Определяет что есть данные для "БОФ перевода документа" }
  property HasSimilarDocuments: Boolean
   read pm_GetHasSimilarDocuments;
   {* Определяет что есть данные для "БОФ похожие документы" }
  property HasChronology: Boolean
   read pm_GetHasChronology;
   {* Определяет что есть данные для "Хронология судебного дела" }
  property dsRelatedDocRef: IvcmViewAreaControllerRef
   read pm_GetDsRelatedDocRef;
   {* Ссылка на "справка к документу" }
  property dsRespondentsRef: IvcmViewAreaControllerRef
   read pm_GetDsRespondentsRef;
   {* Ссылка на "БОФ респонденты документа" }
  property dsCorrespondentsRef: IvcmViewAreaControllerRef
   read pm_GetDsCorrespondentsRef;
   {* Ссылка на "БОФ корреспонденты документа" }
  property dsUserCR1Ref: IvcmViewAreaControllerRef
   read pm_GetDsUserCR1Ref;
   {* Ссылка на "БОФ пользовательский СКР1" }
  property dsUserCR2Ref: IvcmViewAreaControllerRef
   read pm_GetDsUserCR2Ref;
   {* Ссылка на "БОФ пользовательский СКР2" }
  property dsDocumentWithFlashRef: IvcmViewAreaControllerRef
   read pm_GetDsDocumentWithFlashRef;
   {* Ссылка на "документ-схема" }
  property dsAnnotationRef: IvcmViewAreaControllerRef
   read pm_GetDsAnnotationRef;
   {* Ссылка на "аннотация к документу" }
  property dsTranslationRef: IvcmViewAreaControllerRef
   read pm_GetDsTranslationRef;
   {* Ссылка на "БОФ перевода документа" }
  property dsSimilarDocumentsRef: IvcmViewAreaControllerRef
   read pm_GetDsSimilarDocumentsRef;
   {* Ссылка на "БОФ похожие документы" }
  property dsChronologyRef: IvcmViewAreaControllerRef
   read pm_GetDsChronologyRef;
   {* Ссылка на "Хронология судебного дела" }
  property dsSimilarDocumentsToFragmentRef: IvcmViewAreaControllerRef
   read pm_GetDsSimilarDocumentsToFragmentRef;
   {* Ссылка на "" }
 end;//IsdsDocInfo

 IdDocInfo = interface(IdBaseDocumentWithAttributes)
  {* Данные прецедента информация о документе }
  ['{70F8D50C-F370-4AB7-8D96-126C717D23BD}']
  function pm_GetCorrType: IbsFrozenNode;
  procedure pm_SetCorrType(const aValue: IbsFrozenNode);
  function pm_GetCorrList: IDynList;
  procedure pm_SetCorrList(const aValue: IDynList);
  function pm_GetRespType: IbsFrozenNode;
  procedure pm_SetRespType(const aValue: IbsFrozenNode);
  function pm_GetRespList: IDynList;
  procedure pm_SetRespList(const aValue: IDynList);
  function pm_GetUserCRListInfo(aValue: TnsUserCRListId): IbsUserCRListInfoModify;
  function pm_GetDsRelatedDocRef: IvcmFormDataSourceRef;
  function pm_GetHasRelatedDoc: Tl3Bool;
  procedure pm_SetHasRelatedDoc(aValue: Tl3Bool);
  function pm_GetDsRespondentsRef: IvcmFormDataSourceRef;
  function pm_GetHasRespondents: Tl3Bool;
  procedure pm_SetHasRespondents(aValue: Tl3Bool);
  function pm_GetDsCorrespondentsRef: IvcmFormDataSourceRef;
  function pm_GetHasCorrespondents: Tl3Bool;
  procedure pm_SetHasCorrespondents(aValue: Tl3Bool);
  function pm_GetDsUserCR1Ref: IvcmFormDataSourceRef;
  function pm_GetDsUserCR2Ref: IvcmFormDataSourceRef;
  function pm_GetDsDocumentWithFlashRef: IvcmFormDataSourceRef;
  function pm_GetDsAnnotationRef: IvcmFormDataSourceRef;
  function pm_GetHasAnnotation: Tl3Bool;
  procedure pm_SetHasAnnotation(aValue: Tl3Bool);
  function pm_GetDsTranslationRef: IvcmFormDataSourceRef;
  function pm_GetHasTranslation: Tl3Bool;
  procedure pm_SetHasTranslation(aValue: Tl3Bool);
  function pm_GetDsSimilarDocumentsRef: IvcmFormDataSourceRef;
  function pm_GetHasSimilarDocuments: Tl3Bool;
  procedure pm_SetHasSimilarDocuments(aValue: Tl3Bool);
  function pm_GetDsChronologyRef: IvcmFormDataSourceRef;
  function pm_GetHasChronology: Tl3Bool;
  procedure pm_SetHasChronology(aValue: Tl3Bool);
  function pm_GetDsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
  function pm_GetIsUnderControl: Tl3Bool;
  procedure pm_SetIsUnderControl(aValue: Tl3Bool);
  function pm_GetFlashData: IExternalObject;
  procedure pm_SetFlashData(const aValue: IExternalObject);
  property CorrType: IbsFrozenNode
   read pm_GetCorrType
   write pm_SetCorrType;
  property CorrList: IDynList
   read pm_GetCorrList
   write pm_SetCorrList;
   {* список для корреспондентов }
  property RespType: IbsFrozenNode
   read pm_GetRespType
   write pm_SetRespType;
  property RespList: IDynList
   read pm_GetRespList
   write pm_SetRespList;
  property UserCRListInfo[aValue: TnsUserCRListId]: IbsUserCRListInfoModify
   read pm_GetUserCRListInfo;
  property dsRelatedDocRef: IvcmFormDataSourceRef
   read pm_GetDsRelatedDocRef;
   {* Ссылка на "справка к документу" }
  property HasRelatedDoc: Tl3Bool
   read pm_GetHasRelatedDoc
   write pm_SetHasRelatedDoc;
   {* Есть ли "справка к документу" }
  property dsRespondentsRef: IvcmFormDataSourceRef
   read pm_GetDsRespondentsRef;
   {* Ссылка на "БОФ респонденты документа" }
  property HasRespondents: Tl3Bool
   read pm_GetHasRespondents
   write pm_SetHasRespondents;
   {* Есть ли "БОФ респонденты документа" }
  property dsCorrespondentsRef: IvcmFormDataSourceRef
   read pm_GetDsCorrespondentsRef;
   {* Ссылка на "БОФ корреспонденты документа" }
  property HasCorrespondents: Tl3Bool
   read pm_GetHasCorrespondents
   write pm_SetHasCorrespondents;
   {* Есть ли "БОФ корреспонденты документа" }
  property dsUserCR1Ref: IvcmFormDataSourceRef
   read pm_GetDsUserCR1Ref;
   {* Ссылка на "БОФ пользовательский СКР1" }
  property dsUserCR2Ref: IvcmFormDataSourceRef
   read pm_GetDsUserCR2Ref;
   {* Ссылка на "БОФ пользовательский СКР2" }
  property dsDocumentWithFlashRef: IvcmFormDataSourceRef
   read pm_GetDsDocumentWithFlashRef;
   {* Ссылка на "документ-схема" }
  property dsAnnotationRef: IvcmFormDataSourceRef
   read pm_GetDsAnnotationRef;
   {* Ссылка на "аннотация к документу" }
  property HasAnnotation: Tl3Bool
   read pm_GetHasAnnotation
   write pm_SetHasAnnotation;
   {* Есть ли "аннотация к документу" }
  property dsTranslationRef: IvcmFormDataSourceRef
   read pm_GetDsTranslationRef;
   {* Ссылка на "БОФ перевода документа" }
  property HasTranslation: Tl3Bool
   read pm_GetHasTranslation
   write pm_SetHasTranslation;
   {* Есть ли "БОФ перевода документа" }
  property dsSimilarDocumentsRef: IvcmFormDataSourceRef
   read pm_GetDsSimilarDocumentsRef;
   {* Ссылка на "БОФ похожие документы" }
  property HasSimilarDocuments: Tl3Bool
   read pm_GetHasSimilarDocuments
   write pm_SetHasSimilarDocuments;
   {* Есть ли "БОФ похожие документы" }
  property dsChronologyRef: IvcmFormDataSourceRef
   read pm_GetDsChronologyRef;
   {* Ссылка на "Хронология судебного дела" }
  property HasChronology: Tl3Bool
   read pm_GetHasChronology
   write pm_SetHasChronology;
   {* Есть ли "Хронология судебного дела" }
  property dsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef
   read pm_GetDsSimilarDocumentsToFragmentRef;
   {* Ссылка на "dsSimilarDocumentsToFragment" }
  property IsUnderControl: Tl3Bool
   read pm_GetIsUnderControl
   write pm_SetIsUnderControl;
   {* поставлен ли документ на контроль }
  property FlashData: IExternalObject
   read pm_GetFlashData
   write pm_SetFlashData;
   {* данные ролика }
 end;//IdDocInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
