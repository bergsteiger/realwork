////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::ChatManager_i
// «аголовок реализации класса серванта дл€ интерфеса ChatManager
//
// реализаци€
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include <set>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"

namespace GblAdapterLib {
namespace ChatService_i {

class ChatManager_i; // self forward Var
typedef ::Core::Var<ChatManager_i> ChatManager_i_var;
typedef ::Core::Var<const ChatManager_i> ChatManager_i_cvar;

class ChatManager_i_factory;

// реализаци€
class ChatManager_i:
	virtual public ChatInterfaces::ChatManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ChatManager_i)
	friend class ChatManager_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	struct ChatLibrary::ChatService::Message;
	// упор€дочивание сообщений
	struct MessageComparator {
		bool operator () (const ChatLibrary::ChatService::Message& x, const ChatLibrary::ChatService::Message& y) const;

	};

	// список сообщений
	typedef std::set < ChatLibrary::ChatService::Message, MessageComparator > ServerMessages;

	static const ChatLibrary::ChatService::ListenerId UNKNOWN_ID; // идентификатор слушател€ не задан

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ChatManager_i ();

	virtual ~ChatManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// проверить список контактов и добавить пользовател€ при отсутствии
	virtual void add_contact (Uid uid);

	// проверить есть ли пользователь в списке контактов
	virtual bool check_contacts_list (Uid uid);

	// проверить список контактов и удалить из него заданного пользовател€
	virtual void delete_contact (Uid uid);

	// послать дереву пользователей (список контактов) нотификацию об обновлении
	virtual void notify_tree (long count) const;

	// получить список сообщений
	virtual void receive_messages (const ChatLibrary::ChatService::MessageList& messages);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_chat_enabled;

	// список контактов
	UidList m_contacts_list;

	// защита доступа к списку контактов
	Core::Mutex m_contacts_mutex;

	// оболочечный слушатель
	Listener_var m_listener;

	// идентификатор зарегестрированного на сервере интерфейса обратного вызова
	ChatLibrary::ChatService::ListenerId m_listener_id;

	ServerMessages m_unread;

	// защита вектора непрочитанных сообщений
	Core::Mutex m_unread_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatInterfaces::ChatManager
	// добавить пользовател€ в список контактов
	virtual void add_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// удалить пользовател€ из списка контактов
	virtual void delete_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// получить список пользователей, добавленных в контакты
	virtual NodeBase* get_contacts_tree () const;

	// implemented method from ChatInterfaces::ChatManager
	// информаци€ о пользователе с заданным идентификатором
	virtual ChatInterfaces::UserInfo* get_user_info (Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// возвращает true, если на сервере обеспечена поддержка чата
	virtual bool is_embed_chat_enabled () const;

	// implemented method from ChatInterfaces::ChatManager
	// вызываетс€ при выходе из системы
	virtual void logout ();

	// implemented method from ChatInterfaces::ChatManager
	// получить сообщение с сервера
	virtual void receive_message (const ChatLibrary::ChatService::Message& message);

	// implemented method from ChatInterfaces::ChatManager
	// зарегестрировать слушател€
	virtual void register_listener_for_notify (Listener* listener);

	// implemented method from ChatInterfaces::ChatManager
	// выбрать все непрочитанные сообщени€
	virtual ChatLibrary::ChatService::MessageList* take_unreaded_messages (Uid uid);
}; // class ChatManager_i

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
