////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Storage
//
// ������������ ������� ������� � ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"

//#UC START# *4A38C38303B8_CUSTOM_INCLUDES*
#include "shared/Core/mng/Box.h"

#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/indexes.h"

static const CORBA::ULong CHAT_STORAGE_VERSION = 1; // ������ ��������� ���������

namespace NemesisChatImplementation {
namespace ChatImplementation {
	typedef NdtClone::SimpleBase<4096, CHAT_STORAGE_VERSION> ChatBase;

	class Storage;
	typedef ACE_Singleton<Storage, Core::NullMutex> Stg;
}
}
//#UC END# *4A38C38303B8_CUSTOM_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

// ������������ ������� ������� � ����
class Storage {
	SET_OBJECT_COUNTER (Storage)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// �������� ����� ����
	static const std::string& base_file ();

	// ���� � �����
	static const std::string& data_path ();

	// ��� ����� ������
	static const std::string& key_file ();

	// ��� ����� ������
	static const std::string& stream_file ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// �������� ������ ����
	Storage ();

public:
	virtual ~Storage ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ��������� � ����
	ChatLibrary::ChatService::MessageId add_message (const ChatLibrary::ChatService::Message& message);

	// �������� ������������ _user_ � ������ ��������� ��� _mine_
	void add_to_contacts (CoreSrv::UserID mine, CoreSrv::UserID user);

	// �������� ������� ��������� ��� ������������ _mine_ � ������������� _user_
	// (_user_ ������� ��������� � _mine_ �� ������)
	void clean_history (CoreSrv::UserID mine, CoreSrv::UserID user);

	// ������� ������������ _user_ �� ������ ��������� ��� _mine_
	void delete_from_contacts (CoreSrv::UserID mine, CoreSrv::UserID user);

	// �������� ������ ��������� ��� ������������ _mine_
	ChatLibrary::ChatService::UidList* get_contacts (CoreSrv::UserID mine);

	// �������� _count_ ��������� �� ������� ��������� ��� �������� �������������. ���� count=0,
	// ������� ��� ������� ���������
	ChatLibrary::ChatService::MessageList* get_history (
		CoreSrv::UserID my_uid
		, CoreSrv::UserID second
		, CORBA::ULong count
	);

	// �� ��, ��� � get_history, �� ���������� ��� �����
	virtual ChatLibrary::ChatService::MessageList* get_history_with_all_new (
		CoreSrv::UserID my_uid
		, CoreSrv::UserID second
		, CORBA::ULong count
	);

	// �������� ��� ������������� ��������� ��� ��������� ������������
	ChatLibrary::ChatService::MessageList* get_unreaded (CoreSrv::UserID user);

	// ��������� ������� �� ������������ _user_ � ������ ��������� ��� _mine_
	CORBA::Boolean is_user_in_contacts_list (CoreSrv::UserID mine, CoreSrv::UserID user);

	// �������� ��������� ��� �����������
	void mark_as_read (const ChatLibrary::ChatService::MessageIds& keys);

private:
	// �������� ����
	CORBA::ULong build_fast_key ();


//#UC START# *4A38C38303B8*
private:
	static Core::Mutex s_path_mutex;

private:
	friend class ACE_Singleton<Storage, Core::NullMutex>;

private:
	void erase_message_by_key (const FastKeyAndUsers& key);
	ChatLibrary::ChatService::MessageList* get_messages_by_keys (
		const std::vector<FastKeyAndUsers>& users_keys
		, CORBA::ULong count
		, CoreSrv::UserID my_uid
	);

	FastKeyIndex& fastkey ();
	MessagesIndex& messages ();
	UsersIndex& users ();
	UnreadedIndex& unreaded ();
	ContactsIndex& contacts ();

	Core::Mutex& mutex ();
// ��������� ������� ����������:
// ������� ����, ����� �������
// ����������� ������ ����������� � �������� �������
private:
	ChatBase m_base;

	FastKeyIndex	*m_fast_key_index;
	MessagesIndex	*m_messages_index;
	UsersIndex		*m_users_index;
	UnreadedIndex	*m_unreaded_index;
	ContactsIndex	*m_contacts_index;

	mutable Core::Mutex m_base_mutex;
//#UC END# *4A38C38303B8*
}; // class Storage

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_STORAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

