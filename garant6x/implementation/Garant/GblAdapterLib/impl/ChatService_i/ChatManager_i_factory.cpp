////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ChatService_i::ChatManager_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i.h"

namespace GblAdapterLib {
namespace ChatService_i {

ChatManager_i_factory::ChatManager_i_factory () {
}

void ChatManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ChatInterfaces::ChatManagerFactoryManager::register_factory (this, priority);
}

const char* ChatManager_i_factory::key () const {
	return "ChatManager_i";
}

ChatInterfaces::ChatManager* ChatManager_i_factory::make () {
	ChatManager_i_var ret = new ChatManager_i ();
	return ret._retn ();
}

} // namespace ChatService_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

