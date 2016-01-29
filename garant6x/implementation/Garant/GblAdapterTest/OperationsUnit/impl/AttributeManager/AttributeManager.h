////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/AttributeManager/AttributeManager.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::AttributeManager::AttributeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_ATTRIBUTEMANAGER_ATTRIBUTEMANAGER_H__
#define __GARANT6X_OPERATIONSUNIT_ATTRIBUTEMANAGER_ATTRIBUTEMANAGER_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfaces.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2F8C0251_CUSTOM_INCLUDES*
#include <string>
#include <map>
//#UC END# *445B2F8C0251_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace AttributeManager {

class AttributeManager; // self forward Var
typedef ::Core::Var<AttributeManager> AttributeManager_var;

class AttributeManager:
	virtual public OperationInterfaces::IAttributeManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AttributeManager)
	friend class OperationInterfaces::IAttributeManagerFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	
	AttributeManager ();
	virtual ~AttributeManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from IAttributeManager
	virtual void add_string (const char* key, const char* value);

	// implemented method from IAttributeManager
	virtual bool get_bool (const char* key, bool default_value = false);

	// implemented method from IAttributeManager
	virtual long get_long (const char* key, long default_value = 0);

	// implemented method from IAttributeManager
	virtual char* get_string (const char* key, const char* default_value = "");

	// implemented method from IAttributeManager
	virtual bool is_exist (const char* key);

//#UC START# *445B2F8C0251*
protected:
	typedef std::map<std::string, std::string> AttributesMap;
	AttributesMap m_values_map;
//#UC END# *445B2F8C0251*
}; // class AttributeManager

} // namespace AttributeManager
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_ATTRIBUTEMANAGER_ATTRIBUTEMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////