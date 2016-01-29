////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibClient::Start_i::Client
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLibClient/impl/Start_i/Client.h"

namespace GblAdapterLibClient {
namespace Start_i {

Client_factory::Client_factory () {
}

void Client_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GblAdapterLib::ComponentManagerFactoryManager::register_factory (this, priority);
}

const char* Client_factory::key () const {
	return "Client";
}

GblAdapterLib::ComponentManager* Client_factory::make () {
	Client_var ret = new Client ();
	return ret._retn ();
}

} // namespace Start_i
} // namespace GblAdapterLibClient

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

