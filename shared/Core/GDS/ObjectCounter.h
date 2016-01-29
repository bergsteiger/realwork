////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/ObjectCounter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::GDS::ObjectCounter
//
// класс для профайлинга не удаленных объектов и подсчета их кол-ва (создано, освобождено, провисло)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_GDS_OBJECTCOUNTER_H__
#define __SHARED_CORE_GDS_OBJECTCOUNTER_H__

#include "ace/ACE.h"
#include "shared/Core/fix/PragmaWarningDisable.h"
#include "shared/Core/mng/Var.h"
#include "shared/Core/mng/Box.h"
#include "shared/Core/sys/assert.h"
#include "shared/Core/sys/RefCountObjectBase.h"

//#UC START# *450E98A5029F_USER_INCLUDES*
//#define NEED_OBJECT_COUNTER 1
#if defined(_DEBUG) || defined (NEED_OBJECT_COUNTER)
	#include <map>
	#include <typeinfo>
	#include <string>
	#include <ostream>
	#define HAS_OBJECT_COUNTER 1
#else
	#define HAS_OBJECT_COUNTER 0
#endif
//#UC END# *450E98A5029F_USER_INCLUDES*

namespace Core {
namespace GDS {

//#UC START# *450E98A5029F_USER_DEFINITION*
#if defined(_DEBUG) || defined (NEED_OBJECT_COUNTER)

struct ObjectCounterStat {
	std::string object_type;
	Core::AtomicOp<long> active_count;
	Core::AtomicOp<long> total_created_count;

	ObjectCounterStat () : active_count (0), total_created_count (0) {
	}
};

typedef std::vector<ObjectCounterStat> ObjectCounterStatList;

typedef Core::Box<ObjectCounterStatList> ObjectCounterStatList_box;

typedef std::map<unsigned int, ObjectCounterStatList_box> ObjectStates;

class CountHolderBase : virtual public Core::RefCountObjectBase {
public: 
	virtual const ObjectCounterStat& get_stat() const = 0;
};

typedef Core::Var<CountHolderBase> CountHolder_var;

class CountHolderManager {
	friend class CountHolder;
	typedef std::vector<CountHolder_var> CountHolders;

public:
	typedef ACE_Singleton <CountHolderManager, ACE_SYNCH_RECURSIVE_MUTEX> CountHolderManagerSingleton;

public:
	static ObjectCounterStatList* get_current_statistic () {
		ObjectCounterStatList_box ret = new ObjectCounterStatList (CountHolderManagerSingleton::instance ()->m_holders.size());
		ObjectCounterStatList::iterator target_it = ret->begin();
		for (CountHolders::const_iterator it = CountHolderManagerSingleton::instance ()->m_holders.begin(); it != CountHolderManagerSingleton::instance ()->m_holders.end(); it++, target_it++) {
			(*target_it) = (*it)->get_stat();
		}
		return ret.forget ();
	}

	static void dump_csv_statistic (std::ostream& output, const std::string date) {
		CountHolders for_csv (CountHolderManagerSingleton::instance ()->m_holders);

		for (CountHolders::iterator it = for_csv.begin (); it != for_csv.end (); ++it) {
			const ObjectCounterStat& stat = (*it)->get_stat ();
			output << date << ";" 
				<< stat.object_type.data () << ";" << stat.total_created_count.value () << ";" << stat.active_count.value () << "\n";
		}

		output << std::flush;
	}

	static void dump_current_statistic (FILE* to_dump, bool only_leaks = false) { // GARANT_ISOCPP
		ObjectCounterStatList_box stats = get_current_statistic ();

		bool has_leaks = false;

		fprintf (to_dump, "ObjectCounter DEBUG  : dump current statistics\n");
		fprintf (to_dump, "ObjectCounter DEBUG  : object types registred = %zd\n", stats->size());
		for (ObjectCounterStatList::iterator it = stats->begin(); it != stats->end(); it++) {
			if (!only_leaks || it->active_count.value ()) {
				
				has_leaks |= (it->active_count.value () > 0);
				fprintf (
					to_dump
					, "ObjectCounter DEBUG  : Typename = %s; total created = %ld; active = %ld\n"
					, it->object_type.data()
					, it->total_created_count.value ()
					, it->active_count.value ()
				);				
			}
		}

		GDS_ASSERT_MSG (has_leaks == 0, ("ObjectCounter detects LEAKS!"));
	}

	static void dump (bool only_leaks = false) {
		dump_current_statistic (stderr, only_leaks);
	}

	static void save_state (unsigned int state_number) {
		CountHolderManagerSingleton::instance ()->m_object_states[state_number] = get_current_statistic ();
	}

