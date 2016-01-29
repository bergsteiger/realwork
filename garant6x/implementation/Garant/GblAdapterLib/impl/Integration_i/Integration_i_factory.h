////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Integration_i::Integration_i
// Заголовк реализации фабрик интерфеса Integration для серванта Integration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProjectFactories.h"

namespace GblAdapterLib {
namespace Integration_i {

/// Interface-factory implementation for Integration_i
class Integration_i_factory: virtual public ::Core::RefCountObjectBase, virtual public IntegrationAbstractFactory {
public:
	Integration_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Integration* make ();

};

typedef ::Core::Var<Integration_i_factory> Integration_i_factory_var;

} // namespace Integration_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATION_I_INTEGRATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

