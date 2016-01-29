////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/RTEventSupplier.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::RTEventSupplier
//
// имплементация корбовского поставщика событий PushSupplier-а
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/RTEventSupplier.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"

//#UC START# *44B356DD02EE_CUSTOM_INCLUDES*
//#UC END# *44B356DD02EE_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

//#UC START# *44B356DD02EE*
void RTEventSupplier::disconnect_and_deactivate () {
	try {
		if (!CORBA::is_nil (m_proxy_consumer)) {
			try {
				try {
					m_proxy_consumer->disconnect_push_consumer ();
				} catch (CORBA::TRANSIENT&) {
					// "гасим" исключение,
					// если сервер уже недоступен
				} catch (PortableServer::POA::ObjectNotActive&) {
					throw; // объект уже деактивирован
				       // и его не нужно деактивировать нам самим
				} catch (CORBA::Exception& ex) {
					LOG_CEX ((ex, "in GCL::Notifier::disconnect_and_deactivate () catched"));
					GDS_ASSERT (false);
				}

				PortableServer::ObjectId_var object_id = m_poa->servant_to_id (this);
				m_poa->deactivate_object (object_id);

			} catch (PortableServer::POA::ObjectNotActive&) {
				// "гасим" исключение,
				// если объект не был активирован
				// или уже был деактивирован
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "in GCL::Notifier::disconnect_and_deactivate () catched"));
				GDS_ASSERT (false);
			}
			m_proxy_consumer = 0;
		}
	} catch (...) {
		GDS_ASSERT_MSG (false, ("GCL::Notifier::disconnect_and_deactivate (): unknown exception catched"));
	}
}

void RTEventSupplier::notify (
	const CORBA::Any& msg
	, const RtecEventComm::EventSourceID sid
	, const RtecEventComm::EventType type
) const {
	if (!CORBA::is_nil (m_proxy_consumer)) {
		RtecEventComm::EventSet events (1);
		events.length (1);

		RtecEventComm::Event& event_0 = events [0];
		event_0.header.source = sid;
		event_0.header.type = type;
		event_0.data.any_value = msg;
		{ // Fix UMR for collocated calls
			event_0.header.ttl = 1;
			event_0.header.creation_time = ORBSVCS_Time::zero ();
#if !defined (TAO_LACKS_EVENT_CHANNEL_TIMESTAMPS)
			event_0.header.ec_recv_time = ORBSVCS_Time::zero ();
			event_0.header.ec_send_time = ORBSVCS_Time::zero ();
#endif
			event_0.data.pad1 = 0;
		} // Fix UMR for collocated calls

		m_proxy_consumer->push (events);
	}
}

//#UC END# *44B356DD02EE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает корбовского поставщика событий
RTEventSupplier::RTEventSupplier (PortableServer::POA* poa, RtecEventChannelAdmin::SupplierAdmin* supplier_admin)
//#UC START# *44B37D2B033C_BASE_INIT*
: m_poa (poa)
//#UC END# *44B37D2B033C_BASE_INIT*
{
	//#UC START# *44B37D2B033C_BODY*
	if (supplier_admin != 0) {
		try {
			RtecEventComm::PushSupplier_var push_supplier = this->_this ();

			ACE_SupplierQOS_Factory qos;
			qos.insert (ACE_ES_EVENT_SOURCE_ANY, PN_NOTIFY_TO_ALL, 0, 1);
			qos.insert (ACE_ES_EVENT_SOURCE_ANY, PN_NOTIFY_TO_ONE, 0, 1);

			m_proxy_consumer = supplier_admin->obtain_push_consumer ();
			m_proxy_consumer->connect_push_supplier (push_supplier.in (), qos.get_SupplierQOS ());
		} catch (CORBA::Exception& ex) {
			LOG_CEX ((ex, "in GCL::NotifyService::Notifier () catched"));
		}
	} else {
		LOG_W (("GCL::NotifyService::Notifier (): invalid supplier admin"));
	}
	//#UC END# *44B37D2B033C_BODY*
}

RTEventSupplier::~RTEventSupplier () {
	//#UC START# *44B356DD02EE_DESTR_BODY*
	//#UC END# *44B356DD02EE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// послать сообщение для всех
void RTEventSupplier::send_common_notify_ (const CORBA::Any& notify) const {
	//#UC START# *44EED95F0047*
	this->notify (notify, ACE_ES_EVENT_SOURCE_ANY, PN_NOTIFY_TO_ALL);
	//#UC END# *44EED95F0047*
}

// послать персональное сообщение заданному в prs_id юзеру
void RTEventSupplier::send_personal_notify_ (const CORBA::Any& notify, NotifyService::PersonalID prs_id) const {
	//#UC START# *44EED97200D3*
	this->notify (notify, ACE_ES_EVENT_SOURCE_ANY+prs_id, PN_NOTIFY_TO_ONE);
	//#UC END# *44EED97200D3*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct SendCommonNotifyParams_ {
	RTEventSupplier_cvar self;
	const CORBA::Any notify;
	SendCommonNotifyParams_ (
		const RTEventSupplier* self_
		, const CORBA::Any& notify_
	) :
		self(RTEventSupplier::_duplicate(self_))
		, notify(notify_)
	{
	}
};

void RTEventSupplier::thr_send_common_notify_ (void* arg) {
	try {
		Core::Aptr<SendCommonNotifyParams_> arg_ (reinterpret_cast<SendCommonNotifyParams_*>(arg));
		arg_->self->send_common_notify_ (arg_->notify);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute RTEventSupplier::send_common_notify oneway function"));
	} catch (...) {
		LOG_UEX (("while execute RTEventSupplier::send_common_notify oneway function"));
	}
}

struct SendPersonalNotifyParams_ {
	RTEventSupplier_cvar self;
	const CORBA::Any notify;
	const NotifyService::PersonalID prs_id;
	SendPersonalNotifyParams_ (
		const RTEventSupplier* self_
		, const CORBA::Any& notify_
		, NotifyService::PersonalID prs_id_
	) :
		self(RTEventSupplier::_duplicate(self_))
		, notify(notify_)
		, prs_id(prs_id_)
	{
	}
};

void RTEventSupplier::thr_send_personal_notify_ (void* arg) {
	try {
		Core::Aptr<SendPersonalNotifyParams_> arg_ (reinterpret_cast<SendPersonalNotifyParams_*>(arg));
		arg_->self->send_personal_notify_ (arg_->notify, arg_->prs_id);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute RTEventSupplier::send_personal_notify oneway function"));
	} catch (...) {
		LOG_UEX (("while execute RTEventSupplier::send_personal_notify oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle RTEventSupplier::send_common_notify (const CORBA::Any& notify) const {
	Core::Aptr<SendCommonNotifyParams_> arg = new SendCommonNotifyParams_ (this, notify);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (RTEventSupplier::thr_send_common_notify_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}

/*oneway*/ Core::ThreadHandle RTEventSupplier::send_personal_notify (
	const CORBA::Any& notify
	, NotifyService::PersonalID prs_id
) const {
	Core::Aptr<SendPersonalNotifyParams_> arg = new SendPersonalNotifyParams_ (this, notify, prs_id);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (RTEventSupplier::thr_send_personal_notify_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}


} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

