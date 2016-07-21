unit DocumentUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Document" MUID: (4570511E038A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , FoldersUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , UnderControlUnit
;

const
 POSITION_TYPE_MASK: Cardinal = 2147483648;
 POSITION_TYPE_SUB_ID: Cardinal = 0;
 POSITION_TYPE_PARA_ID: Cardinal = 2147483648;

type
 TLinkedObjectType = (
  {* Тип объекта, на который указывает гипертекстовая ссылка. }
  LO_DOCUMENT
   {* Документ. }
  , LO_RELATED_DOCUMENT
   {* Справка к документу. }
  , LO_EXTERNAL_OBJECT
   {* Внешний объект. }
  , LO_MULTILINK
   {* Мультиссылка (список документов). }
  , LO_EXTERNAL_LINK
   {* Внешняя ссылка. }
  , LO_QUERY
   {* Запрос. }
  , LO_BOOKMARK
   {* Закладка }
  , LO_EXTERNAL_OPERATION
  , LO_ENO
   {* Ссылка на ENO }
  , LO_AUTOREFERAT
   {* Автореферат }
  , LO_SCRIPT
   {* скрипт для К271754146 }
  , LO_DELETED_FOLDERS_CONTENT
 );//TLinkedObjectType

 IMissingInfo = interface
  {* Информация об отсутствующем документе. }
  ['{5553DE6A-23C5-4B12-8A98-358CF08F6E59}']
  procedure GetObjName; stdcall;
  procedure GetBlocksInfo; stdcall;
  function IsOneBlock: ByteBool; stdcall;
   {* Отсутствующий объект содержится только в одном блоке (базе) - необходимо для правильного постоения сообщения о том, в каком(их) блоке(ах) содержится отсутствующий объект.  Если в blocks_info содержится только один блок, то возвращается true, в противном случае false. }
  property ObjName: 
   read GetObjName;
   {* Имя отсутствующего объекта. }
  property BlocksInfo: 
   read GetBlocksInfo;
   {* Имена блоков (баз), в которых содержится отсутствующий объект. }
 end;//IMissingInfo

 InvalidParaId = class
  {* Неверный идентификатор параграфа }
 end;//InvalidParaId

 TTimeMachineWarningType = (
  TMWT_RED
  , TMWT_YELLOW
 );//TTimeMachineWarningType

 TTimeMachineWarning = record
  warning: ;
  type: TTimeMachineWarningType;
 end;//TTimeMachineWarning

 InvalidTopicId = class
  {* Возвращается при попытке выполнить операцию с внутренним идентификатором документа, несуществующим в базе. }
 end;//InvalidTopicId

 TPositionType = (
  PT_SUB
  , PT_PARA
  , PT_BOOKMARK
 );//TPositionType

 TPosition = record
  {* Точка входа в документ. }
  type: TPositionType;
   {* Флаг определяющий значение поля point. Если true то point указывает на параграф, в противном случае на саб или блок. }
  point: Cardinal;
   {* Точка входа. }
 end;//TPosition

 IPositionList = array of TPosition;
  {* Список меток или блоков в документе. }

 TTopic = record
  {* Внутренние идентификаторы элемента списка документов. }
  pid: ;
  position: ;
 end;//TTopic

 TParaId = Cardinal;
  {* Идентификатор параграфа (тот самы волшебный, который должен прикрутить Влад) }

 TDocumentType = (
  {* тип документа }
  DT_DOCUMENT
  , DT_EXPLANATORY
  , DT_AUTO_REFERAT
  , DT_BOOK
  , DT_TIP
   {* Совет дня }
  , DT_MEDICAL_EXPLANATORY
   {* элемент словаря мед. терминов }
  , DT_MEDICAL_FIRM
   {* документ с описанием фирмы из инфарм }
  , DT_MEDICAL_DOCUMENT
  , DT_FLASH
   {* Документ-флеш }
  , DT_ACTUAL_ANALYTICS
   {* ААК }
  , DT_ACTUAL_ANALYTICS_CONTENTS
   {* ААК-Содержание }
  , DT_REF
   {* Топик с www ссылками }
 );//TDocumentType

 FolderLinkNotFound = class
  {* Не найдена ссылка на папочный элемент (возможно он был удален) }
 end;//FolderLinkNotFound

 TRedactionID = Integer;
  {* Идентификатор редакции объекта (сейчас будет совпадать с ObjectId). }

 IActiveIntervalList = array of TDateInterval;

 TNotSureInfo = record
  warning: ;
  interval: ;
 end;//TNotSureInfo

 INotSureIntervalList = array of TNotSureInfo;

 TRedactionType = (
  {* Тип редакции объекта. }
  RT_ACTUAL
   {* Документ }
  , RT_ACTUAL_ABOLISHED
   {* документ со статусом DS_ABOLISHED (утратил силу) }
  , RT_ACTUAL_PREACTIVE
   {* документ со статусом DS_PREACTIVE (не вступил в силу) }
  , RT_OLD
   {* редакция в цепочке редакций до актуальной, у которой нет ни DS_ABOLISHED, ни DS_PREACTIVE }
  , RT_NEW
   {* редакция в цепочке редакций после актуальной, у которой нет ни DS_ABOLISHED, ни DS_PREACTIVE }
  , RT_NEW_ABOLISHED
  , RT_NEW_PREACTIVE
   {* редакция со статусом DS_PREACTIVE (не вступил в силу) }
 );//TRedactionType

 TRedactionSourceDocumentInfo = record
  display_name: ;
   {* изменяющий документ (то что показывается) }
  doc_topic: ;
   {* топик для перехода в изменяющий документ }
 end;//TRedactionSourceDocumentInfo

 IRedactionSourceDocumentInfoList = array of TRedactionSourceDocumentInfo;

 RedactionNotFound = class
  {* Возвращается в случае попытки получения несуществующей редакции объекта. }
 end;//RedactionNotFound

 TLinkKind = (
  {* Вид хинта }
  LK_INTERNAL_INVALID
  , LK_REGULAR
  , LK_EXTERNAL
  , LK_ABOLISHED
   {* Ссылка на утративший силу документ }
  , LK_PREACTIVE
   {* Ссылка на не вступивший в силу документ }
  , LK_ENO
   {* Ссылка на ЭО }
  , LK_EDITION
   {* Редакция документа }
  , LK_SCRIPT
   {* ссылка на скрипт }
 );//TLinkKind

 TLinkInfo = record
  kind: TLinkKind;
   {* вид хинта }
  hint: ;
 end;//TLinkInfo

 InvalidDate = class
 end;//InvalidDate

 ExplanationDictionaryNotInstalled = class
  {* Толковый словарь не установлен в системе.
Возвращается в случае вызова операции "поиск толкования" и отсутствии в системе толкового словаря. }
 end;//ExplanationDictionaryNotInstalled

 TFactoryKey = (
  FK_DOCUMENT_MASTER
  , FK_DOCUMENT_DELEGATE
  , FK_DICT_DOCUMENT
  , FK_PHARM_DICT_DOCUMENT
  , FK_PHARM_DOCUMENT
  , FK_PHARM_FIRM_DOCUMENT
  , FK_TIP_DOCUMENT
  , FK_TRANSLATED_DOCUMENT
  , FK_SIMPLE_DOCUMENT
  , FK_FLASH_DOCUMENT
  , FK_AUTOREFERAT_DOCUMENT
  , FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT
  , FK_ACTUAL_ANALYTICS_DOCUMENT
  , FK_REF
  , FK_BOOK
 );//TFactoryKey

 TParaNum = Integer;
  {* список измененных параграфов в порядке выдачи машиной сравнения }

 IDiffIterator = interface
  {* [$175966492]
*  Операции "Следующее изменение" и "Предыдущее изменение" должны работать относительно позиции курсора (если он на экране) или относительно верхнего края документа в фокусе.
* Операция "Следующее изменение" должна работать только до конца документа (не переходя в начало по циклу)
* Операция "Предыдущее изменение" должна работать только до начала документа (не переходя в конец по циклу) }
  ['{A9AA18D9-F87F-4A47-988B-789AA069EEE0}']
  function HasNext: ByteBool; stdcall;
  function HasPrev: ByteBool; stdcall;
  function Next: TParaNum; stdcall; { can raise CanNotFindData }
  function AcquireNext: TParaNum; stdcall;
  function Prev: TParaNum; stdcall; { can raise CanNotFindData }
  function AcquirePrev: TParaNum; stdcall;
  procedure MoveTo(para: TParaNum); stdcall; { can raise CanNotFindData }
 end;//IDiffIterator

 TLayerID = Cardinal;

 InvalidObjectClass = class
 end;//InvalidObjectClass

 NoPrevRedaction = class
 end;//NoPrevRedaction

 TChildID = Cardinal;

 TEntryPoint = record
  layer: TLayerID;
  child: TChildID;
 //#UC START# *4C5AA60F039Bpubl*
 //#UC END# *4C5AA60F039Bpubl*
 end;//TEntryPoint

 TContext = record
  path: ;
  start: Integer;
  finish: Integer;
 end;//TContext

 TEVDType = Byte;

 TExternalID = Integer;

 TEVDStream = IStream;

 InvalidEntryPoint = class
 end;//InvalidEntryPoint

 InvalidLayerID = class
 end;//InvalidLayerID

 TBookmark2 = record
  para_id: TExternalID;
  eid: Cardinal;
  name: ;
 end;//TBookmark2

 IBookmarkList = array of TBookmark2;

 IFragmentList = array of TContext;

 ISubList = array of Cardinal;

 IContextList = array of IFragmentList;

 IFoundContext = interface
  ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
  procedure GetList; stdcall;
  property List: 
   read GetList;
 end;//IFoundContext

 IDocumentTextProvider = interface
  ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
  function GetChildType(const id: TEntryPoint): TEVDType; stdcall; { can raise InvalidEntryPoint }
  function GetChildLayerId(const id: TEntryPoint): TLayerID; stdcall; { can raise InvalidEntryPoint }
  function GetChildExternalId(const id: TEntryPoint): TExternalID; stdcall; { can raise InvalidEntryPoint }
  procedure GetChildEvdStyle(const id: TEntryPoint;
   out aRet
   {* TEVDStream }); stdcall; { can raise InvalidEntryPoint }
  procedure GetChildComment(const id: TEntryPoint;
   out aRet
   {* TEVDStream }); stdcall; { can raise InvalidEntryPoint }
  procedure SetChildComment(const id: TEntryPoint;
   const comment: TEVDStream); stdcall; { can raise InvalidEntryPoint }
  procedure RemoveChildComment(const id: TEntryPoint); stdcall;
  procedure GetChildBookmarks(const id: TEntryPoint;
   out aRet
   {* IBookmarkList }); stdcall; { can raise EmptyResult, InvalidEntryPoint }
  procedure GetChildText(const id: TEntryPoint;
   out aRet
   {* IString }); stdcall; { can raise InvalidEntryPoint }
  procedure GetChildTechComment(const id: TEntryPoint;
   out aRet
   {* IString }); stdcall; { can raise InvalidEntryPoint }
  function AllLeafParaCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  function ChildrenCount(layer_id: TLayerID): Cardinal; stdcall; { can raise InvalidLayerID }
  procedure FindBlockOrSub(id: TExternalID;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
  procedure FindPara(id: TExternalID;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
  procedure FindContext(const context: IString;
   from_id: TExternalID;
   out aRet
   {* IFoundContext }); stdcall; { can raise CanNotFindData }
  procedure GetSubList(const id: TEntryPoint;
   out aRet
   {* ISubList }); stdcall;
  procedure GetPrefixTree(id: TExternalID;
   out aRet
   {* INodeBase }); stdcall;
  function ShowSubPanelIcon(id: TExternalID): ByteBool; stdcall;
   {* Нужно ли показывать иконку для блока на сабпанели }
  function HasSame(id: TExternalID): ByteBool; stdcall;
   {* Если есть похожие к sub вернет true, иначе false. }
 end;//IDocumentTextProvider

 IDocumentTextProviderList = array of IDocumentTextProvider;

 ICommentsParaList = array of TParaId;

 TExternalObjectData = record
  type: TExternalObjectType;
  para_id: TParaId;
  name: ;
 end;//TExternalObjectData

 IExternalObjectDataList = array of TExternalObjectData;

 TDiffData = record
  diff_iterator: ;
  cur: ;
  prev: ;
 end;//TDiffData

 TDocumentTextProviderDescriptor = record
  handle: Cardinal;
  header_leaf_count: Cardinal;
  anno_leaf_count: Cardinal;
 end;//TDocumentTextProviderDescriptor

 IDocumentTextProviderDescriptorList = array of TDocumentTextProviderDescriptor;

 TSubId = Cardinal;

 TDocPoint = record
  {* Точка входа в документ (пара DocId SubId) }
  doc_id: TBaseTypesObjectId;
   {* Идентификатор документа }
  sub_id: TSubId;
   {* Номер саба/блока }
 end;//TDocPoint

 IDocPointList = array of TDocPoint;
  {* Список точек входа в документ }

 ILikeable = interface
  ['{CD879569-CC93-4E02-B56F-C5C1B3FBBEBC}']
  function GetCanLike: ByteBool; stdcall;
  procedure Like; stdcall;
   {* Нравится }
  procedure Unlike; stdcall;
   {* Не нравится }
  property CanLike: ByteBool
   read GetCanLike;
   {* Доступность операции оценки }
 end;//ILikeable

 TRedactionInfo = record
  {* Информация о редакции объекта. }
  name: ;
   {* Имя редакции. }
  time_machine_date: ;
  doc_date: ;
  is_comparable: ByteBool;
  actual_type: TRedactionType;
  not_sure_intervals: ;
  active_intervals: ;
  id: TRedactionID;
  changing_documents: ;
 end;//TRedactionInfo

 TDiffDocPara = record
  text: ;
  style: ;
  data: ;
  type: TEVDType;
  id: Integer;
 end;//TDiffDocPara

 IDiffDocParaList = array of TDiffDocPara;

 TChangedBlock = record
  id: Cardinal;
  header: ;
   {* Название структурной единицы с точностью до минимального блока, входящего в оглавление,
которым  предваряется измененный фрагмент (блок) }
  right_text_para_list: ;
   {* Измененный фрагмент правой редакции }
  left_text_para_list: ;
   {* Измененный фрагмент левой редакции }
 end;//TChangedBlock

 IRedactionInfoList = array of TRedactionInfo;
  {* Список редакций. }

 IBookmark = interface;

 IDocumentState = interface;

 IJournalBookmark = interface;

 ILink = interface;

 IDocument = interface(IEntityBase)
  {* Интерфейс обеспечивающий работу с документом. }
  ['{2906776F-DD41-403A-AF10-DDD0F9BD6590}']
  procedure GetName; stdcall;
  procedure GetShortName; stdcall;
  procedure GetWarning; stdcall;
  function GetSize: Cardinal; stdcall;
  function GetInternalId: Cardinal; stdcall;
  function GetNotTm: ByteBool; stdcall;
  procedure GetFilePosition; stdcall; { can raise CanNotFindData }
  function GetNewRevisionAvailable: ByteBool; stdcall;
  function GetChangeStatus: Cardinal; stdcall;
  function GetStatus: TItemStatus; stdcall;
  procedure GetTextLanguages; stdcall;
  procedure GetAttributesRoot; stdcall;
  procedure GetRedactionsList; stdcall;
  procedure GetCurrentState; stdcall;
  function GetDocType: TDocumentType; stdcall;
  procedure GetTranslation; stdcall;
  procedure GetAnnotation; stdcall;
  procedure GetRelatedDoc; stdcall;
  procedure GetContentsRoot; stdcall; { can raise CanNotFindData }
  procedure GetBookmarkList; stdcall;
  procedure GetCommentsParaList; stdcall;
  procedure GetExternalObjectDataList; stdcall;
  procedure CreateBookmark(para: TParaId;
   is_para: Boolean
   {* Флаг указывающий на то что в первом параметре указывается параграф, в противном случае саб. };
   out aRet
   {* IBookmark }); stdcall;
   {* Создает экземпляр Закладки на заданный идентификатор параграфа. Присваивает ей в качестве названия короткое имя документа. А в качестве full_name имя документа и имя ближайшего (сверху) саба или блока (как в списках). }
  procedure CreateView(var filters: IDocumentState;
   out aRet
   {* IDocument }); stdcall;
   {* Возвращает документ - редакцию, заказанную через  filters.
Если текущая редакция равна заказанной - возвращает NULL }
  procedure GetCorrespondentsToPart(const pos_list: IPositionList
   {* Список позиций. };
   const category: INodeBase
   {* Категория фильтрации };
   out out_list: ICatalogBase); stdcall;
   {* Возвращает список корреспондентов к фрагменту документа (список параграфов) для указанной категории (category).

для редакций, отлчных от "главной", возвращает NULL }
  procedure GetInternetImageUrl(block_id: Integer;
   out aRet
   {* IExternalLink }); stdcall;
   {* Получить url для отсканированного WWW-образа документа. }
  procedure GetLinkedObject(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out obj_type: TLinkedObjectType;
   out obj: IUnknown); stdcall; { can raise InvalidTopicId, FolderLinkNotFound }
   {* Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему идентификатору.
Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах) содержится отсутствующий объект (метод get_missing_info)
Будет использоваться для перехода по гипертекстовой ссылке. }
  procedure GetNotSureInfo(const date: TDate;
   var start: TDate;
   var finish: TDate;
   out info: IDocument;
   out warning: IString); stdcall;
   {* Возвращает информацию об интервале неуверенности документа. Если указанная в параметра date дата не попадает в интревал бросает CanNotFindData }
  procedure GetRespondentsToPart(const pos_list: IPositionList
   {* Список позиций. };
   const category: INodeBase
   {* Категория фильтрации. };
   out out_list: ICatalogBase); stdcall;
   {* Возвращает список респондентов к фрагменту документа (список параграфов) для указанной категории (category).

для редакций, отлчных от "главной", возвращает NULL }
  procedure GetTimeMachineWarning(const date: TDate;
   out aRet
   {* TTimeMachineWarning }); stdcall;
  function HasCorrespondents(const category: INodeBase): ByteBool; stdcall;
   {* Проверка наличия корреспондентов (любогй категории) у текущего документа.
Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.

для редакций, отличных от "главной", возвращает FALSE }
  function HasInternetImage: ByteBool; stdcall;
   {* Проверка наличия WWW-образа у текущего документа.
Возвращает true в случае, если у текущего документа есть WWW-образ. }
  function HasNextRedaction: ByteBool; stdcall;
   {* Функция показывает наличие следующей редакции для объекта.
Следующая редакция считается относительно текущего состояния (current_redaction).
Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции. }
  function HasPrevRedaction: ByteBool; stdcall;
   {* Функция показывает наличие предыдущей редакции для объекта.
Предыдущая редакция считается относительно текущего состояния (current_redaction).
Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции. }
  function HasRelatedDoc: ByteBool; stdcall;
   {* Проверка наличия справки у текущего документа.
Возвращает true в случае, если у текущего документа есть справка.

для редакций, отличных от "главной", поведение такое же как и для "главной" }
  function HasRespondents(const category: INodeBase): ByteBool; stdcall;
   {* Проверка наличия респондентов (любогй категории) у текущего документа.
Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.

для редакций, отличных от "главной", возвращает FALSE }
  function HasAnnotation: ByteBool; stdcall;
  function HasAttributes: ByteBool; stdcall;
   {* для документов типа DT_BOOK возвращает false,
для остальных true }
  function HasWarning: ByteBool; stdcall;
   {* Присутствие предупреждения. }
  function IsAlive: ByteBool; stdcall;
   {* Специальный метод, позволяющий выяснить "жив" ли документ на сервере приложений. Если документ "жив" - возвращается `true` (как правило такая проверка нужна, когда документ может быть удален, например во время обновления базы). Результаты данного метода не кешируются на адаптере, т.е. вызов этого метода всегда обращается к серверу приложений. }
  function IsDateInNotSureInterval(const date: TDate): ByteBool; stdcall;
   {* Метод позволяет определить попадает ли date в интервал неуверенности документа. }
  function IsMyBookmark(const bookmark: IBookmark): ByteBool; stdcall;
  function IsSameDocument(const doc: IDocument): ByteBool; stdcall;
  function IsSameRedaction(const view: IDocument): ByteBool; stdcall;
  function IsSameView(const view: IDocument): ByteBool; stdcall;
   {* Возвращает равенство документов с учетом их состояния (в отличии от is_same_entity, который возвращает равенство без учета состояния). Состоянием документа является суперпозиция номера редакции, языка и списка извлечений. }
  function MayShowAttributes: ByteBool; stdcall;
   {* Проверка возможности отображения атрибутов документа для текущего документа.
Возвращает true в случае, если показ атрибутов разрешен.

для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции ) }
  procedure GetCorrespondents(const category: INodeBase;
   out out_list: ICatalogBase); stdcall;
  procedure GetRespondents(const category: INodeBase;
   out out_list: ICatalogBase); stdcall;
  function HasTranslation: ByteBool; stdcall;
   {* Есть ли у документа перевод }
  function HasSameDocuments: ByteBool; stdcall;
   {* Проверка наличия похожих документов }
  procedure GetSameDocuments(out out_list: ICatalogBase); stdcall;
   {* Получить список похожих документов }
  procedure GetServerDoc; stdcall;
  class function Make(const document); overload; stdcall;
  class function Make(const pid;
   is_edition: Boolean;
   name: PAnsiChar); overload; stdcall;
  function IsMorphoSearchSupported: ByteBool; stdcall;
   {* индексирован ли документ для морфопоиска }
  procedure GetLinkInfo(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out aRet
   {* TLinkInfo }); stdcall;
  procedure GetMissingInfoForObject(const pid: TPId;
   out missing_info: IMissingInfo); stdcall;
   {* Возвращает расширенную информацию по отсутствующему объекту (pid - идентификатор и класс объекта по ссылке) }
  procedure GetDrugList(out aRet
   {* ICatalogBase }); stdcall; { can raise CanNotFindData }
   {* Получить список выпускаемых фирмой препаратов }
  procedure GetFlash(out aRet
   {* IExternalObject }); stdcall;
   {* Получение флеш-ролика }
  procedure CreateJournalBookmark(para: TParaId;
   out aRet
   {* IJournalBookmark }); stdcall;
   {* Создать журнальную закладку }
  function GetAutoReferatDocCount: size; stdcall; { can raise Unsupported }
   {* вернуть число документов для автореферата }
  procedure GetTextProvider(all_at_once: Boolean;
   out aRet
   {* IDocumentTextProvider }); stdcall; { can raise Unsupported, CanNotFindData }
  procedure GetTextProviderDescList(out aRet
   {* IDocumentTextProviderDescriptorList }); stdcall; { can raise Unsupported }
  procedure GetTextProviderByDesc(handle: Cardinal;
   out aRet
   {* IDocumentTextProvider }); stdcall; { can raise Unsupported }
  procedure GetTextProviderList(all_at_once: Boolean;
   out aRet
   {* IDocumentTextProviderList }); stdcall; { can raise Unsupported }
  procedure GetAutoreferatHeaderEvd(out aRet
   {* IStream }); stdcall; { can raise Unsupported }
  procedure GetAnnotationHeaderEvd(handle: Cardinal;
   out aRet
   {* IStream }); stdcall; { can raise Unsupported }
  procedure Diff(const pid;
   out aRet
   {* TDiffData }); stdcall;
  procedure GetEvdStream(out aRet
   {* IStream }); stdcall;
   {* возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе документа или документа запрещенного к просмотру }
  procedure GetSelfMissingInfo(out missing_info: IMissingInfo); stdcall;
   {* Получить расширенную информацию по текущему документу (в случае его отсутствия - в каких блоках этот документ присутствует) }
  procedure GetMultiLinkInfo(doc_id: Cardinal;
   const id: TTopic;
   out aRet
   {* IDocPointList }); stdcall; { can raise CanNotFindData, InternalDatabaseError }
   {* Получить данные по мульnиссылке в виде списка (DocId, SubId) }
  procedure DontShowDocumentStatusChangesWarning; stdcall;
   {* Не показывать статус изменения данного документа в текущей сессии }
  procedure GetRedactionPid; stdcall;
  function HasChronology: ByteBool; stdcall;
   {* есть ли у документа хронология рассмотрения судебного дела
K555095873 }
  procedure GetLink(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out aRet
   {* ILink }); stdcall;
  procedure GetSameToPoint(id: TExternalID;
   out out_list: ICatalogBase); stdcall;
  property Name: 
   read GetName;
   {* Имя документа. }
  property ShortName: 
   read GetShortName;
   {* Краткое имя документа. }
  property Warning: 
   read GetWarning;
   {* Предупреждение к документу. }
  property Size: Cardinal
   read GetSize;
   {* размер документа в байтах }
  property InternalId: Cardinal
   read GetInternalId;
   {* внутренний номер документа в базе }
  property NotTm: ByteBool
   read GetNotTm;
   {* True - если документ не подключен к машине времени }
  property FilePosition: 
   read GetFilePosition;
  property NewRevisionAvailable: ByteBool
   read GetNewRevisionAvailable;
   {* Доступна новая ревизия документа (для супермобильной версии) }
  property ChangeStatus: Cardinal
   read GetChangeStatus;
   {* Статус изменения документа }
  property Status: TItemStatus
   read GetStatus;
   {* Статус документа }
  property TextLanguages: 
   read GetTextLanguages;
  property AttributesRoot: 
   read GetAttributesRoot;
  property RedactionsList: 
   read GetRedactionsList;
  property CurrentState: 
   read GetCurrentState;
  property DocType: TDocumentType
   read GetDocType;
  property Translation: 
   read GetTranslation;
  property Annotation: 
   read GetAnnotation;
  property RelatedDoc: 
   read GetRelatedDoc;
  property ContentsRoot: 
   read GetContentsRoot;
  property BookmarkList: 
   read GetBookmarkList;
  property CommentsParaList: 
   read GetCommentsParaList;
  property ExternalObjectDataList: 
   read GetExternalObjectDataList;
 end;//IDocument

 IBookmark = interface(IEntityBase)
  {* Закладка на документ. Используется для сохранения документа (и позиции) в папках. }
  ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetComment; stdcall;
  procedure SetComment(const aValue); stdcall;
  function GetParagraph: TParaId; stdcall;
  procedure GetPid; stdcall;
  procedure GetDocument; stdcall;
  property Name: 
   read GetName
   write SetName;
   {* Названите закладки. Используется в качестве caption в Папках. }
  property Comment: 
   read GetComment
   write SetComment;
   {* полное имя документа и блока/саба на который указывает закладка. Используется в качестве hint  в Папках. }
  property Paragraph: TParaId
   read GetParagraph;
  property Pid: 
   read GetPid;
  property Document: 
   read GetDocument;
 end;//IBookmark

 IDocumentState = interface
  {* Интерфейс для работы с редакциями объекта. }
  ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
  function GetLanguage: TLanguages; stdcall;
  procedure SetLanguage(aValue: TLanguages); stdcall;
  procedure GetPrevRedactionsList; stdcall;
  procedure GetCurAndNextRedactionsList; stdcall;
  procedure SetPrevRedaction; stdcall; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей предыдущую редакцию объекта.
