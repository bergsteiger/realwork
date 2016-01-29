////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_BUDGET_ORGS_tree_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PUBLISH_SOURCE_BUDGET_ORGS_tree
// �������� ���������� ������ ���������  ��� �������� PUBLISH_SOURCE_BUDGET_ORGS_tree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_BUDGET_ORGS_TREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_BUDGET_ORGS_TREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PUBLISH_SOURCE_BUDGET_ORGS_tree
class PUBLISH_SOURCE_BUDGET_ORGS_tree_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public NodeBaseAbstractFactory
{
public:
	PUBLISH_SOURCE_BUDGET_ORGS_tree_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<PUBLISH_SOURCE_BUDGET_ORGS_tree_factory> PUBLISH_SOURCE_BUDGET_ORGS_tree_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_BUDGET_ORGS_TREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

