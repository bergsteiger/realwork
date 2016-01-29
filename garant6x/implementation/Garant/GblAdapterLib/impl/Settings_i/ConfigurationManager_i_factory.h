////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::ConfigurationManager_i
// Заголовк реализации фабрик интерфеса ConfigurationManager для серванта ConfigurationManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"

/// Servant-factory implementation for ConfigurationManager_i
namespace GblAdapterLib {
	class Configuration_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class SettingsManager_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ConfigurationManager_iServantFactory {
	friend class Configuration_i;
	friend class SettingsManager_i;

	static ConfigurationManager_i* make ();
};

/// Interface-factory implementation for ConfigurationManager_i
class ConfigurationManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ConfigurationManagerAbstractFactory
{
	friend class ConfigurationManager_iServantFactory;

public:
	ConfigurationManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ConfigurationManager_i_factory* s_instance;

	const char* key () const;

	ConfigurationManager* make ();

};

typedef ::Core::Var<ConfigurationManager_i_factory> ConfigurationManager_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ConfigurationManager_i> {
	typedef GblAdapterLib::ConfigurationManager_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATIONMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

