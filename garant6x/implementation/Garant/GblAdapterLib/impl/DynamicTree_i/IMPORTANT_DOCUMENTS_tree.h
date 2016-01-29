////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/IMPORTANT_DOCUMENTS_tree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::IMPORTANT_DOCUMENTS_tree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class IMPORTANT_DOCUMENTS_tree; // self forward Var
typedef ::Core::Var<IMPORTANT_DOCUMENTS_tree> IMPORTANT_DOCUMENTS_tree_var;
typedef ::Core::Var<const IMPORTANT_DOCUMENTS_tree> IMPORTANT_DOCUMENTS_tree_cvar;

class IMPORTANT_DOCUMENTS_tree_factory;

class IMPORTANT_DOCUMENTS_tree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (IMPORTANT_DOCUMENTS_tree)
	friend class IMPORTANT_DOCUMENTS_tree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~IMPORTANT_DOCUMENTS_tree ();
}; // class IMPORTANT_DOCUMENTS_tree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
