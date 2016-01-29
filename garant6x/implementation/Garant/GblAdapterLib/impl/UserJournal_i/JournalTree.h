////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALTREE_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"

namespace GblAdapterLib {

class JournalTree;
typedef Core::Var<JournalTree> JournalTree_var;
typedef Core::Var<const JournalTree> JournalTree_cvar;

class JournalTree :
	virtual public Tree<JournalNode, NodeDelegate>
{
	SET_OBJECT_COUNTER (JournalTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit JournalTree (GTree::Tree* tree);

public:
	virtual ~JournalTree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Очистить дерево
	virtual void clear ();

}; // class JournalTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

