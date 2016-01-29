////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_FINANCE_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PUBLISH_SOURCE_FINANCE_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_FINANCE_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_FINANCE_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class PUBLISH_SOURCE_FINANCE_tree; // self forward Var
typedef ::Core::Var<PUBLISH_SOURCE_FINANCE_tree> PUBLISH_SOURCE_FINANCE_tree_var;
typedef ::Core::Var<const PUBLISH_SOURCE_FINANCE_tree> PUBLISH_SOURCE_FINANCE_tree_cvar;

class PUBLISH_SOURCE_FINANCE_tree_factory;

class PUBLISH_SOURCE_FINANCE_tree:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (PUBLISH_SOURCE_FINANCE_tree)
	friend class PUBLISH_SOURCE_FINANCE_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PUBLISH_SOURCE_FINANCE_tree ();
}; // class PUBLISH_SOURCE_FINANCE_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_FINANCE_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
