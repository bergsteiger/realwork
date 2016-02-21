unit DocumentUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , UnderControlUnit
 , FoldersUnit
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
  function Get_obj_name: IString;
  function Get_blocks_info: IString;
  function is_one_block: Boolean;
   {* Отсутствующий объект содержится только в одном блоке (базе) - необходимо для правильного постоения сообщения о том, в каком(их) блоке(ах) содержится отсутствующий объект.  Если в blocks_info содержится только один блок, то возвращается true, в противном случае false. }
  property obj_name: IString
   read Get_obj_name;
   {* Имя отсутствующего объекта. }
  property blocks_info: IString
   read Get_blocks_info;
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
  warning: IString;
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
  pid: TPId;
  position: TPosition;
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
  warning: IString;
  interval: TDateInterval;
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
  display_name: IString;
   {* изменяющий документ (то что показывается) }
  doc_topic: TTopic;
   {* топик для перехода в изменяющий документ }
 end;//TRedactionSourceDocumentInfo

 IRedactionSourceDocumentInfoList = array of TRedactionSourceDocumentInfo;

 RedactionNotFound = class
  {* Возвращается в случае попытки получения несуществующей редакции объекта. }
 end;//RedactionNotFound

 NotAllowedInTrialMode = class
 end;//NotAllowedInTrialMode

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

 InvalidDate = class
 end;//InvalidDate

 ExplanationDictionaryNotInstalled = class
  {* Толковый словарь не установлен в системе.
Возвращается в случае вызова операции "поиск толкования" и отсутствии в системе толкового словаря. }
 end;//ExplanationDictionaryNotInstalled

 TLinkInfo = record
  kind: TLinkKind;
   {* вид хинта }
  hint: IString;
 end;//TLinkInfo

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
  function has_next: Boolean;
  function has_prev: Boolean;
  function next: TParaNum; { can raise CanNotFindData }
  function acquire_next: TParaNum;
  function prev: TParaNum; { can raise CanNotFindData }
  function acquire_prev: TParaNum;
  procedure move_to(para: TParaNum); { can raise CanNotFindData }
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
  path: INodeIndexPath;
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
  name: IString;
 end;//TBookmark2

 IBookmarkList = array of TBookmark2;

 IFragmentList = array of TContext;

 ISubList = array of Cardinal;

 IContextList = array of IFragmentList;

 IFoundContext = interface
  ['{2852766C-A9A5-4A40-8C9F-FD957D1D856E}']
  function Get_list: IContextList;
  property list: IContextList
   read Get_list;
 end;//IFoundContext

 IDocumentTextProvider = interface
  ['{EDE34F9F-F36F-48FA-82BA-FD755CE46B4B}']
  function get_child_type(const id: TEntryPoint): TEVDType; { can raise InvalidEntryPoint }
  function get_child_layer_id(const id: TEntryPoint): TLayerID; { can raise InvalidEntryPoint }
  function get_child_external_id(const id: TEntryPoint): TExternalID; { can raise InvalidEntryPoint }
  function get_child_evd_style(const id: TEntryPoint): TEVDStream; { can raise InvalidEntryPoint }
  function get_child_comment(const id: TEntryPoint): TEVDStream; { can raise InvalidEntryPoint }
  procedure set_child_comment(const id: TEntryPoint;
   const comment: TEVDStream); { can raise InvalidEntryPoint }
  procedure remove_child_comment(const id: TEntryPoint);
  function get_child_bookmarks(const id: TEntryPoint): IBookmarkList; { can raise EmptyResult, InvalidEntryPoint }
  function get_child_text(const id: TEntryPoint): IString; { can raise InvalidEntryPoint }
  function get_child_tech_comment(const id: TEntryPoint): IString; { can raise InvalidEntryPoint }
  function all_leaf_para_count(layer_id: TLayerID): Cardinal; { can raise InvalidLayerID }
  function children_count(layer_id: TLayerID): Cardinal; { can raise InvalidLayerID }
  function find_block_or_sub(id: TExternalID): INodeIndexPath; { can raise CanNotFindData }
  function find_para(id: TExternalID): INodeIndexPath; { can raise CanNotFindData }
  function find_context(const context: IString;
   from_id: TExternalID): IFoundContext; { can raise CanNotFindData }
  function get_sub_list(const id: TEntryPoint): ISubList;
  function get_prefix_tree(id: TExternalID): INodeBase;
  function show_sub_panel_icon(id: TExternalID): Boolean;
   {* Нужно ли показывать иконку для блока на сабпанели }
  function has_same(id: TExternalID): Boolean;
   {* Если есть похожие к sub вернет true, иначе false. }
 end;//IDocumentTextProvider

 IDocumentTextProviderList = array of IDocumentTextProvider;

 ICommentsParaList = array of TParaId;

 TExternalObjectData = record
  type: TExternalObjectType;
  para_id: TParaId;
  name: IString;
 end;//TExternalObjectData

 IExternalObjectDataList = array of TExternalObjectData;

 TDiffData = record
  diff_iterator: IDiffIterator;
  cur: IDocumentTextProvider;
  prev: IDocumentTextProvider;
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
  function Get_can_like: Boolean;
  procedure like;
   {* Нравится }
  procedure unlike;
   {* Не нравится }
  property can_like: Boolean
   read Get_can_like;
   {* Доступность операции оценки }
 end;//ILikeable

 TRedactionInfo = record
  {* Информация о редакции объекта. }
  name: IString;
   {* Имя редакции. }
  time_machine_date: TDate;
  doc_date: TDate;
  is_comparable: Boolean;
  actual_type: TRedactionType;
  not_sure_intervals: INotSureIntervalList;
  active_intervals: IActiveIntervalList;
  id: TRedactionID;
  changing_documents: IRedactionSourceDocumentInfoList;
 end;//TRedactionInfo

 TDiffDocPara = record
  text: IString;
  style: TEVDStream;
  data: IStream;
  type: TEVDType;
  id: Integer;
 end;//TDiffDocPara

 IDiffDocParaList = array of TDiffDocPara;

 TChangedBlock = record
  id: Cardinal;
  header: IDiffDocParaList;
   {* Название структурной единицы с точностью до минимального блока, входящего в оглавление,
которым  предваряется измененный фрагмент (блок) }
  right_text_para_list: IDiffDocParaList;
   {* Измененный фрагмент правой редакции }
  left_text_para_list: IDiffDocParaList;
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
  function Get_name: IString;
  function Get_short_name: IString;
  function Get_warning: IString;
  function Get_size: Cardinal;
  function Get_internal_id: Cardinal;
  function Get_not_tm: Boolean;
  function Get_file_position: IString; { can raise CanNotFindData }
  function Get_new_revision_available: Boolean;
  function Get_change_status: Cardinal;
  function Get_status: TItemStatus;
  function Get_text_languages: ILanguagesList;
  function Get_attributes_root: INodeBase;
  function Get_redactions_list: IRedactionInfoList;
  function Get_current_state: IDocumentState;
  function Get_doc_type: TDocumentType;
  function Get_translation: IDocument;
  function Get_annotation: IDocument;
  function Get_related_doc: IDocument;
  function Get_contents_root: INodeBase; { can raise CanNotFindData }
  function Get_bookmark_list: IBookmarkList;
  function Get_comments_para_list: ICommentsParaList;
  function Get_external_object_data_list: IExternalObjectDataList;
  function create_bookmark(para: TParaId;
   is_para: Boolean
   {* Флаг указывающий на то что в первом параметре указывается параграф, в противном случае саб. }): IBookmark;
   {* Создает экземпляр Закладки на заданный идентификатор параграфа. Присваивает ей в качестве названия короткое имя документа. А в качестве full_name имя документа и имя ближайшего (сверху) саба или блока (как в списках). }
  function create_view(var filters: IDocumentState): IDocument;
   {* Возвращает документ - редакцию, заказанную через  filters.
Если текущая редакция равна заказанной - возвращает NULL }
  procedure get_correspondents_to_part(const pos_list: IPositionList
   {* Список позиций. };
   const category: INodeBase
   {* Категория фильтрации };
   out out_list: ICatalogBase);
   {* Возвращает список корреспондентов к фрагменту документа (список параграфов) для указанной категории (category).

для редакций, отлчных от "главной", возвращает NULL }
  function get_internet_image_url(block_id: Integer): IExternalLink;
   {* Получить url для отсканированного WWW-образа документа. }
  procedure get_linked_object(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID;
   out obj_type: TLinkedObjectType;
   out obj: IUnknown); { can raise InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode }
   {* Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему идентификатору.
Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах) содержится отсутствующий объект (метод get_missing_info)
Будет использоваться для перехода по гипертекстовой ссылке. }
  procedure get_not_sure_info(const date: TDate;
   var start: TDate;
   var finish: TDate;
   out info: IDocument;
   out warning: IString);
   {* Возвращает информацию об интервале неуверенности документа. Если указанная в параметра date дата не попадает в интревал бросает CanNotFindData }
  procedure get_respondents_to_part(const pos_list: IPositionList
   {* Список позиций. };
   const category: INodeBase
   {* Категория фильтрации. };
   out out_list: ICatalogBase);
   {* Возвращает список респондентов к фрагменту документа (список параграфов) для указанной категории (category).

для редакций, отлчных от "главной", возвращает NULL }
  function get_time_machine_warning(const date: TDate): TTimeMachineWarning;
  function has_correspondents(const category: INodeBase): Boolean;
   {* Проверка наличия корреспондентов (любогй категории) у текущего документа.
Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.

для редакций, отличных от "главной", возвращает FALSE }
  function has_internet_image: Boolean;
   {* Проверка наличия WWW-образа у текущего документа.
Возвращает true в случае, если у текущего документа есть WWW-образ. }
  function has_next_redaction: Boolean;
   {* Функция показывает наличие следующей редакции для объекта.
Следующая редакция считается относительно текущего состояния (current_redaction).
Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции. }
  function has_prev_redaction: Boolean;
   {* Функция показывает наличие предыдущей редакции для объекта.
Предыдущая редакция считается относительно текущего состояния (current_redaction).
Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции. }
  function has_related_doc: Boolean;
   {* Проверка наличия справки у текущего документа.
Возвращает true в случае, если у текущего документа есть справка.

для редакций, отличных от "главной", поведение такое же как и для "главной" }
  function has_respondents(const category: INodeBase): Boolean;
   {* Проверка наличия респондентов (любогй категории) у текущего документа.
Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.

для редакций, отличных от "главной", возвращает FALSE }
  function has_annotation: Boolean;
  function has_attributes: Boolean;
   {* для документов типа DT_BOOK возвращает false,
для остальных true }
  function has_warning: Boolean;
   {* Присутствие предупреждения. }
  function is_alive: Boolean;
   {* Специальный метод, позволяющий выяснить "жив" ли документ на сервере приложений. Если документ "жив" - возвращается `true` (как правило такая проверка нужна, когда документ может быть удален, например во время обновления базы). Результаты данного метода не кешируются на адаптере, т.е. вызов этого метода всегда обращается к серверу приложений. }
  function is_date_in_not_sure_interval(const date: TDate): Boolean;
   {* Метод позволяет определить попадает ли date в интервал неуверенности документа. }
  function is_my_bookmark(const bookmark: IBookmark): Boolean;
  function is_same_document(const doc: IDocument): Boolean;
  function is_same_redaction(const view: IDocument): Boolean;
  function is_same_view(const view: IDocument): Boolean;
   {* Возвращает равенство документов с учетом их состояния (в отличии от is_same_entity, который возвращает равенство без учета состояния). Состоянием документа является суперпозиция номера редакции, языка и списка извлечений. }
  function may_show_attributes: Boolean;
   {* Проверка возможности отображения атрибутов документа для текущего документа.
Возвращает true в случае, если показ атрибутов разрешен.

для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции ) }
  procedure get_correspondents(const category: INodeBase;
   out out_list: ICatalogBase);
  procedure get_respondents(const category: INodeBase;
   out out_list: ICatalogBase);
  function has_translation: Boolean;
   {* Есть ли у документа перевод }
  function has_same_documents: Boolean;
   {* Проверка наличия похожих документов }
  procedure get_same_documents(out out_list: ICatalogBase);
   {* Получить список похожих документов }
  procedure get_server_doc;
  class function make(const document): BadFactoryType; overload;
  class function make(const pid;
   is_edition: Boolean;
   name: PAnsiChar): BadFactoryType; overload;
  function is_morpho_search_supported: Boolean;
   {* индексирован ли документ для морфопоиска }
  function get_link_info(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): TLinkInfo;
  procedure get_missing_info_for_object(const pid: TPId;
   out missing_info: IMissingInfo);
   {* Возвращает расширенную информацию по отсутствующему объекту (pid - идентификатор и класс объекта по ссылке) }
  function get_drug_list: ICatalogBase; { can raise CanNotFindData }
   {* Получить список выпускаемых фирмой препаратов }
  function get_flash: IExternalObject;
   {* Получение флеш-ролика }
  function create_journal_bookmark(para: TParaId): IJournalBookmark;
   {* Создать журнальную закладку }
  function get_auto_referat_doc_count: size; { can raise Unsupported }
   {* вернуть число документов для автореферата }
  function get_text_provider(all_at_once: Boolean): IDocumentTextProvider; { can raise Unsupported, CanNotFindData }
  function get_text_provider_desc_list: IDocumentTextProviderDescriptorList; { can raise Unsupported }
  function get_text_provider_by_desc(handle: Cardinal): IDocumentTextProvider; { can raise Unsupported }
  function get_text_provider_list(all_at_once: Boolean): IDocumentTextProviderList; { can raise Unsupported }
  function get_autoreferat_header_evd: IStream; { can raise Unsupported }
  function get_annotation_header_evd(handle: Cardinal): IStream; { can raise Unsupported }
  function diff(const pid): TDiffData;
  function get_evd_stream: IStream;
   {* возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе документа или документа запрещенного к просмотру }
  procedure get_self_missing_info(out missing_info: IMissingInfo);
   {* Получить расширенную информацию по текущему документу (в случае его отсутствия - в каких блоках этот документ присутствует) }
  function get_multi_link_info(doc_id: Cardinal;
   const id: TTopic): IDocPointList; { can raise CanNotFindData, InternalDatabaseError }
   {* Получить данные по мульnиссылке в виде списка (DocId, SubId) }
  procedure dont_show_document_status_changes_warning;
   {* Не показывать статус изменения данного документа в текущей сессии }
  procedure get_redaction_pid;
  function has_chronology: Boolean;
   {* есть ли у документа хронология рассмотрения судебного дела
K555095873 }
  function get_link(doc_id: Cardinal;
   const id: TTopic;
   rid: TRedactionID): ILink;
  procedure get_same_to_point(id: TExternalID;
   out out_list: ICatalogBase);
  property name: IString
   read Get_name;
   {* Имя документа. }
  property short_name: IString
   read Get_short_name;
   {* Краткое имя документа. }
  property warning: IString
   read Get_warning;
   {* Предупреждение к документу. }
  property size: Cardinal
   read Get_size;
   {* размер документа в байтах }
  property internal_id: Cardinal
   read Get_internal_id;
   {* внутренний номер документа в базе }
  property not_tm: Boolean
   read Get_not_tm;
   {* True - если документ не подключен к машине времени }
  property file_position: IString
   read Get_file_position;
  property new_revision_available: Boolean
   read Get_new_revision_available;
   {* Доступна новая ревизия документа (для супермобильной версии) }
  property change_status: Cardinal
   read Get_change_status;
   {* Статус изменения документа }
  property status: TItemStatus
   read Get_status;
   {* Статус документа }
  property text_languages: ILanguagesList
   read Get_text_languages;
  property attributes_root: INodeBase
   read Get_attributes_root;
  property redactions_list: IRedactionInfoList
   read Get_redactions_list;
  property current_state: IDocumentState
   read Get_current_state;
  property doc_type: TDocumentType
   read Get_doc_type;
  property translation: IDocument
   read Get_translation;
  property annotation: IDocument
   read Get_annotation;
  property related_doc: IDocument
   read Get_related_doc;
  property contents_root: INodeBase
   read Get_contents_root;
  property bookmark_list: IBookmarkList
   read Get_bookmark_list;
  property comments_para_list: ICommentsParaList
   read Get_comments_para_list;
  property external_object_data_list: IExternalObjectDataList
   read Get_external_object_data_list;
 end;//IDocument

 IBookmark = interface(IEntityBase)
  {* Закладка на документ. Используется для сохранения документа (и позиции) в папках. }
  ['{830AC32A-C3AC-4AA1-A5A1-0ACAE229DD2A}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_comment: IString;
  procedure Set_comment(const aValue: IString);
  function Get_paragraph: TParaId;
  function Get_pid: TPId;
  function Get_document: IDocument;
  property name: IString
   read Get_name
   write Set_name;
   {* Названите закладки. Используется в качестве caption в Папках. }
  property comment: IString
   read Get_comment
   write Set_comment;
   {* полное имя документа и блока/саба на который указывает закладка. Используется в качестве hint  в Папках. }
  property paragraph: TParaId
   read Get_paragraph;
  property pid: TPId
   read Get_pid;
  property document: IDocument
   read Get_document;
 end;//IBookmark

 IDocumentState = interface
  {* Интерфейс для работы с редакциями объекта. }
  ['{71C2A950-3D61-44A9-A0FA-845C4A9F5B97}']
  function Get_language: TLanguages;
  procedure Set_language(aValue: TLanguages);
  function Get_prev_redactions_list: IRedactionInfoList;
  function Get_cur_and_next_redactions_list: IRedactionInfoList;
  procedure set_prev_redaction; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей предыдущую редакцию объекта.
Если предыдущей редакции нет, то возвращается RedactionNotFound. }
  procedure set_next_redaction; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей следующую редакцию объекта.
