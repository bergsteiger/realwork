////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributesHelper_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i.h"

namespace GblAdapterLib {

AttributesHelper_i_factory::AttributesHelper_i_factory () {
}

void AttributesHelper_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AttributesHelperFactoryManager::register_factory (this, priority);
}

const char* AttributesHelper_i_factory::key () const {
	return "AttributesHelper_i";
}

AttributesHelper* AttributesHelper_i_factory::make () {
	return Core::IObject::_duplicate (AttributesHelper_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

