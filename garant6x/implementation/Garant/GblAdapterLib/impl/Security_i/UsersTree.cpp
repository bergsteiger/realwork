////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UsersTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Security_i::UsersTree
//
// Дерево  пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UsersTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UsersTree::UsersTree (GTree::Tree* tree)
//#UC START# *49DF1C4A00F4_BASE_INIT*
: TreeBase (true), Tree<UserNode_i, UserNodeDelegate> (true)
//#UC END# *49DF1C4A00F4_BASE_INIT*
{
	//#UC START# *49DF1C4A00F4_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("UsersTree");
	//#UC END# *49DF1C4A00F4_BODY*
}

UsersTree::~UsersTree () {
	//#UC START# *49DF198B015D_DESTR_BODY*
	//#UC END# *49DF198B015D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void UsersTree::register_listener (UserProfile* profile) {
	//#UC START# *49DF1C6501D3*
	ActiveChangeableBase* changeable = dynamic_cast<ActiveChangeableBase*> (profile);
	GDS_ASSERT (changeable);
	GTree::Tree_var stree = this->get_server_tree ();
	if (!changeable->is_registered () && stree.ptr ()) {
		::TimeStampSync::TimeStampObjectID id = stree->timestamp_object_id ();
		changeable->register_object (id);
	}
	//#UC END# *49DF1C6501D3*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

