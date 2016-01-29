////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDocument
//
// Перапарат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument.h"

namespace GblAdapterLib {

PharmDocument_factory::PharmDocument_factory () {
}

void PharmDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey PharmDocument_factory::key () const {
	return FK_PHARM_DOCUMENT;
}

Document* PharmDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019147EBBD0E00A2_460A76FD02B9_IMPL*
	return new PharmDocument (document);
	//#UC END# *45EEB652019147EBBD0E00A2_460A76FD02B9_IMPL*
}

Document* PharmDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019147EBBD0E00A2_4616303E031E_IMPL*
	return new PharmDocument (pid, name);
	//#UC END# *45EEB652019147EBBD0E00A2_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

