////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::TimeStampObjectManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_TIMESTAMPOBJECTMANAGER_H__
#define __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_TIMESTAMPOBJECTMANAGER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"

//#UC START# *4614E03B02EE_CUSTOM_INCLUDES*
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
const long UNINITIALIZED_TIMESTAMP = -1;
//#UC END# *4614E03B02EE_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

class TimeStampObjectManager {
	SET_OBJECT_COUNTER (TimeStampObjectManager)

	// singleton declaration
	typedef ACE_Singleton <TimeStampObjectManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TimeStampObjectManager, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static TimeStampObjectManager* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~TimeStampObjectManager ();


//#UC START# *4614E03B02EE*
public:
	struct TimeStampObjectId_less {
		bool operator () (const ::TimeStampSync::TimeStampObjectID& __x, const ::TimeStampSync::TimeStampObjectID& __y) const {
			return (__x.type+10)*(__x.id+10) < (__y.type+10)*(__y.id+10); 
		}
	};

public:	
	TimeStampObjectManager () : m_timestamp (UNINITIALIZED_TIMESTAMP) {
	}

	void wait_for_changes (const ::TimeStampSync::TimeStampValue& needed_ts) {
		//SLOG_SHIFT
		//SLOG_D (("%s (need = %d, current = %d)", GDS_CURRENT_FUNCTION, needed_ts, m_timestamp));
		while (m_timestamp < needed_ts) {
			ACE_OS::sleep (ACE_Time_Value (0, 1000));
		}
		//SLOG_D (("%s - end", GDS_CURRENT_FUNCTION));
	}
	
	void init (GblPilot::FunctionMng* cached_function_manager);
	void init_desktop ();
	
	long timestamp () {
		return m_timestamp;
	}

	void object_changed (const ::TimeStampSync::TimeStampNotificationHint* hint);
	void dump ();

private:
	friend class ActiveChangeableProxy; // require access to register_object/unregister_object

	void register_object (const ::TimeStampSync::TimeStampObjectID& id, ActiveChangeableProxy* object);
	void unregister_object (const ActiveChangeableProxy* object);

	bool is_init () {
		GUARD (m_mutex);
		return m_timestamp != UNINITIALIZED_TIMESTAMP;
	}

private:
	typedef std::multimap< ::TimeStampSync::TimeStampObjectID, ActiveChangeableProxy*, TimeStampObjectId_less> ObjectMap;
	typedef std::multimap< ::TimeStampSync::TimeStampObjectID, Core::Var<ActiveChangeableProxy>, TimeStampObjectId_less> ObjectMapSnap;
	typedef std::map <long, ::TimeStampSync::TimeStampNotificationHint> HintMap;

	std::deque<long> m_timestamp_deque;
	HintMap m_hint_map;
	ObjectMap m_objects;
	volatile long m_timestamp;
	Core::Mutex m_mutex;
	Core::Mutex m_objects_mutex;

private:
	class Copier : public std::unary_function<ObjectMap::iterator, void> {
	public:
		Copier (ObjectMapSnap& snap) : m_snap(snap) {
		}
	  
		void operator() (ObjectMap::value_type& value) {
			m_snap.insert (ObjectMapSnap::value_type (value.first, Core::IObject::_duplicate (value.second)));
		}

	private:		
		ObjectMapSnap& m_snap;
	};
//#UC END# *4614E03B02EE*
}; // class TimeStampObjectManager

} // namespace TimeStampSync
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_TIMESTAMPOBJECTMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

