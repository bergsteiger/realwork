////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryPhoneNumberAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.h"

namespace GblAdapterLib {

QueryPhoneNumberAttribute_i_factory* QueryPhoneNumberAttribute_i_factory::s_instance = 0;

QueryPhoneNumberAttribute_i_factory::QueryPhoneNumberAttribute_i_factory () {
}

void QueryPhoneNumberAttribute_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	QueryPhoneNumberAttributeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* QueryPhoneNumberAttribute_i_factory::key () const {
	return "QueryPhoneNumberAttribute_i";
}

QueryPhoneNumberAttribute* QueryPhoneNumberAttribute_i_factory::make (AttributeTag_const attribute_tag) {
	QueryPhoneNumberAttribute_i_var ret = new QueryPhoneNumberAttribute_i (attribute_tag);
	return ret._retn ();
}

QueryPhoneNumberAttribute_i* QueryPhoneNumberAttribute_iServantFactory::make (AttributeTag_const attribute_tag) {
	if (QueryPhoneNumberAttribute_i_factory::s_instance) {
		return dynamic_cast<QueryPhoneNumberAttribute_i*>(QueryPhoneNumberAttribute_i_factory::s_instance->make (attribute_tag));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search_i::QueryPhoneNumberAttribute_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

