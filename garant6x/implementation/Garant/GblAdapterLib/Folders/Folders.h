////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// тип папочной ноды
typedef unsigned long FolderId;

// Значения flags для  элемента FoldersNode.
static const unsigned long NF_CONTROLLED = 1; // Сохраненный элемент стоит на контроле.
static const unsigned long NF_SHARED = 2; // Расшарен ли этот узел (если папка).
static const unsigned long NF_EXTERNAL = 4; // Внешний узел.
static const unsigned long NF_IN_SHARED = 8; // Расположен ли этот узел в шареной папке.
static const unsigned long NF_HAS_SHARED = 16; // Есть ли в этом узле (если папка) шаренные папки.
static const unsigned long NF_COMMENTS = 32; // Папка Мои комментарии
static const unsigned long NF_IN_COMMENTS = 64; // Элемент внутри папки Мои кооментарии
static const unsigned long NF_COMMON = 128; // Папка Общие
static const unsigned long NF_USER = 256; // Папки внутри папки Общие (по именам пользователей)
static const unsigned long NF_MY_DOCUMENTS = 512; // Папка Мои документы
static const unsigned long NF_MY_CONSULTATIONS = 1024; // Папка Мои консультации
static const unsigned long NF_FOLDER_SENT = 2048; // Папка Мои консультации/Запросы в обработке
static const unsigned long NF_FOLDER_RECEIVED = 4096; // Папка Мои консультации/Ответы
static const unsigned long NF_CONSULTATION_SENT = 8192; // Консультация со статусом CS_SENT
static const unsigned long NF_PAYMENT_REQUEST = 16384; // Консультация со статусом CS_PAYMAND_REQUEST (Запрошена оплата)
static const unsigned long NF_ANSWER_RECEIVED = 32768; // Консультация со статусом CS_ANSWER_RECEIVED (получен ответ)
static const unsigned long NF_ANSWER_READ = 65536; // Консультация со статусом CS_ANSWER_READ (ответ прочитан)
static const unsigned long NF_ESTIMATION_SENT = 131072; // Консультация со статусом CS_ESTIMATION_SENT (отправлена оценка)
static const unsigned long NF_FOLDER_DRAFTS = 262144; // Папка Мои консультации/Исходящие запросы
static const unsigned long NF_FOLDER_PAYMENT_REFUSAL = 524288; // Папка Мои консультации/Неподтвержденные
static const unsigned long NF_DRAFTS = 1048576; // Консультация со статусом CS_DRAFTS (созданная, но еще не отправленная консультация)
static const unsigned long NF_PAYMENT_REFUSAL = 2097152; // Консультация со статусом CS_PAYMENT_REFUSAL (консультация с неподтвержденной оплатой)
static const unsigned long NF_PAYMENT_CONFIRM = 4194304; // Консультация со статусом CS_PAYMENT_CONFIRM (консультация с подтвержденной оплатой)
static const unsigned long NF_VALIDATION_FAILED = 8388608; // Консультация со статусом CS_VALIDATION_FAILED (консультация не отправлена, так как база невалидирована)

class FoldersNode;
typedef ::Core::Var<FoldersNode> FoldersNode_var;
typedef ::Core::Var<const FoldersNode> FoldersNode_cvar;

class Folders;

// Специализированная нода для Папок. Хранит дополнительный атрибут "дата создания".
// Атрибуты Caption и Hint унаследованные от Node представляю собой Имя элемента и Пользовательский
// Комментарий соответственно.
// В качестве BaseEntity нода может содержать Закладку на Документ, Список, Запрос или собственно
// узел (Folder). Имена и хинты всех элементов (кроме узла) копируются при создании в ноду, однако
// потом могут изменятся независимо (т.е. изменения имени ноды не влечет за собой изменения имени
// сущности содержащейся в ней).
class FoldersNode
	: virtual public Node
	, virtual public Controllable
{
public:
	// Сонтент айди
	virtual const FolderId get_id () const = 0;

	// Дата создания
	virtual const Date get_creation_date () const = 0;

	// Сохраняет информацию о сущности, представляемой папочной нодой консультации в xml.
	virtual void save_consultation_to_xml (const char* xml_file_path) const = 0;

	virtual void save_to_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ = 0;

	// загружает информацию из xml в папку (пустую, нерасшаренную).
	virtual void load_from_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ = 0;

	// сохранить ноду для библиотеки интеграции
	virtual GCI::IO::String* save_to_integration_xml () const /*throw (InvalidEntityType)*/ = 0;

	// Указывает может ли консультация быть сохранена в xml.
	virtual bool can_save_consultation_to_xml () const = 0;

	// указывает может ли нода быть сохранена в xml.
	virtual bool can_save_to_xml () const = 0;

	// указывает можно ли в ноду загрузить данные из xml.
	virtual bool can_load_from_xml () const = 0;

	// может ли нода быть сохранена для библиотеки интеграции
	virtual bool can_save_to_integration_xml () const = 0;

	virtual GCD::PID get_pid () const = 0;
};

