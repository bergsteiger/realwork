////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageListener_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"

namespace GblAdapterLib {
namespace ChatService_i {

MessageListener_i_factory::MessageListener_i_factory () {
}

void MessageListener_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ChatLibrary::ChatService::MessageListenerFactoryManager::register_factory (this, priority);
}

const char* MessageListener_i_factory::key () const {
	return "MessageListener_i";
}

ChatLibrary::ChatService::MessageListener* MessageListener_i_factory::make () {
	MessageListener_i_var ret = new MessageListener_i ();
	return ret->_this ();
}

} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

