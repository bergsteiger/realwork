////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/REG_NUM_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::REG_NUM_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_NUM_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_NUM_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class REG_NUM_tree; // self forward Var
typedef ::Core::Var<REG_NUM_tree> REG_NUM_tree_var;
typedef ::Core::Var<const REG_NUM_tree> REG_NUM_tree_cvar;

class REG_NUM_tree_factory;

class REG_NUM_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (REG_NUM_tree)
	friend class REG_NUM_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~REG_NUM_tree ();
}; // class REG_NUM_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_NUM_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
