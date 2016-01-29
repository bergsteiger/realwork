////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/AutoStopListenConsumer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::AutoStopListenConsumer
//
// ����������, ������� � ����������� ������������ �� ��������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ����������, ������� � ����������� ������������ �� ��������� ���������.
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

