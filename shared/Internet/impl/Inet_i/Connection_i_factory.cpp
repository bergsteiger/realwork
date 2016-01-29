////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connection_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connection_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connection_i.h"

namespace Internet {
namespace Inet_i {

Connection_i_factory::Connection_i_factory () {
}

void Connection_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IConnectionFactoryManager::register_factory (this, priority);
}

const char* Connection_i_factory::key () const {
	return "Connection_i";
}

IConnection* Connection_i_factory::make (void* data, unsigned long flags) {
	Connection_i_var ret = new Connection_i (data, flags);
	return ret._retn ();
}

} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

