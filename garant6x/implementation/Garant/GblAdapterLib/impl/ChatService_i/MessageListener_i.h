////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageListener_i
// Заголовок реализации класса серванта для интерфеса MessageListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/ChatService/ChatServiceS.h"

namespace GblAdapterLib {
namespace ChatService_i {

class MessageListener_i; // self forward Var
typedef ::Core::Var<MessageListener_i> MessageListener_i_var;
typedef ::Core::Var<const MessageListener_i> MessageListener_i_cvar;

class MessageListener_i_factory;

class MessageListener_i:
	virtual public POA_ChatLibrary::ChatService::MessageListener
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (MessageListener_i)
	friend class MessageListener_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MessageListener_i ();

	virtual ~MessageListener_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatLibrary::ChatService::MessageListener
	// получить сообщение
	virtual void receive_message (const ChatLibrary::ChatService::Message& data) throw (CORBA::SystemException);
}; // class MessageListener_i

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
