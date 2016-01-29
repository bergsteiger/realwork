////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::MessageManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i.h"

namespace GblAdapterLib {
namespace ChatService_i {

MessageManager_i_factory::MessageManager_i_factory () {
}

void MessageManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ChatInterfaces::MessagesManagerFactoryManager::register_factory (this, priority);
}

const char* MessageManager_i_factory::key () const {
	return "MessageManager_i";
}

ChatInterfaces::MessagesManager* MessageManager_i_factory::make () {
	MessageManager_i_var ret = new MessageManager_i ();
	return ret._retn ();
}

} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

