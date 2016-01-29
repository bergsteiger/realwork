////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UsersTree.h"

//#UC START# *49E46F4802D4_CUSTOM_INCLUDES*
//#UC END# *49E46F4802D4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *49E46F4802D4*
NodeType UserNode_i::create_type_by_flags (GslUserManager::UserFlag flags) {
	NodeType type = 0;

	type |= (flags & GslUserManager::UF_ACTIVE_FLAG) ? PNT_LOGGED_FLAG : 0;
	type |= (flags & GslUserManager::UF_SYSTEM_FLAG) ? PNT_SYSTEM_FLAG : 0;
	type |= (flags & GslUserManager::UF_WAIT_EXIT_FLAG) ? PNT_EXIT_FLAG : 0;
	type |= (flags & GslUserManager::UF_PERSISTENT_FLAG) ? PNT_PRIVILEGED_FLAG : 0;

	return type;
}
//#UC END# *49E46F4802D4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserNode_i::UserNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *49E470470021_BASE_INIT*
: DefaultNodeBase (owner_tree), RealNodeBase (owner_tree, snode), NodeBase_i (owner_tree, snode)
//#UC END# *49E470470021_BASE_INIT*
{
	//#UC START# *49E470470021_BODY*
	if (snode.value.in ()) {
		GslUserManager::UserNodeValue* node_value = GslUserManager::UserNodeValue::_downcast (snode.value.in ());
		GDS_ASSERT (node_value);
		m_type = UserNode_i::create_type_by_flags (node_value->flags ());
	}
	//#UC END# *49E470470021_BODY*
}

UserNode_i::UserNode_i ()
//#UC START# *49E470640058_BASE_INIT*
//#UC END# *49E470640058_BASE_INIT*
{
	//#UC START# *49E470640058_BODY*
	GDS_ASSERT (false);
	//#UC END# *49E470640058_BODY*
}

UserNode_i::~UserNode_i () {
	//#UC START# *49E46F4802D4_DESTR_BODY*
	//#UC END# *49E46F4802D4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ProfileNode
Uid UserNode_i::get_uid () const {
	//#UC START# *465EC3DA036B_49E46F4802D4*
	return this->get_node_id ();
	//#UC END# *465EC3DA036B_49E46F4802D4*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* UserNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_49E46F4802D4_GET*
	try {
		GTree::NodeEntity_var server_entity;
		{
			CHECK_AND_LOCK_TREE (return 0;) // это нужно здесь, иначе будет deadlock (см. CQ20480)
				server_entity = this->entity ();
		}

		GslUserManager::UserProfileInfo* info;
		if (*server_entity >>= info) {
			UserProfile_var user_profile = UserProfileFactory::make (
				info->m_uid
				, info->m_login.in ()
				, info->m_name.in ()
				, info->m_mail.in ()
				, info->m_system
				, info->m_has_password
				, info->m_can_buy_consulting
				, info->m_permanent
			);

			UserProfile* changeable = dynamic_cast<UserProfile*> (user_profile.ptr ());
			UsersTree* users_tree = const_cast<UsersTree*> (dynamic_cast<const UsersTree*> (this->owner_tree ()));
			if (changeable && users_tree) {
				users_tree->register_listener (changeable);
			} else {
				LOG_D (("%s: can't register active changeable UserProfile.", GDS_CURRENT_FUNCTION));
			}
			return Core::IObject::_duplicate (user_profile.in ());
		}
	} catch (GTree::InvalidPointer&) {
		LOG_D (("%s: Can't find node entity - may be it's group", GDS_CURRENT_FUNCTION));
		return 0;
	}

	GDS_ASSERT (false); // not reachable
	return 0;
	//#UC END# *45F65BEA00DA_49E46F4802D4_GET*
}

EntityBase* UserNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const UserNode_i*)this)->get_entity ());
}

void UserNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_49E46F4802D4_SET*
	GDS_ASSERT (false);
	throw ConstantModify ();
	//#UC END# *45F65BEA00DA_49E46F4802D4_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType UserNode_i::get_type () const {
	//#UC START# *45EEB9590224_49E46F4802D4_GET*
	return m_type;
	//#UC END# *45EEB9590224_49E46F4802D4_GET*
}

void UserNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_49E46F4802D4_SET*
	GDS_ASSERT (false);
	throw ConstantModify ();
	//#UC END# *45EEB9590224_49E46F4802D4_SET*
}

// overloaded method from RealNodeBase
void UserNode_i::change_node_value (const GTree::NodeValueData& value) {
	//#UC START# *45FFE2BC03A9_49E46F4802D4*
	GslUserManager::UserNodeValue* node_value = 0;
	if (value >>= node_value) {
		m_type = UserNode_i::create_type_by_flags (node_value->flags ());
	}
	//#UC END# *45FFE2BC03A9_49E46F4802D4*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

