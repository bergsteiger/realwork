////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PUBLISH_SOURCE_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class PUBLISH_SOURCE_tree; // self forward Var
typedef ::Core::Var<PUBLISH_SOURCE_tree> PUBLISH_SOURCE_tree_var;
typedef ::Core::Var<const PUBLISH_SOURCE_tree> PUBLISH_SOURCE_tree_cvar;

class PUBLISH_SOURCE_tree_factory;

class PUBLISH_SOURCE_tree:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (PUBLISH_SOURCE_tree)
	friend class PUBLISH_SOURCE_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PUBLISH_SOURCE_tree ();
}; // class PUBLISH_SOURCE_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PUBLISH_SOURCE_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
