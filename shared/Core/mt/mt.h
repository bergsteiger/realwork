////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/mt/mt.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::mt
//
// ������ � ����������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MT_H__
#define __SHARED_CORE_MT_H__

#include "shared/Core/sys/core_std_inc.h"
#include "ace/Task.h"

namespace Core {

// ������������� ������ � ����
typedef unsigned long ThreadHandle;

// ������� ��� ACE-������ ����� ���������� ���������� ������� ������
typedef ACE_THR_FUNC_RETURN ThreadResult;

// ����� ���������� � ����� �� ����������� ������� ���� �������
class UnmanagedThread : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ThreadPool;
typedef ::Core::Var<ThreadPool> ThreadPool_var;
typedef ::Core::Var<const ThreadPool> ThreadPool_cvar;
// ��� �������. ����� ��������� �������������� ������ � ����� �������. � ������� �����
// �������������� �� ������� ����� �������.
class ThreadPool
	: virtual public ::Core::IObject
{
public:
	// ������������� �������� ������
	virtual ThreadHandle get_current_thread_handle () const = 0;

	// ��������� ������� ����� �� ������� ���������� ���������� ������, ���������� ��������� ������
	// ������.
	virtual ThreadResult join_thread (ThreadHandle th) = 0;

	// ���������� ������ � ��������� ������� ���� ����������
	virtual void cancel_thread (ThreadHandle th) /*throw (UnmanagedThread)*/ = 0;

	// �������� ������ ��������� ���� ������� ����
	virtual void cancel_all_threads () = 0;

	// ���������� true ���� �������� ������ ��������� ���� ����������
	virtual bool is_current_canceled () const = 0;

	// �������� ��������� ����� �� ���� � �������� ��� ���������� ���������� �������. � ����������
	// ���������� ����� ���������� ������� ��� 0 � ������ ������
	virtual ThreadHandle spawn_thread (ACE_THR_FUNC func, void* param) = 0;

	// ������������� ���-�� ������� � ���� �� ����� ����������� �������� (� ������ ���� ������� ���-��
	// �������� ������ ���������� �������� - �� ���� �� ��������)
	virtual void reserve (unsigned long pool_size) = 0;

	// ������������� ��� ������, ��������� ���������� �� ������.
	virtual void shutdown_all_threads () = 0;

	// ��������� ���������� ����� �� ��� ��� ���� ��� ������ � ���� ����� ���������, � �������������
	// ��� ������ ����� ��������
	virtual void wait_for_busy () const = 0;
};

/// factory interface for ThreadPool
class ThreadPoolFactory {
public:
	// ���������� ����� ��� "�� ���������"
	static ThreadPool& def ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ����� ��� � ��������� ���-��� �������
	static ThreadPool* make (unsigned long pool_size)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ���������������� �������� ������� ������
static const ThreadHandle BAD_HANDLE = 0; // �������� ����������� ������ ������

// ����������������� �������� ���������� ��������� �������
static const ThreadResult THREAD_RESULT_OK = 0; // ������� ������ ����������� �������

} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::ThreadPool> {
	typedef Core::ThreadPoolFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_MT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
