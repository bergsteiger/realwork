////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Searcher_i
// Заголовк реализации фабрик интерфеса ISearcher для серванта Searcher_i
//
// Реализация интерфейса ISearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_FCTR_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"

namespace SearchAdapterLib {
namespace Adapter_i {

/// Interface-factory implementation for Searcher_i
class Searcher_i_factory: virtual public ::Core::RefCountObjectBase, virtual public Adapter::ISearcherAbstractFactory {
public:
	Searcher_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Adapter::ISearcher* make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src);

};

typedef ::Core::Var<Searcher_i_factory> Searcher_i_factory_var;

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

