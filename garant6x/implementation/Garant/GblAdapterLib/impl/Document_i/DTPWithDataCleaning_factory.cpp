////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithDataCleaning
//
// провайдер очищает данные о стиле и тексте после того, как прокидывает их оболочке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning.h"

namespace GblAdapterLib {

DTPWithDataCleaning_factory::DTPWithDataCleaning_factory () {
}

void DTPWithDataCleaning_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentTextProviderFactoryManager::register_factory (this, priority);
}

const char* DTPWithDataCleaning_factory::key () const {
	return "DTPWithDataCleaning";
}

DocumentTextProvider* DTPWithDataCleaning_factory::make (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) {
	DTPWithDataCleaning_var ret = new DTPWithDataCleaning (server_doc, handle, all_at_once);
	return ret._retn ();
}

DocumentTextProvider* DTPWithDataCleaning_factory::make (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) {
	DTPWithDataCleaning_var ret = new DTPWithDataCleaning (server_doc, handle, all_at_once);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

