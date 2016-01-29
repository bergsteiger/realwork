////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsDocument
//
// ААК
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument.h"

namespace GblAdapterLib {

ActualAnalyticsDocument_factory::ActualAnalyticsDocument_factory () {
}

void ActualAnalyticsDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey ActualAnalyticsDocument_factory::key () const {
	return FK_ACTUAL_ANALYTICS_DOCUMENT;
}

Document* ActualAnalyticsDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914FE8620402D3_460A76FD02B9_IMPL*
	return new ActualAnalyticsDocument (document);
	//#UC END# *45EEB65201914FE8620402D3_460A76FD02B9_IMPL*
}

Document* ActualAnalyticsDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914FE8620402D3_4616303E031E_IMPL*
	return new ActualAnalyticsDocument (pid, name);
	//#UC END# *45EEB65201914FE8620402D3_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

