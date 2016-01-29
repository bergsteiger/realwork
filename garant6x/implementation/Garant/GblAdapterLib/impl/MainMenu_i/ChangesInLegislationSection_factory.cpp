////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::ChangesInLegislationSection
//
// Раздел Изменения в законодательстве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection.h"

namespace GblAdapterLib {

ChangesInLegislationSection_factory::ChangesInLegislationSection_factory () {
}

void ChangesInLegislationSection_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionFactoryManager::register_factory (this, priority);
}

const SectionType ChangesInLegislationSection_factory::key () const {
	return ST_CHANGES_IN_LEGISLATION;
}

Section* ChangesInLegislationSection_factory::make () {
	ChangesInLegislationSection_var ret = new ChangesInLegislationSection ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

