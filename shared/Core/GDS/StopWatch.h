////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/StopWatch.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::GDS::StopWatch
//
// класс секундомера (с точностью до микро сек), для профайлинга времени выполнения участков кода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_GDS_STOPWATCH_H__
#define __SHARED_CORE_GDS_STOPWATCH_H__

#include "ace/ACE.h"
#include "shared/Core/fix/PragmaWarningDisable.h"
#include "shared/Core/sys/Logs.h"
#include "shared/Core/mng/TypeSingleton.h"

//#UC START# *450E992C02FD_USER_INCLUDES*
#include <limits>
#include <map>
#include <string>
#include <vector>
#include <algorithm>
#include "ace/Singleton.h"
#include "ace/High_Res_Timer.h"
//#UC END# *450E992C02FD_USER_INCLUDES*

namespace Core {
namespace GDS {

//#UC START# *450E992C02FD_USER_DEFINITION*
    
#if !defined(__APPLE__)
class HiResCounter {
private:
	ACE_High_Res_Timer t; // ctor will calibrate timer automatically
	const ACE_hrtime_t t_per_1sec; // 1 second
	const ACE_hrtime_t t_per_msec; // millisecond
	const ACE_hrtime_t t_per_usec; // microsecond
public:
	inline ACE_hrtime_t get_count() {
		ACE_hrtime_t ret;
		this->t.stop_incr();
		this->t.elapsed_time_incr(ret); // ret gets value in nanoseconds
		this->t.start_incr();
		return ret;
	}
	inline double get_seconds () {
		ACE_hrtime_t ret = this->get_count ();
		return double (ret) / 1000000000.0;
	}
	inline void tiks_to_time (ACE_hrtime_t tiks, unsigned int& s, unsigned int& ms, unsigned int& us) {
		s = static_cast <unsigned int> (tiks/t_per_1sec);
		unsigned dsec = static_cast <unsigned int>(tiks - (s * t_per_1sec));
		ms = static_cast <unsigned int> (dsec/t_per_msec);
		unsigned dmsec =  static_cast <unsigned int> (dsec - (ms * t_per_msec));
		us = static_cast <unsigned int> (dmsec/t_per_usec);
	}
	HiResCounter (): t(), t_per_usec(1000UL), t_per_msec(1000000UL), t_per_1sec(1000000000UL) { // to emphasize default parameters for t ctor
		this->t.start_incr();
	}
	~HiResCounter () { 
		this->t.stop_incr();
	}
};

typedef Core::TypeSingleton <HiResCounter> HiResCounterSingl;


class StopWatchBase {
protected:
	HiResCounter hi_res_counter;
public :	
	virtual ~StopWatchBase () {
	}

	void flush (const char* mess) {
		this->print_time (this->hi_res_counter.get_count() - m_start_count, mess);
	}

protected:
	StopWatchBase (): hi_res_counter() {	
		m_format_buf[0] = 0;
	}

	void finish (ACE_hrtime_t count) {
		if (m_format_buf[0]) {
			this->print_time (count, m_format_buf);
		}
	}

	void print_time (ACE_hrtime_t count, const char* mess) {
		unsigned sec;
		unsigned msec;
		unsigned usec;
		HiResCounterSingl::instance()->tiks_to_time(count, sec, msec, usec);

		LOG_D (("RT of \"%s\":\t%us, %ums, %uus"
			, mess
			, sec
			, msec
			, usec
		));
	}

	void inline init_counter () {		
		m_start_count = this->hi_res_counter.get_count();
	}

protected :
	ACE_hrtime_t m_start_count;
	static const size_t max_buffer_size = 4096;
	static const size_t max_buffer_size_for_format = max_buffer_size - 1;
	char m_format_buf [max_buffer_size];
};

class StopWatch : public StopWatchBase {
public :
	StopWatch (const char *format_str, ... ) {	
		if (format_str) {
			va_list argp;
			va_start (argp, format_str);
			vsnprintf(m_format_buf, max_buffer_size_for_format, format_str, argp);
			va_end (argp);
		} 
		this->init_counter();
	}

