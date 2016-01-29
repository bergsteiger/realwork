////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/indexes.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::NemesisChatImplementation::ChatImplementation::indexes
//
// индексы для чата
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_INDEXES_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_INDEXES_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4A38CF6A0260_USER_INCLUDES*
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/SimpleIndex.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/SimpleBase.h"
//#UC END# *4A38CF6A0260_USER_INCLUDES*

namespace NemesisChatImplementation {
namespace ChatImplementation {

//#UC START# *4A38CF6A0260_USER_DEFINITION*
// ключ для быстрого поиска сообщения
typedef unsigned long FastKey;

typedef CORBA::ULong MessageFlags;
static const CORBA::ULong MESSAGE_EXISTS_FOR_SENDER_FLAG = 0x1;
static const CORBA::ULong MESSAGE_EXISTS_FOR_RECEIVER_FLAG = 0x10;

typedef LOKI_TYPELIST_2 (
    ChatLibrary::ChatService::Message,
	MessageFlags
) StoredMessage;
typedef NdtClone::StrictSimpleIndex<FastKey, StoredMessage, NdtClone::ThrowRecovery> MessagesIndex;

struct FastKeyAndUsers {
	FastKeyAndUsers (FastKey k, CoreSrv::UserID s, CoreSrv::UserID r) : key (k), sender (s), receiver (r) {
	}

	FastKey key;
	CoreSrv::UserID sender;
	CoreSrv::UserID receiver;
};
typedef NdtClone::StrictSimpleIndex<FastKeyAndUsers, LOKI_TYPELIST_1 (int) /*fake*/, NdtClone::ThrowRecovery> UsersIndex;

typedef std::pair<FastKey, CoreSrv::UserID> UnreadedKey;
typedef NdtClone::StrictSimpleIndex<UnreadedKey, LOKI_TYPELIST_1 (int) /*fake*/, NdtClone::ThrowRecovery> UnreadedIndex;

typedef NdtClone::StrictSimpleIndex<CoreSrv::UserID, LOKI_TYPELIST_1 (UidList), NdtClone::ThrowRecovery> ContactsIndex;

const unsigned long LAST_ALLOCATED_FAST_KEY = 1;
typedef NdtClone::StrictSimpleIndex<unsigned long, LOKI_TYPELIST_1 (FastKey), NdtClone::ThrowRecovery> FastKeyIndex;

struct UnreadedByUserSelector {
public:
	UnreadedByUserSelector (CoreSrv::UserID receiver) : m_receiver (receiver) {}

	bool operator () (const UnreadedKey& value) const {
		return value.second == m_receiver;
	}
	
private:
	CoreSrv::UserID m_receiver;
};

struct FastKeyByUsersSelector {
	FastKeyByUsersSelector (CoreSrv::UserID u1, CoreSrv::UserID u2) : user1 (u1), user2 (u2) {}

	bool operator () (const FastKeyAndUsers& value) const {
		if ((value.sender == user1) && (value.receiver == user2)) {
			return true;
		}
		if ((value.sender == user2) && (value.receiver == user1)) {
			return true;
		}

		return false;
	}
private:
	CoreSrv::UserID user1;
	CoreSrv::UserID user2;
};

struct FastKeyByReceiverSelector {
	FastKeyByReceiverSelector (CoreSrv::UserID r) : receiver (r) {}

	bool operator () (const FastKeyAndUsers& value) const {
		return value.receiver == receiver;
	}
private:
	CoreSrv::UserID receiver;
};

typedef std::pair<FastKey, CoreSrv::UserID> UnreadedKey;

struct UnreadedKeyByFastKey {
	UnreadedKeyByFastKey (FastKey key) : m_key (key) {}

	bool operator () (const UnreadedKey& value) const {
		return value.first == m_key;
	}
private:
	FastKey m_key;
};

struct UnreadedKeyByUserSelector {
	UnreadedKeyByUserSelector (CoreSrv::UserID uid) : m_uid (uid) {}

	bool operator () (const UnreadedKey& value) const {
		return value.second == m_uid;
	}
private:
	FastKey m_uid;
};

//#UC END# *4A38CF6A0260_USER_DEFINITION*

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_INDEXES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