Если следующей редакции нет, то возвращается RedactionNotFound. }
  procedure set_redaction_on_date(const date: TDate); { can raise RedactionNotFound }
  procedure set_redaction_on_id(id: TRedactionID); { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой, что и до вызова метода.
Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId. }
  procedure set_actual_redaction; { can raise RedactionNotFound }
   {* Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой, что и до вызова метода. }
  function redaction: TRedactionID;
  function get_current_redaction: TRedactionInfo;
  function is_same_redactions(const other: IDocumentState): Boolean;
  function diff_with_redaction_by_id(id: TRedactionID): TDiffData;
  function clone: IDocumentState;
  procedure set_prev_active_redaction; { can raise RedactionNotFound }
   {* GetБлижайшаяДействующаяРедакцияВниз. [$178325284] }
  function can_compare_with_any_other_redaction: Boolean;
   {* [$178325284] }
  function is_actual: Boolean;
   {* возвращает true, если эта редакция актуальная, т. е. имеет тип:
- RT_ACTUAL
- RT_ACTUAL_ABOLISHED
- RT_ACTUAL_PREACTIVE }
  property language: TLanguages
   read Get_language
   write Set_language;
  property prev_redactions_list: IRedactionInfoList
   read Get_prev_redactions_list;
  property cur_and_next_redactions_list: IRedactionInfoList
   read Get_cur_and_next_redactions_list;
   {* [$178324034] }
 end;//IDocumentState

 AllChangesInTables = class
 end;//AllChangesInTables

 IJournalBookmark = interface(IEntityBase)
  {* Журнальная закладка }
  ['{7EC5D2E1-6B5C-4C7E-AE21-C98E21A8D018}']
  function Get_name: IString;
  function Get_full_name: IString;
  function Get_para_id: Cardinal;
  function Get_document: IDocument;
  procedure get_journal_bookmark;
   {* Получить  серверную журнальную закладку }
  property name: IString
   read Get_name;
   {* Имя }
  property full_name: IString
   read Get_full_name;
   {* Полное имя (хинт) }
  property para_id: Cardinal
   read Get_para_id;
  property document: IDocument
   read Get_document;
 end;//IJournalBookmark

 TDocumentLayerID = TLayerID;

 ILink = interface
  ['{FBA5DE98-0FAD-4647-B2DE-AB788A6DDFE6}']
  function get_object_type: TLinkedObjectType;
  function get_object: IUnknown; { can raise InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode }
  function get_link_info: TLinkInfo;
  function get_linked_hint: IString;
  function get_kind: TLinkKind;
 end;//ILink

 IJournalBookmarkList = array of IJournalBookmark;

 IDiffDocDataProvider = interface
  ['{E9D2FB7F-1DE5-4C75-8998-72B6C443FF03}']
  function get_all_leaf_para_count: Cardinal;
  function get_header_para_list: IDiffDocParaList;
   {* Заголовок документа состоит из:

Фраза "Обзор изменений документа"
Длинное имя документа (!Name)
Фраза "Подготовлено экспертами компании "Гарант" 
Фраза "Далее приведены изменившиеся фрагменты редакций:" }
  function get_date_para_right(out para: TDiffDocPara): Boolean;
   {* параграф с датами изменений документа для правого документа }
  function get_date_para_left(out para: TDiffDocPara): Boolean;
   {* параграф с датами изменений документа для левого документа }
  function get_redaction_name_right: TDiffDocPara;
   {* Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для правого документа) }
  function get_redaction_name_left: TDiffDocPara;
   {* Каждая таблица имеет заголовок содержащий имена редакций (это имя редакции для левого документа) }
  function get_changed_block_count: Cardinal;
  function get_changed_block(i: Cardinal): TChangedBlock;
 end;//IDiffDocDataProvider

 IObjectFromLink = interface
  ['{51778307-FE15-45BF-9A86-62A66BF81725}']
  function get_object: IUnknown;
  function get_object_type: TLinkedObjectType;
  class function make(const server_link): BadFactoryType;
 end;//IObjectFromLink

