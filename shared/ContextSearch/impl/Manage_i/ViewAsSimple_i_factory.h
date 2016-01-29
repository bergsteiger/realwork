////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSimple_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSimple_i
// Заголовк реализации фабрик интерфеса IRequestView для серванта ViewAsSimple_i
//
// Простое представление (без синонимов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for ViewAsSimple_i
class ViewAsSimple_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Search::IRequestViewAbstractFactory
{
public:
	ViewAsSimple_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Search::AlgorithmSelector key () const;

	Search::IRequestView* make (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

};

typedef ::Core::Var<ViewAsSimple_i_factory> ViewAsSimple_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

