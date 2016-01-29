////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/AttributeManager/AttributeManager.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::AttributeManager::AttributeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/AttributeManager/AttributeManager.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2F8C0251_CUSTOM_INCLUDES*
//#UC END# *445B2F8C0251_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace AttributeManager {

//#UC START# *445B2F8C0251*
//#UC END# *445B2F8C0251*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AttributeManager::AttributeManager ()
//#UC START# *445B2F8C0251_BASE_INIT*
//#UC END# *445B2F8C0251_BASE_INIT*
{
	//#UC START# *445B2F8C0251_BODY*
	m_values_map.clear ();
	//#UC END# *445B2F8C0251_BODY*
}



AttributeManager::~AttributeManager () {
	//#UC START# *445B2F8C0251_DESTR_BODY*
	//#UC END# *445B2F8C0251_DESTR_BODY*
}	


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IAttributeManager
void AttributeManager::add_string (const char* key, const char* value) {
	//#UC START# *4461D0F601B5_445B2F8C0251*
	m_values_map.insert (AttributesMap::value_type (key, value));
	//#UC END# *4461D0F601B5_445B2F8C0251*
}

// implemented method from IAttributeManager
bool AttributeManager::get_bool (const char* key, bool default_value) {
	//#UC START# *445B2F0C00FA_445B2F8C0251*
	std::string s = this->get_string (key, "");
	if (true == s.empty ()) {
		return default_value;
	}

	if (stricmp ("true", s.c_str ()) == 0) {
		return true;
	} else if (stricmp ("false", s.c_str ()) == 0) {
		return false;
	}

	return false;
	//#UC END# *445B2F0C00FA_445B2F8C0251*
}

// implemented method from IAttributeManager
long AttributeManager::get_long (const char* key, long default_value) {
	//#UC START# *445B2EA303A9_445B2F8C0251*
	std::string s = this->get_string (key, "");
	if (true == s.empty ()) {
		return default_value;
	}
	return atol (s.c_str ());
	//#UC END# *445B2EA303A9_445B2F8C0251*
}

// implemented method from IAttributeManager
char* AttributeManager::get_string (const char* key, const char* default_value) {
	//#UC START# *445B2E5F02DE_445B2F8C0251*
	AttributesMap::iterator it = m_values_map.find (key);
	if (m_values_map.end () == it) {
		return default_value;
	}
	return it->second.c_str ();
	//#UC END# *445B2E5F02DE_445B2F8C0251*
}

// implemented method from IAttributeManager
bool AttributeManager::is_exist (const char* key) {
	//#UC START# *445B2F3602DE_445B2F8C0251*
	return (m_values_map.end () != m_values_map.find (key));
	//#UC END# *445B2F3602DE_445B2F8C0251*
}
} // namespace AttributeManager
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////