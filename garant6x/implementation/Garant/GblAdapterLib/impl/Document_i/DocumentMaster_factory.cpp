////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentMaster
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"
//#UC START# *460A604B02E4CUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
//#UC END# *460A604B02E4CUSTOM_INLUDE*

namespace GblAdapterLib {

DocumentMaster_factory::DocumentMaster_factory () {
}

void DocumentMaster_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey DocumentMaster_factory::key () const {
	return FK_DOCUMENT_MASTER;
}

Document* DocumentMaster_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB6520191460A604B02E4_460A76FD02B9_IMPL*
	return new DocumentMaster (document);
	//#UC END# *45EEB6520191460A604B02E4_460A76FD02B9_IMPL*
}

Document* DocumentMaster_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB6520191460A604B02E4_4616303E031E_IMPL*
	//find in AOM by PID
	Document_i::AOM::const_iterator f = Document_i::get_aom ().find (pid.m_object_id);
	if (f != Document_i::get_aom ().end ()) {
		return Document::_duplicate(f->second);
	}
	Document_var ret;
	if (is_edition) {
		GblPilot::Document_var server_original_document;
		try {
			 server_original_document = 
				ApplicationHelper::instance ()->get_cached_function_manager ()->get_original_document (pid); // LifeCycle::duplicate_object (GblPilot::LegalDocument)
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		}
		
		// create master document, then create view to edition
		Document_var adapter_original_document = new DocumentMaster (server_original_document.in ());

		DocumentState_cvar state = adapter_original_document->get_current_state ();
		state->set_redaction_on_id (pid.m_object_id);
		ret = adapter_original_document->create_view (const_cast<DocumentState*> (state.in ()));
		if (ret.is_nil ()) {                         // no view - return master document
			return adapter_original_document._retn (); // ATTENTION!!! DO NOT PUT this 'no view' in AOM, see [$145098118]
		}
	} else {
		// create new master doc
		ret = new DocumentMaster (pid, name);
	}
	// save doc (or view) in AOM
	// no copy - need do be removed from AOM in destructor (DocumentMaster or DocumentDeleagte)
	const_cast<Document_i::AOM&> (Document_i::get_aom ()).insert (Document_i::AOM::value_type (pid.m_object_id, ret.ptr ()));
	return ret._retn();			
	//#UC END# *45EEB6520191460A604B02E4_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

