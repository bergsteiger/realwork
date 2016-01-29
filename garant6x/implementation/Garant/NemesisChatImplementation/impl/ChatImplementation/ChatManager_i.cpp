////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::ChatManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ChatManager_i::ChatManager_i ()
//#UC START# *4A2E0B760095_4A37355B0168_4A2E39DA02B7_BASE_INIT*
//#UC END# *4A2E0B760095_4A37355B0168_4A2E39DA02B7_BASE_INIT*
{
	//#UC START# *4A2E0B760095_4A37355B0168_4A2E39DA02B7_BODY*
	//#UC END# *4A2E0B760095_4A37355B0168_4A2E39DA02B7_BODY*
}

ChatManager_i::~ChatManager_i () {
	//#UC START# *4A2E39DA02B7_DESTR_BODY*
	//#UC END# *4A2E39DA02B7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatLibrary::ChatService::ChatManager
// добавить получателя сообщений для пользователя, вызвавшего данный метод
ChatLibrary::ChatService::ListenerId ChatManager_i::add_listener (
	ChatLibrary::ChatService::MessageListener* listener
) throw (
	CORBA::SystemException
) {
	//#UC START# *4A2E2CD00128_4A2E39DA02B7*
	GDS_ASSERT (listener);
	CoreSrv::UserID key = UserHelper::get_user_id ();

	GUARD (m_listeners_guard);

	m_listeners.erase (key);

	LOG_D (("%s: listener id is %d", GDS_CURRENT_FUNCTION, key));
	m_listeners.insert (Listeners::value_type (key, ChatLibrary::ChatService::MessageListener::_duplicate (listener)));

	return key;
	//#UC END# *4A2E2CD00128_4A2E39DA02B7*
}

// implemented method from ChatLibrary::ChatService::ChatManager
// удалить слушателя с заданным идентификатором
void ChatManager_i::delete_listener (ChatLibrary::ChatService::ListenerId id) throw (CORBA::SystemException) {
	//#UC START# *4A2FA1260301_4A2E39DA02B7*
	LOG_D (("%s: id %d", GDS_CURRENT_FUNCTION, id));

	GUARD (m_listeners_guard);

	size_t count = m_listeners.erase (id);
	GDS_ASSERT (count == 1);
	if (count != 1) {
		LOG_W (("%s: trying to delete listener with id: %d (count of deleted objects is %d)", GDS_CURRENT_FUNCTION, id, count));
	}
	//#UC END# *4A2FA1260301_4A2E39DA02B7*
}

// implemented method from ChatLibrary::ChatService::ChatManager
// получить информацию о пользователе
ChatLibrary::ChatService::UserInfo* ChatManager_i::get_user_info (
	CoreSrv::UserID user
) throw (
	CORBA::SystemException
	, ChatLibrary::ChatService::UnknownUser
) {
	//#UC START# *4A2E0BCB03DF_4A2E39DA02B7*
	return UserHelper::get_user_info (user);
	//#UC END# *4A2E0BCB03DF_4A2E39DA02B7*
}

// implemented method from LocalChatManager
// послать сообщение от заданного пользователя заданному
void ChatManager_i::send_message (
	CoreSrv::UserID from
	, CoreSrv::UserID to
	, const ChatLibrary::ChatService::MessageData& message
) /*throw (
	ChatLibrary::ChatService::UnknownUser
)*/ {
	//#UC START# *4A3645DE03A9_4A2E39DA02B7*
	if (!UserHelper::is_user_exists (to)) {
		Stg::instance ()->delete_from_contacts (from, to);
		throw ChatLibrary::ChatService::UnknownUser ();
	}
	ChatLibrary::ChatService::Message full_message;
	full_message.data = message;
	full_message.meta_data.receiver = to;
	full_message.meta_data.sender = from;
	const ACE_Time_Value time_value = ACE_OS::gettimeofday ();
	time_value.msec (full_message.meta_data.date);
	full_message.meta_data.id = Stg::instance ()->add_message (full_message);

	GUARD (m_listeners_guard);

	Listeners::iterator receiver = m_listeners.find (to);
	if (receiver != m_listeners.end ()) {
		try {
			receiver->second->receive_message (full_message);
		} catch (CORBA::Exception&) {
			LOG_D (("%s: can't send message from %d to %d", GDS_CURRENT_FUNCTION, from, to));
			m_listeners.erase (receiver);
		} catch (...) {
			GDS_ASSERT (false && "can't send message");
		}
	}

#ifdef DEBUG
	if (!Stg::instance ()->is_user_in_contacts_list (from, to)) {
		GDS_ASSERT (false && "message sent to user not from contacts list");
	}
#endif
	//#UC END# *4A3645DE03A9_4A2E39DA02B7*
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

