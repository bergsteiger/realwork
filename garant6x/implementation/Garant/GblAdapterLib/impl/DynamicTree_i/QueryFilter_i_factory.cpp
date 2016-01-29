////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::QueryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.h"

namespace GblAdapterLib {

QueryFilter_i_factory* QueryFilter_i_factory::s_instance = 0;

QueryFilter_i_factory::QueryFilter_i_factory () {
}

void QueryFilter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryFilterFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* QueryFilter_i_factory::key () const {
	return "QueryFilter_i";
}

QueryFilter* QueryFilter_i_factory::make (FilterFromQuery* data) {
	QueryFilter_i_var ret = new QueryFilter_i (data);
	return ret._retn ();
}

QueryFilter* QueryFilter_i_factory::make (FiltersFromQuery& data) {
	QueryFilter_i_var ret = new QueryFilter_i (data);
	return ret._retn ();
}

QueryFilter* QueryFilter_i_factory::make () {
	QueryFilter_i_var ret = new QueryFilter_i ();
	return ret._retn ();
}

QueryFilter_i* QueryFilter_iServantFactory::make (FilterFromQuery* data) {
	if (QueryFilter_i_factory::s_instance) {
		return dynamic_cast<QueryFilter_i*>(QueryFilter_i_factory::s_instance->make (data));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::QueryFilter_i_factory");
	}
}

QueryFilter_i* QueryFilter_iServantFactory::make (FiltersFromQuery& data) {
	if (QueryFilter_i_factory::s_instance) {
		return dynamic_cast<QueryFilter_i*>(QueryFilter_i_factory::s_instance->make (data));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::QueryFilter_i_factory");
	}
}

QueryFilter_i* QueryFilter_iServantFactory::make () {
	if (QueryFilter_i_factory::s_instance) {
		return dynamic_cast<QueryFilter_i*>(QueryFilter_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::QueryFilter_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

