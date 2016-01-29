////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"

namespace GblAdapterLib {

NodeIterator_i_factory* NodeIterator_i_factory::s_instance = 0;

NodeIterator_i_factory::NodeIterator_i_factory () {
}

void NodeIterator_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeIteratorFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* NodeIterator_i_factory::key () const {
	return "NodeIterator_i";
}

NodeIterator* NodeIterator_i_factory::make () {
	//#UC START# *45EEC8A6033C45F7BD35005D_473DCB1102C4_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEC8A6033C45F7BD35005D_473DCB1102C4_IMPL*
}

NodeIterator_i* NodeIterator_iServantFactory::make () {
	if (NodeIterator_i_factory::s_instance) {
		return dynamic_cast<NodeIterator_i*>(NodeIterator_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::NodeIterator_i_factory");
	}
}

NodeIterator_i* NodeIterator_iServantFactory::make (DefaultNodeBase* from_node, FlagMask with_flag) {
	//#UC START# *45F7BD35005D45F7BD35005D_4625D990000F_IMPL*
	NodeIterator_i_var ret = new NodeIterator_i (from_node, with_flag);
	return ret._retn ();
	//#UC END# *45F7BD35005D45F7BD35005D_4625D990000F_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

