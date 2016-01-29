////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/PrefixTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::PrefixTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/PrefixTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrefixTree::PrefixTree (GTree::Tree* tree)
//#UC START# *4660175E035B_BASE_INIT*
	: TreeBase (false), Tree <PrefixNode_i, NodeDelegate> (false)
//#UC END# *4660175E035B_BASE_INIT*
{
	//#UC START# *4660175E035B_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("CorrespondentKind");
	//#UC END# *4660175E035B_BODY*
}

PrefixTree::~PrefixTree () {
	//#UC START# *466016AA008C_DESTR_BODY*
	try {
		GTree::Tree_var stree = this->get_server_tree ();
		if (!CORBA::is_nil (stree)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (stree);
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *466016AA008C_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

