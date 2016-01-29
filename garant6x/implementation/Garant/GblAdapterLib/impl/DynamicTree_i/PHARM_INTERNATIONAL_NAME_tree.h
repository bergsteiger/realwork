////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_INTERNATIONAL_NAME_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PHARM_INTERNATIONAL_NAME_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_INTERNATIONAL_NAME_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_INTERNATIONAL_NAME_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class PHARM_INTERNATIONAL_NAME_tree; // self forward Var
typedef ::Core::Var<PHARM_INTERNATIONAL_NAME_tree> PHARM_INTERNATIONAL_NAME_tree_var;
typedef ::Core::Var<const PHARM_INTERNATIONAL_NAME_tree> PHARM_INTERNATIONAL_NAME_tree_cvar;

class PHARM_INTERNATIONAL_NAME_tree_factory;

class PHARM_INTERNATIONAL_NAME_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (PHARM_INTERNATIONAL_NAME_tree)
	friend class PHARM_INTERNATIONAL_NAME_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PHARM_INTERNATIONAL_NAME_tree ();
}; // class PHARM_INTERNATIONAL_NAME_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_INTERNATIONAL_NAME_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
