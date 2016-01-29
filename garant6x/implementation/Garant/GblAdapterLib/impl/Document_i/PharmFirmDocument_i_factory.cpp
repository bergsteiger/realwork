////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmFirmDocument_i
//
// Фирма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i.h"

namespace GblAdapterLib {

PharmFirmDocument_i_factory::PharmFirmDocument_i_factory () {
}

void PharmFirmDocument_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey PharmFirmDocument_i_factory::key () const {
	return FK_PHARM_FIRM_DOCUMENT;
}

Document* PharmFirmDocument_i_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019147EBB73000F1_460A76FD02B9_IMPL*
	return new PharmFirmDocument_i (document);
	//#UC END# *45EEB652019147EBB73000F1_460A76FD02B9_IMPL*
}

Document* PharmFirmDocument_i_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019147EBB73000F1_4616303E031E_IMPL*
	return new PharmFirmDocument_i (pid, name);
	//#UC END# *45EEB652019147EBB73000F1_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

