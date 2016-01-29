////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentState_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"

namespace GblAdapterLib {

DocumentState_i_factory* DocumentState_i_factory::s_instance = 0;

DocumentState_i_factory::DocumentState_i_factory () {
}

void DocumentState_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentStateFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DocumentState_i_factory::key () const {
	return "DocumentState_i";
}

DocumentState* DocumentState_i_factory::make (Document* source_doc) {
	DocumentState_i_var ret = new DocumentState_i (source_doc);
	return ret._retn ();
}

DocumentState* DocumentState_i_factory::make () {
	DocumentState_i_var ret = new DocumentState_i ();
	return ret._retn ();
}

DocumentState_i* DocumentState_iServantFactory::make (Document* source_doc) {
	if (DocumentState_i_factory::s_instance) {
		return dynamic_cast<DocumentState_i*>(DocumentState_i_factory::s_instance->make (source_doc));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DocumentState_i_factory");
	}
}

DocumentState_i* DocumentState_iServantFactory::make () {
	if (DocumentState_i_factory::s_instance) {
		return dynamic_cast<DocumentState_i*>(DocumentState_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DocumentState_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

