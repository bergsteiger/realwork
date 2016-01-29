////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/KW_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::KW_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_KW_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_KW_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class KW_tree; // self forward Var
typedef ::Core::Var<KW_tree> KW_tree_var;
typedef ::Core::Var<const KW_tree> KW_tree_cvar;

class KW_tree_factory;

class KW_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (KW_tree)
	friend class KW_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~KW_tree ();
}; // class KW_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_KW_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
