////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Tips_i::TipsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREE_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"

namespace GblAdapterLib {

class TipsTree;
typedef Core::Var<TipsTree> TipsTree_var;
typedef Core::Var<const TipsTree> TipsTree_cvar;

class TipsTree :
	virtual public Tree<TipsTreeNode_i, NodeDelegate>
{
	SET_OBJECT_COUNTER (TipsTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit TipsTree (GTree::Tree* tree);

public:
	virtual ~TipsTree ();

}; // class TipsTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