	static void dump_diff_with_state (FILE* to_dump, unsigned int state_number) {
		assert (CountHolderManagerSingleton::instance ()->m_object_states.end () != CountHolderManagerSingleton::instance ()->m_object_states.find (state_number));
		ObjectCounterStatList_box saved_state = CountHolderManagerSingleton::instance ()->m_object_states[state_number];
		ObjectCounterStatList_box cur_state = get_current_statistic ();

		fprintf (to_dump, "ObjectCounter DEBUG  : dump current statistics\n");
		//
		ObjectCounterStatList::iterator cur_state_it;
		unsigned int active_objects_count = 0;
		for (cur_state_it = cur_state->begin(); cur_state_it != cur_state->end(); cur_state_it++) {
			active_objects_count += cur_state_it->active_count.value ();
		}
		fprintf (to_dump, "ObjectCounter DEBUG  : active objects count = %d\n", active_objects_count);
		//
		ObjectCounterStatList::iterator saved_state_it;
		for (cur_state_it = cur_state->begin(); cur_state_it != cur_state->end(); cur_state_it++) {
			int total_created_count = 0;
			int active_count = 0;
			std::string type;
			for (saved_state_it = saved_state->begin(); saved_state_it != saved_state->end(); saved_state_it++) {
				if (cur_state_it->object_type == saved_state_it->object_type) {
					break;
				}
			}
			type = cur_state_it->object_type;
			if (saved_state_it == saved_state->end ()) {
				// new object of that type was created
				total_created_count = cur_state_it->total_created_count.value ();
				active_count = cur_state_it->active_count.value ();
			} else {
				total_created_count = static_cast<int>(cur_state_it->total_created_count.value ()) - static_cast<int>(saved_state_it->total_created_count.value ());
				active_count = static_cast<int>(cur_state_it->active_count.value ()) - static_cast<int>(saved_state_it->active_count.value ());
			}

			if (0 != total_created_count || 0 != active_count) {
				fprintf (
					to_dump
					, "Object diff DEBUG  : Typename = %s; total created = %ld (%ld in prev state); active = %ld (%ld)\n"
					, type.c_str ()
					, cur_state_it->total_created_count.value (), (saved_state_it != saved_state->end ()) ? saved_state_it->total_created_count.value (): 0
					, cur_state_it->active_count.value (), (saved_state_it != saved_state->end ()) ? saved_state_it->active_count.value (): 0
				);
			}
		}
	}

	~CountHolderManager () {
		CountHolderManager::dump (true);
	}	

public:
	CountHolders m_holders;
	ObjectStates m_object_states;
};

template <class _OwnerType> 
class ObjectCounter {
public:
	ObjectCounter () {		
		instance()->inc_obj ();
	}

	ObjectCounter (const ObjectCounter&) {		
		instance()->inc_obj ();
	}

	~ObjectCounter () {
		instance()->dec_obj ();
	}

public:
	class CountHolder : virtual public CountHolderBase  {
	public:
		CountHolder () {
			_OwnerType* p = 0;
			m_stat.object_type = typeid(p).name();
			//fprintf (stderr, "ObjectCounter DEBUG  : \"%s\" - set up counter\n", m_stat.object_type.data());
			//fflush (stderr);			
		}

		~CountHolder () {
			if (m_stat.active_count.value ()) {
				fprintf (stderr, "ObjectCounter WARNING: \"%s\" - leaks detected!!!\n", m_stat.object_type.data());
			}
			//fprintf (stderr, "ObjectCounter DEBUG  : \"%s\" - total created: %d; lost: %d\n", m_stat.object_type.data(), m_stat.total_created_count.value (), m_stat.active_count.value ());
			fflush (stderr);
		}
	
		void inc_obj () {
			++m_stat.active_count;
			++m_stat.total_created_count;
		}

		void dec_obj () {
			if (!m_stat.active_count.value ()) {
				fprintf (stderr, "ObjectCounter ERROR  : \"%s\" - memory damaged!!! (attempt to delete not created object)\n", m_stat.object_type.data());
				assert (0);
			}
			--m_stat.active_count;

			if (!m_stat.active_count.value ()) {
				//fprintf (stderr, "ObjectCounter DEBUG  : \"%s\" - last object released\n", m_stat.object_type.data());
			}
			fflush (stderr);
		}

		const ObjectCounterStat& get_stat() const {
			return m_stat;
		}

	private:
		ObjectCounterStat m_stat;		
	};

	static CountHolder* s_holder;
	typedef ACE_Recursive_Thread_Mutex Mutex;
	typedef ACE_Guard<Mutex> Guard;
	static Mutex s_holder_mutex;

	static inline CountHolder* const instance () {
		if (s_holder == 0) {
			Guard guard (s_holder_mutex);
			if (s_holder == 0) {
				s_holder = new CountHolder ();
				CountHolderManager::CountHolderManagerSingleton::instance ()->m_holders.push_back(s_holder);
			}
		}
		return s_holder;
	}

	// [dolgop] оператор присваивания нужен из-за суперской оптимизации в 
	// stlport 5, которая в зависимости от присутствия в классе оператора =
	// проводит оптимизацию при работе с контейнерами, что
	// приводит к вызову 1 конструктора и 2 деструкторов, отчего каунтеру само-собой 
	// башню сносит...
	ObjectCounter& operator= (const ObjectCounter& from) {
		return *this;
	}

};

template <class _OwnerType> 
typename ObjectCounter<_OwnerType>::CountHolder* ObjectCounter<_OwnerType>::s_holder = 0;

template <class _OwnerType> 
typename ObjectCounter<_OwnerType>::Mutex ObjectCounter<_OwnerType>::s_holder_mutex;

#define SET_OBJECT_COUNTER(TYPE) Core::GDS::ObjectCounter<TYPE> __TYPE##_counter;

#else // ! (defined(_DEBUG) || defined (NEED_OBJECT_COUNTER))

#define SET_OBJECT_COUNTER(TYPE) 

#endif
//#UC END# *450E98A5029F_USER_DEFINITION*

} // namespace GDS
} // namespace Core


#endif //__SHARED_CORE_GDS_OBJECTCOUNTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
