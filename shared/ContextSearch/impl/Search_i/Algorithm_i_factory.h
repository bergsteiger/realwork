////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Algorithm_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Algorithm_i
// Заголовк реализации фабрик интерфеса IAlgorithm для серванта Algorithm_i
//
// Реализация интерфейса поискового алгоритма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Search_i {

/// Interface-factory implementation for Algorithm_i
class Algorithm_i_factory: virtual public ::Core::RefCountObjectBase, virtual public Search::IAlgorithmAbstractFactory {
public:
	Algorithm_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Search::AlgorithmSelector key () const;

	Search::IAlgorithm* make (
		Search::IRequestView* view
		, DBComm::IProgress* progress
		, const Search::AlgorithmProperties& properties
	);

};

typedef ::Core::Var<Algorithm_i_factory> Algorithm_i_factory_var;

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

