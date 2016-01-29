////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Manager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Manager_i
// Заголовк реализации фабрик интерфеса ManagerLocal для серванта Manager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_FCTR_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"

namespace GSI {
namespace NotifyService_i {

/// Interface-factory implementation for Manager_i
class Manager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ManagerLocalAbstractFactory {
public:
	Manager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NotifyService::Manager* make ();

};

typedef ::Core::Var<Manager_i_factory> Manager_i_factory_var;

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_MANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

