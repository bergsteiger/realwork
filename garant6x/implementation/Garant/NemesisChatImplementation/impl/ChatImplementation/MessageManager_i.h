////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::MessageManager_i
// «аголовок реализации класса серванта дл€ интерфеса MessageManager
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/ChatService/ChatServiceS.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

class MessageManager_i; // self forward Var
typedef ::Core::Var<MessageManager_i> MessageManager_i_var;
typedef ::Core::Var<const MessageManager_i> MessageManager_i_cvar;

class MessageManager_i_factory;

class MessageManager_i:
	virtual public POA_ChatLibrary::ChatService::MessageManager
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (MessageManager_i)
	friend class MessageManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MessageManager_i (CoreSrv::UserID uid);

	virtual ~MessageManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CoreSrv::UserID m_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatLibrary::ChatService::MessageManager
	// удал€ет историю переписки текущего пользовател€ с заданным пользователем
	virtual void clean_history_for_user (CoreSrv::UserID user) throw (CORBA::SystemException);

	// implemented method from ChatLibrary::ChatService::MessageManager
	// получить список, состо€щий из  _count_ последних сообщений при общении текущего пользовател€ и
	// пользовател€ _user_, ≈сли _count=0_, будет возвращена вс€ истори€ переписки. ≈сли _get_all_new
	// = true_ будут получены все новые сообщени€, а также все сообщени€ после самого старого нового,
	// даже если их количество превышает _count_,
	virtual ChatLibrary::ChatService::MessageList* get_messages_for_user (
		CoreSrv::UserID user
		, CORBA::ULong count
		, CORBA::Boolean get_all_new
	) throw (
		CORBA::SystemException
		, ChatLibrary::ChatService::UnknownUser
	);

	// implemented method from ChatLibrary::ChatService::MessageManager
	// список новых сообщений дл€ текущего пользовател€
	virtual ChatLibrary::ChatService::MessageList* get_unreaded_list () throw (CORBA::SystemException, ChatLibrary::ChatService::UnknownUser);

	// implemented method from ChatLibrary::ChatService::MessageManager
	// послать сообщение заданному пользователю
	virtual void send_message (
		CoreSrv::UserID receiver
		, const ChatLibrary::ChatService::MessageData& data
	) throw (
		CORBA::SystemException
		, ChatLibrary::ChatService::UnknownUser
	);

	// implemented method from ChatLibrary::ChatService::MessageManager
	// пометить сообщени€ как прочитанные
	virtual void set_messages_as_read (const ChatLibrary::ChatService::MessageIds& list) throw (CORBA::SystemException);
}; // class MessageManager_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
