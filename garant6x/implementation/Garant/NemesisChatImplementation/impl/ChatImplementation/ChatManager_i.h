////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::ChatManager_i
// Заголовок реализации класса серванта для интерфеса LocalChatManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_CHATMANAGER_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_CHATMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

class ChatManager_i; // self forward Var
typedef ::Core::Var<ChatManager_i> ChatManager_i_var;
typedef ::Core::Var<const ChatManager_i> ChatManager_i_cvar;

class ChatManager_i_factory;

class ChatManager_i:
	virtual public LocalChatManager
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (ChatManager_i)
	friend class ChatManager_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// список слушателей сообщений чата
	typedef std::map < CoreSrv::UserID, ChatLibrary::ChatService::MessageListener_var > Listeners;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ChatManager_i ();

	virtual ~ChatManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Listeners m_listeners;

	Core::Mutex m_listeners_guard;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatLibrary::ChatService::ChatManager
	// добавить получателя сообщений для пользователя, вызвавшего данный метод
	virtual ChatLibrary::ChatService::ListenerId add_listener (
		ChatLibrary::ChatService::MessageListener* listener
	) throw (
		CORBA::SystemException
	);

	// implemented method from ChatLibrary::ChatService::ChatManager
	// удалить слушателя с заданным идентификатором
	virtual void delete_listener (ChatLibrary::ChatService::ListenerId id) throw (CORBA::SystemException);

	// implemented method from ChatLibrary::ChatService::ChatManager
	// получить информацию о пользователе
	virtual ChatLibrary::ChatService::UserInfo* get_user_info (
		CoreSrv::UserID user
	) throw (
		CORBA::SystemException
		, ChatLibrary::ChatService::UnknownUser
	);

	// implemented method from LocalChatManager
	// послать сообщение от заданного пользователя заданному
	virtual void send_message (
		CoreSrv::UserID from
		, CoreSrv::UserID to
		, const ChatLibrary::ChatService::MessageData& message
	) /*throw (
		ChatLibrary::ChatService::UnknownUser
	)*/;
}; // class ChatManager_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_CHATMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
