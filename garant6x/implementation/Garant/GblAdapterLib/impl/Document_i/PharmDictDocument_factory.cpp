////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmDictDocument
//
// Документ толкование медицинского толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument.h"

namespace GblAdapterLib {

PharmDictDocument_factory::PharmDictDocument_factory () {
}

void PharmDictDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey PharmDictDocument_factory::key () const {
	return FK_PHARM_DICT_DOCUMENT;
}

Document* PharmDictDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019147EBBA510379_460A76FD02B9_IMPL*
	return new PharmDictDocument (document);
	//#UC END# *45EEB652019147EBBA510379_460A76FD02B9_IMPL*
}

Document* PharmDictDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019147EBBA510379_4616303E031E_IMPL*
	return new PharmDictDocument (pid, name);
	//#UC END# *45EEB652019147EBBA510379_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

