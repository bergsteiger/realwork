////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PREFIX_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PREFIX_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PREFIX_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PREFIX_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class PREFIX_tree; // self forward Var
typedef ::Core::Var<PREFIX_tree> PREFIX_tree_var;
typedef ::Core::Var<const PREFIX_tree> PREFIX_tree_cvar;

class PREFIX_tree_factory;

class PREFIX_tree:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (PREFIX_tree)
	friend class PREFIX_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PREFIX_tree ();
}; // class PREFIX_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PREFIX_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
