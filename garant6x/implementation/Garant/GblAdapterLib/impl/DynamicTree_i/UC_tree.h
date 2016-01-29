////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/UC_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::UC_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_UC_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_UC_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class UC_tree; // self forward Var
typedef ::Core::Var<UC_tree> UC_tree_var;
typedef ::Core::Var<const UC_tree> UC_tree_cvar;

class UC_tree_factory;

class UC_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (UC_tree)
	friend class UC_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~UC_tree ();
}; // class UC_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_UC_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
