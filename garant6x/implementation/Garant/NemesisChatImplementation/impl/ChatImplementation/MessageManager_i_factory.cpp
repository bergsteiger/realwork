////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::MessageManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/MessageManager_i.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/LibHome.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

MessageManager_i_factory::MessageManager_i_factory () {
}

void MessageManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ChatLibrary::ChatService::MessageManagerFactoryManager::register_factory (this, priority);
}

const char* MessageManager_i_factory::key () const {
	return "MessageManager_i";
}

ChatLibrary::ChatService::MessageManager* MessageManager_i_factory::get (CoreSrv::UserID uid) {
	MessageManager_i_var ret = new MessageManager_i (uid);
	return ret->_this ();
}

} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

