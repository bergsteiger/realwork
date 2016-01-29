////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/REG_IN_MU_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::REG_IN_MU_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_IN_MU_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_IN_MU_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class REG_IN_MU_tree; // self forward Var
typedef ::Core::Var<REG_IN_MU_tree> REG_IN_MU_tree_var;
typedef ::Core::Var<const REG_IN_MU_tree> REG_IN_MU_tree_cvar;

class REG_IN_MU_tree_factory;

class REG_IN_MU_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (REG_IN_MU_tree)
	friend class REG_IN_MU_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~REG_IN_MU_tree ();
}; // class REG_IN_MU_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REG_IN_MU_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