const
 ROOT_CHILD: TChildID = 0;
 ROOT_LAYER: TLayerID = 4294967295;
  {* 0xFFFFFFFF }

class function make(const pid): BadFactoryType;
class function make(const diff_data): BadFactoryType;
class function make(const list): BadFactoryType;
class function make(const server_doc;
 const handle;
 all_at_once: Boolean): BadFactoryType; overload;
class function make(const server_doc;
 handle: Cardinal;
 all_at_once: Boolean): BadFactoryType; overload;
class function make(const bookmark;
 const doc_bookmark;
 var folders_node: IFoldersNode): BadFactoryType;
class function make(var source_doc: IDocument): BadFactoryType; overload;
class function make: BadFactoryType; overload;
class function make(doc_id: TObjectId;
 para_id: TParaId): BadFactoryType; overload;
class function make(const journal_bookmark): BadFactoryType; overload;
class function make(doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType; overload;
class function make(const document: IDocument;
 doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType; overload;
class function make(const left: IDocument;
 const right: IDocument): BadFactoryType; { can raise AllChangesInTables }

implementation

uses
 l3ImplUses
;

class function make(const pid): BadFactoryType;
var
 l_Inst : IMissingInfo;
begin
 l_Inst := Create(pid);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const diff_data): BadFactoryType;
var
 l_Inst : IDiffIterator;
begin
 l_Inst := Create(diff_data);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const list): BadFactoryType;
