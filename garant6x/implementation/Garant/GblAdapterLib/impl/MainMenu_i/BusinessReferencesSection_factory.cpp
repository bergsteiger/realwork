////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::BusinessReferencesSection
//
// Раздел Бизнес-справки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection.h"

namespace GblAdapterLib {

BusinessReferencesSection_factory::BusinessReferencesSection_factory () {
}

void BusinessReferencesSection_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionFactoryManager::register_factory (this, priority);
}

const SectionType BusinessReferencesSection_factory::key () const {
	return ST_BUSINESS_REFERENCES;
}

Section* BusinessReferencesSection_factory::make () {
	BusinessReferencesSection_var ret = new BusinessReferencesSection ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

