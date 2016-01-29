////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeManager
// Заголовк реализации фабрик интерфеса LibHomeManager для серванта CorbaLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_FCTR_H__
#define __SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Root/RootFactories.h"
#include "shared/CoreSrv/impl/Root_i/Root_i.h"

namespace CoreSrv {
namespace Root_i {

/// Interface-factory implementation for CorbaLibHomeManager
class CorbaLibHomeManager_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Core::Root::LibHomeManagerAbstractFactory
{
public:
	CorbaLibHomeManager_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Core::Root::LibHomeManager* get ();

};

typedef ::Core::Var<CorbaLibHomeManager_factory> CorbaLibHomeManager_factory_var;

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

