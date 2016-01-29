////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/STATUS_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::STATUS_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_STATUS_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_STATUS_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class STATUS_tree; // self forward Var
typedef ::Core::Var<STATUS_tree> STATUS_tree_var;
typedef ::Core::Var<const STATUS_tree> STATUS_tree_cvar;

class STATUS_tree_factory;

class STATUS_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (STATUS_tree)
	friend class STATUS_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~STATUS_tree ();
}; // class STATUS_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_STATUS_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
