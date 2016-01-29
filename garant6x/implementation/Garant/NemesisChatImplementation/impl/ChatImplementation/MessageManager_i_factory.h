////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::MessageManager_i
// Заголовк реализации фабрик интерфеса MessageManager для серванта MessageManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_FCTR_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/ChatImplementation.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

/// Interface-factory implementation for MessageManager_i
class MessageManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ChatLibrary::ChatService::MessageManagerAbstractFactory
{
public:
	MessageManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ChatLibrary::ChatService::MessageManager* get (CoreSrv::UserID uid);

};

typedef ::Core::Var<MessageManager_i_factory> MessageManager_i_factory_var;

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_MESSAGEMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

