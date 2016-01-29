////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TipDocument
//
// Документ Совета дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument.h"

namespace GblAdapterLib {

TipDocument_factory::TipDocument_factory () {
}

void TipDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey TipDocument_factory::key () const {
	return FK_TIP_DOCUMENT;
}

Document* TipDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019147BC15EC02BE_460A76FD02B9_IMPL*
	return new TipDocument (document);
	//#UC END# *45EEB652019147BC15EC02BE_460A76FD02B9_IMPL*
}

Document* TipDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019147BC15EC02BE_4616303E031E_IMPL*
	return new TipDocument (pid, name);
	//#UC END# *45EEB652019147BC15EC02BE_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

