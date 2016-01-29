////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FiltersManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i.h"

namespace GblAdapterLib {

FiltersManager_i_factory::FiltersManager_i_factory () {
}

void FiltersManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FiltersManagerFactoryManager::register_factory (this, priority);
}

const char* FiltersManager_i_factory::key () const {
	return "FiltersManager_i";
}

FiltersManager* FiltersManager_i_factory::make () {
	return Core::IObject::_duplicate (FiltersManager_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

