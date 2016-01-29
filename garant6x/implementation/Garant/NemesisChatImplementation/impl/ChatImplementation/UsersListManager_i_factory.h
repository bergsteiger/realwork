////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/UsersListManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::UsersListManager_i
// �������� ���������� ������ ��������� UsersListManager ��� �������� UsersListManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_FCTR_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

/// Interface-factory implementation for UsersListManager_i
class UsersListManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ChatLibrary::ChatService::UsersListManagerAbstractFactory
{
public:
	UsersListManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ChatLibrary::ChatService::UsersListManager* get (CoreSrv::UserID uid);

	ChatLibrary::ChatService::UsersListManager* get_by_uid (CoreSrv::UserID uid);

};

typedef ::Core::Var<UsersListManager_i_factory> UsersListManager_i_factory_var;

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_USERSLISTMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

