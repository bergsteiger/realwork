////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/EDITION_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::EDITION_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_EDITION_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_EDITION_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class EDITION_tree; // self forward Var
typedef ::Core::Var<EDITION_tree> EDITION_tree_var;
typedef ::Core::Var<const EDITION_tree> EDITION_tree_cvar;

class EDITION_tree_factory;

class EDITION_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (EDITION_tree)
	friend class EDITION_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~EDITION_tree ();
}; // class EDITION_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_EDITION_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
