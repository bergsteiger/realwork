////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSequence_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSequence_i
// Заголовк реализации фабрик интерфеса IRequestView для серванта ViewAsSequence_i
//
// Представление запроса в виде последовательности синонимичных запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for ViewAsSequence_i
class ViewAsSequence_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Search::IRequestViewAbstractFactory
{
public:
	ViewAsSequence_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Search::AlgorithmSelector key () const;

	Search::IRequestView* make (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

};

typedef ::Core::Var<ViewAsSequence_i_factory> ViewAsSequence_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSEQUENCE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

