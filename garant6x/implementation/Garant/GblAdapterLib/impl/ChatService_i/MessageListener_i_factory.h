////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageListener_i
// �������� ���������� ������ ��������� MessageListener ��� �������� MessageListener_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"

namespace GblAdapterLib {
namespace ChatService_i {

/// Interface-factory implementation for MessageListener_i
class MessageListener_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ChatLibrary::ChatService::MessageListenerAbstractFactory
{
public:
	MessageListener_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ChatLibrary::ChatService::MessageListener* make ();

};

typedef ::Core::Var<MessageListener_i_factory> MessageListener_i_factory_var;

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGELISTENER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

