////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewLibExecutor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> TestModel::BasicTests::NewLibSupport::NewLibExecutor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWLIBEXECUTOR_H__
#define __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWLIBEXECUTOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace BasicTests {


class NewLibExecutor : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (NewLibExecutor)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(NewLibExecutor)

public:
	static NewLibExecutor& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class NewLibExecutor

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWLIBEXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
