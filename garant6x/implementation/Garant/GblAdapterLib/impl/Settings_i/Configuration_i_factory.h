////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::Configuration_i
// Заголовк реализации фабрик интерфеса Configuration для серванта Configuration_i
//
// Реализация интерфейса, обеспечивающего работу с конкретной конфигурацией, является элементом
// списка конфигураций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.h"

/// Servant-factory implementation for Configuration_i
namespace GblAdapterLib {
	class ConfigurationManager_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Configuration_iServantFactory {
	friend class ConfigurationManager_i;

	static Configuration_i* make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly);
};

/// Interface-factory implementation for Configuration_i
class Configuration_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ConfigurationAbstractFactory {
	friend class Configuration_iServantFactory;

public:
	Configuration_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Configuration_i_factory* s_instance;

	const char* key () const;

	Configuration* make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly);

};

typedef ::Core::Var<Configuration_i_factory> Configuration_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Configuration_i> {
	typedef GblAdapterLib::Configuration_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_CONFIGURATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

