////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_REVIEW_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::SOURCE_REVIEW_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SOURCE_REVIEW_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SOURCE_REVIEW_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class SOURCE_REVIEW_tree; // self forward Var
typedef ::Core::Var<SOURCE_REVIEW_tree> SOURCE_REVIEW_tree_var;
typedef ::Core::Var<const SOURCE_REVIEW_tree> SOURCE_REVIEW_tree_cvar;

class SOURCE_REVIEW_tree_factory;

class SOURCE_REVIEW_tree:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (SOURCE_REVIEW_tree)
	friend class SOURCE_REVIEW_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~SOURCE_REVIEW_tree ();
}; // class SOURCE_REVIEW_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SOURCE_REVIEW_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
