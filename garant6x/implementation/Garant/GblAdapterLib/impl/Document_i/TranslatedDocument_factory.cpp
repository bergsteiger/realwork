////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::TranslatedDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.h"

namespace GblAdapterLib {

TranslatedDocument_factory* TranslatedDocument_factory::s_instance = 0;

TranslatedDocument_factory::TranslatedDocument_factory () {
}

void TranslatedDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const FactoryKey TranslatedDocument_factory::key () const {
	return FK_TRANSLATED_DOCUMENT;
}

Document* TranslatedDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914610D2060105_460A76FD02B9_IMPL*
	return new TranslatedDocument (document);
	//#UC END# *45EEB65201914610D2060105_460A76FD02B9_IMPL*
}

Document* TranslatedDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914610D2060105_4616303E031E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB65201914610D2060105_4616303E031E_IMPL*
}

TranslatedDocument* TranslatedDocumentServantFactory::make (GblPilot::Document* document) {
	if (TranslatedDocument_factory::s_instance) {
		return dynamic_cast<TranslatedDocument*>(TranslatedDocument_factory::s_instance->make (document));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::TranslatedDocument_factory");
	}
}

TranslatedDocument* TranslatedDocumentServantFactory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	if (TranslatedDocument_factory::s_instance) {
		return dynamic_cast<TranslatedDocument*>(TranslatedDocument_factory::s_instance->make (pid, is_edition, name));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::TranslatedDocument_factory");
	}
}

TranslatedDocument* TranslatedDocumentServantFactory::make_servant (GblPilot::Document* document) {
	//#UC START# *4610D20601054610D2060105_4610D40C010F_IMPL*
	return new TranslatedDocument (document);
	//#UC END# *4610D20601054610D2060105_4610D40C010F_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

