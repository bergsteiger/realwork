////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::ChatManager_i
//
// реализаци€
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"

namespace GblAdapterLib {
namespace ChatService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool ChatManager_i::MessageComparator::operator () (const ChatLibrary::ChatService::Message& x, const ChatLibrary::ChatService::Message& y) const {
	//#UC START# *4A4A0B30025F_4A434DEF0022_COMP*
	if (x.meta_data.date > y.meta_data.date) {
		return false;
	} else if (x.meta_data.date == y.meta_data.date) {
		return x.meta_data.id < y.meta_data.id;
	}

	return true;
	//#UC END# *4A4A0B30025F_4A434DEF0022_COMP*
}



const ChatLibrary::ChatService::ListenerId ChatManager_i::UNKNOWN_ID = 0xFFFFFFFF; // идентификатор слушател€ не задан

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ChatManager_i::ChatManager_i ()
//#UC START# *4A4099A302A3_4A4099B701A8_4A40BAB201EE_BASE_INIT*
: m_chat_enabled (boost::indeterminate), m_listener_id (UNKNOWN_ID)
//#UC END# *4A4099A302A3_4A4099B701A8_4A40BAB201EE_BASE_INIT*
{
	//#UC START# *4A4099A302A3_4A4099B701A8_4A40BAB201EE_BODY*
	//#UC END# *4A4099A302A3_4A4099B701A8_4A40BAB201EE_BODY*
}

ChatManager_i::~ChatManager_i () {
	//#UC START# *4A40BAB201EE_DESTR_BODY*
	//#UC END# *4A40BAB201EE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверить список контактов и добавить пользовател€ при отсутствии
void ChatManager_i::add_contact (Uid uid) {
	//#UC START# *4A793EFC020A*
	m_contacts_list.push_back (uid);
	this->notify_tree (1);
	//#UC END# *4A793EFC020A*
}

// проверить есть ли пользователь в списке контактов
bool ChatManager_i::check_contacts_list (Uid uid) {
	//#UC START# *4A7937930398*
	if (m_contacts_list.empty ()) {
		ChatLibrary::ChatService::UidList_var contacts_list (ChatLibrary::ChatService::UsersListManagerFactory::get ().get_contacts_list ());
		m_contacts_list.reserve (contacts_list->length ());

		for (size_t i = 0; i < contacts_list->length (); ++i) {
			m_contacts_list.push_back (contacts_list[i]);
		}
	}

	return std::find (m_contacts_list.begin (), m_contacts_list.end (), uid) != m_contacts_list.end ();
	//#UC END# *4A7937930398*
}

// проверить список контактов и удалить из него заданного пользовател€
void ChatManager_i::delete_contact (Uid uid) {
	//#UC START# *4A79401603CE*
	m_contacts_list.erase (std::remove (m_contacts_list.begin (), m_contacts_list.end (), uid), m_contacts_list.end ());
	this->notify_tree (-1);
	//#UC END# *4A79401603CE*
}

// послать дереву пользователей (список контактов) нотификацию об обновлении
void ChatManager_i::notify_tree (long count) const {
	//#UC START# *4A43341502D0*
	//UserManager_var manager (UserManagerFactory::make ());
	//NodeBase_var root = manager->get_users_tree ();
	//DefaultNodeBase* root_implementation = dynamic_cast<DefaultNodeBase*> (root.inout ());
	//GDS_ASSERT (root_implementation);
	//NodeIndexPath zero_path;
	//root_implementation->owner_tree ()->change_children_count (VI_ALL_CHILDREN, count, zero_path, 0);
	Notification_var notify (NotificationFactory::make ());

	notify->set_type ((count > 0) ? NT_CHAT_CONTACT_ADDED : NT_CHAT_CONTACT_REMOVED);
	m_listener->fire (notify.in ());
	//#UC END# *4A43341502D0*
}

// получить список сообщений
void ChatManager_i::receive_messages (const ChatLibrary::ChatService::MessageList& messages) {
	//#UC START# *4A4B0FED012E*
	GUARD (m_unread_mutex);

	std::vector<CoreSrv::UserID> notify_data;
	for (size_t i = 0; i < messages.length (); ++i) {
		if (!m_unread.insert (messages[i]).second) {
			continue;
		}
		if (std::find (notify_data.begin (), notify_data.end (), messages[i].meta_data.sender) == notify_data.end ()) {
			GUARD (m_contacts_mutex);
			if (!this->check_contacts_list (messages[i].meta_data.sender)) {
				try {
					this->add_user (messages[i].meta_data.sender);
					notify_data.push_back (messages[i].meta_data.sender);
				} catch (ChatLibrary::ChatService::UnknownUser&) {
					// пользовател€ грохнули до того момента, как прочитали его сообщени€
					ChatLibrary::ChatService::MessageManagerFactory::get ().clean_history_for_user (
						messages[i].meta_data.sender
					);					
				}
			} else {
				notify_data.push_back (messages[i].meta_data.sender);
			}
		}
	}

	if (!notify_data.empty ()) {
		Notification_var notify (NotificationFactory::make ());
		notify->set_type (NT_NEW_CHAT_MESSAGES_RECEIVED);
		for (size_t i = 0; i < notify_data.size (); ++i) {
			Variant_var data (VariantFactory::make_long (notify_data[i]));
			notify->set_data (data.ptr ());
			m_listener->fire (notify.in ());
		}
	}
	//#UC END# *4A4B0FED012E*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatInterfaces::ChatManager
// добавить пользовател€ в список контактов
void ChatManager_i::add_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/ {
	//#UC START# *4A409CB202AF_4A40BAB201EE*
	GUARD (m_contacts_mutex);

	if (!this->check_contacts_list (uid)) {
		ChatLibrary::ChatService::UsersListManagerFactory::get ().add_user_to_list (uid);
		this->add_contact (uid);
	}
	//#UC END# *4A409CB202AF_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// удалить пользовател€ из списка контактов
void ChatManager_i::delete_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/ {
	//#UC START# *4A409CFB026A_4A40BAB201EE*
	GUARD (m_contacts_mutex);

	if (this->check_contacts_list (uid)) {
		ChatLibrary::ChatService::UsersListManagerFactory::get ().del_user_from_list (uid);
		this->delete_contact (uid);
	}
	//#UC END# *4A409CFB026A_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// получить список пользователей, добавленных в контакты
NodeBase* ChatManager_i::get_contacts_tree () const {
	//#UC START# *4A409AAF0399_4A40BAB201EE*
	UserManager_var manager (UserManagerFactory::make ());
	return manager->get_users_tree ();
	//#UC END# *4A409AAF0399_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// информаци€ о пользователе с заданным идентификатором
ChatInterfaces::UserInfo* ChatManager_i::get_user_info (Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/ {
	//#UC START# *4A409B2D01EC_4A40BAB201EE*
	ChatLibrary::ChatService::UserInfo_var info;
	try {
		info = ChatLibrary::ChatService::ChatManagerFactory::make ().get_user_info (uid);
	} catch (ChatLibrary::ChatService::UnknownUser&) {
		throw ChatInterfaces::UnknownUser ();
	}
	Core::Aptr<ChatInterfaces::UserInfo> result (new ChatInterfaces::UserInfo ());
	result->email = GCI::IO::StringFactory::make (info->email.in ());
	result->login = GCI::IO::StringFactory::make (info->login.in ());
	result->name = GCI::IO::StringFactory::make (info->name.in ());

	return result._retn ();
	//#UC END# *4A409B2D01EC_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// возвращает true, если на сервере обеспечена поддержка чата
bool ChatManager_i::is_embed_chat_enabled () const {
	//#UC START# *4A4099E902D0_4A40BAB201EE*
	if (boost::indeterminate (m_chat_enabled)) {
		m_chat_enabled = ApplicationHelper::instance ()->get_cached_function_manager ()->is_embed_chat_enabled ();
	}

	return m_chat_enabled;
	//#UC END# *4A4099E902D0_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// вызываетс€ при выходе из системы
void ChatManager_i::logout () {
	//#UC START# *4A4C657500D1_4A40BAB201EE*
	if (m_listener_id != UNKNOWN_ID) {
		try {
			ChatLibrary::ChatService::ChatManagerFactory::make ().delete_listener (m_listener_id);
		} catch (CORBA::Exception&) {
			LOG_D (("%s: can't remove callback from server (id: %d)", GDS_CURRENT_FUNCTION, m_listener_id));
		}
	}
	//#UC END# *4A4C657500D1_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// получить сообщение с сервера
void ChatManager_i::receive_message (const ChatLibrary::ChatService::Message& message) {
	//#UC START# *4A4369DE03C8_4A40BAB201EE*
	{
		GUARD (m_unread_mutex);
		if (!m_unread.insert (message).second) {
			return;
		}
	}
	GUARD (m_contacts_mutex);
	if (!this->check_contacts_list (message.meta_data.sender)) {
		this->add_user (message.meta_data.sender);
	}

	Notification_var notify (NotificationFactory::make ());
	GblAdapterLib::NotifyType type = NT_NEW_CHAT_MESSAGES_RECEIVED;
	Variant_var data (VariantFactory::make_long (message.meta_data.sender));
	notify->set_type (type);
	notify->set_data (data.ptr ());
	m_listener->fire (notify.in ());
	//#UC END# *4A4369DE03C8_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// зарегестрировать слушател€
void ChatManager_i::register_listener_for_notify (Listener* listener) {
	//#UC START# *4A43633E02A4_4A40BAB201EE*
	GDS_ASSERT (this->is_embed_chat_enabled () && "chat is disabled but used");

	m_listener = Core::IObject::_duplicate (listener);
	// создаЄм и регистрируем слушател€ сообщений от сервера
	m_listener_id = ChatLibrary::ChatService::ChatManagerFactory::make ().add_listener (&ChatLibrary::ChatService::MessageListenerFactory::make ());
	// получаем непрочитанные сообщени€ с сервера
	ChatLibrary::ChatService::MessageList_var list (ChatInterfaces::MessagesManagerFactory::make ().get_unreaded_messages ());
	this->receive_messages (list.in ());
	//#UC END# *4A43633E02A4_4A40BAB201EE*
}

// implemented method from ChatInterfaces::ChatManager
// выбрать все непрочитанные сообщени€
ChatLibrary::ChatService::MessageList* ChatManager_i::take_unreaded_messages (Uid uid) {
	//#UC START# *4A4B13F40252_4A40BAB201EE*
	ChatLibrary::ChatService::MessageList_var list (new ChatLibrary::ChatService::MessageList ());
	GUARD (m_unread_mutex);
	ServerMessages::iterator it = m_unread.begin ();
	while (it != m_unread.end ()) {
		if (it->meta_data.sender == uid) {
			size_t index = list->length ();
			list->length (index + 1);
			list[index] = *it;
			m_unread.erase (it++);
		} else {
			++it;
		}
	}

	return list._retn ();
	//#UC END# *4A4B13F40252_4A40BAB201EE*
}
} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

