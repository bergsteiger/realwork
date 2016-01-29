////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/TestLib/DummyTest.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> shared::TestLib::NewLibraryImpl::DummyTest
//
// �������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_TESTLIB_NEWLIBRARYIMPL_DUMMYTEST_H__
#define __SHARED_TESTLIB_NEWLIBRARYIMPL_DUMMYTEST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace TestLib {

// �������� �����������

class DummyTest : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (DummyTest)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(DummyTest)

public:
	static DummyTest& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class DummyTest

} // namespace TestLib


#endif //__SHARED_TESTLIB_NEWLIBRARYIMPL_DUMMYTEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
