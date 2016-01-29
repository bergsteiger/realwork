////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CLASS_REVIEW_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CLASS_REVIEW_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CLASS_REVIEW_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CLASS_REVIEW_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class CLASS_REVIEW_tree; // self forward Var
typedef ::Core::Var<CLASS_REVIEW_tree> CLASS_REVIEW_tree_var;
typedef ::Core::Var<const CLASS_REVIEW_tree> CLASS_REVIEW_tree_cvar;

class CLASS_REVIEW_tree_factory;

class CLASS_REVIEW_tree:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (CLASS_REVIEW_tree)
	friend class CLASS_REVIEW_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~CLASS_REVIEW_tree ();
}; // class CLASS_REVIEW_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CLASS_REVIEW_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
