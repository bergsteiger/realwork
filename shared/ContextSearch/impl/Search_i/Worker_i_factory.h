////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Search_i/Worker_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Worker_i
// �������� ���������� ������ ��������� IWorker ��� �������� Worker_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Search_i {

/// Interface-factory implementation for Worker_i
class Worker_i_factory: virtual public ::Core::RefCountObjectBase, virtual public Search::IWorkerAbstractFactory {
public:
	Worker_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Search::IWorker* make ();

};

typedef ::Core::Var<Worker_i_factory> Worker_i_factory_var;

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_WORKER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

