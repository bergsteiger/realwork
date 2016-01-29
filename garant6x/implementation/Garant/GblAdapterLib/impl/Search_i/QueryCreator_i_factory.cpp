////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryCreator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i.h"

namespace GblAdapterLib {

QueryCreator_i_factory::QueryCreator_i_factory () {
}

void QueryCreator_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryCreatorFactoryManager::register_factory (this, priority);
}

const char* QueryCreator_i_factory::key () const {
	return "QueryCreator_i";
}

QueryCreator* QueryCreator_i_factory::make () {
	return Core::IObject::_duplicate (QueryCreator_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

