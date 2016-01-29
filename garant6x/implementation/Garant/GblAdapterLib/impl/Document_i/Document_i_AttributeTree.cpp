////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i_AttributeTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Document_i::Document_i::AttributeTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"

namespace GblAdapterLib {
class Document_i;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Document_i::AttributeTree::AttributeTree (GTree::Tree* tree)
//#UC START# *460A2DEB0357_BASE_INIT*
	: TreeBase (false), Tree <NodeBase_i, NodeDelegate> (false)
//#UC END# *460A2DEB0357_BASE_INIT*
{
	//#UC START# *460A2DEB0357_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("AttributeTree");
	//#UC END# *460A2DEB0357_BODY*
}

Document_i::AttributeTree::~AttributeTree () {
	//#UC START# *460A2CB80155_DESTR_BODY*
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
	//#UC END# *460A2CB80155_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

