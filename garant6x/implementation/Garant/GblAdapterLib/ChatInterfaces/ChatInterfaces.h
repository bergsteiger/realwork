////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// ���������� ��� ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ���������� � ������������
struct UserInfo {
	// email ������������
	GCI::IO::String_var email;
	// ��������������� ��� ������������
	GCI::IO::String_var login;
	// ��� ������������
	GCI::IO::String_var name;
};

#pragma pack (pop)

// ����� ������������� ������������ ������������
class UnknownUser : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ChatManager;
typedef ::Core::Var<ChatManager> ChatManager_var;
typedef ::Core::Var<const ChatManager> ChatManager_cvar;
// ���������� �����
class ChatManager
	: virtual public ::Core::IObject
{
public:
	// ���������� true, ���� �� ������� ���������� ��������� ����
	virtual bool is_embed_chat_enabled () const = 0;

	// �������� ������ �������������, ����������� � ��������
	virtual NodeBase* get_contacts_tree () const = 0;

	// ���������� � ������������ � �������� ���������������
	virtual UserInfo* get_user_info (Uid uid) const /*throw (UnknownUser)*/ = 0;

	// �������� ������������ � ������ ���������
	virtual void add_user (Uid uid) /*throw (UnknownUser)*/ = 0;

	// ������� ������������ �� ������ ���������
	virtual void delete_user (Uid uid) /*throw (UnknownUser)*/ = 0;

	// ���������������� ���������
	virtual void register_listener_for_notify (Listener* listener) = 0;

	// �������� ��������� � �������
	virtual void receive_message (const ChatLibrary::ChatService::Message& message) = 0;

	// ������� ��� ������������� ���������
	virtual ChatLibrary::ChatService::MessageList* take_unreaded_messages (Uid uid) = 0;

	// ���������� ��� ������ �� �������
	virtual void logout () = 0;
};

/// factory interface for ChatManager
class ChatManagerFactory {
public:
	// �������
	static ChatManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ������ ���������
struct Message {
	// ��������� (��������������, ��� � evd �������)
	GCI::IO::Stream_var text;
	// ����� �������� ���������
	DateTime time;
	// true, ���� ��������� ������� ������� �������������, ����� ��� ��������� ��� ����
	bool my;
};

#pragma pack (pop)

// ������ ���������
typedef std::vector < Message > Messages;

class MessagesManager;
typedef ::Core::Var<MessagesManager> MessagesManager_var;
typedef ::Core::Var<const MessagesManager> MessagesManager_cvar;
// ������ � �����������
class MessagesManager
	: virtual public ::Core::IObject
{
public:
	// �������� ������������� ��������� �� ������������ � �������� uid
	virtual Messages* get_unreaded_messages (Uid uid) const /*throw (UnknownUser)*/ = 0;

	// ������� ��������� ��������� ������������
	virtual void send_message (GCI::IO::Stream* message, Uid uid) const /*throw (UnknownUser)*/ = 0;

	// �������� count ��������� ��������� ��������� � ������������� uid. ���� count = 0, ��������
	// ������ ������� ���������. ���� all_new = true, ����� �������� ��� ������������� ���������, ����
	// ���� �� ���������� ��������� count.
	virtual Messages* get_history_for_user (
		unsigned long count
		, bool all_new
		, Uid uid
	) const /*throw (
		UnknownUser
	)*/ = 0;

	// �������� ������� ��������� � �������� �������������
	virtual void clean_history (Uid uid) /*throw (UnknownUser)*/ = 0;

	// �������� ������������� ��������� � �������
	virtual ChatLibrary::ChatService::MessageList* get_unreaded_messages () const = 0;
};

/// factory interface for MessagesManager
class MessagesManagerFactory {
public:
	// �������
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
