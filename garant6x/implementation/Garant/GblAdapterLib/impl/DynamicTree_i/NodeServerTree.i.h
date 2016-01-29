////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeServerTree
//
// Адаптерное дерево, с кешом сервантов (эмуляция мультифабрики)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *45F7C10C005D_CUSTOM_INCLUDES*
//#UC END# *45F7C10C005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F7C10C005D*
//#UC END# *45F7C10C005D*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

template <class NodeType_>
TreeBase* NodeServerTree<NodeType_>::make_tree (AttributeTag_const name) {
	//#UC START# *45F7C1B5035B*
	//Core::GDS::StopWatchEx sw ("make_tree", "NodeServerTree::make_tree (%s)", name)
	// Выкинуть очистку деревьев из кеша когда на оболочке с этим разберемся
	if (!ApplicationHelper::instance ()->compare_and_update_base_id (*BaseIdSingleton::instance())) {
		//LOG_D (("NodeServerTree::make_tree (%s) - reset cache map", name));
		for (TreesMap::iterator it = TreesMapSingl::instance()->begin(); it != TreesMapSingl::instance()->end(); it++) {
			RealNodeRoot* root = dynamic_cast<RealNodeRoot*>(it->second.ptr());
			if (root) {
				root->safety_tree_remove();
			}
		}
		TreesMapSingl::instance()->clear();
	}
	TreesMap::iterator f = TreesMapSingl::instance()->find(name);
	if (f == TreesMapSingl::instance()->end()) {
		try {
			TreeBase* tree = new NodeServerTree<NodeType_> (name);
			GCL::StaticNode* root = tree->root();
			TreesMapSingl::instance()->insert(
				TreesMapSingl::instance()->begin()
				, TreesMap::value_type(name, root)
			);
			return tree;
		} catch (std::logic_error& ) {
			LOG_E (("Unknown index name(%s)", name));
			return 0;
		} catch (GCD::CanNotFindData& ) {
			LOG_W (("Can't load index (%s)", name));
			return 0;
		}
	} else {
		//LOG_D (("NodeServerTree[%d]::second make ", (TreeBase*)f->second));
		RealNodeRoot* rnr = dynamic_cast<RealNodeRoot*>(f->second.ptr());
		return const_cast<TreeBase*> (rnr->get_owner_tree_var ());
	}		
	//#UC END# *45F7C1B5035B**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeType_>
NodeServerTree<NodeType_>::~NodeServerTree () {
	//#UC START# *45F7C10C005D_DESTR_BODY*
	//LOG_D (("%s (%s)", GDS_CURRENT_FUNCTION, (TreeBase*)this, m_tree_name.data ()));
	//#UC END# *45F7C10C005D_DESTR_BODY**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Listener
template <class NodeType_>
void NodeServerTree<NodeType_>::fire (const Notification* notify) const {
	//#UC START# *45EEDE9D01C5_45F7C10C005D*
	GDS_ASSERT (notify->get_id() == NT_MONITORING_UPDATE);

	// clean predefined data
	TreesMap::iterator f = TreesMapSingl::instance()->find ("AT_NEWS_LINE");
	if (f != TreesMapSingl::instance()->end ()) {
		LOG_D (("%s [%d] - cleaning %s", GDS_CURRENT_FUNCTION, (TreeBase*)this, this->get_tree_name ().c_str ()));
		try {
			RealNodeRoot* root = dynamic_cast<RealNodeRoot*>(f->second.ptr());
			if (root) {
				root->safety_tree_remove ();
			}
			TreesMapSingl::instance()->erase (f);
		} catch (...) {
			LOG_E (("%s [%d] - cleaning %s", GDS_CURRENT_FUNCTION, (TreeBase*)this, this->get_tree_name ().c_str ()));
		}
	}
	//#UC END# *45EEDE9D01C5_45F7C10C005D**cpp*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

