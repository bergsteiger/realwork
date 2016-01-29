////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CountryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.h"

namespace GblAdapterLib {

CountryFilter_i_factory* CountryFilter_i_factory::s_instance = 0;

CountryFilter_i_factory::CountryFilter_i_factory () {
}

void CountryFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	CountryFilterFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* CountryFilter_i_factory::key () const {
	return "CountryFilter_i";
}

CountryFilter* CountryFilter_i_factory::make (const NodeBase* country) {
	CountryFilter_i_var ret = new CountryFilter_i (country);
	return ret._retn ();
}

CountryFilter* CountryFilter_i_factory::make () {
	CountryFilter_i_var ret = new CountryFilter_i ();
	return ret._retn ();
}

CountryFilter_i* CountryFilter_iServantFactory::make (const NodeBase* country) {
	if (CountryFilter_i_factory::s_instance) {
		return dynamic_cast<CountryFilter_i*>(CountryFilter_i_factory::s_instance->make (country));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::CountryFilter_i_factory");
	}
}

CountryFilter_i* CountryFilter_iServantFactory::make () {
	if (CountryFilter_i_factory::s_instance) {
		return dynamic_cast<CountryFilter_i*>(CountryFilter_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::CountryFilter_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

