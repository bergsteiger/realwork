////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::ChatManager_i
// ��������� ���������� ������ �������� ��� ��������� ChatManager
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ����������
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
	// �������������� ���������
	struct MessageComparator {
		bool operator () (const ChatLibrary::ChatService::Message& x, const ChatLibrary::ChatService::Message& y) const;

	};

	// ������ ���������
	typedef std::set < ChatLibrary::ChatService::Message, MessageComparator > ServerMessages;

	static const ChatLibrary::ChatService::ListenerId UNKNOWN_ID; // ������������� ��������� �� �����

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ChatManager_i ();

	virtual ~ChatManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������� ������ ��������� � �������� ������������ ��� ����������
	virtual void add_contact (Uid uid);

	// ��������� ���� �� ������������ � ������ ���������
	virtual bool check_contacts_list (Uid uid);

	// ��������� ������ ��������� � ������� �� ���� ��������� ������������
	virtual void delete_contact (Uid uid);

	// ������� ������ ������������� (������ ���������) ����������� �� ����������
	virtual void notify_tree (long count) const;

	// �������� ������ ���������
	virtual void receive_messages (const ChatLibrary::ChatService::MessageList& messages);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_chat_enabled;

	// ������ ���������
	UidList m_contacts_list;

	// ������ ������� � ������ ���������
	Core::Mutex m_contacts_mutex;

	// ����������� ���������
	Listener_var m_listener;

	// ������������� ������������������� �� ������� ���������� ��������� ������
	ChatLibrary::ChatService::ListenerId m_listener_id;

	ServerMessages m_unread;

	// ������ ������� ������������� ���������
	Core::Mutex m_unread_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatInterfaces::ChatManager
	// �������� ������������ � ������ ���������
	virtual void add_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// ������� ������������ �� ������ ���������
	virtual void delete_user (Uid uid) /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// �������� ������ �������������, ����������� � ��������
	virtual NodeBase* get_contacts_tree () const;

	// implemented method from ChatInterfaces::ChatManager
	// ���������� � ������������ � �������� ���������������
	virtual ChatInterfaces::UserInfo* get_user_info (Uid uid) const /*throw (ChatInterfaces::UnknownUser)*/;

	// implemented method from ChatInterfaces::ChatManager
	// ���������� true, ���� �� ������� ���������� ��������� ����
	virtual bool is_embed_chat_enabled () const;

	// implemented method from ChatInterfaces::ChatManager
	// ���������� ��� ������ �� �������
	virtual void logout ();

	// implemented method from ChatInterfaces::ChatManager
	// �������� ��������� � �������
	virtual void receive_message (const ChatLibrary::ChatService::Message& message);

	// implemented method from ChatInterfaces::ChatManager
	// ���������������� ���������
	virtual void register_listener_for_notify (Listener* listener);

	// implemented method from ChatInterfaces::ChatManager
	// ������� ��� ������������� ���������
	virtual ChatLibrary::ChatService::MessageList* take_unreaded_messages (Uid uid);
}; // class ChatManager_i

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
