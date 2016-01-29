////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"

namespace GblAdapterLib {

DynList_i_factory* DynList_i_factory::s_instance = 0;

DynList_i_factory::DynList_i_factory () {
}

void DynList_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DynListFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* DynList_i_factory::key () const {
	return "DynList_i";
}

DynList* DynList_i_factory::make (GblDocList::DocListTree* server_list) {
	DynList_i_var ret = new DynList_i (server_list);
	return ret._retn ();
}

DynList* DynList_i_factory::make (
	GblPilot::LegalDocument* legal_document
	, const GblPilotQueryDef::Query& query
	, DynListType type
) {
	DynList_i_var ret = new DynList_i (legal_document, query, type);
	return ret._retn ();
}

DynList* DynList_i_factory::make (SpecialListKey key) {
	DynList_i_var ret = new DynList_i (key);
	return ret._retn ();
}

DynList_i* DynList_iServantFactory::make (GblDocList::DocListTree* server_list) {
	if (DynList_i_factory::s_instance) {
		return dynamic_cast<DynList_i*>(DynList_i_factory::s_instance->make (server_list));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::DynList_i_factory");
	}
}

DynList_i* DynList_iServantFactory::make (GblPilot::LegalDocument* legal_document, const GblPilotQueryDef::Query& query, DynListType type) {
	if (DynList_i_factory::s_instance) {
		return dynamic_cast<DynList_i*>(DynList_i_factory::s_instance->make (legal_document, query, type));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::DynList_i_factory");
	}
}

DynList_i* DynList_iServantFactory::make (SpecialListKey key) {
	if (DynList_i_factory::s_instance) {
		return dynamic_cast<DynList_i*>(DynList_i_factory::s_instance->make (key));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::DynList_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

