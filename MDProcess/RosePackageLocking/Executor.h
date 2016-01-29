////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/Executor.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::RosePackageLocking::LibSupport::Executor
//
// ��� ������ ������� ������������� ���������� Ctrl-C � ��������� ���������� � �������� �� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace RosePackageLocking {

// ��� ������ ������� ������������� ���������� Ctrl-C � ��������� ���������� � �������� �� �����

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

} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
