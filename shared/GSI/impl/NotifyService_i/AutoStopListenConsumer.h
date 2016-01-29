////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/AutoStopListenConsumer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::AutoStopListenConsumer
//
// Получатель, которые в деструкторе отписывается от получения сообщений.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_AUTOSTOPLISTENCONSUMER_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_AUTOSTOPLISTENCONSUMER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

//#UC START# *44A13FC00203_CUSTOM_INCLUDES*
//#UC END# *44A13FC00203_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

// Получатель, которые в деструкторе отписывается от получения сообщений.
class AutoStopListenConsumer;
typedef Core::Var<AutoStopListenConsumer> AutoStopListenConsumer_var;
typedef Core::Var<const AutoStopListenConsumer> AutoStopListenConsumer_cvar;

class AutoStopListenConsumer :
	virtual public Consumer_i
{
// virtual void destructor
public:
	virtual ~AutoStopListenConsumer () {};

//#UC START# *44A13FC00203*
protected:
	virtual void delete_obj () {
		this->stop_listen_personal ();
		this->stop_listen_common ();
		Core::RefCountObjectBase::delete_obj ();
	}
//#UC END# *44A13FC00203*
}; // class AutoStopListenConsumer

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_AUTOSTOPLISTENCONSUMER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

