////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::ChatManager_i
// Заголовк реализации фабрик интерфеса ChatManager для серванта ChatManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"

namespace GblAdapterLib {
namespace ChatService_i {

/// Interface-factory implementation for ChatManager_i
class ChatManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ChatInterfaces::ChatManagerAbstractFactory
{
public:
	ChatManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ChatInterfaces::ChatManager* make ();

};

typedef ::Core::Var<ChatManager_i_factory> ChatManager_i_factory_var;

} // namespace ChatService_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CHATSERVICE_I_CHATMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

