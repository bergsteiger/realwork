////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsView.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContentsTree::ContentsTree (GTree::Tree* tree)
//#UC START# *4C778AE80242_BASE_INIT*
	: TreeBase (false), Tree <ContentsNode_i, ContentsNodeDelegate> (false)
//#UC END# *4C778AE80242_BASE_INIT*
{
	//#UC START# *4C778AE80242_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("ContentsTree");
	//#UC END# *4C778AE80242_BODY*
}

ContentsTree::~ContentsTree () {
	//#UC START# *4C778A2900FB_DESTR_BODY*
	//try {
	//	GTree::Tree_var stree = this->get_server_tree ();
	//	if (!CORBA::is_nil (stree)) {
	//		ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (stree);
	//	}
	//} catch (CORBA::TRANSIENT&) {
	//	// do nothing, CORBA::TRANSIENT exception ignored
	//} catch (...) {
	//	GDS_ASSERT ((false, "Unknown exception catched"));
	//}
	//#UC END# *4C778A2900FB_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
ViewBase* ContentsTree::alloc_new_view () {
	//#UC START# *460127E400EA_4C778A2900FB*
	return new ContentsView ();
	//#UC END# *460127E400EA_4C778A2900FB*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

