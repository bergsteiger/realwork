////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Session_i
//
// заглушка для получения идентификатора пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i_factory.h"
#include "garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

Session_i_factory::Session_i_factory () {
}

void Session_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CoreSrv::SessionFactoryManager::register_factory (this, priority);
}

const char* Session_i_factory::key () const {
	return "Session_i";
}

CoreSrv::Session* Session_i_factory::get () {
	Session_i_var ret = new Session_i ();
	return ret._retn ();
}

} // namespace ChatImplementation
} // namespace NemesisChatImplementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

