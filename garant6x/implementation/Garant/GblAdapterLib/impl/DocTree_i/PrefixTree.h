////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/PrefixTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::PrefixTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_PREFIXTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_PREFIXTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"

namespace GblAdapterLib {

class PrefixTree;
typedef Core::Var<PrefixTree> PrefixTree_var;
typedef Core::Var<const PrefixTree> PrefixTree_cvar;

class PrefixTree :
	virtual public Tree<PrefixNode_i, NodeDelegate>
{
	SET_OBJECT_COUNTER (PrefixTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit PrefixTree (GTree::Tree* tree);

public:
	virtual ~PrefixTree ();

}; // class PrefixTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_PREFIXTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

