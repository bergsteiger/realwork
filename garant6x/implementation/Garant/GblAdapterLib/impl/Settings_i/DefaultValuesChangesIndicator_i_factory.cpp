////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::DefaultValuesChangesIndicator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.h"

namespace GblAdapterLib {

DefaultValuesChangesIndicator_i_factory* DefaultValuesChangesIndicator_i_factory::s_instance = 0;

DefaultValuesChangesIndicator_i_factory::DefaultValuesChangesIndicator_i_factory () {
}

void DefaultValuesChangesIndicator_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DefaultValuesChangesIndicatorFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DefaultValuesChangesIndicator_i_factory::key () const {
	return "DefaultValuesChangesIndicator_i";
}

DefaultValuesChangesIndicator* DefaultValuesChangesIndicator_i_factory::make (
	DefaultValuesChangesState state
	, const Configuration* configuration
) {
	DefaultValuesChangesIndicator_i_var ret = new DefaultValuesChangesIndicator_i (state, configuration);
	return ret._retn ();
}

DefaultValuesChangesIndicator_i* DefaultValuesChangesIndicator_iServantFactory::make (DefaultValuesChangesState state, const Configuration* configuration) {
	if (DefaultValuesChangesIndicator_i_factory::s_instance) {
		return dynamic_cast<DefaultValuesChangesIndicator_i*>(DefaultValuesChangesIndicator_i_factory::s_instance->make (state, configuration));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings_i::DefaultValuesChangesIndicator_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