Если предыдущей редакции нет, то возвращается RedactionNotFound. }
  procedure SetNextRedaction; stdcall; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей следующую редакцию объекта.
Если следующей редакции нет, то возвращается RedactionNotFound. }
  procedure SetRedactionOnDate(const date: TDate); stdcall; { can raise RedactionNotFound }
  procedure SetRedactionOnId(id: TRedactionID); stdcall; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой, что и до вызова метода.
Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId. }
  procedure SetActualRedaction; stdcall; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой, что и до вызова метода. }
  function Redaction: TRedactionID; stdcall;
  procedure GetCurrentRedaction(out aRet
   {* TRedactionInfo }); stdcall;
  function IsSameRedactions(const other: IDocumentState): ByteBool; stdcall;
  procedure DiffWithRedactionById(id: TRedactionID;
   out aRet
   {* TDiffData }); stdcall;
  procedure Clone(out aRet
   {* IDocumentState }); stdcall;
  procedure SetPrevActiveRedaction; stdcall; { can raise RedactionNotFound }
   {* GetБлижайшаяДействующаяРедакцияВниз. [$178325284] }
  function CanCompareWithAnyOtherRedaction: ByteBool; stdcall;
   {* [$178325284] }
  function IsActual: ByteBool; stdcall;
   {* возвращает true, если эта редакция актуальная, т. е. имеет тип:
- RT_ACTUAL
- RT_ACTUAL_ABOLISHED
- RT_ACTUAL_PREACTIVE }
  property Language: TLanguages
   read GetLanguage
   write SetLanguage;
  property PrevRedactionsList: 
   read GetPrevRedactionsList;
  property CurAndNextRedactionsList: 
   read GetCurAndNextRedactionsList;
   {* [$178324034] }
 end;//IDocumentState

 AllChangesInTables = class
 end;//AllChangesInTables

 IJournalBookmark = interface(IEntityBase)
  {* Журнальная закладка }
  ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
  procedure GetName; stdcall;
  procedure GetFullName; stdcall;
  function GetParaId: Cardinal; stdcall;
  procedure GetDocument; stdcall;
  procedure GetJournalBookmark; stdcall;
   {* Получить  серверную журнальную закладку }
  property Name: 
   read GetName;
   {* Имя }
  property FullName: 
   read GetFullName;
   {* Полное имя (хинт) }
  property ParaId: Cardinal
   read GetParaId;
  property Document: 
   read GetDocument;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface
  ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
  function GetObjectType: TLinkedObjectType; stdcall;
  procedure GetObject(out aRet
   {* IUnknown }); stdcall; { can raise InvalidTopicId, FolderLinkNotFound }
  procedure GetLinkInfo(out aRet
   {* TLinkInfo }); stdcall;
  procedure GetLinkedHint(out aRet
   {* IString }); stdcall;
  function GetKind: TLinkKind; stdcall;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface
  ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
  function GetAllLeafParaCount: Cardinal; stdcall;
  procedure GetHeaderParaList(out aRet
   {* IDiffDocParaList }); stdcall;
   {* Заголовок документа состоит из:

Фраза "Обзор изменений документа"
Длинное имя документа (!Name)
Фраза "Подготовлено экспертами компании "Гарант" 
Фраза "Далее приведены изменившиеся фрагменты редакций:" }
  function GetDateParaRight(out para: TDiffDocPara): ByteBool; stdcall;
   {* параграф с датами изменений документа для правого документа }
  function GetDateParaLeft(out para: TDiffDocPara): ByteBool; stdcall;
   {* параграф с датами изменений документа для левого документа }
  procedure GetRedactionNameRight(out aRet
   {* TDiffDocPara }); stdcall;
   {* Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для правого документа) }
  procedure GetRedactionNameLeft(out aRet
   {* TDiffDocPara }); stdcall;
   {* Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для левого документа) }
  function GetChangedBlockCount: Cardinal; stdcall;
  procedure GetChangedBlock(i: Cardinal;
   out aRet
   {* TChangedBlock }); stdcall;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface
  ['{51778307-FE15-45BF-9A86-62A66BF81725}']
  procedure GetObject(out aRet
   {* IUnknown }); stdcall;
  function GetObjectType: TLinkedObjectType; stdcall;
  class function Make(const server_link); stdcall;
 end;//IObjectFromLink

const
 ROOT_CHILD: TChildID = 0;
 ROOT_LAYER: TLayerID = 4294967295;
  {* 0xFFFFFFFF }

implementation

uses
 l3ImplUses
;

end.
