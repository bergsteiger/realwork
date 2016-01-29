////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageManager_i
// Заголовк реализации фабрик интерфеса MessagesManager для серванта MessageManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"

namespace GblAdapterLib {
namespace ChatService_i {

/// Interface-factory implementation for MessageManager_i
class MessageManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ChatInterfaces::MessagesManagerAbstractFactory
{
public:
	MessageManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ChatInterfaces::MessagesManager* make ();

};

typedef ::Core::Var<MessageManager_i_factory> MessageManager_i_factory_var;

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_MESSAGEMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

