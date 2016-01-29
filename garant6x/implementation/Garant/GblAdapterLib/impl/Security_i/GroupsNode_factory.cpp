////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::GroupsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"

namespace GblAdapterLib {

GroupsNode_factory* GroupsNode_factory::s_instance = 0;

GroupsNode_factory::GroupsNode_factory () {
}

void GroupsNode_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GroupNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* GroupsNode_factory::key () const {
	return "GroupsNode";
}

// фабрика
GroupNode* GroupsNode_factory::make () {
	//#UC START# *49EF204201EB49DF28BE03B4_49EF20EE0123_IMPL*
	GroupsNode_var ret = new GroupsNode ();
	return ret._retn ();
	//#UC END# *49EF204201EB49DF28BE03B4_49EF20EE0123_IMPL*
}

GroupsNode* GroupsNodeServantFactory::make () {
	if (GroupsNode_factory::s_instance) {
		return dynamic_cast<GroupsNode*>(GroupsNode_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Security_i::GroupsNode_factory");
	}
}

GroupsNode* GroupsNodeServantFactory::make (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *49DF28BE03B449DF28BE03B4_49DF2A270349_IMPL*
	return new GroupsNode (owner_tree, snode);
	//#UC END# *49DF28BE03B449DF28BE03B4_49DF2A270349_IMPL*
}

GroupsNode* GroupsNodeServantFactory::servant_make () {
	//#UC START# *49DF28BE03B449DF28BE03B4_49DF2A6B030D_IMPL*
	return new GroupsNode ();
	//#UC END# *49DF28BE03B449DF28BE03B4_49DF2A6B030D_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

