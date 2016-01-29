////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodesClipboard_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"

namespace GblAdapterLib {

NodesClipboard_i_factory* NodesClipboard_i_factory::s_instance = 0;

NodesClipboard_i_factory::NodesClipboard_i_factory () {
}

void NodesClipboard_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodesClipboardFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* NodesClipboard_i_factory::key () const {
	return "NodesClipboard_i";
}

NodesClipboard* NodesClipboard_i_factory::make () {
	NodesClipboard_i_var ret = new NodesClipboard_i ();
	return ret._retn ();
}

NodesClipboard* NodesClipboard_i_factory::make (GTree::NodeHolder* node_holder) {
	NodesClipboard_i_var ret = new NodesClipboard_i (node_holder);
	return ret._retn ();
}

NodesClipboard_i* NodesClipboard_iServantFactory::make () {
	if (NodesClipboard_i_factory::s_instance) {
		return dynamic_cast<NodesClipboard_i*>(NodesClipboard_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::NodesClipboard_i_factory");
	}
}

NodesClipboard_i* NodesClipboard_iServantFactory::make (GTree::NodeHolder* node_holder) {
	if (NodesClipboard_i_factory::s_instance) {
		return dynamic_cast<NodesClipboard_i*>(NodesClipboard_i_factory::s_instance->make (node_holder));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::NodesClipboard_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

