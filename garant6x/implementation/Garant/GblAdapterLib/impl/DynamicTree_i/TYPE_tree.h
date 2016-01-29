////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TYPE_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TYPE_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TYPE_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TYPE_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class TYPE_tree; // self forward Var
typedef ::Core::Var<TYPE_tree> TYPE_tree_var;
typedef ::Core::Var<const TYPE_tree> TYPE_tree_cvar;

class TYPE_tree_factory;

class TYPE_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (TYPE_tree)
	friend class TYPE_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~TYPE_tree ();
}; // class TYPE_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TYPE_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
