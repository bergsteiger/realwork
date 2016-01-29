////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::TimeStampObjectManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"

//#UC START# *4614E03B02EE_CUSTOM_INCLUDES*
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
//#UC END# *4614E03B02EE_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

//#UC START# *4614E03B02EE*
void TimeStampObjectManager::init (GblPilot::FunctionMng* cached_function_manager) {
	GUARD (m_mutex);
	
	GDS_ASSERT (!this->is_init ());   // MUST be init only once
	GDS_ASSERT (m_objects.empty ());  // MUST be initialized before any object will be registered
	
	m_timestamp = cached_function_manager->current_timestamp ();

	// для приведения объекта в согласованное начальное состояние 
	// достаточно очистить timestamp'ы, накопленные до инициализации
	// начиная с этого момента мы принимаем для обработки все нотификации
	// с timestamp'ом большим текущего, причем ни одна из них не может "потеряться"
	
	m_timestamp_deque.clear ();
	m_hint_map.clear ();
}

void TimeStampObjectManager::init_desktop () {
	GUARD (m_mutex);
	
	GDS_ASSERT (!this->is_init ());   // MUST be init only once
	GDS_ASSERT (m_objects.empty ());  // MUST be initialized before any object will be registered
	
	m_timestamp = 0;

	// для приведения объекта в согласованное начальное состояние 
	// достаточно очистить timestamp'ы, накопленные до инициализации
	// начиная с этого момента мы принимаем для обработки все нотификации
	// с timestamp'ом большим текущего, причем ни одна из них не может "потеряться"
	
	m_timestamp_deque.clear ();
	m_hint_map.clear ();
}

void TimeStampObjectManager::register_object (
	const ::TimeStampSync::TimeStampObjectID& id
	, ActiveChangeableProxy* object
) {
	GUARD (m_objects_mutex);
	
	std::pair <ObjectMap::iterator, ObjectMap::iterator> range = m_objects.equal_range (id);
	for (ObjectMap::iterator it = range.first; it != range.second; ++it) {
		if ((*it).second == object) {
			GDS_ASSERT (!"TRY TO REGISTER ActiveCheangable OBJECT IN TimeStampObjectManager TWICE!");
			return; // second registration is illegal! (object will receive notification twice or more)
		}
	}

	m_objects.insert (ObjectMap::value_type (id, object));
}


void TimeStampObjectManager::unregister_object (const ActiveChangeableProxy* object) {
	GUARD (m_objects_mutex);

	ObjectMap::iterator it = m_objects.begin ();
	while (it != m_objects.end ()) {
		if ((*it).second == object) {
			m_objects.erase (it++);
		} else {
			++it;
		}
	}
}


void TimeStampObjectManager::object_changed (const ::TimeStampSync::TimeStampNotificationHint* hint) {

	//SLOG_SHIFT
	//SLOG_D (("%s - incoming timestamp [%d]", GDS_CURRENT_FUNCTION, hint->timestamp));
	//ACE_OS::sleep (10);
	//SLOG_D (("%s - wakeup", GDS_CURRENT_FUNCTION));

	ObjectMapSnap objects;
	{
		GUARD (m_objects_mutex);
		std::for_each (m_objects.begin (), m_objects.end (), Copier (objects));
	}


	GUARD (m_mutex);
	
	if (hint->timestamp <= m_timestamp) { // ignore not actual notifications
		//LOG_D (("%s: not actual timestamp [%d] ignored (need [%d])", GDS_CURRENT_FUNCTION, hint->timestamp, m_timestamp));
		return;
	}
	
	try {
		m_timestamp_deque.push_front (hint->timestamp);
		m_hint_map [hint->timestamp] = *hint;
		std::sort (m_timestamp_deque.begin (), m_timestamp_deque.end ());

		if (m_timestamp_deque.size () && (m_timestamp == m_timestamp_deque.front ()-1)) {
			try {
				for (ObjectMapSnap::iterator it = objects.begin (); it != objects.end (); ++it) {
					it->second->acquire_update_mutex ();
				}
			} catch (...) {
				GDS_ASSERT_MSG (false, ("TimeStampObjectManager::object_changed (): unknown exception [1] - invalid behavior"));
			}

			do {
				HintMap::iterator hint_it = m_hint_map.find (m_timestamp_deque.front ());
				GDS_ASSERT (hint_it != m_hint_map.end ());
				
				// notify ActiveChangeable objects 
				const ::TimeStampSync::TimeStampNotificationHint& current = (*hint_it).second;
				std::pair <ObjectMapSnap::iterator, ObjectMapSnap::iterator> range = objects.equal_range (current.id);

				ObjectMapSnap::iterator obj_it = range.first;
				while (obj_it != range.second) {
					try {
						// iterator MUST be incremeted before update_cache operation (at the end of operation
						// ActiveChangeable object may be desrtoyed & iterator will be invalidated by this destroing)
						ObjectMapSnap::iterator tmp = obj_it++;
						(*tmp).second->update_cache (&current.hint);
					} catch (::TimeStampSync::InvalidTimeStamp&) {
						GDS_ASSERT_MSG (false, ("Adapter goes to server in change node event - server locked"));
					} catch (...) {
						GDS_ASSERT_MSG (false, ("TimeStampObjectManager::object_changed (): unknown exception [2] - invalid behavior"));
					}
				}
				
				// update timestamp
				GDS_ASSERT (m_timestamp == current.timestamp - 1);
				m_timestamp = current.timestamp;
				//SLOG_D (("%s: timestamp updated to [%d]", GDS_CURRENT_FUNCTION, m_timestamp));

				m_timestamp_deque.pop_front ();
				m_hint_map.erase (hint_it);
			} while (m_timestamp_deque.size () && (m_timestamp == m_timestamp_deque.front ()-1));

			try {
				for (ObjectMapSnap::iterator it = objects.begin (); it != objects.end (); ++it) {
					it->second->release_update_mutex ();
				}
			} catch (...) {
				LOG_E (("%s: unknown exception [3] - invalid behavior", GDS_CURRENT_FUNCTION));
				GDS_ASSERT (false);
			}
		}
	} catch (...) {
		LOG_E (("%s: unknown exception [4] - invalid behavior", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}
}

void TimeStampObjectManager::dump () {
	GUARD (m_mutex);

	LOG_D (("%s: current timestamp [%d]", GDS_CURRENT_FUNCTION, m_timestamp));
	LOG_D (("%s: hint map size [%d]", GDS_CURRENT_FUNCTION, m_hint_map.size ()));
	for (HintMap::iterator hint_it = m_hint_map.begin (); hint_it != m_hint_map.end (); ++hint_it) {
		SLOG_SHIFT
		SLOG_D (("[timestamp, hint_ptr] : [%d, 0x%08X]", (*hint_it).first, &(*hint_it).second));
	}
	LOG_D (("%s: timestamp deque size [%d]", GDS_CURRENT_FUNCTION, m_timestamp_deque.size ()));
	for (size_t i = 0; i < m_timestamp_deque.size (); ++i) {
		SLOG_SHIFT
		SLOG_D (("[%d]", m_timestamp_deque [i]));
	}
}
//#UC END# *4614E03B02EE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TimeStampObjectManager::~TimeStampObjectManager () {
	//#UC START# *4614E03B02EE_DESTR_BODY*
	GDS_ASSERT (m_objects.size () == 0);
	//#UC END# *4614E03B02EE_DESTR_BODY*
}


} // namespace TimeStampSync
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

