////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryContextAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.h"

namespace GblAdapterLib {

QueryContextAttribute_i_factory* QueryContextAttribute_i_factory::s_instance = 0;

QueryContextAttribute_i_factory::QueryContextAttribute_i_factory () {
}

void QueryContextAttribute_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryContextAttributeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* QueryContextAttribute_i_factory::key () const {
	return "QueryContextAttribute_i";
}

QueryContextAttribute* QueryContextAttribute_i_factory::make (AttributeTag_const attribute_tag) {
	QueryContextAttribute_i_var ret = new QueryContextAttribute_i (attribute_tag);
	return ret._retn ();
}

QueryContextAttribute_i* QueryContextAttribute_iServantFactory::make (AttributeTag_const attribute_tag) {
	if (QueryContextAttribute_i_factory::s_instance) {
		return dynamic_cast<QueryContextAttribute_i*>(QueryContextAttribute_i_factory::s_instance->make (attribute_tag));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::QueryContextAttribute_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

