////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BASES_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BASES_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASES_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASES_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class BASES_tree; // self forward Var
typedef ::Core::Var<BASES_tree> BASES_tree_var;
typedef ::Core::Var<const BASES_tree> BASES_tree_cvar;

class BASES_tree_factory;

class BASES_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (BASES_tree)
	friend class BASES_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~BASES_tree ();
}; // class BASES_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASES_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
