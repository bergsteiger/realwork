////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_EFFECT_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PHARM_EFFECT_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_EFFECT_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_EFFECT_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class PHARM_EFFECT_tree; // self forward Var
typedef ::Core::Var<PHARM_EFFECT_tree> PHARM_EFFECT_tree_var;
typedef ::Core::Var<const PHARM_EFFECT_tree> PHARM_EFFECT_tree_cvar;

class PHARM_EFFECT_tree_factory;

class PHARM_EFFECT_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (PHARM_EFFECT_tree)
	friend class PHARM_EFFECT_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PHARM_EFFECT_tree ();
}; // class PHARM_EFFECT_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_EFFECT_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
