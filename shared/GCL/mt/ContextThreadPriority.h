////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCL/mt/ContextThreadPriority.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::mt::ContextThreadPriority
//
// ����� ����������� �������� ��������� �������� ������ � ������������ (� �����������) ����������
// ��� ������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_MT_CONTEXTTHREADPRIORITY_H__
#define __SHARED_GCL_MT_CONTEXTTHREADPRIORITY_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Task.h"

//#UC START# *4501A229004E_CUSTOM_INCLUDES*
#include "ace/Thread_Manager.h"

class ContextThreadPriority;
typedef Core::Box<ContextThreadPriority> AutoContextThreadPriority;
//#UC END# *4501A229004E_CUSTOM_INCLUDES*

namespace GCL {

// ����� ����������� �������� ��������� �������� ������ � ������������ (� �����������) ����������
// ��� ������ ��������
class ContextThreadPriority {
	SET_OBJECT_COUNTER (ContextThreadPriority)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ������������� ����� ��������� ������ (���������� ��� �������������)
	explicit ContextThreadPriority (int priority, bool absolute = false);

public:
	virtual ~ContextThreadPriority ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ACE_hthread_t m_self_th;

	int m_seved_prio;

//#UC START# *4501A229004E*
#define AUTO_CONTEXT_THREAD_PRIORITY_ABS(PRIO,ABS)	GCL::ContextThreadPriority _actp(PRIO,ABS);
#define AUTO_CONTEXT_THREAD_PRIORITY(PRIO)	GCL::ContextThreadPriority _actp(PRIO);
//#UC END# *4501A229004E*
}; // class ContextThreadPriority

} // namespace GCL


#endif //__SHARED_GCL_MT_CONTEXTTHREADPRIORITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

