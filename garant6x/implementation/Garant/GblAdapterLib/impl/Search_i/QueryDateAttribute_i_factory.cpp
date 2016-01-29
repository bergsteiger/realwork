////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryDateAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.h"

namespace GblAdapterLib {

QueryDateAttribute_i_factory* QueryDateAttribute_i_factory::s_instance = 0;

QueryDateAttribute_i_factory::QueryDateAttribute_i_factory () {
}

void QueryDateAttribute_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryDateAttributeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* QueryDateAttribute_i_factory::key () const {
	return "QueryDateAttribute_i";
}

QueryDateAttribute* QueryDateAttribute_i_factory::make (AttributeTag_const attribute_tag) {
	QueryDateAttribute_i_var ret = new QueryDateAttribute_i (attribute_tag);
	return ret._retn ();
}

QueryDateAttribute_i* QueryDateAttribute_iServantFactory::make (AttributeTag_const attribute_tag) {
	if (QueryDateAttribute_i_factory::s_instance) {
		return dynamic_cast<QueryDateAttribute_i*>(QueryDateAttribute_i_factory::s_instance->make (attribute_tag));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::QueryDateAttribute_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

