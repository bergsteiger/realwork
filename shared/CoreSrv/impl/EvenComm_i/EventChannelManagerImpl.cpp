////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::EvenComm_i::EventChannelManagerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/impl/EvenComm_i/EventChannelManagerImpl.h"
// by <<uses>> dependencies
#include "orbsvcs/orbsvcs/Event/EC_Default_Factory.h"
#include "orbsvcs/orbsvcs/Event/EC_Event_Channel.h"

namespace CoreSrv {
namespace EvenComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EventChannelManagerImpl::EventChannelManagerImpl ()
//#UC START# *47FF471101F1_47FF483C0078_47FF49C10158_BASE_INIT*
//#UC END# *47FF471101F1_47FF483C0078_47FF49C10158_BASE_INIT*
{
	//#UC START# *47FF471101F1_47FF483C0078_47FF49C10158_BODY*
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
	//#UC END# *47FF471101F1_47FF483C0078_47FF49C10158_BODY*
}

EventChannelManagerImpl::~EventChannelManagerImpl () {
	//#UC START# *47FF49C10158_DESTR_BODY*	
	//#UC END# *47FF49C10158_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EventComm::EventChannelManager
// Создаёт корбовский канал (если он не был создан до этого) и регестирует его в NameService
void EventChannelManagerImpl::create_channel (
	const char* channel_name
) throw (
	CORBA::SystemException
	, EventComm::CreateChannelFailed
) {
	//#UC START# *47FF4887025F_47FF49C10158*
	try {
		GUARD (m_channel_mutex);
		if (m_channels.find (channel_name) == m_channels.end ()) {
			
			//канал в списке не найден
			RtecEventChannelAdmin::EventChannel_var ec = RtecEventChannelAdmin::EventChannel::_nil ();
			CosNaming::NamingContext& name_service = LibHomeFactory::get ().get_orb_facet ().get_ns_root ();
			try {
				//возможно канал с таким именем уже зарегестрирован
				CORBA::Object_var obj = CoreSrv::resolve_path (&name_service, channel_name);
				ec = RtecEventChannelAdmin::EventChannel::_narrow (obj.in ());				
			} catch (...) {
				//канал с <<channel_name>> не зарегестированн в системе
				//гасим исключение
				ec = RtecEventChannelAdmin::EventChannel::_nil ();
			}
			if (CORBA::is_nil (ec.in ()) == false) {				
				//сохраняем канал с <<channel_name>> в мапу
				m_channels.insert (ChannelMap::value_type (channel_name, ec));				
			} else {
				//создаём новый канал и регестируем его в нэйм сервисе
				PortableServer::POA& poa = LibHomeFactory::get ().get_orb_facet ().get_root_poa ();
				
				TAO_EC_Event_Channel_Attributes attributes (&poa, &poa);
				TAO_EC_Event_Channel* ec_impl = new TAO_EC_Event_Channel (attributes);
				ec_impl->activate ();
				PortableServer::ObjectId_var oid = poa.activate_object (ec_impl);
				ec_impl->_remove_ref (); 
				CORBA::Object_var ec_obj = poa.id_to_reference (oid.in ());
				ec = RtecEventChannelAdmin::EventChannel::_narrow (ec_obj.in ());

				if (CORBA::is_nil (ec.in ()) == true) {
					throw EventComm::CreateChannelFailed ();
				} else {
					try {
						CoreSrv::bind_path (&name_service, ec.in (), channel_name);
						m_channels.insert (ChannelMap::value_type (channel_name, ec));
					} catch (CORBA::ORB::InvalidName& ex) {
						LOG_CEX ((ex, "Can't bind  channel \"%s\"", channel_name));
						throw EventComm::CreateChannelFailed ();
					}
				}
			}

			LOG_D (("Channel created %s", channel_name));
		}
	} catch (EventComm::CreateChannelFailed&) {
		throw;
	} CATCH_LOG_AND_DO("in EventChannelManagerImpl::create_channel ()", throw EventComm::CreateChannelFailed (););		
	//#UC END# *47FF4887025F_47FF49C10158*
}
} // namespace EvenComm_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

