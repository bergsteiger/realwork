////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/RTEventSupplier.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::RTEventSupplier
//
// имплементация корбовского поставщика событий PushSupplier-а
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_RTEVENTSUPPLIER_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_RTEVENTSUPPLIER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "orbsvcs/orbsvcs/RtecEventCommC.h"
#include "orbsvcs/orbsvcs/RtecEventChannelAdminC.h"
#include "tao/PortableServer/PortableServerC.h"
#include "orbsvcs/orbsvcs/RtecEventCommS.h"

//#UC START# *44B356DD02EE_CUSTOM_INCLUDES*
//#UC END# *44B356DD02EE_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

// имплементация корбовского поставщика событий PushSupplier-а
class RTEventSupplier;
typedef Core::Var<RTEventSupplier> RTEventSupplier_var;
typedef Core::Var<const RTEventSupplier> RTEventSupplier_cvar;

class RTEventSupplier :
	virtual public POA_RtecEventComm::PushSupplier
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (RTEventSupplier)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// Корбовский поставщик событий, бокс нужен для выполнения специальной деинициализации.
	struct BoxDeallocator {
		static void destroy (RTEventSupplier* content) {
		//#UC START# *44B3573B002E*
		content->disconnect_and_deactivate ();
		content->_remove_ref ();
	//#UC END# *44B3573B002E*
		}
	};
	typedef ::Core::Box<RTEventSupplier, BoxDeallocator, true> Box;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// создает корбовского поставщика событий
	RTEventSupplier (PortableServer::POA* poa, RtecEventChannelAdmin::SupplierAdmin* supplier_admin);

public:
	virtual ~RTEventSupplier ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// послать сообщение для всех
	/*oneway*/ Core::ThreadHandle send_common_notify (const CORBA::Any& notify) const;

	// послать персональное сообщение заданному в prs_id юзеру
	/*oneway*/ Core::ThreadHandle send_personal_notify (
		const CORBA::Any& notify
		, NotifyService::PersonalID prs_id
	) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	PortableServer::POA* m_poa;

	RtecEventChannelAdmin::ProxyPushConsumer_var m_proxy_consumer;
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_send_common_notify_ (void* arg);

	static void thr_send_personal_notify_ (void* arg);

protected:
	virtual void send_common_notify_ (const CORBA::Any& notify) const;

	virtual void send_personal_notify_ (const CORBA::Any& notify, NotifyService::PersonalID prs_id) const;


//#UC START# *44B356DD02EE*
protected:
	void disconnect_push_supplier () throw (CORBA::SystemException) {
		LOG_D (("GCL::Notifier::disconnect_push_supplier (): ok [push consumer call]"));
	}

private:
	void disconnect_and_deactivate ();
	void notify (
		const CORBA::Any& msg
		, const RtecEventComm::EventSourceID sid
		, const RtecEventComm::EventType type
	) const;

//#UC END# *44B356DD02EE*
}; // class RTEventSupplier

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_RTEVENTSUPPLIER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