/// factory interface for FoldersNode
class FoldersNodeFactory {
public:
	static FoldersNode* make (Containers::Content* content, Folders* folders)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Folders;
typedef ::Core::Var<Folders> Folders_var;
typedef ::Core::Var<const Folders> Folders_cvar;

class Folder;

// Интерфейс (менеджер) обеспечивающий работу с деревом папок. Сложит фабрикой для узлов (Folder).
class Folders
	: virtual public BaseCatalog
{
public:
	// Фабрика узлов, возвращает новый созданный экземпляр BaseEntity типа Folder.
	virtual Folder* create_folder () const = 0;

	// Найти узел папки по его идентификатору. Если не найден то CanNotFindData.
	virtual FoldersNode* find_folder_node (FolderId id) const = 0;
};

/// factory interface for Folders
class FoldersFactory {
public:
	static Folders& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Статус изменения папки.
enum NotifyStatus {
	NS_NODE // Изменена структура папки. Означает что удалился/добавился один из дочерних узлов.
	, NS_CONTENT // Изменено содержимое папки, например имя папки, комментарий, дата, и т.д.
};

class DoneNotifier;
typedef ::Core::Var<DoneNotifier> DoneNotifier_var;
typedef ::Core::Var<const DoneNotifier> DoneNotifier_cvar;
class DoneNotifier
	: virtual public ::Core::IObject
{
public:
	virtual bool done () = 0;
};

class Folder;
typedef ::Core::Var<Folder> Folder_var;
typedef ::Core::Var<const Folder> Folder_cvar;
// Реализация BaseEntity воплощающая узловой элемент дерва Папок.
class Folder
	: virtual public EntityBase
	, virtual public NamedElement
{
public:
	// Для сетевой версии. Признак того что папка является общедоступной, т.е видимой другим
	// пользователям.
	// Прим. внешние папки вегда являются общедоступными.
	// При попытки изменить данный признак у внешней папки генерируется исключение ConstantModify.
	virtual bool get_shared () const = 0;

	virtual void set_shared (bool shared) = 0;

	// Для сетевой версии.
	// Признак того что папка является внешней (т.е. не собственной а принадлежащей другому
	// пользователю).
	virtual bool get_external () const = 0;

	// можно ли расшарить папку
	virtual bool can_share () const = 0;
};

/// factory interface for Folder
class FolderFactory {
public:
	static Folder* make (GblFolders::Folder* folder_content, FoldersNode* folders_node)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Значения object_type для  элемента FolderNode.
enum FoldersItemType {
	FIT_BOOKMARK // Интерфейс Bookamark
	, FIT_LIST // Интерфейс List
	, FIT_QUERY // Интерфейс Query
	, FIT_FOLDER // Группирующий элемент (папка)
	, FIT_CONSULTATION // Консультация
	, FIT_PHARM_LIST // список мед. препаратов
	, FIT_PHARM_BOOKMARK // закладка на мед. препарат
	, FIT_OLD_HISTORY // Ссылка на старый журнал работы
};

#pragma pack (push, 1)

// Данные нотификации по изменению папок.
struct NotifyData {
	// Статус изменения.
	NotifyStatus status;
	DoneNotifier_var done_notifier;
	FoldersNode_var folder;
};

#pragma pack (pop)

class ExternalFoldersChangeNotifier;
typedef ::Core::Var<ExternalFoldersChangeNotifier> ExternalFoldersChangeNotifier_var;
typedef ::Core::Var<const ExternalFoldersChangeNotifier> ExternalFoldersChangeNotifier_cvar;
// Интерфейс нотификации изменения структуры папок.
class ExternalFoldersChangeNotifier
	: virtual public ::Core::IObject
{
public:
	// Произошло изменение папки. При этом необходимо перечитать только непосредственное содержимое
	// папки, исключая рекурсивную прогрузку дочерних папок.
	virtual void fire (const NotifyData& data) const = 0;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FoldersNode> {
	typedef GblAdapterLib::FoldersNodeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Folders> {
	typedef GblAdapterLib::FoldersFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Folder> {
	typedef GblAdapterLib::FolderFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
