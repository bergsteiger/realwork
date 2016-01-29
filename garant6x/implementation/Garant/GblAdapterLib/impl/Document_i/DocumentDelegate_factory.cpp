////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.h"

namespace GblAdapterLib {

DocumentDelegate_factory* DocumentDelegate_factory::s_instance = 0;

DocumentDelegate_factory::DocumentDelegate_factory () {
}

void DocumentDelegate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const FactoryKey DocumentDelegate_factory::key () const {
	return FK_DOCUMENT_DELEGATE;
}

Document* DocumentDelegate_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB6520191460A602403B0_460A76FD02B9_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB6520191460A602403B0_460A76FD02B9_IMPL*
}

Document* DocumentDelegate_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB6520191460A602403B0_4616303E031E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB6520191460A602403B0_4616303E031E_IMPL*
}

DocumentDelegate* DocumentDelegateServantFactory::make (GblPilot::Document* document) {
	if (DocumentDelegate_factory::s_instance) {
		return dynamic_cast<DocumentDelegate*>(DocumentDelegate_factory::s_instance->make (document));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DocumentDelegate_factory");
	}
}

DocumentDelegate* DocumentDelegateServantFactory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	if (DocumentDelegate_factory::s_instance) {
		return dynamic_cast<DocumentDelegate*>(DocumentDelegate_factory::s_instance->make (pid, is_edition, name));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DocumentDelegate_factory");
	}
}

DocumentDelegate* DocumentDelegateServantFactory::make (DocumentMaster* master, DocumentState_i* new_state) {
	//#UC START# *460A602403B0460A602403B0_460D2463003F_IMPL*
	return new DocumentDelegate (master, new_state);
	//#UC END# *460A602403B0460A602403B0_460D2463003F_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

