////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::FinanceSection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection.h"

namespace GblAdapterLib {

FinanceSection_factory::FinanceSection_factory () {
}

void FinanceSection_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionFactoryManager::register_factory (this, priority);
}

const SectionType FinanceSection_factory::key () const {
	return ST_FINANCE;
}

Section* FinanceSection_factory::make () {
	FinanceSection_var ret = new FinanceSection ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

