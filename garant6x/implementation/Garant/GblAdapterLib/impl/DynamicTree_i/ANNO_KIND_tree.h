////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_KIND_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_KIND_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_KIND_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_KIND_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ANNO_KIND_tree; // self forward Var
typedef ::Core::Var<ANNO_KIND_tree> ANNO_KIND_tree_var;
typedef ::Core::Var<const ANNO_KIND_tree> ANNO_KIND_tree_cvar;

class ANNO_KIND_tree_factory;

class ANNO_KIND_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ANNO_KIND_tree)
	friend class ANNO_KIND_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ANNO_KIND_tree ();
}; // class ANNO_KIND_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_KIND_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
