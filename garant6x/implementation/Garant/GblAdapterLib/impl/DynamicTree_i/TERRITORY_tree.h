////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TERRITORY_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TERRITORY_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TERRITORY_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TERRITORY_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class TERRITORY_tree; // self forward Var
typedef ::Core::Var<TERRITORY_tree> TERRITORY_tree_var;
typedef ::Core::Var<const TERRITORY_tree> TERRITORY_tree_cvar;

class TERRITORY_tree_factory;

class TERRITORY_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (TERRITORY_tree)
	friend class TERRITORY_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~TERRITORY_tree ();
}; // class TERRITORY_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TERRITORY_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
