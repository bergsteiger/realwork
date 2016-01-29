////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::MessageManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UserHelper.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/indexes.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Storage.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MessageManager_i::MessageManager_i (CoreSrv::UserID uid)
//#UC START# *4A30A0EE00F5_4A3735BB039D_4A30A4B300FB_BASE_INIT*
: m_uid (uid)
//#UC END# *4A30A0EE00F5_4A3735BB039D_4A30A4B300FB_BASE_INIT*
{
	//#UC START# *4A30A0EE00F5_4A3735BB039D_4A30A4B300FB_BODY*
	//#UC END# *4A30A0EE00F5_4A3735BB039D_4A30A4B300FB_BODY*
}

MessageManager_i::~MessageManager_i () {
	//#UC START# *4A30A4B300FB_DESTR_BODY*
	//#UC END# *4A30A4B300FB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ChatLibrary::ChatService::MessageManager
// ������� ������� ��������� �������� ������������ � �������� �������������
void MessageManager_i::clean_history_for_user (CoreSrv::UserID user) throw (CORBA::SystemException) {
	//#UC START# *4A35F1E801BD_4A30A4B300FB*
	Stg::instance ()->clean_history (m_uid, user);
 	//#UC END# *4A35F1E801BD_4A30A4B300FB*
}

// implemented method from ChatLibrary::ChatService::MessageManager
// �������� ������, ��������� ��  _count_ ��������� ��������� ��� ������� �������� ������������ �
// ������������ _user_, ���� _count=0_, ����� ���������� ��� ������� ���������. ���� _get_all_new =
// true_ ����� �������� ��� ����� ���������, � ����� ��� ��������� ����� ������ ������� ������,
// ���� ���� �� ���������� ��������� _count_,
ChatLibrary::ChatService::MessageList* MessageManager_i::get_messages_for_user (
	CoreSrv::UserID user
	, CORBA::ULong count
	, CORBA::Boolean get_all_new
) throw (
	CORBA::SystemException
	, ChatLibrary::ChatService::UnknownUser
) {
	//#UC START# *4A30A17A01B3_4A30A4B300FB*
	if (!UserHelper::is_user_exists (user)) {
		throw ChatLibrary::ChatService::UnknownUser ();
	}

	if (get_all_new) {
		return Stg::instance ()->get_history_with_all_new (m_uid, user, count);
	}

	return Stg::instance ()->get_history (m_uid, user, count);
	//#UC END# *4A30A17A01B3_4A30A4B300FB*
}

// implemented method from ChatLibrary::ChatService::MessageManager
// ������ ����� ��������� ��� �������� ������������
ChatLibrary::ChatService::MessageList* MessageManager_i::get_unreaded_list () throw (CORBA::SystemException, ChatLibrary::ChatService::UnknownUser) {
	//#UC START# *4A30A17D02FD_4A30A4B300FB*
	return Stg::instance ()->get_unreaded (m_uid);
	//#UC END# *4A30A17D02FD_4A30A4B300FB*
}

// implemented method from ChatLibrary::ChatService::MessageManager
// ������� ��������� ��������� ������������
void MessageManager_i::send_message (
	CoreSrv::UserID receiver
	, const ChatLibrary::ChatService::MessageData& data
) throw (
	CORBA::SystemException
	, ChatLibrary::ChatService::UnknownUser
) {
	//#UC START# *4A30A181009B_4A30A4B300FB*
	LocalChatManagerFactory::make ().send_message (m_uid, receiver, data);
	//#UC END# *4A30A181009B_4A30A4B300FB*
}

// implemented method from ChatLibrary::ChatService::MessageManager
// �������� ��������� ��� �����������
void MessageManager_i::set_messages_as_read (
	const ChatLibrary::ChatService::MessageIds& list
) throw (
	CORBA::SystemException
) {
	//#UC START# *4A41D68701D4_4A30A4B300FB*
	Stg::instance ()->mark_as_read (list);
	//#UC END# *4A41D68701D4_4A30A4B300FB*
}
} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

