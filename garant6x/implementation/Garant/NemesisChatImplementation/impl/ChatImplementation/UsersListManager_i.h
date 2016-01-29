////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UsersListManager_i
// Заголовок реализации класса серванта для интерфеса UsersListManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/ChatService/ChatServiceS.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

class UsersListManager_i; // self forward Var
typedef ::Core::Var<UsersListManager_i> UsersListManager_i_var;
typedef ::Core::Var<const UsersListManager_i> UsersListManager_i_cvar;

class UsersListManager_i_factory;

class UsersListManager_i:
	virtual public POA_ChatLibrary::ChatService::UsersListManager
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (UsersListManager_i)
	friend class UsersListManager_i_factory; // self factory
protected:
	// factories id
	struct FactoriesID {
		class Get {}; // ChatService::UsersListManager::get
		class GetByUid {}; // ChatService::UsersListManager::get_by_uid
	};
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UsersListManager_i (CoreSrv::UserID uid, const FactoriesID::Get& factory_id);

	UsersListManager_i (CoreSrv::UserID uid, const FactoriesID::GetByUid& factory_id);

	virtual ~UsersListManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CoreSrv::UserID m_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ChatLibrary::ChatService::UsersListManager
	// добавить пользователя в список контактов
	virtual void add_user_to_list (
		CoreSrv::UserID user
	) throw (
		CORBA::SystemException
		, ChatLibrary::ChatService::UnknownUser
	);

	// implemented method from ChatLibrary::ChatService::UsersListManager
	// удалить пользователя из списка контактов
	virtual void del_user_from_list (
		CoreSrv::UserID user
	) throw (
		CORBA::SystemException
		, ChatLibrary::ChatService::UnknownUser
	);

	// implemented method from ChatLibrary::ChatService::UsersListManager
	// получить список контактов
	virtual ChatLibrary::ChatService::UidList* get_contacts_list () throw (CORBA::SystemException);
}; // class UsersListManager_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
