////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы для поддержки чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_H__
#define __GARANT6X_GBLADAPTERLIB_CHATINTERFACES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {
namespace ChatInterfaces {

#pragma pack (push, 1)

// информация о пользователе
struct UserInfo {
	// email пользователя
	GCI::IO::String_var email;
	// регистрационное имя пользователя
	GCI::IO::String_var login;
	// имя пользователя
	GCI::IO::String_var name;
};

#pragma pack (pop)

// задан идентификатор неизвестного пользователя
class UnknownUser : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ChatManager;
typedef ::Core::Var<ChatManager> ChatManager_var;
typedef ::Core::Var<const ChatManager> ChatManager_cvar;
// управление чатом
class ChatManager
	: virtual public ::Core::IObject
{
public:
	// возвращает true, если на сервере обеспечена поддержка чата
	virtual bool is_embed_chat_enabled () const = 0;

	// получить список пользователей, добавленных в контакты
	virtual NodeBase* get_contacts_tree () const = 0;

	// информация о пользователе с заданным идентификатором
	virtual UserInfo* get_user_info (Uid uid) const /*throw (UnknownUser)*/ = 0;

	// добавить пользователя в список контактов
	virtual void add_user (Uid uid) /*throw (UnknownUser)*/ = 0;

	// удалить пользователя из списка контактов
	virtual void delete_user (Uid uid) /*throw (UnknownUser)*/ = 0;

	// зарегестрировать слушателя
	virtual void register_listener_for_notify (Listener* listener) = 0;

	// получить сообщение с сервера
	virtual void receive_message (const ChatLibrary::ChatService::Message& message) = 0;

	// выбрать все непрочитанные сообщения
	virtual ChatLibrary::ChatService::MessageList* take_unreaded_messages (Uid uid) = 0;

	// вызывается при выходе из системы
	virtual void logout () = 0;
};

/// factory interface for ChatManager
class ChatManagerFactory {
public:
	// фабрика
	static ChatManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// данные сообщения
struct Message {
	// сообщение (предполагается, что в evd формате)
	GCI::IO::Stream_var text;
	// время создания сообщения
	DateTime time;
	// true, если сообщение послано текущим пользователем, иначе это сообщение для него
	bool my;
};

#pragma pack (pop)

// список сообщений
typedef std::vector < Message > Messages;

class MessagesManager;
typedef ::Core::Var<MessagesManager> MessagesManager_var;
typedef ::Core::Var<const MessagesManager> MessagesManager_cvar;
// работа с сообщениями
class MessagesManager
	: virtual public ::Core::IObject
{
public:
	// получить непрочитанные сообщения от пользователя с заданным uid
	virtual Messages* get_unreaded_messages (Uid uid) const /*throw (UnknownUser)*/ = 0;

	// послать сообщение заданному пользователю
	virtual void send_message (GCI::IO::Stream* message, Uid uid) const /*throw (UnknownUser)*/ = 0;

	// получить count последних сообщений переписки с пользователем uid. Если count = 0, получить
	// полную историю переписки. Если all_new = true, будут получены все непрочитанные сообщения, даже
	// если их количество превышает count.
	virtual Messages* get_history_for_user (
		unsigned long count
		, bool all_new
		, Uid uid
	) const /*throw (
		UnknownUser
	)*/ = 0;

	// очистить историю сообщений с заданным пользователем
	virtual void clean_history (Uid uid) /*throw (UnknownUser)*/ = 0;

	// получить непрочитанные сообщения с сервера
	virtual ChatLibrary::ChatService::MessageList* get_unreaded_messages () const = 0;
};

/// factory interface for MessagesManager
class MessagesManagerFactory {
public:
	// фабрика
	static MessagesManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace ChatInterfaces
} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ChatInterfaces::ChatManager> {
	typedef GblAdapterLib::ChatInterfaces::ChatManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ChatInterfaces::MessagesManager> {
	typedef GblAdapterLib::ChatInterfaces::MessagesManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_CHATINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
