////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentTextProvider_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.h"

namespace GblAdapterLib {

DocumentTextProvider_i_factory::DocumentTextProvider_i_factory () {
}

void DocumentTextProvider_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentTextProviderFactoryManager::register_factory (this, priority);
}

const char* DocumentTextProvider_i_factory::key () const {
	return "DocumentTextProvider_i";
}

DocumentTextProvider* DocumentTextProvider_i_factory::make (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) {
	DocumentTextProvider_i_var ret = new DocumentTextProvider_i (server_doc, handle, all_at_once);
	return ret._retn ();
}

DocumentTextProvider* DocumentTextProvider_i_factory::make (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) {
	DocumentTextProvider_i_var ret = new DocumentTextProvider_i (server_doc, handle, all_at_once);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

