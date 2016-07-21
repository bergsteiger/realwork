unit FoldersUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FoldersUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Folders" MUID: (4570501E037A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
 , FiltersUnit
 , UnderControlUnit
 , ContextSearchSupportUnit
;

const
 {* Значения flags для  элемента FoldersNode. }
 NF_CONTROLLED: Cardinal = 1;
  {* Сохраненный элемент стоит на контроле. }
 NF_SHARED: Cardinal = 2;
  {* Расшарен ли этот узел (если папка). }
 NF_EXTERNAL: Cardinal = 4;
  {* Внешний узел. }
 NF_IN_SHARED: Cardinal = 8;
  {* Расположен ли этот узел в шареной папке. }
 NF_HAS_SHARED: Cardinal = 16;
  {* Есть ли в этом узле (если папка) шаренные папки. }
 NF_COMMENTS: Cardinal = 32;
  {* Папка Мои комментарии }
 NF_IN_COMMENTS: Cardinal = 64;
  {* Элемент внутри папки Мои кооментарии }
 NF_COMMON: Cardinal = 128;
  {* Папка Общие }
 NF_USER: Cardinal = 256;
  {* Папки внутри папки Общие (по именам пользователей) }
 NF_MY_DOCUMENTS: Cardinal = 512;
  {* Папка Мои документы }
 NF_MY_CONSULTATIONS: Cardinal = 1024;
  {* Папка Мои консультации }
 NF_FOLDER_SENT: Cardinal = 2048;
  {* Папка Мои консультации/Запросы в обработке }
 NF_FOLDER_RECEIVED: Cardinal = 4096;
  {* Папка Мои консультации/Ответы }
 NF_CONSULTATION_SENT: Cardinal = 8192;
  {* Консультация со статусом CS_SENT }
 NF_PAYMENT_REQUEST: Cardinal = 16384;
  {* Консультация со статусом CS_PAYMAND_REQUEST (Запрошена оплата) }
 NF_ANSWER_RECEIVED: Cardinal = 32768;
  {* Консультация со статусом CS_ANSWER_RECEIVED (получен ответ) }
 NF_ANSWER_READ: Cardinal = 65536;
  {* Консультация со статусом CS_ANSWER_READ (ответ прочитан) }
 NF_ESTIMATION_SENT: Cardinal = 131072;
  {* Консультация со статусом CS_ESTIMATION_SENT (отправлена оценка) }
 NF_FOLDER_DRAFTS: Cardinal = 262144;
  {* Папка Мои консультации/Исходящие запросы }
 NF_FOLDER_PAYMENT_REFUSAL: Cardinal = 524288;
  {* Папка Мои консультации/Неподтвержденные }
 NF_DRAFTS: Cardinal = 1048576;
  {* Консультация со статусом CS_DRAFTS (созданная, но еще не отправленная консультация) }
 NF_PAYMENT_REFUSAL: Cardinal = 2097152;
  {* Консультация со статусом CS_PAYMENT_REFUSAL (консультация с неподтвержденной оплатой) }
 NF_PAYMENT_CONFIRM: Cardinal = 4194304;
  {* Консультация со статусом CS_PAYMENT_CONFIRM (консультация с подтвержденной оплатой) }
 NF_VALIDATION_FAILED: Cardinal = 8388608;
  {* Консультация со статусом CS_VALIDATION_FAILED (консультация не отправлена, так как база невалидирована) }

