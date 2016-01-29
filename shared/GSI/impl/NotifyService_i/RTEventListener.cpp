////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/RTEventListener.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::RTEventListener
//
// Наследник от корбовского получателя сообщений. При получении собщений корбой дергается метод
// push_event.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/RTEventListener.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"

//#UC START# *44B375D50242_CUSTOM_INCLUDES*
//#UC END# *44B375D50242_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

//#UC START# *44B375D50242*
void RTEventListener::push (const RtecEventComm::EventSet& events) throw (CORBA::SystemException) {
	this->push_i (events);
}

void RTEventListener::init (RtecEventChannelAdmin::ConsumerAdmin_ptr consumer_admin, ACE_ConsumerQOS_Factory& qos) {
	WRITE_GUARD (m_consumer_mutex);
	if (consumer_admin != 0) {
		try {
			RtecEventComm::PushConsumer_var push_consumer = this->_this ();
			m_proxy_supplier = consumer_admin->obtain_push_supplier ();
			m_proxy_supplier->connect_push_consumer (push_consumer.in (), qos.get_ConsumerQOS ());
		} catch (CORBA::Exception& ex) {
			LOG_CEX ((ex, "in RTEventListener::RTEventListener () catched"));
		}
	} else {
		LOG_W (("RTEventListener::RTEventListener (): invalid consumer admin"));
	}
}

void RTEventListener::deactivate () {
	try {
		WRITE_GUARD (m_consumer_mutex);

		m_consumers.clear ();

		if (!CORBA::is_nil (m_proxy_supplier)) {
			try {
				try {
					m_proxy_supplier->disconnect_push_supplier ();
				} catch (CORBA::TRANSIENT&) {
					// "гасим" исключение,
					// если сервер уже недоступен
				} catch (PortableServer::POA::ObjectNotActive&) {
					throw; // объект уже деактивирован
					       // и его не нужно деактивировать нам самим
				} catch (CORBA::Exception& ex) {
					LOG_CEX ((ex, "in RTEventListener::disconnect_and_deactivate () catched"));
					GDS_ASSERT (false);
				}

				PortableServer::ObjectId_var object_id = m_poa->servant_to_id (this);

				m_poa->deactivate_object (object_id);
			} catch (PortableServer::POA::ObjectNotActive&) {
				// "гасим" исключение,
				// если объект не был активирован
				// или уже был деактивирован
			} catch (CORBA::Exception& ex) {
				LOG_CEX ((ex, "in RTEventListener::deactivate () catched"));
				GDS_ASSERT (false);
			}

			m_proxy_supplier = 0;
		}
	} catch (...) {
		GDS_ASSERT_MSG (false, ("RTEventListener::deactivate (): unknown exception catched"));
	}
}
//#UC END# *44B375D50242*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор для корбовского листенера для слушанья сообщений для всех
RTEventListener::RTEventListener (PortableServer::POA* poa, RtecEventChannelAdmin::ConsumerAdmin* consumer_admin)
//#UC START# *44B37DCD005D_BASE_INIT*
: m_poa (poa)
//#UC END# *44B37DCD005D_BASE_INIT*
{
	//#UC START# *44B37DCD005D_BODY*
	ACE_ConsumerQOS_Factory qos;
	qos.start_disjunction_group (1);
	qos.insert_type (PN_NOTIFY_TO_ALL, 0);
	this->init (consumer_admin, qos);
	//#UC END# *44B37DCD005D_BODY*
}

// конструктор для корбовского листенера для слушанья персональных сообщений
RTEventListener::RTEventListener (
	PortableServer::POA* poa
	, RtecEventChannelAdmin::ConsumerAdmin* consumer_admin
	, NotifyService::PersonalID id
)
//#UC START# *44B3819A007D_BASE_INIT*
: m_poa (poa)
//#UC END# *44B3819A007D_BASE_INIT*
{
	//#UC START# *44B3819A007D_BODY*
	ACE_ConsumerQOS_Factory qos;
	qos.start_disjunction_group (1);
	qos.insert (ACE_ES_EVENT_SOURCE_ANY+id, PN_NOTIFY_TO_ONE, 0);
	this->init (consumer_admin, qos);
	//#UC END# *44B3819A007D_BODY*
}

RTEventListener::~RTEventListener () {
	//#UC START# *44B375D50242_DESTR_BODY*
	//#UC END# *44B375D50242_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет прокси консьюмера
void RTEventListener::add_consumer (ProxyConsumer* pc) {
	//#UC START# *44EEDF7E0354*
	WRITE_GUARD (m_consumer_mutex);
	m_consumers.insert (const_cast<ProxyConsumer*>(pc));
	//#UC END# *44EEDF7E0354*
}

// Нужно выполнять push в отдельном потоке, что бы не виснуть при BiDir-е
void RTEventListener::push_i_ (const RtecEventComm::EventSet& events) {
	//#UC START# *49B9244B039F*
	std::vector<ProxyConsumer_var> consumers_set_snap;
	unsigned int i = 0;
	{
		READ_GUARD (m_consumer_mutex);
		consumers_set_snap.resize (m_consumers.size ());
		for (ConsumersSet::iterator it = m_consumers.begin (); it != m_consumers.end (); ++it) {
			consumers_set_snap[i] = Core::IObject::_duplicate (*it);
			++i;
		}
	}
	for (i = 0; i < consumers_set_snap.size (); ++i) {
		consumers_set_snap[i]->push_event (events [0].data.any_value);
	}
	//#UC END# *49B9244B039F*
}

// удаляет прокси консъюмера
unsigned long RTEventListener::remove_consumer (const ProxyConsumer* pc) {
	//#UC START# *44EEDF8F02F6*
	WRITE_GUARD (m_consumer_mutex);
	m_consumers.erase (const_cast<ProxyConsumer*>(pc));
	return static_cast<unsigned long> (m_consumers.size ());	
	//#UC END# *44EEDF8F02F6*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct PushIParams_ {
	RTEventListener_var self;
	RtecEventComm::EventSet events;
	PushIParams_ (
		RTEventListener* self_
		, const RtecEventComm::EventSet& events_
	) :
		self(RTEventListener::_duplicate(self_))
		, events(events_)
	{
	}
};

void RTEventListener::thr_push_i_ (void* arg) {
	try {
		Core::Aptr<PushIParams_> arg_ (reinterpret_cast<PushIParams_*>(arg));
		arg_->self->push_i_ (arg_->events);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute RTEventListener::push_i oneway function"));
	} catch (...) {
		LOG_UEX (("while execute RTEventListener::push_i oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle RTEventListener::push_i (const RtecEventComm::EventSet& events) {
	Core::Aptr<PushIParams_> arg = new PushIParams_ (this, events);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (RTEventListener::thr_push_i_), arg.in ()
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

