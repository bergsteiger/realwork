////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_INTEREST_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_INTEREST_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_INTEREST_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_INTEREST_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ANNO_INTEREST_tree; // self forward Var
typedef ::Core::Var<ANNO_INTEREST_tree> ANNO_INTEREST_tree_var;
typedef ::Core::Var<const ANNO_INTEREST_tree> ANNO_INTEREST_tree_cvar;

class ANNO_INTEREST_tree_factory;

class ANNO_INTEREST_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ANNO_INTEREST_tree)
	friend class ANNO_INTEREST_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ANNO_INTEREST_tree ();
}; // class ANNO_INTEREST_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_INTEREST_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
