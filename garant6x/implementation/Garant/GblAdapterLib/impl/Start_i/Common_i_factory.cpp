////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Common_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i.h"

namespace GblAdapterLib {

Common_i_factory::Common_i_factory () {
}

void Common_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CommonFactoryManager::register_factory (this, priority);
}

const char* Common_i_factory::key () const {
	return "Common_i";
}

Common* Common_i_factory::make () {
	return Core::IObject::_duplicate (Common_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