var
 l_Inst : IFoundContext;
begin
 l_Inst := Create(list);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_doc;
 const handle;
 all_at_once: Boolean): BadFactoryType;
var
 l_Inst : IDocumentTextProvider;
begin
 l_Inst := Create(server_doc, handle, all_at_once);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_doc;
 handle: Cardinal;
 all_at_once: Boolean): BadFactoryType;
var
 l_Inst : IDocumentTextProvider;
begin
 l_Inst := Create(server_doc, handle, all_at_once);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const bookmark;
 const doc_bookmark;
 var folders_node: IFoldersNode): BadFactoryType;
var
 l_Inst : IBookmark;
begin
 l_Inst := Create(bookmark, doc_bookmark, folders_node);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(var source_doc: IDocument): BadFactoryType;
var
 l_Inst : IDocumentState;
begin
 l_Inst := Create(source_doc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IDocumentState;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: TObjectId;
 para_id: TParaId): BadFactoryType;
var
 l_Inst : IJournalBookmark;
begin
 l_Inst := Create(doc_id, para_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const journal_bookmark): BadFactoryType;
var
 l_Inst : IJournalBookmark;
begin
 l_Inst := Create(journal_bookmark);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType;
var
 l_Inst : ILink;
begin
 l_Inst := Create(doc_id, topic, redaction_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const document: IDocument;
 doc_id: Cardinal;
 const topic: TTopic;
 redaction_id: TRedactionID): BadFactoryType;
var
 l_Inst : ILink;
begin
 l_Inst := Create(document, doc_id, topic, redaction_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const left: IDocument;
 const right: IDocument): BadFactoryType; { can raise AllChangesInTables }
var
 l_Inst : IDiffDocDataProvider;
begin
 l_Inst := Create(left, right);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
