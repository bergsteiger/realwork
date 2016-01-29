////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::LawForAllSection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection.h"

namespace GblAdapterLib {

LawForAllSection_factory::LawForAllSection_factory () {
}

void LawForAllSection_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionFactoryManager::register_factory (this, priority);
}

const SectionType LawForAllSection_factory::key () const {
	return ST_LAW_FOR_ALL;
}

Section* LawForAllSection_factory::make () {
	LawForAllSection_var ret = new LawForAllSection ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

