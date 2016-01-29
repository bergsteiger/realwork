////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::GroupsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *49DF28BE03B4_CUSTOM_INCLUDES*
#include "garantServer/src/Services/GslUserManager/Server/GroupsTreeConst.h"
//#UC END# *49DF28BE03B4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *49DF28BE03B4*
//#UC END# *49DF28BE03B4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GroupsNode::GroupsNode (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *49DF2A270349_BASE_INIT*
: DefaultNodeBase (owner_tree), RealNodeBase (owner_tree, snode), NodeBase_i (owner_tree, snode)
//#UC END# *49DF2A270349_BASE_INIT*
{
	//#UC START# *49DF2A270349_BODY*
	//#UC END# *49DF2A270349_BODY*
}

GroupsNode::GroupsNode ()
//#UC START# *49DF2A6B030D_BASE_INIT*
//#UC END# *49DF2A6B030D_BASE_INIT*
{
	//#UC START# *49DF2A6B030D_BODY*
	//#UC END# *49DF2A6B030D_BODY*
}

GroupsNode::~GroupsNode () {
	//#UC START# *49DF28BE03B4_DESTR_BODY*
	//#UC END# *49DF28BE03B4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GroupNode
// есть ли в группе пользователи
bool GroupsNode::has_users () const /*throw (AccessDenied, CanNotFindData)*/ {
	//#UC START# *49EF2092024E_49DF28BE03B4*
	try {
		GCD::UidList_var users_list (ApplicationHelper::instance ()->get_cached_group_manager ()->get_users_for_group (this->get_uid ()));

		return users_list->length ();
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (GslUserManager::BadGUID&) {
		throw CanNotFindData ();
	} catch (GCD::StorageInternalError&) {
		GDS_ASSERT (false && "StorageInternalError");
		LOG_E (("%s: storage internal error", GDS_CURRENT_FUNCTION));

		return true;
	}

	GDS_ASSERT (false && "UNREACHABLE");
	return true;
	//#UC END# *49EF2092024E_49DF28BE03B4*
}

// implemented method from ProfileNode
Uid GroupsNode::get_uid () const {
	//#UC START# *465EC3DA036B_49DF28BE03B4*
	return this->get_node_id () - GslUserManagerServer::GROUPS_DELTA_BETWEEN_POINTER_AND_UID;
	//#UC END# *465EC3DA036B_49DF28BE03B4*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType GroupsNode::get_type () const {
	//#UC START# *45EEB9590224_49DF28BE03B4_GET*
	if (this->get_uid () == GCD::BaseUsersGroup) {
		return PNT_SYSTEM_FLAG;
	}

	return 0;
	//#UC END# *45EEB9590224_49DF28BE03B4_GET*
}

void GroupsNode::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_49DF28BE03B4_SET*
	GDS_ASSERT (false);
	throw ConstantModify ();
	//#UC END# *45EEB9590224_49DF28BE03B4_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

