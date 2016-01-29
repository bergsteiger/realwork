////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ContextFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"

namespace GblAdapterLib {

ContextFilter_i_factory* ContextFilter_i_factory::s_instance = 0;

ContextFilter_i_factory::ContextFilter_i_factory () {
}

void ContextFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ContextFilterFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ContextFilter_i_factory::key () const {
	return "ContextFilter_i";
}

ContextFilter* ContextFilter_i_factory::make () {
	ContextFilter_i_var ret = new ContextFilter_i ();
	return ret._retn ();
}

ContextFilter_i* ContextFilter_iServantFactory::make () {
	if (ContextFilter_i_factory::s_instance) {
		return dynamic_cast<ContextFilter_i*>(ContextFilter_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::ContextFilter_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

