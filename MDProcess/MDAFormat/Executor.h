////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/Executor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::MDAFormat::LibSupport::Executor
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_LIBSUPPORT_EXECUTOR_H__
#define __MDPROCESS_MDAFORMAT_LIBSUPPORT_EXECUTOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace MDAFormat {

// пока нет документации

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

} // namespace MDAFormat


#endif //__MDPROCESS_MDAFORMAT_LIBSUPPORT_EXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