type
 TFolderId = Cardinal;
  {* тип папочной ноды }

 IFolders = interface;

 IFoldersNode = interface(INode)
  {* Специализированная нода для Папок. Хранит дополнительный атрибут "дата создания".
Атрибуты Caption и Hint унаследованные от Node представляю собой Имя элемента и Пользовательский Комментарий соответственно.
В качестве BaseEntity нода может содержать Закладку на Документ, Список, Запрос или собственно узел (Folder). Имена и хинты всех элементов (кроме узла) копируются при создании в ноду, однако потом могут изменятся независимо (т.е. изменения имени ноды не влечет за собой изменения имени сущности содержащейся в ней). }
  ['{6B1E4393-7BE4-4201-A8F9-D3C817C440B5}']
  function GetId: TFolderId; stdcall;
  procedure GetCreationDate; stdcall;
  procedure SaveConsultationToXml(xml_file_path: PAnsiChar); stdcall;
   {* Сохраняет информацию о сущности, представляемой папочной нодой консультации в xml. }
  procedure SaveToXml(xml_file_path: PAnsiChar); stdcall; { can raise AccessDenied, InvalidEntityType }
  procedure LoadFromXml(xml_file_path: PAnsiChar); stdcall; { can raise AccessDenied, InvalidEntityType }
   {* загружает информацию из xml в папку (пустую, нерасшаренную). }
  procedure SaveToIntegrationXml(out aRet
   {* IString }); stdcall; { can raise InvalidEntityType }
   {* сохранить ноду для библиотеки интеграции }
  function CanSaveConsultationToXml: ByteBool; stdcall;
   {* Указывает может ли консультация быть сохранена в xml. }
  function CanSaveToXml: ByteBool; stdcall;
   {* указывает может ли нода быть сохранена в xml. }
  function CanLoadFromXml: ByteBool; stdcall;
   {* указывает можно ли в ноду загрузить данные из xml. }
  function CanSaveToIntegrationXml: ByteBool; stdcall;
   {* может ли нода быть сохранена для библиотеки интеграции }
  procedure GetPid; stdcall;
  property Id: TFolderId
   read GetId;
   {* Сонтент айди }
  property CreationDate: 
   read GetCreationDate;
   {* Дата создания }
 end;//IFoldersNode

 IFolder = interface;

 IFolders = interface(IBaseCatalog)
  {* Интерфейс (менеджер) обеспечивающий работу с деревом папок. Сложит фабрикой для узлов (Folder). }
  ['{085870DB-A1B6-48E7-ADDD-3C9F3911FEF5}']
  procedure CreateFolder(out aRet
   {* IFolder }); stdcall;
   {* Фабрика узлов, возвращает новый созданный экземпляр BaseEntity типа Folder. }
  procedure FindFolderNode(id: TFolderId
   {* Идентификатор узла папки. };
   out aRet
   {* IFoldersNode }); stdcall;
   {* Найти узел папки по его идентификатору. Если не найден то CanNotFindData. }
 end;//IFolders

 TNotifyStatus = (
  {* Статус изменения папки. }
  NS_NODE
   {* Изменена структура папки. Означает что удалился/добавился один из дочерних узлов. }
  , NS_CONTENT
   {* Изменено содержимое папки, например имя папки, комментарий, дата, и т.д. }
 );//TNotifyStatus

 IDoneNotifier = interface
  ['{B9089580-C0F0-43C8-B449-B2AA3A0D4FFF}']
  function Done: ByteBool; stdcall;
 end;//IDoneNotifier

 IFolder = interface(IEntityBase)
  {* Реализация BaseEntity воплощающая узловой элемент дерва Папок. }
  ['{4B736A91-FDC7-4F00-B445-9C91CE120AB9}']
  function GetShared: ByteBool; stdcall;
  procedure SetShared(const aValue: ByteBool); stdcall;
  function GetExternal: ByteBool; stdcall;
  function CanShare: ByteBool; stdcall;
   {* можно ли расшарить папку }
  property Shared: ByteBool
   read GetShared
   write SetShared;
   {* Для сетевой версии. Признак того что папка является общедоступной, т.е видимой другим пользователям.
Прим. внешние папки вегда являются общедоступными.
При попытки изменить данный признак у внешней папки генерируется исключение ConstantModify. }
  property External: ByteBool
   read GetExternal;
   {* Для сетевой версии. 
Признак того что папка является внешней (т.е. не собственной а принадлежащей другому пользователю). }
 end;//IFolder

 TFoldersItemType = (
  {* Значения object_type для  элемента FolderNode. }
  FIT_BOOKMARK
   {* Интерфейс Bookamark }
  , FIT_LIST
   {* Интерфейс List }
  , FIT_QUERY
   {* Интерфейс Query }
  , FIT_FOLDER
   {* Группирующий элемент (папка) }
  , FIT_CONSULTATION
   {* Консультация }
  , FIT_PHARM_LIST
   {* список мед. препаратов }
  , FIT_PHARM_BOOKMARK
   {* закладка на мед. препарат }
  , FIT_OLD_HISTORY
   {* Ссылка на старый журнал работы }
 );//TFoldersItemType

 TNotifyData = record
  {* Данные нотификации по изменению папок. }
  status: TNotifyStatus;
   {* Статус изменения. }
  done_notifier: ;
  folder: ;
 end;//TNotifyData

 IExternalFoldersChangeNotifier = interface
  {* Интерфейс нотификации изменения структуры папок. }
  ['{9AFA9214-42F7-439F-97DB-EB7827289CE0}']
  procedure Fire(const data: TNotifyData
   {* Данные нотификации. }); stdcall;
   {* Произошло изменение папки. При этом необходимо перечитать только непосредственное содержимое папки, исключая рекурсивную прогрузку дочерних папок. }
 end;//IExternalFoldersChangeNotifier

implementation

uses
 l3ImplUses
;

end.
