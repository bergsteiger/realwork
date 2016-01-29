////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Security_i::GroupsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSTREE_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"

namespace GblAdapterLib {

class GroupsTree;
typedef Core::Var<GroupsTree> GroupsTree_var;
typedef Core::Var<const GroupsTree> GroupsTree_cvar;

class GroupsTree :
	virtual public Tree<GroupsNode, NodeDelegate>
{
	SET_OBJECT_COUNTER (GroupsTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit GroupsTree (GTree::Tree* stree);

public:
	virtual ~GroupsTree ();

}; // class GroupsTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

