////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryNodeAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.h"

namespace GblAdapterLib {

QueryNodeAttribute_i_factory* QueryNodeAttribute_i_factory::s_instance = 0;

QueryNodeAttribute_i_factory::QueryNodeAttribute_i_factory () {
}

void QueryNodeAttribute_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryNodeAttributeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* QueryNodeAttribute_i_factory::key () const {
	return "QueryNodeAttribute_i";
}

QueryNodeAttribute* QueryNodeAttribute_i_factory::make (AttributeTag_const attribute_tag) {
	QueryNodeAttribute_i_var ret = new QueryNodeAttribute_i (attribute_tag);
	return ret._retn ();
}

QueryNodeAttribute_i* QueryNodeAttribute_iServantFactory::make (AttributeTag_const attribute_tag) {
	if (QueryNodeAttribute_i_factory::s_instance) {
		return dynamic_cast<QueryNodeAttribute_i*>(QueryNodeAttribute_i_factory::s_instance->make (attribute_tag));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::QueryNodeAttribute_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