	virtual ~StopWatch () {
		this->finish (this->hi_res_counter.get_count() - m_start_count);
	}
};

class StopWatchEx : public StopWatchBase {
public:
	typedef std::string GroupId;

public:	
	StopWatchEx (const char* id) { // blind
		m_group_id = id;
		this->init_counter ();
	}

	StopWatchEx (const char* id, const char *format_str, ... ) {
		if (format_str) {
			va_list argp;
			va_start (argp, format_str);
			vsnprintf(m_format_buf, max_buffer_size_for_format, format_str, argp);
			va_end (argp);
		} 
		m_group_id = id;		
		this->init_counter ();
	}
	~StopWatchEx () {		
		ACE_hrtime_t count = this->hi_res_counter.get_count() - m_start_count;
		StatMngSingl::instance()->more_call (m_group_id, count);
		this->finish (count);
	}

protected:
	struct StatData {
		unsigned long call_count;
		ACE_hrtime_t total_value;
		ACE_hrtime_t max_value;
		ACE_hrtime_t min_value;
		
		StatData () {
			call_count = 0;
			total_value = 0;
			max_value = 0;
			min_value = std::numeric_limits<ACE_hrtime_t>::max();
		}
		
		inline void more_call (ACE_hrtime_t count) {
			call_count++;
			total_value += count;
			if (count < min_value) {
				min_value = count;
			}
			if (count > max_value) {
				max_value = count;
			}
		}
	};

	struct StatDataTotalGreater
		: std::binary_function<std::pair<GroupId, StatData>, std::pair<GroupId, StatData>, bool>
	{
		bool operator () (const std::pair<GroupId, StatData>& x, const std::pair<GroupId, StatData>& y) {
			return x.second.total_value > y.second.total_value;
		}
	};

	typedef std::map<GroupId, StatData> StatMap;

	class StatMng {
		StatMap m_map;
	public:
		inline void more_call (const GroupId& id, ACE_hrtime_t count) {
			m_map[id].more_call(count);
		}

		~StatMng () {
		#ifndef GDS_NLOG_DEBUG

			unsigned sec;
			unsigned msec;
			unsigned usec;

			LOG_D (("StopWatch Debug: TOTAL STATISTIC"));
			LOG_D (("StopWatch Debug: TRT - total run time"));
			LOG_D (("StopWatch Debug: ART - avarage run time"));

			typedef std::vector<std::pair<GroupId, StatData> > StatDataVec;
			StatDataVec sorted_stat (m_map.begin (), m_map.end ());
			
			std::sort (sorted_stat.begin (), sorted_stat.end (), StatDataTotalGreater ());
			for (StatDataVec::iterator it = sorted_stat.begin (); it != sorted_stat.end (); ++it) {
				HiResCounterSingl::instance()->tiks_to_time(it->second.total_value, sec, msec, usec);
				
				LOG_D (("StopWatch Debug: group \"%s\": calls = %d", it->first.data(), it->second.call_count));
				LOG_D (("\tTRT:\t%us, %ums, %uus (tiks: %Q)", sec, msec, usec, it->second.total_value));
		
				HiResCounterSingl::instance()->tiks_to_time(it->second.total_value/it->second.call_count, sec, msec, usec);

				LOG_D (("\tART:\t%us, %ums, %uus"
					, sec
					, msec
					, usec
				));

				HiResCounterSingl::instance()->tiks_to_time(it->second.max_value, sec, msec, usec);

				LOG_D (("\tMAX:\t%us, %ums, %uus"
					, sec
					, msec
					, usec
				));

				HiResCounterSingl::instance()->tiks_to_time(it->second.min_value, sec, msec, usec);

				LOG_D (("\tMIN:\t%us, %ums, %uus"
					, sec
					, msec
					, usec
				));
			}
			LOG_D (("*************** END ***************"));
			LOG_D (("")); // push output

		#endif // GDS_NLOG_DEBUG
		}	

	};
	typedef ACE_Singleton <StatMng, ACE_Recursive_Thread_Mutex> StatMngSingl;

protected:
	GroupId m_group_id;
};
#endif
//#UC END# *450E992C02FD_USER_DEFINITION*

} // namespace GDS
} // namespace Core


#endif //__SHARED_CORE_GDS_STOPWATCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
