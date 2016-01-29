////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"

namespace GblAdapterLib {

JournalNode_factory* JournalNode_factory::s_instance = 0;

JournalNode_factory::JournalNode_factory () {
}

void JournalNode_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* JournalNode_factory::key () const {
	return "JournalNode";
}

NodeBase* JournalNode_factory::make () /*throw (CanNotFindData)*/ {
	JournalNode_var ret = new JournalNode ();
	return ret._retn ();
}

NodeBase* JournalNode_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	JournalNode_var ret = new JournalNode (owner_tree, snode);
	return ret._retn ();
}

JournalNode* JournalNodeServantFactory::make () /*throw (CanNotFindData)*/ {
	if (JournalNode_factory::s_instance) {
		return dynamic_cast<JournalNode*>(JournalNode_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::UserJournal_i::JournalNode_factory");
	}
}

JournalNode* JournalNodeServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (JournalNode_factory::s_instance) {
		return dynamic_cast<JournalNode*>(JournalNode_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::UserJournal_i::JournalNode_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

