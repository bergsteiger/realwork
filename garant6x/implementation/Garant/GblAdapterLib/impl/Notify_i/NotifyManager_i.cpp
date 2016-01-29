////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::NotifyManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClient.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NotifyManager_i::NotifyManager_i ()
//#UC START# *45EEDE9A0260_45F80136005E_45F7E2F3000C_BASE_INIT*
//#UC END# *45EEDE9A0260_45F80136005E_45F7E2F3000C_BASE_INIT*
{
	//#UC START# *45EEDE9A0260_45F80136005E_45F7E2F3000C_BODY*
	//#UC END# *45EEDE9A0260_45F80136005E_45F7E2F3000C_BODY*
}

NotifyManager_i::~NotifyManager_i () {
	//#UC START# *45F7E2F3000C_DESTR_BODY*
	try {
		this->stop_listen_personal ();
		this->stop_listen_common (); // отписываемся от сообщейний, получаемых через EventChanel (это нужно делать здесь)
	} catch (Core::Root::FactoryManagerWasDestroyed&) {
		// это исключение летит, так как идёт попытка использования серверного объекта, а он уже грохнут
	} catch (...) {
		GDS_ASSERT_MSG (false, ("%s: unknown exception", GDS_CURRENT_FUNCTION));
	}
	//#UC END# *45F7E2F3000C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void NotifyManager_i::send_notify_to_all (NotifyType notify_id, const CORBA::Any& data_in_any) {
	//#UC START# *45F9514601B8*
	Notification_var notify (NotificationFactory::make ());
	notify->set_type (notify_id);
	TransformerList::iterator transformers_it = m_data_transformers.find (notify_id);
	if (m_data_transformers.end () != transformers_it) {
		notify->set_data (Variant_var (transformers_it->second->get_variant (data_in_any)).ptr ());
	}

	for (
		ListenerList::iterator it = m_listeners.lower_bound (notify_id)
		; it != m_listeners.upper_bound (notify_id)
		; ++it
	) {
		//LOG_D (("%s: before fire [messageID = %d]", GDS_CURRENT_FUNCTION, notify_id));
		it->second->fire (notify.in ());
	}
	//#UC END# *45F9514601B8*
}

