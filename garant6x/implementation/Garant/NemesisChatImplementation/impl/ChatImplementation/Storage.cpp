////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Storage
//
// инкапсул€ци€ методов доступа к базе
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/indexes.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/StorageStreamOperators.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementationFactories.h"

//#UC START# *4A38C38303B8_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

Core::Mutex Storage::s_path_mutex;

bool operator< (const FastKeyAndUsers& lhs, const FastKeyAndUsers& rhs) {
	return lhs.key < rhs.key;
}

}
}
//#UC END# *4A38C38303B8_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

//#UC START# *4A38C38303B8*
ChatLibrary::ChatService::MessageList* Storage::get_messages_by_keys (
	const std::vector<FastKeyAndUsers>& users_keys
	, CORBA::ULong count
	, CoreSrv::UserID my_uid
) {
	// считаем, что сообщени€ записываютс€ в базу в пор€дке отправки
	// считаем, что ключи сортированы
	ChatLibrary::ChatService::MessageList_var list (new ChatLibrary::ChatService::MessageList ());
	list->length (count);
	ChatLibrary::ChatService::Message message;
	MessageFlags flags;
	size_t count_to_send = 0;
	for (size_t i = users_keys.size () - count; i < users_keys.size (); ++i) {
		this->messages ().read (users_keys[i].key, message);
		this->messages ().read (users_keys[i].key, flags);
		// в историю должны попасть только неудалЄнные сообщени€
		if (!(flags & MESSAGE_EXISTS_FOR_SENDER_FLAG) && (my_uid == message.meta_data.sender)) {
			continue;
		}
		if (!(flags & MESSAGE_EXISTS_FOR_RECEIVER_FLAG) && (my_uid == message.meta_data.receiver)) {
			continue;
		}
		list[count_to_send++] = message;
	}
	list->length (count_to_send);

	return list._retn ();
}


void Storage::erase_message_by_key (const FastKeyAndUsers& key) {
	GUARD (this->mutex ());

	this->messages ().remove (key.key);
	this->users ().remove (key);
	if (this->unreaded ().is_exist (std::make_pair (key.key, key.receiver))) {
		this->unreaded ().remove (std::make_pair (key.key, key.receiver));
	}
}

FastKeyIndex& Storage::fastkey () {
	return *m_fast_key_index;
}

MessagesIndex& Storage::messages () {
	return *m_messages_index;
}

UsersIndex& Storage::users () {
	return *m_users_index;
}

UnreadedIndex& Storage::unreaded () {
	return *m_unreaded_index;
}

ContactsIndex& Storage::contacts () {
	return *m_contacts_index;
}

Core::Mutex& Storage::mutex () {
	return m_base_mutex;
}
//#UC END# *4A38C38303B8*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// им€ файла ключей
const std::string& Storage::key_file () {
	//#UC START# *4A39DEF2019C*
	static std::string key_file;
	if (key_file.empty ()) {
		GUARD (s_path_mutex);
		if (key_file.empty ()) {
			key_file = Storage::data_path () + ACE_DIRECTORY_SEPARATOR_CHAR + Storage::base_file () + ".k";
		}
	}

	return key_file;
	//#UC END# *4A39DEF2019C*
}

// им€ файла данных
const std::string& Storage::stream_file () {
	//#UC START# *4A39DF2E0009*
	static std::string stream_file;
	if (stream_file.empty ()) {
		GUARD (s_path_mutex);
		if (stream_file.empty ()) {
			stream_file = Storage::data_path () + ACE_DIRECTORY_SEPARATOR_CHAR + Storage::base_file () + ".s";
		}
	}

	return stream_file;
	//#UC END# *4A39DF2E0009*
}

// название файла базы
const std::string& Storage::base_file () {
	//#UC START# *4A39DFEE03CE*
	const static std::string base_file ("data_chb");

	return base_file;
	//#UC END# *4A39DFEE03CE*
}

