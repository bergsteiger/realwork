////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

JournalTree::JournalTree (GTree::Tree* tree)
//#UC START# *4A92A941032E_BASE_INIT*
: TreeBase (true), Tree<JournalNode, NodeDelegate> (true)
//#UC END# *4A92A941032E_BASE_INIT*
{
	//#UC START# *4A92A941032E_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("UserJournalTree");
	//#UC END# *4A92A941032E_BODY*
}

JournalTree::~JournalTree () {
	//#UC START# *4A92A8F2022D_DESTR_BODY*
	//#UC END# *4A92A8F2022D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Очистить дерево
void JournalTree::clear () {
	//#UC START# *4AF42B76023D*
	GUARD (*this->get_change_mutex ());
	ApplicationHelper::instance ()->get_cached_user_journal ()->clear ();
	//#UC END# *4AF42B76023D*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

