////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithCachedData
//
// Провайдер кеширует стиль и текст на адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"

namespace GblAdapterLib {

DTPWithCachedData_factory* DTPWithCachedData_factory::s_instance = 0;

DTPWithCachedData_factory::DTPWithCachedData_factory () {
}

void DTPWithCachedData_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentTextProviderFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DTPWithCachedData_factory::key () const {
	return "DTPWithCachedData";
}

DocumentTextProvider* DTPWithCachedData_factory::make (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) {
	DTPWithCachedData_var ret = new DTPWithCachedData (server_doc, handle, all_at_once);
	return ret._retn ();
}

DocumentTextProvider* DTPWithCachedData_factory::make (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) {
	DTPWithCachedData_var ret = new DTPWithCachedData (server_doc, handle, all_at_once);
	return ret._retn ();
}

DTPWithCachedData* DTPWithCachedDataServantFactory::make (GblPilot::Document* server_doc, const GblPilot::HighlightHandle& handle, bool all_at_once) {
	if (DTPWithCachedData_factory::s_instance) {
		return dynamic_cast<DTPWithCachedData*>(DTPWithCachedData_factory::s_instance->make (server_doc, handle, all_at_once));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DTPWithCachedData_factory");
	}
}

DTPWithCachedData* DTPWithCachedDataServantFactory::make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once) {
	if (DTPWithCachedData_factory::s_instance) {
		return dynamic_cast<DTPWithCachedData*>(DTPWithCachedData_factory::s_instance->make (server_doc, handle, all_at_once));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Document_i::DTPWithCachedData_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

