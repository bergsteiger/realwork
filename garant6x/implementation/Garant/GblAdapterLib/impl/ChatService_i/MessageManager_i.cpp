////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageManager_i
//
// реализаци€
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "ace/Date_Time.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"

namespace GblAdapterLib {
namespace ChatService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// перевод серверной даты в оболочечную
void MessageManager_i::microseconds_to_datetime (unsigned long long from, DateTime& to) {
	//#UC START# *4A48C4AC03D8*
	ACE_Time_Value time_value;
	time_value.sec (static_cast<long> (from / 1000));
	ACE_Date_Time date_time (time_value);
	to.time.sec = static_cast <unsigned short> (date_time.second ());
	to.time.min = static_cast <unsigned short> (date_time.minute ());
	to.time.hour = static_cast <unsigned short> (date_time.hour ());
	to.date.day = static_cast <unsigned short> (date_time.day ());
	to.date.month = static_cast <unsigned short> (date_time.month ());
	to.date.year = static_cast <unsigned short> (date_time.year ());
	//#UC END# *4A48C4AC03D8*
}

// перемывка серверной коллекции сообщений в адаптерную
ChatInterfaces::Messages* MessageManager_i::server_to_adapter_list (const ChatLibrary::ChatService::MessageList& from, Uid with) {
	//#UC START# *4A49E01B012B*
	Core::Aptr<ChatInterfaces::Messages> messages (new ChatInterfaces::Messages ());

	messages->reserve (from.length ());
	for (size_t i = 0; i < from.length (); ++i) {
		ChatInterfaces::Message message;
		message.text = MemoryStreamFactory::make (from[i].data.text, true);
		MessageManager_i::microseconds_to_datetime (from[i].meta_data.date, message.time);
		message.my = (from[i].meta_data.receiver == with);
		messages->push_back (message);
	}

	return messages._retn ();
	//#UC END# *4A49E01B012B*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MessageManager_i::MessageManager_i ()
//#UC START# *4A409DC300BF_4A40A59901F4_4A40BAC700AE_BASE_INIT*
//#UC END# *4A409DC300BF_4A40A59901F4_4A40BAC700AE_BASE_INIT*
{
	//#UC START# *4A409DC300BF_4A40A59901F4_4A40BAC700AE_BODY*
	//#UC END# *4A409DC300BF_4A40A59901F4_4A40BAC700AE_BODY*
}

MessageManager_i::~MessageManager_i () {
	//#UC START# *4A40BAC700AE_DESTR_BODY*
	//#UC END# *4A40BAC700AE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatInterfaces::MessagesManager
// очистить историю сообщений с заданным пользователем
void MessageManager_i::clean_history (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/ {
	//#UC START# *4A40A93400D7_4A40BAC700AE*
	ChatLibrary::ChatService::MessageManagerFactory::get ().clean_history_for_user (uid);
	//#UC END# *4A40A93400D7_4A40BAC700AE*
}

// implemented method from ChatInterfaces::MessagesManager
// получить count последних сообщений переписки с пользователем uid. ≈сли count = 0, получить
// полную историю переписки. ≈сли all_new = true, будут получены все непрочитанные сообщени€, даже
// если их количество превышает count.
ChatInterfaces::Messages* MessageManager_i::get_history_for_user (
	unsigned long count
	, bool all_new
	, Uid uid
) const /*throw (
	ChatInterfaces::UnknownUser
)*/ {
	//#UC START# *4A40A84A02FE_4A40BAC700AE*
	ChatLibrary::ChatService::MessageList_var list;
	try {
		list =
			ChatLibrary::ChatService::MessageManagerFactory::get ().get_messages_for_user (uid, count, all_new);
	} catch (ChatLibrary::ChatService::UnknownUser&) {
		throw ChatInterfaces::UnknownUser ();
	}

	// помечаем непрочитанные, попавшие в историю, как прочитанные
	ChatLibrary::ChatService::MessageList_var unread = 
		ChatInterfaces::ChatManagerFactory::make ().take_unreaded_messages (uid);
	if (unread->length ()) {
		if (all_new) {
			ChatLibrary::ChatService::MessageIds id_list;
			id_list.length (unread->length ());
			for (size_t i = 0; i < unread->length (); ++i) {
				id_list[i] = unread[i].meta_data.id;
			}
			ChatLibrary::ChatService::MessageManagerFactory::get ().set_messages_as_read (id_list);
		} else {
			ChatLibrary::ChatService::MessageIds id_list (std::min (list->length (), unread->length ()));
			for (size_t i = 0; i < unread->length (); ++i) {
				for (size_t j = 0; j < list->length (); ++j) {
					if (unread[i].meta_data.id == list[j].meta_data.id) {
						size_t size = id_list.length ();
						id_list.length (size + 1);
						id_list[size] = unread[i].meta_data.id;
						break;
					}
				}
			}
			if (id_list.length ()) {
				ChatLibrary::ChatService::MessageManagerFactory::get ().set_messages_as_read (id_list);
			}
		}
	}

	return MessageManager_i::server_to_adapter_list (list, uid);
	//#UC END# *4A40A84A02FE_4A40BAC700AE*
}

// implemented method from ChatInterfaces::MessagesManager
// получить непрочитанные сообщени€ от пользовател€ с заданным uid
ChatInterfaces::Messages* MessageManager_i::get_unreaded_messages (
	Uid uid
) const /*throw (
	ChatInterfaces::UnknownUser
)*/ {
	//#UC START# *4A40A5D7025F_4A40BAC700AE*
	ChatLibrary::ChatService::MessageList_var list = ChatInterfaces::ChatManagerFactory::make ().take_unreaded_messages (uid);
	if (list->length ()) {
		ChatLibrary::ChatService::MessageIds id_list;
		id_list.length (list->length ());
		for (size_t i = 0; i < list->length (); ++i) {
			id_list[i] = list[i].meta_data.id;
		}
		ChatLibrary::ChatService::MessageManagerFactory::get ().set_messages_as_read (id_list);
	}

	return MessageManager_i::server_to_adapter_list (list, uid);
	//#UC END# *4A40A5D7025F_4A40BAC700AE*
}

// implemented method from ChatInterfaces::MessagesManager
// получить непрочитанные сообщени€ с сервера
ChatLibrary::ChatService::MessageList* MessageManager_i::get_unreaded_messages () const {
	//#UC START# *4A4B0CCC007A_4A40BAC700AE*
	return ChatLibrary::ChatService::MessageManagerFactory::get ().get_unreaded_list ();
	//#UC END# *4A4B0CCC007A_4A40BAC700AE*
}

// implemented method from ChatInterfaces::MessagesManager
// послать сообщение заданному пользователю
void MessageManager_i::send_message (GCI::IO::Stream* message, Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/ {
	//#UC START# *4A40A73102AC_4A40BAC700AE*
	// так как query - MSDNStream, в конструкторе которого делаетс€ addref
	// надо его положить в Var, иначе он утечЄт
	GCI::IO::Stream_var stream_remover (message);

	size_t size = message->seek (0, GCI::IO::SSD_END);
	if (!size) {
		LOG_W (("%s: empty message, hasn't been sent", GDS_CURRENT_FUNCTION));
	}
	message->seek (0, GCI::IO::SSD_BEGIN);

	ChatLibrary::ChatService::MessageData data;
	data.text.length (size);
	if (message->read (data.text.get_buffer (), size) != size) {
		LOG_E (("%s: message hasn't been sent. Error is occured while read stream data.", GDS_CURRENT_FUNCTION));
	}
	data.type = ChatLibrary::ChatService::MT_EVD;

	try {
		ChatLibrary::ChatService::MessageManagerFactory::get ().send_message (uid, data);
	} catch (ChatLibrary::ChatService::UnknownUser&) {
		throw ChatInterfaces::UnknownUser ();
	}
	//#UC END# *4A40A73102AC_4A40BAC700AE*
}
} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

