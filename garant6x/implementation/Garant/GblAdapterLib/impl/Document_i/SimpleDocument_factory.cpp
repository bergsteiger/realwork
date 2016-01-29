////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::SimpleDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

SimpleDocument_factory::SimpleDocument_factory () {
}

void SimpleDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey SimpleDocument_factory::key () const {
	return FK_SIMPLE_DOCUMENT;
}

Document* SimpleDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914610CF5501E6_460A76FD02B9_IMPL*
	return new SimpleDocument (document);
	//#UC END# *45EEB65201914610CF5501E6_460A76FD02B9_IMPL*
}

Document* SimpleDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914610CF5501E6_4616303E031E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB65201914610CF5501E6_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

