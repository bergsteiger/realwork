////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Security_i::GroupsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GroupsTree::GroupsTree (GTree::Tree* stree)
//#UC START# *49DF2E710165_BASE_INIT*
: TreeBase (true), Tree<GroupsNode, NodeDelegate> (true)
//#UC END# *49DF2E710165_BASE_INIT*
{
	//#UC START# *49DF2E710165_BODY*
	this->apply_server_tree (stree);
	this->set_tree_name ("GroupsTree");
	//#UC END# *49DF2E710165_BODY*
}

GroupsTree::~GroupsTree () {
	//#UC START# *49DF2E21014A_DESTR_BODY*
	//#UC END# *49DF2E21014A_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

