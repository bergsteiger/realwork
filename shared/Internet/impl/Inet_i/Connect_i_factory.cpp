////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connect_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connect_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connect_i.h"

namespace Internet {
namespace Inet_i {

Connect_i_factory::Connect_i_factory () {
}

void Connect_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IConnectFactoryManager::register_factory (this, priority);
}

const char* Connect_i_factory::key () const {
	return "Connect_i";
}

IConnect* Connect_i_factory::make (const InternetAccessInfo& info) {
	Connect_i_var ret = new Connect_i (info);
	return ret._retn ();
}

} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

