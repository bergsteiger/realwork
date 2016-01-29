////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/SahiTestLib/TestExecutor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::SahiTestLib::TestPerformer::TestExecutor
//
// исполнитель тестов sahi - контролирует процесс выполнения тестов и публикует результаты
// стандартным способом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTEXECUTOR_H__
#define __MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTEXECUTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace SahiTestLib {

// исполнитель тестов sahi - контролирует процесс выполнения тестов и публикует результаты
// стандартным способом

class TestExecutor : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (TestExecutor)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(TestExecutor)

public:
	static TestExecutor& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class TestExecutor

} // namespace SahiTestLib


#endif //__MDPROCESS_SAHITESTLIB_TESTPERFORMER_TESTEXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