// путь к базам
const std::string& Storage::data_path () {
	//#UC START# *4A39E18A00B0*
	static std::string path;
	if (path.empty ()) {
		GUARD (s_path_mutex);
		if (path.empty ()) {
			path = Core::ParamManagerFactory::get ().get_string (Defines::PC_SYS_SETTINGS_PATH, "");
			GDS_ASSERT (!path.empty () || !"SettingsPath is not specified");
		}
	}

	return path;
	//#UC END# *4A39E18A00B0*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создание файлов базы
Storage::Storage ()
//#UC START# *4A39D54D0351_BASE_INIT*
//#UC END# *4A39D54D0351_BASE_INIT*
{
	//#UC START# *4A39D54D0351_BODY*
	std::pair <NdtClone::PagedFile*, NdtClone::StreamFile*> base (
		m_base.open (Storage::key_file (), Storage::stream_file ())
	);

	m_fast_key_index = new FastKeyIndex (base.first, "fastkey", base.second);
	m_messages_index = new MessagesIndex (base.first, "messages", base.second);
	m_users_index = new UsersIndex (base.first, "users", base.second);
	m_unreaded_index = new UnreadedIndex (base.first, "unreaded", base.second);
	m_contacts_index = new ContactsIndex (base.first, "contacts", base.second);
	//#UC END# *4A39D54D0351_BODY*
}

Storage::~Storage () {
	//#UC START# *4A38C38303B8_DESTR_BODY*
	//#UC END# *4A38C38303B8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// положить сообщение в базу
ChatLibrary::ChatService::MessageId Storage::add_message (const ChatLibrary::ChatService::Message& message) {
	//#UC START# *4A3A0DB6014B*
	LOG_D (("%s: adding message from %d to %d", GDS_CURRENT_FUNCTION, message.meta_data.sender, message.meta_data.receiver));
	GUARD (this->mutex ());

	FastKey key = this->build_fast_key ();
	const_cast<ChatLibrary::ChatService::Message&> (message).meta_data.id = key;
	MessageFlags flags = MESSAGE_EXISTS_FOR_SENDER_FLAG | MESSAGE_EXISTS_FOR_RECEIVER_FLAG;
	this->messages ().write (key, message);
	this->messages ().write (key, flags);

	this->users ().write (FastKeyAndUsers (key, message.meta_data.sender, message.meta_data.receiver), 0 /*fake*/);
	this->unreaded ().write (std::make_pair (key, message.meta_data.receiver), 0 /*fake*/);

	return key;
	//#UC END# *4A3A0DB6014B*
}

// добавить пользовател€ _user_ в список контактов дл€ _mine_
void Storage::add_to_contacts (CoreSrv::UserID mine, CoreSrv::UserID user) {
	//#UC START# *4A3B2DC9026C*
	LOG_D (("%s: adding user %d to contact list for %d", GDS_CURRENT_FUNCTION, user, mine));
	GUARD (this->mutex ());

	UidList list;
	if (this->contacts ().is_exist (mine)) {
		this->contacts ().read (mine, list);
	}
	if (std::find (list.begin (), list.end (), user) == list.end ()) {
		list.push_back (user);
		this->contacts ().write (mine, list);
	} else {
		LOG_W (("%s: user %d already in contacts list for %d", GDS_CURRENT_FUNCTION, user, mine));
	}
	//#UC END# *4A3B2DC9026C*
}

// получить ключ
CORBA::ULong Storage::build_fast_key () {
	//#UC START# *4A39EB7C02C4*
	GUARD (this->mutex ());
	unsigned long key = LAST_ALLOCATED_FAST_KEY;

	if (this->fastkey ().is_exist (LAST_ALLOCATED_FAST_KEY)) {
		unsigned long last_fast_key;
		this->fastkey ().read (LAST_ALLOCATED_FAST_KEY, last_fast_key);
		key = last_fast_key + 1;
	} 

	this->fastkey ().write (LAST_ALLOCATED_FAST_KEY, key);
	return key;
	//#UC END# *4A39EB7C02C4*
}

// очистить историю сообщений дл€ пользовател€ _mine_ с пользователем _user_
// (_user_ историю переписки с _mine_ не тер€ет)
void Storage::clean_history (CoreSrv::UserID mine, CoreSrv::UserID user) {
	//#UC START# *4A3A1C3F0034*
	LOG_D (("%s: clean history for %d and %d", GDS_CURRENT_FUNCTION, mine, user));
	GUARD (this->mutex ());

	FastKeyByUsersSelector selector (mine, user);
	std::vector<FastKeyAndUsers> keys;
	this->users ().get_keys (selector, keys);

	for (size_t i = 0; i < keys.size (); ++i) {
		MessageFlags flags = 0;
		try {
			this->messages ().read (keys[i].key, flags);
		} catch (NdtClone::Error&) {
			GDS_ASSERT (false && "users and messages indexes mistiming");
		}
		GDS_ASSERT (flags && "flags can't be equal to zero");

		MessageFlags whoami = (mine == keys[i].sender) ? MESSAGE_EXISTS_FOR_SENDER_FLAG : MESSAGE_EXISTS_FOR_RECEIVER_FLAG;
		flags &= ~whoami;
		// если сообщение не видимо ни получателю ни отправителю - чистим его из базы
		if (!(flags & (MESSAGE_EXISTS_FOR_SENDER_FLAG | MESSAGE_EXISTS_FOR_RECEIVER_FLAG))) {
			this->erase_message_by_key (keys[i]);
		} else {
			this->messages ().write (keys[i].key, flags);
			// если сообщение не прочитано тем, кто почистил историю переписки, чистим его из непрочитанных
			if ((whoami == MESSAGE_EXISTS_FOR_RECEIVER_FLAG) && this->unreaded ().is_exist (std::make_pair (keys[i].key, keys[i].receiver))) {
				this->unreaded ().remove (std::make_pair (keys[i].key, keys[i].receiver));
			}
		}
	}
	//#UC END# *4A3A1C3F0034*
}

// удалить пользовател€ _user_ из списка контактов дл€ _mine_
void Storage::delete_from_contacts (CoreSrv::UserID mine, CoreSrv::UserID user) {
	//#UC START# *4A3A02ED01C9*
	LOG_D (("%s: delete %d from contacs for %d", GDS_CURRENT_FUNCTION, user, mine));
	GUARD (this->mutex ());

	if (this->contacts ().is_exist (mine)) {
		UidList list;
		this->contacts ().read (mine, list);
		list.erase (std::remove (list.begin (), list.end (), user));
		this->contacts ().write (mine, list);
	}
	//#UC END# *4A3A02ED01C9*
}

// получить список контактов дл€ пользовател€ _mine_
ChatLibrary::ChatService::UidList* Storage::get_contacts (CoreSrv::UserID mine) {
	//#UC START# *4A3B3882021F*
	LOG_D (("%s: get contacts for %d", GDS_CURRENT_FUNCTION, mine));
	GUARD (this->mutex ());

	Core::Aptr<ChatLibrary::ChatService::UidList> list (new ChatLibrary::ChatService::UidList ());
	if (this->contacts ().is_exist (mine)) {
		UidList data;
		this->contacts ().read (mine, data);
		list->length (data.size ());
		for (size_t i = 0; i < data.size (); ++i) {
			list->operator [] (i)  = data[i];
		}
	}

	return list._retn ();
	//#UC END# *4A3B3882021F*
}

// получить _count_ сообщений из истории переписки дл€ заданных пользователей. ≈сли count=0,
// вернЄтс€ вс€ истори€ сообщений
ChatLibrary::ChatService::MessageList* Storage::get_history (
	CoreSrv::UserID my_uid
	, CoreSrv::UserID second
	, CORBA::ULong count
) {
	//#UC START# *4A3A2D5A028D*
	LOG_D (("%s: get history between %d and %d (minimum %d messages)", GDS_CURRENT_FUNCTION, my_uid, second, count));
	GUARD (this->mutex ());

	FastKeyByUsersSelector selector (my_uid, second);
	std::vector<FastKeyAndUsers> keys;
	this->users ().get_keys (selector, keys);
	std::sort (keys.begin (), keys.end ());

	if (!count) {
		count = keys.size ();
	} else {
		count = std::min<size_t> (count, keys.size ());
	}

	return this->get_messages_by_keys (keys, count, my_uid);
	//#UC END# *4A3A2D5A028D*
}

// то же, что и get_history, но возвращает все новые
ChatLibrary::ChatService::MessageList* Storage::get_history_with_all_new (
	CoreSrv::UserID my_uid
	, CoreSrv::UserID second
	, CORBA::ULong count
) {
	//#UC START# *4A49E76101BB*
	LOG_D (("%s: get history between %d and %d, get all new (minimum %d messages)", GDS_CURRENT_FUNCTION, my_uid, second, count));
	GUARD (this->mutex ());

	FastKeyByUsersSelector selector (my_uid, second);
	std::vector<FastKeyAndUsers> users_keys;
	this->users ().get_keys (selector, users_keys);
	std::sort (users_keys.begin (), users_keys.end ());
	if (!count || (count >= users_keys.size ())) {
		count = users_keys.size ();
	} else {
		// ищем первое непрочитанное сообщение от заданного пользовател€
		UnreadedKeyByUserSelector selector (my_uid);
		std::vector<UnreadedKey> unreaded_keys;
		this->unreaded ().get_keys (selector, unreaded_keys);

		ChatLibrary::ChatService::Message message;
		FastKey key = LAST_ALLOCATED_FAST_KEY - 1;
		for (size_t i = 0; i < unreaded_keys.size (); ++i) {
			this->messages ().read (unreaded_keys[i].first, message);
			if (message.meta_data.sender == second) {
				key = unreaded_keys[i].first;
			}
		}
		// ищем первое непрочитанное в списке сообщений, если такое есть
		if (key != LAST_ALLOCATED_FAST_KEY - 1) {
			for (long i = users_keys.size () - 1; i >= 0; --i) {
				if (users_keys[i].key == key) {
					if (count < (users_keys.size () - i)) {
						count = users_keys.size () - i;
					}
					break;
				}
			}
		}

		count = std::min<size_t> (count, users_keys.size ());
	}

	return this->get_messages_by_keys (users_keys, count, my_uid);
	//#UC END# *4A49E76101BB*
}

// получить все непрочитанные сообщени€ дл€ заданного пользовател€
ChatLibrary::ChatService::MessageList* Storage::get_unreaded (CoreSrv::UserID user) {
	//#UC START# *4A3A340502AB*
	LOG_D (("%s: get unreaded messages for %d", GDS_CURRENT_FUNCTION, user));
	GUARD (this->mutex ());

	UnreadedKeyByUserSelector selector (user);
	std::vector<UnreadedKey> keys;
	this->unreaded ().get_keys (selector, keys);

	Core::Aptr<ChatLibrary::ChatService::MessageList> list (new ChatLibrary::ChatService::MessageList ());
	list->length (keys.size ());
	for (size_t i = 0; i < keys.size (); ++i) {
		this->messages ().read (keys[i].first, list->operator [] (i));
	}

	return list._retn ();
	//#UC END# *4A3A340502AB*
}

// провер€ет включЄн ли пользователь _user_ в список контактов дл€ _mine_
CORBA::Boolean Storage::is_user_in_contacts_list (CoreSrv::UserID mine, CoreSrv::UserID user) {
	//#UC START# *4A3A09A8003B*
	GUARD (this->mutex ());

	if (this->contacts ().is_exist (mine)) {
		UidList list;
		this->contacts ().read (mine, list);
		return std::find (list.begin (), list.end (), user) != list.end ();
	}

	return false;
	//#UC END# *4A3A09A8003B*
}

// пометить сообщени€ как прочитанные
void Storage::mark_as_read (const ChatLibrary::ChatService::MessageIds& keys) {
	//#UC START# *4A41F2A202CF*
	GUARD (this->mutex ());

	for (size_t i = 0; i < keys.length (); ++i) {
		UnreadedKeyByFastKey selector (keys[i]);
		std::vector<UnreadedKey> result;
		this->unreaded ().get_keys (selector, result);
		GDS_ASSERT (result.size () < 2);

		if (result.size () == 1) {
			this->unreaded ().remove (result[0]);
		} else {
			LOG_D (("%s: message with key %d has been already read", GDS_CURRENT_FUNCTION, keys[i]));
		}
	}
	//#UC END# *4A41F2A202CF*
}

} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

