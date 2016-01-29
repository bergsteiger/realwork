////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageManager_i
// Заголовок реализации класса серванта для интерфеса MessagesManager
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"

namespace GblAdapterLib {
namespace ChatService_i {

class MessageManager_i; // self forward Var
typedef ::Core::Var<MessageManager_i> MessageManager_i_var;
typedef ::Core::Var<const MessageManager_i> MessageManager_i_cvar;

class MessageManager_i_factory;

// реализация
class MessageManager_i:
	virtual public ChatInterfaces::MessagesManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MessageManager_i)
	friend class MessageManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// перевод серверной даты в оболочечную
	static void microseconds_to_datetime (unsigned long long from, DateTime& to);

	// перемывка серверной коллекции сообщений в адаптерную
	static ChatInterfaces::Messages* server_to_adapter_list (const ChatLibrary::ChatService::MessageList& from, Uid with);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MessageManager_i ();

	virtual ~MessageManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatInterfaces::MessagesManager
	// очистить историю сообщений с заданным пользователем
	virtual void clean_history (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::MessagesManager
	// получить count последних сообщений переписки с пользователем uid. Если count = 0, получить
	// полную историю переписки. Если all_new = true, будут получены все непрочитанные сообщения, даже
	// если их количество превышает count.
	virtual ChatInterfaces::Messages* get_history_for_user (
		unsigned long count
		, bool all_new
		, Uid uid
	) const /*throw (
		ChatInterfaces::UnknownUser
	)*/;

	// implemented method from ChatInterfaces::MessagesManager
	// получить непрочитанные сообщения от пользователя с заданным uid
	virtual ChatInterfaces::Messages* get_unreaded_messages (Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::MessagesManager
	// получить непрочитанные сообщения с сервера
	virtual ChatLibrary::ChatService::MessageList* get_unreaded_messages () const;

	// implemented method from ChatInterfaces::MessagesManager
	// послать сообщение заданному пользователю
	virtual void send_message (GCI::IO::Stream* message, Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/;
}; // class MessageManager_i

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
