////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/Executor.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::KPageToolLib::LibSupport::Executor
//
// �������� �� ���������� � �������� ����������������� ���������� ������������ �������� � ��������,
// ������� ���������� ���������� � ��������� ���.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_EXECUTOR_H__
#define __MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_EXECUTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace KPageToolLib {

// �������� �� ���������� � �������� ����������������� ���������� ������������ �������� � ��������,
// ������� ���������� ���������� � ��������� ���.

class Executor : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (Executor)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(Executor)

public:
	static Executor& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class Executor

} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_LIBSUPPORT_EXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
