////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NORM_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NORM_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NORM_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NORM_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class NORM_tree; // self forward Var
typedef ::Core::Var<NORM_tree> NORM_tree_var;
typedef ::Core::Var<const NORM_tree> NORM_tree_cvar;

class NORM_tree_factory;

class NORM_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (NORM_tree)
	friend class NORM_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~NORM_tree ();
}; // class NORM_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NORM_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
