////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_IMPORTANT_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PHARM_IMPORTANT_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_IMPORTANT_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_IMPORTANT_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class PHARM_IMPORTANT_tree; // self forward Var
typedef ::Core::Var<PHARM_IMPORTANT_tree> PHARM_IMPORTANT_tree_var;
typedef ::Core::Var<const PHARM_IMPORTANT_tree> PHARM_IMPORTANT_tree_cvar;

class PHARM_IMPORTANT_tree_factory;

class PHARM_IMPORTANT_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (PHARM_IMPORTANT_tree)
	friend class PHARM_IMPORTANT_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PHARM_IMPORTANT_tree ();
}; // class PHARM_IMPORTANT_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_PHARM_IMPORTANT_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
