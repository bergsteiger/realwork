////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::SearchImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl.h"

namespace GblAdapterLib {

SearchImpl_factory::SearchImpl_factory () {
}

void SearchImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SearchFactoryManager::register_factory (this, priority);
}

const char* SearchImpl_factory::key () const {
	return "SearchImpl";
}

Search* SearchImpl_factory::make () {
	SearchImpl_var ret = new SearchImpl ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

