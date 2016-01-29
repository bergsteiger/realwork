unit FoldersUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/FoldersUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, BaseTreeSupportUnit
	, FiltersUnit
	, UnderControlUnit
	//#UC START# *4423F94903C8_4570501E037A_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4570501E037A_UNIT_FOR_Stream*
	;

type

IFoldersNode = interface;
{ - предварительное описание IFoldersNode. }

IFolders = interface;
{ - предварительное описание IFolders. }

IFolder = interface;
{ - предварительное описание IFolder. }


// тип папочной ноды
PFolderId = ^TFolderId;
TFolderId = Longword;

// Статус изменения папки.
PNotifyStatus = ^TNotifyStatus;
TNotifyStatus = (
	NS_NODE // Изменена структура папки. Означает что удалился/добавился один из дочерних узлов.
	, NS_CONTENT // Изменено содержимое папки, например имя папки, комментарий, дата, и т.д.
);

IDoneNotifier = interface (IInterface) ['{B9089580-C0F0-43C8-B449-B2AA3A0D4FFF}']
	function DontUseMe: Pointer;
	function Done (): Bytebool; stdcall;
end;

// Значения object_type для  элемента FolderNode.
PFoldersItemType = ^TFoldersItemType;
TFoldersItemType = (
	FIT_BOOKMARK // Интерфейс Bookamark
	, FIT_LIST // Интерфейс List
	, FIT_QUERY // Интерфейс Query
	, FIT_FOLDER // Группирующий элемент (папка)
	, FIT_CONSULTATION // Консультация
	, FIT_PHARM_LIST // список мед. препаратов
	, FIT_PHARM_BOOKMARK // закладка на мед. препарат
	, FIT_OLD_HISTORY // Ссылка на старый журнал работы
);

// Данные нотификации по изменению папок.
PNotifyData = ^TNotifyData;
TNotifyData = packed record
	rStatus: TNotifyStatus; // Статус изменения.
	rDoneNotifier: IDoneNotifier;
	rFolder: IFoldersNode;
end;

// Интерфейс нотификации изменения структуры папок.
IExternalFoldersChangeNotifier = interface (IInterface) ['{9AFA9214-42F7-439F-97DB-EB7827289CE0}']
	// Произошло изменение папки. При этом необходимо перечитать только непосредственное содержимое
	// папки, исключая рекурсивную прогрузку дочерних папок.
	procedure Fire (
		const aData: TNotifyData
	); stdcall;
end;

