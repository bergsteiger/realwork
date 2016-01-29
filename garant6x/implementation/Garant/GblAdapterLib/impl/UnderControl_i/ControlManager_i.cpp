////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UnderControl_i::ControlManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

ACE_THR_FUNC_RETURN ControlManager_i::async_update_status (void* param) {
	//#UC START# *45FEA0ED0223*
	ControlManager_i* control_manager = reinterpret_cast<ControlManager_i*> (param);
	return control_manager->do_update_status ();
	//#UC END# *45FEA0ED0223*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ControlManager_i::ControlManager_i ()
//#UC START# *45F118B90277_45FA9A5D0124_45FA9E500072_BASE_INIT*
	: m_control_notifier (0)
	, m_force_for_update_status (false)
//#UC END# *45F118B90277_45FA9A5D0124_45FA9E500072_BASE_INIT*
{
	//#UC START# *45F118B90277_45FA9A5D0124_45FA9E500072_BODY*
	//#UC END# *45F118B90277_45FA9A5D0124_45FA9E500072_BODY*
}

ControlManager_i::~ControlManager_i () {
	//#UC START# *45FA9E500072_DESTR_BODY*
	//#UC END# *45FA9E500072_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const GblUnderControlDef::UnderControlObjectList& ControlManager_i::get_cached_pilot_controlled_object () const {
	//#UC START# *487328A40022*
	GUARD (m_controlled_objects_mutex);
	if (!m_pilot_controlled_objects.ptr ()) {
		m_pilot_controlled_objects = 
			ApplicationHelper::instance ()->get_cached_under_control_manager ()->get_list_objects ();
	}
	return *m_pilot_controlled_objects;
	//#UC END# *487328A40022*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void ControlManager_i::clear_cache () {
	//#UC START# *45702DA9037A_45FA9E500072*
	this->update_status (false);
	//#UC END# *45702DA9037A_45FA9E500072*
}

// implemented method from ControlManager
void ControlManager_i::add (const GCD::PID& pid) {
	//#UC START# *46164E3A02FE_45FA9E500072*
	try {
		ApplicationHelper::instance ()->get_cached_under_control_manager ()->add (pid);
		this->refresh_control_status ();
	} catch (GCD::AlreadyControlled&) {
		throw AlreadyControlled ();
	} catch (...) {
		throw NotSaved ();
	}
	//#UC END# *46164E3A02FE_45FA9E500072*
}

// implemented method from ControlManager
const CatalogBase* ControlManager_i::get_changed_doc () const {
	//#UC START# *45FA9A2000A8_45FA9E500072_GET*
	try {
		GblDocList::DocListTree_var controlled_objects = 
			ApplicationHelper::instance ()->get_cached_under_control_manager ()->get_bookmark_list ();
		return DynListFactory::make (controlled_objects.in ());
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45FA9A2000A8_45FA9E500072_GET*
}

CatalogBase* ControlManager_i::get_changed_doc () {
	return const_cast<CatalogBase*>(((const ControlManager_i*)this)->get_changed_doc ());
}

// implemented method from ControlManager
void ControlManager_i::set_controlled_change_notifier (ControlledChangeNotifier* controlled_change_notifier) {
	//#UC START# *45F11924017B_45FA9E500072_SET*
	if (m_control_notifier.is_nil ()) {
		m_control_notifier = ControlledChangeNotifier::_duplicate (controlled_change_notifier);
	} else {
		GDS_ASSERT (false); //ses: why?
	}
	//#UC END# *45F11924017B_45FA9E500072_SET*
}

// implemented method from ControlManager
ACE_THR_FUNC_RETURN ControlManager_i::do_update_status () {
	//#UC START# *46164E76005D_45FA9E500072*
	bool is_updated = false;
	try {
		is_updated = ApplicationHelper::instance ()->get_cached_under_control_manager ()->update_status ();
	} catch (...) {
		LOG_E (("%s: some exception in update_status", GDS_CURRENT_FUNCTION));
		return 1;
	}
	if (is_updated && m_control_notifier.ptr ()) {
		this->refresh_control_status ();
		m_control_notifier->fire ();
	}
	return 0;
	//#UC END# *46164E76005D_45FA9E500072*
}

// implemented method from ControlManager
ControlledObjects* ControlManager_i::get_controlled_objects () const {
	//#UC START# *48733C8703E3_45FA9E500072*
	GUARD (m_controlled_objects_mutex);
	const GblUnderControlDef::UnderControlObjectList& pilot_controlled_objects = this->get_cached_pilot_controlled_object ();
	CORBA::ULong count = pilot_controlled_objects.length ();
	Core::Aptr<ControlledObjects> controlled_objects = new ControlledObjects ();

	for (CORBA::ULong i = 0; i < count; i ++) {
		controlled_objects->push_back (DocumentFactory::make (
											pilot_controlled_objects [i].pid
											, 0
											, pilot_controlled_objects [i].name
											, DocumentFactoryKeyHelper::PID_to_key (pilot_controlled_objects [i].pid)
										)
							);
	}
	return controlled_objects.forget ();
	//#UC END# *48733C8703E3_45FA9E500072*
}

// implemented method from ControlManager
bool ControlManager_i::get_under_control_status (const GCD::PID& pid, unsigned long& status) {
	//#UC START# *46164DFA005F_45FA9E500072*
	GUARD (m_controlled_objects_mutex);
	const GblUnderControlDef::UnderControlObjectList& pilot_controlled_objects = this->get_cached_pilot_controlled_object ();
	CORBA::ULong i = 0;
	for (; i < pilot_controlled_objects.length (); ++i) {
		if (pid.m_class_id == pilot_controlled_objects [i].pid.m_class_id
			&& pid.m_object_id == pilot_controlled_objects [i].pid.m_object_id
		) {
			status = pilot_controlled_objects [i].status;
			break;
		}
	}
	return i < m_pilot_controlled_objects->length ();
	//#UC END# *46164DFA005F_45FA9E500072*
}

// implemented method from ControlManager
void ControlManager_i::refresh_control_status () {
	//#UC START# *46164E6500AC_45FA9E500072*
	GUARD (m_controlled_objects_mutex);
	m_pilot_controlled_objects = 0;
	//#UC END# *46164E6500AC_45FA9E500072*
}

// implemented method from ControlManager
void ControlManager_i::remove (const GCD::PID& pid) {
	//#UC START# *46164E480197_45FA9E500072*
	try {
		try { 
			ApplicationHelper::instance ()->get_cached_under_control_manager ()->remove (pid);
		} catch (GCD::CanNotFindData&) {
		}
		this->refresh_control_status ();
	} catch (...) {
		throw NotUnderControl ();
	}
	//#UC END# *46164E480197_45FA9E500072*
}

// implemented method from ControlManager
void ControlManager_i::reset_control_status (const GCD::PID& pid) {
	//#UC START# *46164E54004E_45FA9E500072*
	try {
		ApplicationHelper::instance ()->get_cached_under_control_manager ()->reset_status (pid);
		this->refresh_control_status ();
	} catch (...) {
		throw NotUnderControl ();
	}
	//#UC END# *46164E54004E_45FA9E500072*
}

// implemented method from ControlManager
// Обновить статусы объектов на контроле.
void ControlManager_i::update_status (bool force) {
	//#UC START# *45F118B90278_45FA9E500072*
	if (m_control_notifier.ptr ()) {
		int thread_id =	ACE_Thread_Manager::instance ()->spawn (async_update_status, this);
		if (thread_id < 0) {
			LOG_E (("%s: can't create thread", GDS_CURRENT_FUNCTION));
		}
	} else {
		ApplicationHelper::instance ()->get_cached_under_control_manager ()->update_status ();
		// Нужно только здесь - т.к. выше это вызовется при завершении ами вызова update_status
		this->refresh_control_status ();
	}
	//#UC END# *45F118B90278_45FA9E500072*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

