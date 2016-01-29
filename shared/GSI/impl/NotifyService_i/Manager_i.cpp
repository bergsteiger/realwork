////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Manager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Manager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/LibHome.h"
#include "shared/GSI/impl/NotifyService_i/Manager_i.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"

//#UC START# *44A13F9E035B_CUSTOM_INCLUDES*
#include "orbsvcs/Event/EC_Default_Factory.h"
#include "orbsvcs/Event/EC_Dispatching_Task.h"
#include "orbsvcs/Event/EC_Event_Channel.h"
//#UC END# *44A13F9E035B_CUSTOM_INCLUDES*

namespace GSI {
namespace NotifyService_i {

//#UC START# *44A13F9E035B*
#if !defined (ACE_WIN32) || (defined (ACE_WIN32) && defined (ACE_AS_STATIC_LIBS)) // GARANT_ATTENTION: preprocess logic false: does not depend on lib type!
ACE_STATIC_SVC_REQUIRE (TAO_EC_Default_Factory);
ACE_STATIC_SVC_REQUIRE (TAO_EC_Simple_Queue_Full_Action);
#endif
//#UC END# *44A13F9E035B*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool Manager_i::EventListenerLess::operator () (const EventListenerKey& x, const EventListenerKey& y) const {
	//#UC START# *44B280F801A5_44B280A502CE_COMP*
	if (x.et == y.et) {
		return x.id < y.id;
	}
	return x.et < y.et;
	//#UC END# *44B280F801A5_44B280A502CE_COMP*
}



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Manager_i::Manager_i ()
//#UC START# *44A13E3702DE_44B2080D028F_44A13F9E035B_BASE_INIT*
//#UC END# *44A13E3702DE_44B2080D028F_44A13F9E035B_BASE_INIT*
{
	//#UC START# *44A13E3702DE_44B2080D028F_44A13F9E035B_BODY*
	//#UC END# *44A13E3702DE_44B2080D028F_44A13F9E035B_BODY*
}

Manager_i::~Manager_i () {
	//#UC START# *44A13F9E035B_DESTR_BODY*
	//#UC END# *44A13F9E035B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NotifyService::Manager
// остановка сервиса
void Manager_i::done () /*throw (NotifyService::InternalError, NotifyService::NotInitialized)*/ {
	//#UC START# *44A13E670186_44A13F9E035B*
	if (0 == m_orb.ptr ()) {
		throw NotifyService::NotInitialized ();
	}

	m_rte_supplier = 0;
	{
        GUARD (m_subscribe_event_mutex);
		m_consumers_set.clear ();
		m_event_listeners.clear ();
	}
	m_consumer_adm = RtecEventChannelAdmin::ConsumerAdmin::_nil ();
	m_supplier_adm = RtecEventChannelAdmin::SupplierAdmin::_nil ();
	if (false == CORBA::is_nil (m_event_channel)) {
		if (CT_CLIENT != m_prid) {
			m_event_channel->destroy ();
		}
		m_event_channel = RtecEventChannelAdmin::EventChannel::_nil ();
	}
	m_poa = PortableServer::POA::_nil ();
	m_orb = CORBA::ORB::_nil ();
	//#UC END# *44A13E670186_44A13F9E035B*
}

// implemented method from NotifyService::Manager
// запуск сервиса
void Manager_i::init () /*throw (NotifyService::InternalError, NotifyService::NotInitialized)*/ {
	//#UC START# *44A142C901B5_44A13F9E035B*
	m_orb = CORBA::ORB::_duplicate (&Environment::get_orb ());
	m_prid = Environment::get_type ();

	if (0 == m_orb.ptr ()) {
		throw NotifyService::NotInitialized ();
	}

	try {
		CORBA::Object_var obj_poa = m_orb->resolve_initial_references ("RootPOA");
		m_poa = PortableServer::POA::_narrow (obj_poa.in ());
		
		if (CT_CLIENT != m_prid) {
			ACE_Service_Config::process_directive (
				"static EC_Factory \""
					"-ECDispatching mt"
					" -ECDispatchingThreads 5"
					" -ECProxyConsumerLock thread"
					" -ECProxySupplierLock thread"
					" -ECConsumerControl reactive"
					" -ECSupplierControl reactive"
					" -ECConsumerControlPeriod 600000000" // 10 минут
					" -ECSupplierControlPeriod 600000000" // 10 минут
					" -ECConsumerControlTimeout 10000000" // 10 секунд
					" -ECSupplierControlTimeout 10000000" // 10 секунд
					" -ECUseORBId MainORB"
				"\""
			);
	
			TAO_EC_Default_Factory::init_svcs ();
			TAO_EC_Event_Channel_Attributes attributes (m_poa, m_poa);
			TAO_EC_Event_Channel* ec_impl = new TAO_EC_Event_Channel (attributes);
			ec_impl->activate ();
			PortableServer::ObjectId_var oid = m_poa->activate_object (ec_impl);
			ec_impl->_remove_ref (); 
			CORBA::Object_var ec_obj = m_poa->id_to_reference (oid.in ());
			m_event_channel = RtecEventChannelAdmin::EventChannel::_narrow (ec_obj.in ());
			m_consumer_adm = ec_impl->for_consumers ();
			m_supplier_adm = ec_impl->for_suppliers ();

			if (true == CORBA::is_nil (m_event_channel.in ())) {
				LOG_E (("RTE Service not found!\n"));
			} else {
				try {
					CORBA::Object_var naming_obj = m_orb->resolve_initial_references ("NameService");
					CosNaming::NamingContext_var naming_server = CosNaming::NamingContext::_narrow (naming_obj.in ());
					if (!CORBA::is_nil (naming_server)) {
						CosNaming::Name name;
						name.length (1);
						name[0].id = static_cast<const char*>("EventService");
						naming_server->rebind (name, m_event_channel.in ());
					} else {
						LOG_W (("NSSingletonTarget::init: NameService not found"));
					}
				} catch (CORBA::ORB::InvalidName&) {
					LOG_W (("NSSingletonTarget::init: NameService not found"));
				}
			}

			m_rte_supplier = new RTEventSupplier (m_poa.in (), m_supplier_adm.in ());
		} else {
			CORBA::Object_var naming_obj = m_orb->resolve_initial_references ("NameService");
			CosNaming::NamingContext_var naming_server = CosNaming::NamingContext::_narrow (naming_obj.in ());

			CosNaming::Name name;
			name.length (1);
			name[0].id = static_cast<const char*>("EventService");
			CORBA::Object_var obj = naming_server->resolve (name);
			m_event_channel = RtecEventChannelAdmin::EventChannel::_narrow (obj.in ());

			m_consumer_adm = m_event_channel->for_consumers ();
			m_supplier_adm = m_event_channel->for_suppliers ();
		}

	} catch (const CORBA::Exception& ex) {
		LOG_CEX ((ex, "in GCL::NotifyService::init"));
		throw NotifyService::InternalError ();
	} catch (...) {
		LOG_E (("in GCL::NotifyService::init"));
		throw NotifyService::InternalError ();
	}
	//#UC END# *44A142C901B5_44A13F9E035B*
}

// implemented method from ManagerLocal
// послать обычное сообщение
void Manager_i::send_common_notify (
	const CORBA::Any& notify
) /*throw (
	NotifyService::InternalError
	, NotifyService::NotInitialized
)*/ {
	//#UC START# *4954818501E3_44A13F9E035B*
	std::vector<ProxyConsumer_var> consumers_set_snap;

	//делаем "слепок" списка подписчиков на общие нотификации
	{
		GUARD (m_subscribe_event_mutex);
		for (Manager_i::ProxyConsumersMap::iterator it = m_consumers_set.begin (); it != m_consumers_set.end (); ++it) {
			if (it->second.et == PN_NOTIFY_TO_ALL) {
				consumers_set_snap.push_back (ProxyConsumer_var (Core::IObject::_duplicate (it->first)));
			}
		}
	}

	for (unsigned int i = 0; i < consumers_set_snap.size (); ++i) {
		consumers_set_snap[i]->push_event (notify);
	}
	consumers_set_snap.clear ();

	if (m_rte_supplier.ptr () == 0) {
		throw NotifyService::NotInitialized ();
	}

	try {
		m_rte_supplier->send_common_notify (notify);
	} catch (...) {
		throw NotifyService::InternalError ();
	}
	//#UC END# *4954818501E3_44A13F9E035B*
}

// implemented method from ManagerLocal
// послать персональное сообщение
void Manager_i::send_personal_notify (
	const CORBA::Any& notify
	, NotifyService::PersonalID prs_id
) /*throw (
	NotifyService::InternalError
	, NotifyService::NotInitialized
)*/ {
	//#UC START# *495481AD0304_44A13F9E035B*
	std::vector<ProxyConsumer_var> consumers_set_snap;

	//делаем "слепок" списка подписчиков на персональную нотификацию
	{
		GUARD (m_subscribe_event_mutex);
		for (Manager_i::ProxyConsumersMap::iterator it = m_consumers_set.begin (); it != m_consumers_set.end (); ++it) {
			if (it->second.et == PN_NOTIFY_TO_ONE && it->second.id == prs_id) {
				consumers_set_snap.push_back (ProxyConsumer_var (Core::IObject::_duplicate (it->first)));
			}
		}
	}

	for (unsigned int i = 0; i < consumers_set_snap.size (); ++i) {
		consumers_set_snap[i]->push_event (notify);
	}
	consumers_set_snap.clear ();

	if (m_rte_supplier.ptr () == 0) {
		throw NotifyService::NotInitialized ();
	}

	try {
		m_rte_supplier->send_personal_notify (notify, prs_id);
	} catch (...) {
		throw NotifyService::InternalError ();
	}
	//#UC END# *495481AD0304_44A13F9E035B*
}

// implemented method from ManagerLocal
// подписываем прокси консьюмера на сообщения для всех
ProxyConsumer* Manager_i::subscribe_for_common (const Consumer_i* consumer) {
	//#UC START# *4954BC2E0312_44A13F9E035B*
	//#UC START# *49547B0B0359_44A13F9E035B*
	if (0 == m_orb.ptr ()) {
		throw NotifyService::NotInitialized ();
	}

	GUARD (m_subscribe_event_mutex);

	EventListenerKey key;
	key.et = PN_NOTIFY_TO_ALL;
	key.id = 0;

	ProxyConsumer_var pc (new ProxyConsumer (const_cast<Consumer_i*>(consumer)));
	m_consumers_set[pc.in ()] = key;

	if (m_prid == CT_CLIENT) {
		RTEventListener::Box& el = m_event_listeners[key];
		if (0 == el.ptr ()) {
			el = new RTEventListener (m_poa.in (), m_consumer_adm.in ());
		}
		el->add_consumer (pc.in());
	}
	return pc._retn ();
	//#UC END# *4954BC2E0312_44A13F9E035B*
}

// implemented method from ManagerLocal
// подписываем прокси консьюмера на прием персональных сообщений
ProxyConsumer* Manager_i::subscribe_for_personal (const Consumer_i* consumer, NotifyService::PersonalID prs_id) {
	//#UC START# *4954BC2C01D5_44A13F9E035B*
	if (0 == m_orb.ptr ()) {
		throw NotifyService::NotInitialized ();
	}

	GUARD (m_subscribe_event_mutex);

	EventListenerKey key;
	key.et = PN_NOTIFY_TO_ONE;
	key.id = prs_id;

	ProxyConsumer_var pc (new ProxyConsumer (const_cast<Consumer_i*>(consumer)));
	m_consumers_set[pc.in ()] = key;
	
	if (m_prid == CT_CLIENT) {
		RTEventListener::Box& el = m_event_listeners[key];
		if (0 == el.ptr ()) {
			el = new RTEventListener (m_poa.in (), m_consumer_adm.in (), prs_id);
		}
		el->add_consumer (pc.in());
	}
	return pc._retn ();
	//#UC END# *4954BC2C01D5_44A13F9E035B*
}

// implemented method from ManagerLocal
// отписываем прокси консьюмера от приема сообщений
void Manager_i::unregister (const ProxyConsumer* proxy) {
	//#UC START# *49547B110126_44A13F9E035B*
	GUARD (m_subscribe_event_mutex);

	ProxyConsumersMap::iterator it = m_consumers_set.find (const_cast<ProxyConsumer*>(proxy));
	if (m_consumers_set.end () != it) {
		if (m_prid == CT_CLIENT) {
			RTEventListener::Box& el = m_event_listeners[it->second];
			if (0 == el->remove_consumer (proxy)) {
				m_event_listeners.erase (it->second);
			}
		}
		m_consumers_set.erase (it);
	}
	//#UC END# *49547B110126_44A13F9E035B*
}
} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

