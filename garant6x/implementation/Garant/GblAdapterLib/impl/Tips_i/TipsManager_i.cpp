////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTree.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TipsManager_i::TipsManager_i ()
//#UC START# *47B30CD40027_47B30CFF0271_47B3124700CC_BASE_INIT*
: m_tips_exists (boost::indeterminate)
//#UC END# *47B30CD40027_47B30CFF0271_47B3124700CC_BASE_INIT*
{
	//#UC START# *47B30CD40027_47B30CFF0271_47B3124700CC_BODY*
	//#UC END# *47B30CD40027_47B30CFF0271_47B3124700CC_BODY*
}

TipsManager_i::~TipsManager_i () {
	//#UC START# *47B3124700CC_DESTR_BODY*
	//#UC END# *47B3124700CC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void TipsManager_i::clear_cache () {
	//#UC START# *45702DA9037A_47B3124700CC*
	m_tips_exists = boost::indeterminate;
	//#UC END# *45702DA9037A_47B3124700CC*
}

// implemented method from TipsManager
// Получить текущий (по сценарию) Совет дня
NodeIndexPath* TipsManager_i::get_current_tip () const {
	//#UC START# *47B572E3010B_47B3124700CC*
	try {
		GblPilot::TipsTree_var server_tree = 
			ApplicationHelper::instance ()->get_cached_tree_factory ()->get_tips_tree ();
		::GTree::NodeIndexPath_var node_index_path =  server_tree->get_current_tip ();
		NodeIndexPath* ret = new NodeIndexPath ();
		ServerAdapterConverters::server_to_adapter (node_index_path.ptr (), *ret);
		return ret;
	} catch (...) {
	}
	return 0;
	//#UC END# *47B572E3010B_47B3124700CC*
}

// implemented method from TipsManager
bool TipsManager_i::is_exist () const {
	//#UC START# *47B93A910257_47B3124700CC*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_tips_exists)) {
		m_tips_exists = ApplicationHelper::instance ()->get_cached_search_manager ()->attribute_exists (GblPilotQueryDef::AT_TIPS);
	}
	return m_tips_exists;
	//#UC END# *47B93A910257_47B3124700CC*
}

// implemented method from TipsManager
// Рут дерева совет дня
const NodeBase* TipsManager_i::get_tips_tree_root () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *47B30D8F0330_47B3124700CC_GET*
	GTree::Tree_var server_tree = 
		ApplicationHelper::instance ()->get_cached_tree_factory ()->get_tips_tree ();
	Core::Var <TipsTree> tips_tree = new TipsTree (server_tree.in ());
	return dynamic_cast<NodeBase*> (tips_tree->root ());
	//#UC END# *47B30D8F0330_47B3124700CC_GET*
}

NodeBase* TipsManager_i::get_tips_tree_root ()
	/*throw (CanNotFindData)*/
{
	return const_cast<NodeBase*>(((const TipsManager_i*)this)->get_tips_tree_root ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

