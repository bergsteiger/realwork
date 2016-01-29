////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FlashDocument
//
// Документ-флеш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument.h"

namespace GblAdapterLib {

FlashDocument_factory::FlashDocument_factory () {
}

void FlashDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey FlashDocument_factory::key () const {
	return FK_FLASH_DOCUMENT;
}

Document* FlashDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914857C21E0230_460A76FD02B9_IMPL*
	return new FlashDocument (document);
	//#UC END# *45EEB65201914857C21E0230_460A76FD02B9_IMPL*
}

Document* FlashDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914857C21E0230_4616303E031E_IMPL*
	return new FlashDocument (pid, name);
	//#UC END# *45EEB65201914857C21E0230_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

