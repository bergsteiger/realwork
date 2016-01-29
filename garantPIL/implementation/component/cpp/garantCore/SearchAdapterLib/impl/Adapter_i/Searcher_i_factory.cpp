////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Searcher_i
//
// Реализация интерфейса ISearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i_factory.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i.h"

namespace SearchAdapterLib {
namespace Adapter_i {

Searcher_i_factory::Searcher_i_factory () {
}

void Searcher_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Adapter::ISearcherFactoryManager::register_factory (this, priority);
}

const char* Searcher_i_factory::key () const {
	return "Searcher_i";
}

Adapter::ISearcher* Searcher_i_factory::make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) {
	Searcher_i_var ret = new Searcher_i (base, cache, src);
	return ret._retn ();
}

} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

