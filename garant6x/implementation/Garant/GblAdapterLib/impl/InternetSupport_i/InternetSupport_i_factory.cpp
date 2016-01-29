////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::InternetSupport_i
//
// поддержка работы пользователей через internet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i.h"

namespace GblAdapterLib {

InternetSupport_i_factory::InternetSupport_i_factory () {
}

void InternetSupport_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	InternetSupportFactoryManager::register_factory (this, priority);
}

const char* InternetSupport_i_factory::key () const {
	return "InternetSupport_i";
}

InternetSupport* InternetSupport_i_factory::make () {
	return Core::IObject::_duplicate (InternetSupport_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

