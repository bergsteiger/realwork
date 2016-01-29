////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::NemesisChatImplementation::ChatImplementation
//
// ���������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "tao/ORB_Core.h"
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
#include "shared/CoreSrv/Root/Root.h"
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/ChatLibrary/ChatService/ChatService.h"
#include "shared/ChatLibrary/ChatService/ChatServiceS.h"


namespace NemesisChatImplementation {
namespace ChatImplementation {

class LocalChatManager;
typedef ::Core::Var<LocalChatManager> LocalChatManager_var;
typedef ::Core::Var<const LocalChatManager> LocalChatManager_cvar;
// �������� � ������������ ������� ���������
class LocalChatManager
	: virtual public POA_ChatLibrary::ChatService::ChatManager
{
public:
	// ������� ��������� �� ��������� ������������ ���������
	virtual void send_message (
		CoreSrv::UserID from
		, CoreSrv::UserID to
		, const ChatLibrary::ChatService::MessageData& message
	) /*throw (
		ChatLibrary::ChatService::UnknownUser
	)*/ = 0;
};

/// factory interface for LocalChatManager
class LocalChatManagerFactory {
public:
	// �������� ������, ���������� �� ����� ���������� ��� ������������
	static LocalChatManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������ ��������������� �������������
typedef std::vector < CoreSrv::UserID > UidList;

} //namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

