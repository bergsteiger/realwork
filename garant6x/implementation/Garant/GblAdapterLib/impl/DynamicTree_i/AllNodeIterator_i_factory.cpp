////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::AllNodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"

namespace GblAdapterLib {

AllNodeIterator_i_factory* AllNodeIterator_i_factory::s_instance = 0;

AllNodeIterator_i_factory::AllNodeIterator_i_factory () {
}

void AllNodeIterator_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeIteratorFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* AllNodeIterator_i_factory::key () const {
	return "AllNodeIterator_i";
}

NodeIterator* AllNodeIterator_i_factory::make () {
	//#UC START# *45EEC8A6033C473D8B540129_473DCB1102C4_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEC8A6033C473D8B540129_473DCB1102C4_IMPL*
}

AllNodeIterator_i* AllNodeIterator_iServantFactory::make () {
	if (AllNodeIterator_i_factory::s_instance) {
		return dynamic_cast<AllNodeIterator_i*>(AllNodeIterator_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::AllNodeIterator_i_factory");
	}
}

AllNodeIterator_i* AllNodeIterator_iServantFactory::make (DefaultNodeBase* from_node, FlagMask with_flag) {
	//#UC START# *473D8B540129473D8B540129_473D8EEC010F_IMPL*
	return new AllNodeIterator_i (from_node, with_flag);
	//#UC END# *473D8B540129473D8B540129_473D8EEC010F_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

