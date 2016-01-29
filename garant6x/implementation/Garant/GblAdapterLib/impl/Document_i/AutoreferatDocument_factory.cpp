////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument.h"

namespace GblAdapterLib {

AutoreferatDocument_factory* AutoreferatDocument_factory::s_instance = 0;

AutoreferatDocument_factory::AutoreferatDocument_factory () {
}

void AutoreferatDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const FactoryKey AutoreferatDocument_factory::key () const {
	return FK_AUTOREFERAT_DOCUMENT;
}

Document* AutoreferatDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914610D3060057_460A76FD02B9_IMPL*
	return new AutoreferatDocument (document);
	//#UC END# *45EEB65201914610D3060057_460A76FD02B9_IMPL*
}

Document* AutoreferatDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914610D3060057_4616303E031E_IMPL*
	GDS_ASSERT (false);
	return 0;	
	//#UC END# *45EEB65201914610D3060057_4616303E031E_IMPL*
}

AutoreferatDocument* AutoreferatDocumentServantFactory::make (GblPilot::Document* document) {
	if (AutoreferatDocument_factory::s_instance) {
		return dynamic_cast<AutoreferatDocument*>(AutoreferatDocument_factory::s_instance->make (document));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::AutoreferatDocument_factory");
	}
}

AutoreferatDocument* AutoreferatDocumentServantFactory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	if (AutoreferatDocument_factory::s_instance) {
		return dynamic_cast<AutoreferatDocument*>(AutoreferatDocument_factory::s_instance->make (pid, is_edition, name));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::AutoreferatDocument_factory");
	}
}

AutoreferatDocument* AutoreferatDocumentServantFactory::make_servant (GblPilot::Document* document) {
	//#UC START# *4610D30600574610D3060057_475D60C2036D_IMPL*
	return new AutoreferatDocument (document);
	//#UC END# *4610D30600574610D3060057_475D60C2036D_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