void NotifyManager_i::timestamp_changed (const CORBA::Any& data) {
	//#UC START# *45F9515C032F*
	const ::TimeStampSync::TimeStampNotificationHint* hint;
	if (data >>= hint) {
		//SLOG_D (("%s: new timestamp [%d] received hint.id [%d:%d]", GDS_CURRENT_FUNCTION, hint->timestamp, hint->id.type, hint->id.id));
		TimeStampSync::TimeStampObjectManager::instance ()->object_changed (hint);
	} else {
		GDS_ASSERT (false);
	}
	//#UC END# *45F9515C032F*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NotifyManager
void NotifyManager_i::listen_for_all () {
	//#UC START# *46135D58010B_45F7E2F3000C*
	this->start_listen_common ();
	//#UC END# *46135D58010B_45F7E2F3000C*
}

// implemented method from NotifyManager
void NotifyManager_i::listen_only_for_me () {
	//#UC START# *46135D64013A_45F7E2F3000C*
	this->start_listen_personal (ApplicationHelper::instance ()->get_cached_current_user_id ());
	//#UC END# *46135D64013A_45F7E2F3000C*
}

// implemented method from NotifyManager
void NotifyManager_i::register_listener_for_notify (NotifyType notify_id, Listener* listener) {
	//#UC START# *45EEDE9A0261_45F7E2F3000C*
	m_listeners.insert (ListenerList::value_type (notify_id, Core::IObject::_duplicate (listener)));
	//#UC END# *45EEDE9A0261_45F7E2F3000C*
}

// implemented method from NotifyManager
void NotifyManager_i::register_transformer (NotifyType type, DataTransformer* transformer) {
	//#UC START# *46135D3F0292_45F7E2F3000C*
	m_data_transformers [type] = Core::IObject::_duplicate (transformer);
	//#UC END# *46135D3F0292_45F7E2F3000C*
}

// implemented method from NotifyManager
void NotifyManager_i::stop_listen_me () {
	//#UC START# *46135D7101D6_45F7E2F3000C*
	this->stop_listen_personal ();
	//#UC END# *46135D7101D6_45F7E2F3000C*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from GSI::NotifyService::Consumer
// Для получения сообщений реализация перекрывает этот метод.
void NotifyManager_i::fire_event (const CORBA::Any& event) {
	//#UC START# *44A119280119_45F7E2F3000C*
	GblPilotDef::UserNotify* user_notify;
	static ACE_Atomic_Op<ACE_Thread_Mutex, long> s_start_notify_whatcher = 0;
	if (event >>= user_notify) {
		if (user_notify->m_type == GblPilotDef::unt_LongOperationStart) {
			if (1 != (++s_start_notify_whatcher)) {
				LOG_W (("%s: unexpected order of Long Operation message", GDS_CURRENT_FUNCTION));
			}
			this->send_notify_to_all (NT_LONG_OPERATION_START, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_LongOperationEnd) {
			if (0 != (--s_start_notify_whatcher)) {
				LOG_W (("%s: unexpected order of Long Operation message", GDS_CURRENT_FUNCTION));
			}
			this->send_notify_to_all (NT_LONG_OPERATION_END, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_monitoring_update) {			
			this->send_notify_to_all (NT_MONITORING_UPDATE, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_ServerStopped) {
			this->send_notify_to_all (NT_SHUTDOWN, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_LogOut) {
			this->send_notify_to_all (NT_LOGOUT, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_BaseStartUpdate) {
			this->send_notify_to_all (NT_BASE_UPDATE_START, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_BaseUpdated) {
			ApplicationHelper::instance ()->clear_cache_and_regenerate_base_id ();			
			this->send_notify_to_all (NT_BASE_UPDATE_END, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_BaseUpdateFailed) {
			this->send_notify_to_all (NT_BASE_UPDATE_FAILED, user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_TimeStampChanged) {
			this->timestamp_changed (user_notify->m_data);
		} else if (user_notify->m_type == GblPilotDef::unt_consultation_received) {
			this->send_notify_to_all (NT_CONSULTATION_RECEIVED, user_notify->m_data); 
		} else if (user_notify->m_type == GblPilotDef::unt_consultation_not_sent) {
			this->send_notify_to_all (NT_CONSULTATION_NOT_SENT, user_notify->m_data); 
		} else if (user_notify->m_type == GblPilotDef::unt_no_subscription) {
			this->send_notify_to_all (NT_NO_SUBSCRIPTION, user_notify->m_data); 
		} else if (user_notify->m_type == GblPilotDef::unt_internet_available) {
			this->send_notify_to_all (NT_INTERNET_AVAILABLE, user_notify->m_data); 
		} else if (user_notify->m_type == GblPilotDef::unt_internet_not_available) {
			this->send_notify_to_all (NT_INTERNET_NOT_AVAILABLE, user_notify->m_data); 
		} else if (user_notify->m_type == GblPilotDef::unt_FoldersChanged || user_notify->m_type == GblPilotDef::unt_consultation_folders_changed) {
			// Нотификация об изменении папок идет в обход NotifyManager_i потому здесь не обрабатывается
		} else if (user_notify->m_type == GblPilotDef::unt_document_changed) {
			// Нотификация о наличии новой версии документа обрабатывается в каждом документе
			// Клиенту она не транслируется
		} else if (user_notify->m_type == GblPilotDef::unt_shared_filters_changed) {
			// изменение общих фильтров обрабатывается в FiltersManager-е
		} else if (user_notify->m_type == GblPilotDef::unt_clear_offline_user) {
			// логаут зависшего пользователя - для интранет версии, в оболочке не обрабатывается
		} else {
			LOG_W (("%s: unknown user type %d", GDS_CURRENT_FUNCTION, user_notify->m_type));
			GDS_ASSERT (false);
		}
	} else {
		LOG_W (("%s: unknown data", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}
	//#UC END# *44A119280119_45F7E2F3000C*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

