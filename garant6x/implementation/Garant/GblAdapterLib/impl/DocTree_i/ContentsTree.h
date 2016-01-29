////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"

namespace GblAdapterLib {

class ContentsTree;
typedef Core::Var<ContentsTree> ContentsTree_var;
typedef Core::Var<const ContentsTree> ContentsTree_cvar;

class ContentsTree :
	virtual public Tree<ContentsNode_i, ContentsNodeDelegate>
{
	SET_OBJECT_COUNTER (ContentsTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit ContentsTree (GTree::Tree* tree);

public:
	virtual ~ContentsTree ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from TreeBase
	virtual ViewBase* alloc_new_view ();

}; // class ContentsTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

