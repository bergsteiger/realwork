////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i
// Заголовк реализации фабрик интерфеса SettingsManager для серванта SettingsManager_i
//
// Реализация интерфейса работы с настройками. Обеспечивает создание новых свойств и их получение.
// Свойство характеризуется строковым идентификатором. Интерфейс может быть получен или  из
// интерфейса Common,  в этом случае он обеспечивает доступ к свойствам активной конфигурации, или
// из интерфейса Configuration, тогда обеспечивается работа со свойствами этой конфигурации.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"

/// Servant-factory implementation for SettingsManager_i
namespace GblAdapterLib {
	class Configuration_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class SettingsManager_iServantFactory {
	friend class Configuration_i;

	static SettingsManager_i* make () /*throw (NoSession)*/;

	static SettingsManager_i* make (const SettingsManager_i::ConfigurationSelector* selector) /*throw (NoSession)*/;
};

/// Interface-factory implementation for SettingsManager_i
class SettingsManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public SettingsManagerAbstractFactory
{
	friend class SettingsManager_iServantFactory;

public:
	SettingsManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static SettingsManager_i_factory* s_instance;

	const char* key () const;

	SettingsManager* make () /*throw (NoSession)*/;

};

typedef ::Core::Var<SettingsManager_i_factory> SettingsManager_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SettingsManager_i> {
	typedef GblAdapterLib::SettingsManager_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

