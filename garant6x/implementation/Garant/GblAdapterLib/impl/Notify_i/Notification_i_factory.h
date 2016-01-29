////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::Notification_i
// Заголовк реализации фабрик интерфеса Notification для серванта Notification_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Notification_i
class Notification_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NotificationAbstractFactory {
public:
	Notification_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Notification* make ();

};

typedef ::Core::Var<Notification_i_factory> Notification_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

