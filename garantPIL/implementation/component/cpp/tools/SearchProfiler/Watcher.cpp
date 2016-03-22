//
// Watcher.cpp : implementation file
//

#include "ace/ACE.h"

#include "Watcher.h"

namespace SearchProfiler {

class HiResCounter {
public:
	inline ACE_hrtime_t get_count () {
		ACE_hrtime_t ret;
		this->t.stop_incr ();
		this->t.elapsed_time_incr (ret); // ret gets value in nanoseconds
		this->t.start_incr ();
		return ret;
	}

	inline void tiks_to_time (ACE_hrtime_t tiks, unsigned int& s, unsigned int& ms, unsigned int& us) {
		s  = static_cast <unsigned int> (tiks / t_per_1sec);
		unsigned dsec = static_cast <unsigned int>(tiks - (s * t_per_1sec));
		ms = static_cast <unsigned int> (dsec / t_per_msec);
		unsigned dmsec =  static_cast <unsigned int> (dsec - (ms * t_per_msec));
		us = static_cast <unsigned int> (dmsec / t_per_usec);
	}

	inline void reset () {
		this->t.reset (); 
		this->t_per_usec = 1000UL; 
		this->t_per_msec = 1000000UL;
		this->t_per_1sec = 1000000000UL;
	}

	inline void start () {
		this->reset ();
		this->t.start_incr ();
	}

	inline void stop () {
		this->t.stop_incr ();
	}

private:
	ACE_High_Res_Timer t;     // ctor will calibrate timer automatically
	ACE_hrtime_t t_per_1sec;  // 1 second
	ACE_hrtime_t t_per_msec;  // millisecond
	ACE_hrtime_t t_per_usec;  // microsecond
};

class Watcher_i
	: virtual public IWatcher
	, virtual public Core::RefCountObjectBase {
public:
	Watcher_i () { }

	virtual void start () {
		hi_res_counter.start ();
		m_start_count = this->hi_res_counter.get_count ();
	}

	virtual void finish () {
		ACE_hrtime_t count = this->hi_res_counter.get_count () - m_start_count;
		hi_res_counter.tiks_to_time (count, m_time.sec, m_time.msec, m_time.usec);
		hi_res_counter.stop ();
	}

	virtual const WatchTime& get_data () const {
		return m_time; 
	}

private:
	WatchTime m_time;
	ACE_hrtime_t m_start_count;
	HiResCounter hi_res_counter;
};

//////////////////////////////////////////////////////////////////////////////////////////////

IWatcher* WatcherFactory::make () {
	return new Watcher_i ();
}

}