// Специализированная нода для Папок. Хранит дополнительный атрибут "дата создания".
// Атрибуты Caption и Hint унаследованные от Node представляю собой Имя элемента и Пользовательский
// Комментарий соответственно.
// В качестве BaseEntity нода может содержать Закладку на Документ, Список, Запрос или собственно
// узел (Folder). Имена и хинты всех элементов (кроме узла) копируются при создании в ноду, однако
// потом могут изменятся независимо (т.е. изменения имени ноды не влечет за собой изменения имени
// сущности содержащейся в ней).
IFoldersNode = interface (INode) ['{6B1E4393-7BE4-4201-A8F9-D3C817C440B5}']
	// указывает можно ли в ноду загрузить данные из xml.
	function CanLoadFromXml (): Bytebool; stdcall;

	// Указывает может ли консультация быть сохранена в xml.
	function CanSaveConsultationToXml (): Bytebool; stdcall;

	// может ли нода быть сохранена для библиотеки интеграции
	function CanSaveToIntegrationXml (): Bytebool; stdcall;

	// указывает может ли нода быть сохранена в xml.
	function CanSaveToXml (): Bytebool; stdcall;

	// Дата создания
	procedure GetCreationDate (out a: TDate); stdcall;

	// Сонтент айди
	function GetId (): TFolderId; stdcall;

	// загружает информацию из xml в папку (пустую, нерасшаренную).
	procedure LoadFromXml (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidEntityType

	// Сохраняет информацию о сущности, представляемой папочной нодой консультации в xml.
	procedure SaveConsultationToXml (
		const aXmlFilePath: PAnsiChar
	); stdcall;

	// сохранить ноду для библиотеки интеграции
	procedure SaveToIntegrationXml (
		out aRet {: IString}
	); stdcall; // can raise EInvalidEntityType

	procedure SaveToXml (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidEntityType
end;

// Интерфейс (менеджер) обеспечивающий работу с деревом папок. Сложит фабрикой для узлов (Folder).
IFolders = interface (IBaseCatalog) ['{085870DB-A1B6-48E7-ADDD-3C9F3911FEF5}']
	// Фабрика узлов, возвращает новый созданный экземпляр BaseEntity типа Folder.
	procedure CreateFolder (
		out aRet {: IFolder}
	); stdcall;

	// Найти узел папки по его идентификатору. Если не найден то CanNotFindData.
	procedure FindFolderNode (
		aId: TFolderId;
		out aRet {: IFoldersNode}
	); stdcall;
end;

// Реализация BaseEntity воплощающая узловой элемент дерва Папок.
IFolder = interface (INamedElement) ['{4B736A91-FDC7-4F00-B445-9C91CE120AB9}']
	// можно ли расшарить папку
	function CanShare (): Bytebool; stdcall;

	// Для сетевой версии.
	// Признак того что папка является внешней (т.е. не собственной а принадлежащей другому
	// пользователю).
	function GetExternal (): Bytebool; stdcall;

	// Для сетевой версии. Признак того что папка является общедоступной, т.е видимой другим
	// пользователям.
	// Прим. внешние папки вегда являются общедоступными.
	// При попытки изменить данный признак у внешней папки генерируется исключение ConstantModify.
	function GetShared (): Bytebool; stdcall;
	procedure SetShared (aShared: Bytebool); stdcall;
end;

const

 { Значения flags для  элемента FoldersNode. }
	NF_CONTROLLED = Longword(1);
 { Сохраненный элемент стоит на контроле. }
	NF_SHARED = Longword(2);
 { Расшарен ли этот узел (если папка). }
	NF_EXTERNAL = Longword(4);
 { Внешний узел. }
	NF_IN_SHARED = Longword(8);
 { Расположен ли этот узел в шареной папке. }
	NF_HAS_SHARED = Longword(16);
 { Есть ли в этом узле (если папка) шаренные папки. }
	NF_COMMENTS = Longword(32);
 { Папка Мои комментарии }
	NF_IN_COMMENTS = Longword(64);
 { Элемент внутри папки Мои кооментарии }
	NF_COMMON = Longword(128);
 { Папка Общие }
	NF_USER = Longword(256);
 { Папки внутри папки Общие (по именам пользователей) }
	NF_MY_DOCUMENTS = Longword(512);
 { Папка Мои документы }
	NF_MY_CONSULTATIONS = Longword(1024);
 { Папка Мои консультации }
	NF_FOLDER_SENT = Longword(2048);
 { Папка Мои консультации/Запросы в обработке }
	NF_FOLDER_RECEIVED = Longword(4096);
 { Папка Мои консультации/Ответы }
	NF_CONSULTATION_SENT = Longword(8192);
 { Консультация со статусом CS_SENT }
	NF_PAYMENT_REQUEST = Longword(16384);
 { Консультация со статусом CS_PAYMAND_REQUEST (Запрошена оплата) }
	NF_ANSWER_RECEIVED = Longword(32768);
 { Консультация со статусом CS_ANSWER_RECEIVED (получен ответ) }
	NF_ANSWER_READ = Longword(65536);
 { Консультация со статусом CS_ANSWER_READ (ответ прочитан) }
	NF_ESTIMATION_SENT = Longword(131072);
 { Консультация со статусом CS_ESTIMATION_SENT (отправлена оценка) }
	NF_FOLDER_DRAFTS = Longword(262144);
 { Папка Мои консультации/Исходящие запросы }
	NF_FOLDER_PAYMENT_REFUSAL = Longword(524288);
 { Папка Мои консультации/Неподтвержденные }
	NF_DRAFTS = Longword(1048576);
 { Консультация со статусом CS_DRAFTS (созданная, но еще не отправленная консультация) }
	NF_PAYMENT_REFUSAL = Longword(2097152);
 { Консультация со статусом CS_PAYMENT_REFUSAL (консультация с неподтвержденной оплатой) }
	NF_PAYMENT_CONFIRM = Longword(4194304);
 { Консультация со статусом CS_PAYMENT_CONFIRM (консультация с подтвержденной оплатой) }
	NF_VALIDATION_FAILED = Longword(8388608);
 { Консультация со статусом CS_VALIDATION_FAILED (консультация не отправлена, так как база невалидирована) }

implementation
end.