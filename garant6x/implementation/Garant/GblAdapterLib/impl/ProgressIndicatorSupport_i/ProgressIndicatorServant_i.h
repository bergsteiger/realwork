#ifndef _DATATYPES_GBLADAPTER_GARANT_PROGRESSINDICATORSERVANT_I_H_
#define _DATATYPES_GBLADAPTER_GARANT_PROGRESSINDICATORSERVANT_I_H_

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/GCD_amiS.h"

namespace GblAdapterLib {

class ProgressIndicatorServantBase
	: virtual public POA_GCD::ProgressIndicator
	, virtual public TAO_RefCountServantBase {
public:
	ProgressIndicatorServantBase () : m_finished (false) {
	}

	Core::Mutex& get_synch () {
		return m_mutex;
	}

	void set_finish () {
		m_finished = true;
	}

	virtual ~ProgressIndicatorServantBase () {
	}

protected:
	bool m_finished;
	Core::Mutex m_mutex;
};

template <class T>
class ProgressIndicatorServant_i: public ProgressIndicatorServantBase {
public:
	virtual CORBA::Short max_progress_count () {
		GUARD (m_mutex);
		if (m_max_progress_count == -1) {
			m_max_progress_count = CORBA::Short (m_progress_indicator->get_max_count ());
		}
		return m_max_progress_count;
	}

	virtual void set_current (CORBA::Long cur_count, CORBA::Long arg) {
		//if (cur_count>0) LOG_D (("PI(%d)::set_current(%d) (f=%d) - in", this, cur_count, m_finished));
		if (!m_finished && cur_count > m_cur_count) {
			GUARD (m_mutex);
			if (m_progress_indicator.ptr ()) {
				//if (cur_count>0) LOG_D (("PI(%d)::set_current(%d) (f=%d) - call set_current", this, cur_count, m_finished));
				m_progress_indicator->set_current (cur_count, arg);
				//if (cur_count>0) LOG_D (("PI(%d)::set_current(%d) (f=%d) - retn set_current", this, cur_count, m_finished));
			}
		}
		//if (cur_count>0) LOG_D (("PI(%d)::set_current(%d) (f=%d) - out", this, cur_count, m_finished));
	}

	ProgressIndicatorServant_i (T* progress_indicator)
		: m_progress_indicator (Core::IObject::_duplicate (progress_indicator)), m_max_progress_count (-1), m_cur_count (0) {
	}

	virtual ~ProgressIndicatorServant_i () {
	}

private:
	CORBA::Short m_max_progress_count;
	CORBA::Long m_cur_count;	
	Core::Var<T> m_progress_indicator;
};

}; // namespace GblAdapterLib;

#endif // _DATATYPES_GBLADAPTER_GARANT_PROGRESSINDICATORSERVANT_I_H_
