////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/Configuration_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::Configuration_i
// Заголовк реализации фабрик интерфеса Configuration для серванта Configuration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_CONFIGURATION_I_FCTR_H__
#define __SHARED_CORE_ROOT_I_CONFIGURATION_I_FCTR_H__

#include "ace/ACE.h"
#include "shared/Core/Root/RootFactories.h"
#include "shared/Core/impl/Root_i/Root_i.h"

namespace Core {
namespace Root_i {

/// Interface-factory implementation for Configuration_i
class Configuration_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Root::ConfigurationAbstractFactory
{
public:
	Configuration_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Root::Configuration* get ();

};

typedef ::Core::Var<Configuration_i_factory> Configuration_i_factory_var;

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_CONFIGURATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

