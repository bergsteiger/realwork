////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/AtomicOp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::AtomicOp
//
// кросплатформеная атомарная операция
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_ATOMICOP_H__
#define __SHARED_CORE_SYS_ATOMICOP_H__

#include "ace/ACE.h"

//#UC START# *45003451029F_USER_INCLUDES*
#include "ace/ACE.h"
#include "ace/OS.h"
#include "ace/Atomic_Op.h"
#include "ace/Synch.h"
//#UC END# *45003451029F_USER_INCLUDES*

namespace Core {

//#UC START# *45003451029F_USER_DEFINITION*
#if defined(WIN32) || defined(_MSC_VER) || defined(GARANT_MPCXC_I686)  // GARANT_CROSSP

template <typename _T>
class AtomicOp : public ACE_Atomic_Op <ACE_Thread_Mutex, _T> {
public:
	AtomicOp () {
#if defined(GARANT_MPCXC_I686)
// preserve this source line to uncomment for future debug of C/C++ static storage at other source files
//	    ACE_Atomic_Op <ACE_Thread_Mutex, _T>::init_functions ();
#endif
	}
	
	AtomicOp (const _T& t) : ACE_Atomic_Op <ACE_Thread_Mutex, _T> (t) {
#if defined(GARANT_MPCXC_I686)
// preserve this source line to uncomment for future debug of C/C++ static storage at other source files
//	    ACE_Atomic_Op <ACE_Thread_Mutex, _T>::init_functions ();
#endif
	}
};

#else

template <typename _T>
class AtomicOp {
public:
  AtomicOp (): m_value(0) { this->init_fn(); }
  AtomicOp (const _T& t): m_value(t) { this->init_fn(); }
  ~AtomicOp () { this->fini_fn(); }
  _T operator++ () {
    ACE_OS::mutex_lock(&m_mutex);
    ++m_value;
    _T tmp = m_value;
    ACE_OS::mutex_unlock(&m_mutex);
    return tmp;
  }
  _T operator++ (int) {
    return this->operator++ ();
  }
  _T operator-- () {
    ACE_OS::mutex_lock(&m_mutex);
    --m_value;
    _T tmp = m_value;
    ACE_OS::mutex_unlock(&m_mutex);
    return tmp;
  }
  _T operator-- (int) {
    return this->operator-- ();
  }
  bool operator== (const AtomicOp<_T>& op) {
    ACE_OS::mutex_lock(&m_mutex);
    ACE_OS::mutex_lock(&op.m_mutex);
    bool tmp = (m_value == op.m_value);
    ACE_OS::mutex_unlock(&m_mutex);
    ACE_OS::mutex_unlock(&op.m_mutex);
    return tmp;
  }
  bool operator!=(const AtomicOp<_T>& op) {
    return !(this->operator==(op));
  }
  _T value () const {
    ACE_OS::mutex_lock(&m_mutex);
    _T tmp = m_value;
    ACE_OS::mutex_unlock(&m_mutex);
    return tmp;
  }
private:
  _T m_value;
  mutable ACE_mutex_t m_mutex;
  void init_fn() {
    ACE_OS::mutex_init(&m_mutex);
  }
  void fini_fn() {
    ACE_OS::mutex_destroy(&m_mutex);
  }
};

#endif

class AutoAtomicCounter {
public:
	AutoAtomicCounter (Core::AtomicOp<unsigned long>& count) : m_count (count) {
		m_count++;
	}
	~AutoAtomicCounter () {
		m_count--;
	}
private:
	Core::AtomicOp<unsigned long>& m_count;
};

//#UC END# *45003451029F_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_ATOMICOP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
