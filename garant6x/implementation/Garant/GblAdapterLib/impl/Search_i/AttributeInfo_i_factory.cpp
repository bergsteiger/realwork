////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributeInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i.h"

namespace GblAdapterLib {

AttributeInfo_i_factory::AttributeInfo_i_factory () {
}

void AttributeInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AttributeInfoFactoryManager::register_factory (this, priority);
}

const char* AttributeInfo_i_factory::key () const {
	return "AttributeInfo_i";
}

AttributeInfo* AttributeInfo_i_factory::make (AttributeTag_const tag) {
	//#UC START# *45F115DD01E14601290C02F8_460128C701A1_IMPL*
	// std::map, std::string, ACE_Singleton должны вытянуться из std_inc.h
	typedef std::map<std::string, AttributeInfo_var> AttrInfoMap;
	typedef ACE_Singleton <AttrInfoMap, ACE_SYNCH_RECURSIVE_MUTEX> AttrInfoMapSingleton;

	AttrInfoMap::iterator f = AttrInfoMapSingleton::instance ()->find (tag);

	if (f == AttrInfoMapSingleton::instance ()->end()) {
		f = AttrInfoMapSingleton::instance ()->insert (AttrInfoMap::value_type(tag, new AttributeInfo_i(tag))).first;
	} else {
		dynamic_cast <AttributeInfo_i*> (f->second.in ())->check_update_and_clear_cache ();
		dynamic_cast <AttributeInfo_i*> (f->second.in ())->fill_attribute_info (tag);
	}
	return f->second._sretn();
	//#UC END# *45F115DD01E14601290C02F8_460128C701A1_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

