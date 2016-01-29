////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::DefaultValuesChangesIndicator_i
// Заголовк реализации фабрик интерфеса DefaultValuesChangesIndicator для серванта DefaultValuesChangesIndicator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i.h"

/// Servant-factory implementation for DefaultValuesChangesIndicator_i
namespace GblAdapterLib {
	class ConfigurationManager_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DefaultValuesChangesIndicator_iServantFactory {
	friend class ConfigurationManager_i;

	static DefaultValuesChangesIndicator_i* make (DefaultValuesChangesState state, const Configuration* configuration);
};

/// Interface-factory implementation for DefaultValuesChangesIndicator_i
class DefaultValuesChangesIndicator_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DefaultValuesChangesIndicatorAbstractFactory
{
	friend class DefaultValuesChangesIndicator_iServantFactory;

public:
	DefaultValuesChangesIndicator_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DefaultValuesChangesIndicator_i_factory* s_instance;

	const char* key () const;

	DefaultValuesChangesIndicator* make (DefaultValuesChangesState state, const Configuration* configuration);

};

typedef ::Core::Var<DefaultValuesChangesIndicator_i_factory> DefaultValuesChangesIndicator_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DefaultValuesChangesIndicator_i> {
	typedef GblAdapterLib::DefaultValuesChangesIndicator_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_DEFAULTVALUESCHANGESINDICATOR_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

