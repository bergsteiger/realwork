////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Link_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i.h"

namespace GblAdapterLib {

Link_i_factory::Link_i_factory () {
}

void Link_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	LinkFactoryManager::register_factory (this, priority);
}

const char* Link_i_factory::key () const {
	return "Link_i";
}

Link* Link_i_factory::make (unsigned long doc_id, const Topic& topic, RedactionID redaction_id) {
	Link_i_var ret = new Link_i (doc_id, topic, redaction_id);
	return ret._retn ();
}

Link* Link_i_factory::make (
	const Document* document
	, unsigned long doc_id
	, const Topic& topic
	, RedactionID redaction_id
) {
	Link_i_var ret = new Link_i (document, doc_id, topic, redaction_id);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

