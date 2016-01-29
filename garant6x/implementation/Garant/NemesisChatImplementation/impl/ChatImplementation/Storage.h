////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Storage
//
// инкапсуляция методов доступа к базе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"

//#UC START# *4A38C38303B8_CUSTOM_INCLUDES*
#include "shared/Core/mng/Box.h"

#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/indexes.h"

static const CORBA::ULong CHAT_STORAGE_VERSION = 1; // версия хранилища сообщений

namespace NemesisChatImplementation {
namespace ChatImplementation {
	typedef NdtClone::SimpleBase<4096, CHAT_STORAGE_VERSION> ChatBase;

	class Storage;
	typedef ACE_Singleton<Storage, Core::NullMutex> Stg;
}
}
//#UC END# *4A38C38303B8_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

// инкапсуляция методов доступа к базе
class Storage {
	SET_OBJECT_COUNTER (Storage)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// название файла базы
	static const std::string& base_file ();

	// путь к базам
	static const std::string& data_path ();

	// имя файла ключей
	static const std::string& key_file ();

	// имя файла данных
	static const std::string& stream_file ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// создание файлов базы
	Storage ();

public:
	virtual ~Storage ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// положить сообщение в базу
	ChatLibrary::ChatService::MessageId add_message (const ChatLibrary::ChatService::Message& message);

	// добавить пользователя _user_ в список контактов для _mine_
	void add_to_contacts (CoreSrv::UserID mine, CoreSrv::UserID user);

	// очистить историю сообщений для пользователя _mine_ с пользователем _user_
	// (_user_ историю переписки с _mine_ не теряет)
	void clean_history (CoreSrv::UserID mine, CoreSrv::UserID user);

	// удалить пользователя _user_ из списка контактов для _mine_
	void delete_from_contacts (CoreSrv::UserID mine, CoreSrv::UserID user);

	// получить список контактов для пользователя _mine_
	ChatLibrary::ChatService::UidList* get_contacts (CoreSrv::UserID mine);

	// получить _count_ сообщений из истории переписки для заданных пользователей. Если count=0,
	// вернётся вся история сообщений
	ChatLibrary::ChatService::MessageList* get_history (
		CoreSrv::UserID my_uid
		, CoreSrv::UserID second
		, CORBA::ULong count
	);

	// то же, что и get_history, но возвращает все новые
	virtual ChatLibrary::ChatService::MessageList* get_history_with_all_new (
		CoreSrv::UserID my_uid
		, CoreSrv::UserID second
		, CORBA::ULong count
	);

	// получить все непрочитанные сообщения для заданного пользователя
	ChatLibrary::ChatService::MessageList* get_unreaded (CoreSrv::UserID user);

	// проверяет включён ли пользователь _user_ в список контактов для _mine_
	CORBA::Boolean is_user_in_contacts_list (CoreSrv::UserID mine, CoreSrv::UserID user);

	// пометить сообщения как прочитанные
	void mark_as_read (const ChatLibrary::ChatService::MessageIds& keys);

private:
	// получить ключ
	CORBA::ULong build_fast_key ();


//#UC START# *4A38C38303B8*
private:
	static Core::Mutex s_path_mutex;

private:
	friend class ACE_Singleton<Storage, Core::NullMutex>;

private:
	void erase_message_by_key (const FastKeyAndUsers& key);
	ChatLibrary::ChatService::MessageList* get_messages_by_keys (
		const std::vector<FastKeyAndUsers>& users_keys
		, CORBA::ULong count
		, CoreSrv::UserID my_uid
	);

	FastKeyIndex& fastkey ();
	MessagesIndex& messages ();
	UsersIndex& users ();
	UnreadedIndex& unreaded ();
	ContactsIndex& contacts ();

	Core::Mutex& mutex ();
// соблюдаем порядок объявления:
// сначала база, потом индексы
// деструкторы должны выполниться в обратном порядке
private:
	ChatBase m_base;

	FastKeyIndex	*m_fast_key_index;
	MessagesIndex	*m_messages_index;
	UsersIndex		*m_users_index;
	UnreadedIndex	*m_unreaded_index;
	ContactsIndex	*m_contacts_index;

	mutable Core::Mutex m_base_mutex;
//#UC END# *4A38C38303B8*
}; // class Storage

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

