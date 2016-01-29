////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_USER_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_USER_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_USER_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_USER_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ANNO_USER_tree; // self forward Var
typedef ::Core::Var<ANNO_USER_tree> ANNO_USER_tree_var;
typedef ::Core::Var<const ANNO_USER_tree> ANNO_USER_tree_cvar;

class ANNO_USER_tree_factory;

class ANNO_USER_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ANNO_USER_tree)
	friend class ANNO_USER_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ANNO_USER_tree ();
}; // class ANNO_USER_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_USER_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
