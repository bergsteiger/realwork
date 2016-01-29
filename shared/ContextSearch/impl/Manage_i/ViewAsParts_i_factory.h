////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Manage_i/ViewAsParts_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsParts_i
// �������� ���������� ������ ��������� IRequestView ��� �������� ViewAsParts_i
//
// ������������� ������� � ���� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_FCTR_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Manage_i {

/// Interface-factory implementation for ViewAsParts_i
class ViewAsParts_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Search::IRequestViewAbstractFactory
{
public:
	ViewAsParts_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Search::AlgorithmSelector key () const;

	Search::IRequestView* make (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

};

typedef ::Core::Var<ViewAsParts_i_factory> ViewAsParts_i_factory_var;

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

