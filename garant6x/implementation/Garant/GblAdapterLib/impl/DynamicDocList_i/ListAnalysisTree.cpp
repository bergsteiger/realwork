////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListAnalysisTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListAnalysisTree
//
// Дерево анализа списка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListAnalysisTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListAnalysisTree::ListAnalysisTree (GTree::Tree* stree)
//#UC START# *4A9F727601E7_BASE_INIT*
: TreeBase (true), Tree<AnalysisNode_i, NodeDelegate> (true), m_expanded (false)
//#UC END# *4A9F727601E7_BASE_INIT*
{
	//#UC START# *4A9F727601E7_BODY*
	this->apply_server_tree (stree);
	this->set_tree_name ("AnalysisTree");
	//#UC END# *4A9F727601E7_BODY*
}

ListAnalysisTree::~ListAnalysisTree () {
	//#UC START# *4A9F669C007E_DESTR_BODY*
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
	//#UC END# *4A9F669C007E_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
void ListAnalysisTree::add_notifier (GCL::StaticNode* root, NodeNotifier* notifier) {
	//#UC START# *46011F130203_4A9F669C007E*
	TreeBase::add_notifier (root, notifier);
	if (!m_expanded) {
		this->load_all_tree ();
		GCL::StaticNode_var child (root->first_child ());
		GDS_ASSERT (!child.is_nil ());
		for (; !child.is_nil (); child = child->next()) {
			AnalysisNode_i* analisys_node = dynamic_cast<AnalysisNode_i*> (child.ptr ());
			GDS_ASSERT (analisys_node);
			analisys_node->expand_if_needed ();
		}
		m_expanded = true;
	}
	//#UC END# *46011F130203_4A9F669C007E*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

