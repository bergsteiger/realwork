////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BudgetOrgsSection_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::BudgetOrgsSection
//
// Раздел для бюджетных организаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BudgetOrgsSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BudgetOrgsSection.h"

namespace GblAdapterLib {

BudgetOrgsSection_factory::BudgetOrgsSection_factory () {
}

void BudgetOrgsSection_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SectionFactoryManager::register_factory (this, priority);
}

const SectionType BudgetOrgsSection_factory::key () const {
	return ST_BUDGET_ORGS;
}

Section* BudgetOrgsSection_factory::make () {
	BudgetOrgsSection_var ret = new BudgetOrgsSection ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

