////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Variants_tree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::Variants_tree
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������ ��������� ��� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTS_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTS_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class Variants_tree; // self forward Var
typedef ::Core::Var<Variants_tree> Variants_tree_var;
typedef ::Core::Var<const Variants_tree> Variants_tree_cvar;

class Variants_tree_factory;

// ������ ��������� ��� �������� ������
class Variants_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (Variants_tree)
	friend class Variants_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~Variants_tree ();
}; // class Variants_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VARIANTS_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
